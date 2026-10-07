-- tests/test_ts_utils.lua
--
-- Unit tests for lua/nvim-treesitter/ts_utils.lua
--
-- These tests verify compatibility with Neovim 0.12 breaking changes,
-- specifically that vim.treesitter.get_parser() may return nil instead
-- of throwing an error.
--
-- Run with:  nvim --headless -u NONE -l tests/test_ts_utils.lua
-- Or:        make test

-- Add the runtime path so require() can find modules under lua/
vim.opt.rtp:prepend(vim.fn.fnamemodify(vim.fn.getcwd(), ":p"))

-- Minimal test framework (avoids plenary.nvim dependency for CI)
local test_results = { passed = 0, failed = 0, skipped = 0, errors = {} }

-- Sentinel returned by a test body to mark it as skipped
local SKIP = {}

local function assert_eq(actual, expected, msg)
  if actual ~= expected then
    error(
      string.format(
        "%s: expected %s, got %s",
        msg or "assert_eq",
        tostring(expected),
        tostring(actual)
      )
    )
  end
end

local function assert_nil(value, msg)
  if value ~= nil then
    error(
      string.format(
        "%s: expected nil, got %s",
        msg or "assert_nil",
        tostring(value)
      )
    )
  end
end

local function assert_not_nil(value, msg)
  if value == nil then
    error(string.format("%s: expected non-nil value", msg or "assert_not_nil"))
  end
end

local function describe(name, fn)
  print(string.format("\n  %s", name))
  fn()
end

local function it(name, fn)
  local ok, err = pcall(fn)
  if ok and err == SKIP then
    test_results.skipped = test_results.skipped + 1
    print(string.format("    - %s (skipped)", name))
  elseif ok then
    test_results.passed = test_results.passed + 1
    print(string.format("    ✓ %s", name))
  else
    test_results.failed = test_results.failed + 1
    table.insert(test_results.errors, { name = name, err = err })
    print(string.format("    ✗ %s", name))
    print(string.format("      %s", err))
  end
end

-- Helper: create a scratch buffer with given content and filetype
local function make_buffer(content, filetype)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(content, "\n"))
  if filetype then
    vim.bo[buf].filetype = filetype
  end
  vim.api.nvim_set_current_buf(buf)
  return buf
end

-- Helper: run fn with vim.treesitter.get_parser mocked to return nil
-- (simulating 0.12 failure). The mock is always restored, even on error.
local original_get_parser = vim.treesitter.get_parser
local function with_nil_parser(fn)
  vim.treesitter.get_parser = function()
    return nil
  end
  local ok, result = pcall(fn)
  vim.treesitter.get_parser = original_get_parser
  if not ok then
    error(result, 0)
  end
  return result
end

-- ============================================================================
-- TESTS
-- ============================================================================

print("\n=== ts_utils tests ===")

describe("get_node_at_cursor", function()
  it("returns nil without error when get_parser() returns nil", function()
    make_buffer("local x = 1\n", "lua")
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    local ts_utils = require("nvim-treesitter.ts_utils")

    local ok, result = pcall(with_nil_parser, ts_utils.get_node_at_cursor)
    if not ok then
      error("get_node_at_cursor threw: " .. tostring(result))
    end
    assert_nil(result, "should return nil when parser is unavailable")
  end)

  it("returns a node when parser is available", function()
    make_buffer("local x = 1\n", "lua")
    vim.api.nvim_win_set_cursor(0, { 1, 0 })

    -- Only run if lua parser is installed
    local ok, parser = pcall(vim.treesitter.get_parser, 0, "lua")
    if not ok or not parser then
      return SKIP
    end

    local ts_utils = require("nvim-treesitter.ts_utils")
    local result = ts_utils.get_node_at_cursor()
    assert_not_nil(
      result,
      "get_node_at_cursor should return a node when parser is available"
    )
  end)
end)

describe("get_root_for_node", function()
  it("returns the node itself when it has no parent", function()
    make_buffer("local x = 1\n", "lua")
    local ok, parser = pcall(vim.treesitter.get_parser, 0, "lua")
    if not ok or not parser then
      return SKIP
    end
    local tree = parser:parse()[1]
    local root = tree:root()
    local ts_utils = require("nvim-treesitter.ts_utils")
    local result = ts_utils.get_root_for_node(root)
    assert_eq(result, root, "root of root node should be itself")
  end)
end)

describe("get_vim_range", function()
  it("converts 0-indexed range to 1-indexed vim positions", function()
    local ts_utils = require("nvim-treesitter.ts_utils")
    -- 0-indexed: start_row=0, start_col=0, end_row=0, end_col=5
    local sr, sc, er, ec = ts_utils.get_vim_range({ 0, 0, 0, 5 }, 0)
    assert_eq(sr, 1, "start_row should be 1-indexed")
    assert_eq(sc, 1, "start_col should be 1-indexed")
    assert_eq(er, 1, "end_row should be 1-indexed")
    assert_eq(ec, 5, "end_col should remain exclusive (0-indexed end_col)")
  end)

  it("handles end_col=0 by adjusting to previous line", function()
    make_buffer("hello\nworld\n")
    local ts_utils = require("nvim-treesitter.ts_utils")
    -- Simulate a node that ends at column 0 of line 1 (i.e., end of line 0)
    local sr, sc, er, ec = ts_utils.get_vim_range({ 0, 0, 1, 0 }, 0)
    assert_eq(sr, 1, "start_row")
    assert_eq(sc, 1, "start_col")
    assert_eq(er, 1, "end_row should be adjusted to previous line")
    assert_eq(ec, 5, "end_col should be line length (hello = 5 chars)")
  end)
end)

describe("goto_node", function()
  it("does nothing when node is nil", function()
    make_buffer("local x = 1\n")
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    local ts_utils = require("nvim-treesitter.ts_utils")
    -- Should not throw
    ts_utils.goto_node(nil, false)
  end)
end)

describe("swap_nodes", function()
  it("does nothing when either node is nil", function()
    make_buffer("local x = 1\n")
    local buf = vim.api.nvim_get_current_buf()
    local ts_utils = require("nvim-treesitter.ts_utils")
    -- Should not throw
    ts_utils.swap_nodes(nil, nil, buf)
  end)
end)

-- ============================================================================
-- SUMMARY
-- ============================================================================

print(
  string.format(
    "\n=== Results: %d passed, %d failed, %d skipped ===",
    test_results.passed,
    test_results.failed,
    test_results.skipped
  )
)

if test_results.failed > 0 then
  os.exit(1)
end
