-- lua/nvim-treesitter/ts_utils.lua
--
-- Compatibility shim for `nvim-treesitter.ts_utils`, which was removed in the
-- nvim-treesitter rewrite (main branch).  Only the functions actually called
-- by plugins in this config are implemented here; everything else is a no-op
-- stub so that `require("nvim-treesitter.ts_utils")` does not raise an error.

local M = {}

--- Return the node under the cursor in the current buffer.
--- Replaces ts_utils.get_node_at_cursor().
---@return TSNode|nil
function M.get_node_at_cursor()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.treesitter.get_parser(0):parse({ row - 1, col, row - 1, col })
  return vim.treesitter.get_node({ pos = { row - 1, col } })
end

--- Walk up the tree to find the root node for a given node.
--- Replaces ts_utils.get_root_for_node().
---@param node TSNode
---@return TSNode
function M.get_root_for_node(node)
  local parent = node:parent()
  while parent do
    node = parent
    parent = node:parent()
  end
  return node
end

--- Convert 0-indexed treesitter range to 1-indexed vim positions.
--- Replaces ts_utils.get_vim_range().
--- @param range integer[] {start_row, start_col, end_row, end_col} (0-indexed)
--- @param _buf integer  (unused — kept for API compatibility)
--- @return integer start_row, integer start_col, integer end_row, integer end_col (1-indexed)
function M.get_vim_range(range, _buf)
  local start_row = range[1] + 1
  local start_col = range[2] + 1
  local end_row   = range[3] + 1
  local end_col   = range[4]
  -- end_col: treesitter gives the column *after* the last char (exclusive).
  -- Vim visual selection wants the column *of* the last char (inclusive).
  if end_col == 0 then
    end_row = end_row - 1
    end_col = #vim.fn.getline(end_row)
  end
  return start_row, start_col, end_row, end_col
end

--- Move the cursor to the start or end of a node.
--- Replaces ts_utils.goto_node().
---@param node TSNode
---@param go_to_end boolean|nil  true = jump to end, false/nil = jump to start
---@param _avoid_set_jump boolean|nil  (unused — kept for API compatibility)
function M.goto_node(node, go_to_end, _avoid_set_jump)
  if not node then
    return
  end
  local row, col
  if go_to_end then
    row, col = node:end_()
    -- end_ is the position *after* the last character; move back one column
    if col > 0 then
      col = col - 1
    end
  else
    row, col = node:start()
  end
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

--- Swap the text of two treesitter nodes in a buffer.
--- Replaces ts_utils.swap_nodes().
---@param node_a TSNode
---@param node_b TSNode
---@param bufnr integer
---@param _reindent boolean|nil  (unused — kept for API compatibility)
function M.swap_nodes(node_a, node_b, bufnr, _reindent)
  if not node_a or not node_b then
    return
  end

  local sa_row, sa_col, ea_row, ea_col = node_a:range()
  local sb_row, sb_col, eb_row, eb_col = node_b:range()

  -- Ensure node_a comes before node_b in the buffer
  if sa_row > sb_row or (sa_row == sb_row and sa_col > sb_col) then
    node_a, node_b = node_b, node_a
    sa_row, sa_col, ea_row, ea_col, sb_row, sb_col, eb_row, eb_col =
      sb_row, sb_col, eb_row, eb_col, sa_row, sa_col, ea_row, ea_col
  end

  local text_a = vim.api.nvim_buf_get_text(bufnr, sa_row, sa_col, ea_row, ea_col, {})
  local text_b = vim.api.nvim_buf_get_text(bufnr, sb_row, sb_col, eb_row, eb_col, {})

  -- Replace in reverse order to preserve earlier offsets
  vim.api.nvim_buf_set_text(bufnr, sb_row, sb_col, eb_row, eb_col, text_a)
  vim.api.nvim_buf_set_text(bufnr, sa_row, sa_col, ea_row, ea_col, text_b)
end

return M
