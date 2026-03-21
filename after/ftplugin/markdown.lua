-- Move cursor to the start of a treesitter node.
-- Replaces the removed nvim-treesitter.ts_utils.goto_node().
local function goto_node(node)
  local row, col = node:start()
  vim.api.nvim_win_set_cursor(0, { row + 1, col })
end

local function goto_next_header()
  local query = vim.treesitter.query.parse("markdown", "((atx_heading) @header)")
  local root = vim.treesitter.get_parser():parse()[1]:root()
  local _, node, _ = query:iter_captures(root, 0, vim.fn.line("."), -1)()

  if node then
    goto_node(node)
  end
end

local function goto_prev_header()
  local query = vim.treesitter.query.parse("markdown", "((atx_heading) @header)")
  local root = vim.treesitter.get_parser():parse()[1]:root()

  if vim.fn.line(".") == 1 then
    return
  end

  local node
  for _, n, _ in query:iter_captures(root, 0, 0, vim.fn.line(".") - 1) do
    node = n
  end

  if node then
    goto_node(node)
  end
end

vim.keymap.set("n", "]h", goto_next_header, { desc = "Go to next header", buffer = true })
vim.keymap.set("n", "[h", goto_prev_header, { desc = "Go to previous header", buffer = true })
