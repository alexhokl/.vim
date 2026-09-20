-- after/ftplugin/markdown.lua
-- <leader>gq: reflow bullet and numbered lists with `gq`, then strip
-- list prefixes from wrapped continuation lines (first line keeps its
-- marker; numbers are preserved as written).
--
-- Both modes use the operator pattern: the mapping only sets
-- `operatorfunc` and returns "g@" (expression mappings must not change
-- text). Neovim then calls the operatorfunc with '[ / '] set to the
-- motion target or the visual selection.
local function set_operatorfunc()
	vim.o.operatorfunc = "v:lua.require'config.md_reflow'.operatorfunc"
	return "g@"
end

local opts = {
	noremap = true,
	silent = true,
	desc = "Reflow markdown list (bullet/numbered)",
	buffer = true,
	expr = true,
}

vim.keymap.set("n", "<leader>gq", set_operatorfunc, opts)
vim.keymap.set("x", "<leader>gq", set_operatorfunc, opts)
