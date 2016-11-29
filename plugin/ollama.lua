local default_keymap_options = { noremap = true, silent = true }

-- collama works but the context passed to model codellama is not large enough
-- to produce a very good completion but it is still useful when working offline
-- model codegemma does not work with the plugin yet
-- while model codestral gives bad completions
-- local collama_preset = require("collama.preset.example")
-- local collama = require("collama.copilot")
-- local collama_logger = require("collama.logger")
-- local fidget = require("fidget")
-- -- collama_preset.setup { model = "codegemma:7b-code" }
-- collama_preset.setup { model = "codellama:7b-code" }
-- -- collama_preset.setup { model = "codestral:22b" }
-- vim.keymap.set('i', '<leader>a', collama.accept)
-- collama_logger.setup(fidget.notify)

-- gen.nvim
local gen = require("gen")
gen.setup({
	model = "gemma3:27b-it-qat",
})
gen.prompts["Last_Line"] = {
	prompt =
	"Complete the last line by following the pattern before the last line. Repeat all lines before outputing the last line. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
	replace = true,
	extract = "```$filetype\n(.-)```",
}

vim.keymap.set({ "v", "x" }, "<leader>oec", ":'<,'>Gen Enhance_Code<CR>", default_keymap_options)
vim.keymap.set({ "v", "x" }, "<leader>oeg", ":'<,'>Gen Enhance_Grammar_Spelling<CR>", default_keymap_options)
vim.keymap.set({ "v", "x" }, "<leader>oll", ":'<,'>Gen Last_Line<CR>", default_keymap_options)
