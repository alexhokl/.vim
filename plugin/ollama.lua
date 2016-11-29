-- charmbracelet/mods
-- command! -range -nargs=0 ModsExplain :'<,'>w !mods "explain this, be very succint"
-- command! -range -nargs=* ModsRefactor :'<,'>!mods "refactor this to improve its readability"
-- command! -range -nargs=+ Mods :'<,'>w !mods <q-args>
vim.api.nvim_create_user_command("ModsExplain", function()
	vim.api.nvim_command("'<,'>w !mods 'explain this, be very succint'")
end, { nargs = 0, range = true })
vim.api.nvim_create_user_command("ModsRefactor", function()
	vim.api.nvim_command("'<,'>!mods 'refactor this to improve its readability'")
end, { nargs = "*", range = true })
-- commented out as it is not working due to syntax errors
-- vim.api.nvim_create_user_command("Mods", function(args)
-- 	vim.api.nvim_command("'<,'>w !mods " .. args)
-- end, { nargs = "+", range = true })

-- yetone/avante.nvim
-- local avante = require("avante")
-- avante.setup({
-- 	provider = "ollama",
-- 	vendors = {
-- 		["ollama"] = {
-- 			["local"] = true,
-- 			endpoint = "127.0.0.1:11434/v1",
-- 			model = "codellama:7b-code",
-- 			parse_curl_args = function(opts, code_opts)
-- 				return {
-- 					url = opts.endpoint .. "/chat/completions",
-- 					headers = {
-- 					["Accept"] = "application/json",
-- 					["Content-Type"] = "application/json",
-- 					},
-- 					body = {
-- 						model = opts.model,
-- 						messages = {
-- 							{ role = "system", content = code_opts.system_prompt },
-- 							{ role = "user", content = require("avante.providers.openai").get_user_message(code_opts) },
-- 						},
-- 						max_tokens = 2048,
-- 						stream = true,
-- 					},
-- 				}
-- 			end,
-- 			parse_response_data = function(data_stream, event_state, opts)
-- 				require("avante.providers").openai.parse_response(data_stream, event_state, opts)
-- 			end,
-- 		},
-- 	},
-- })

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
