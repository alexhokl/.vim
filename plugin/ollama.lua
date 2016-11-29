-- nomnivore/ollama.nvim
local ollama = require("ollama")
ollama.setup()

local cmp_ai = require("cmp_ai.config")
local notify = require('notify')
cmp_ai:setup({
  max_lines = 10,
  provider = 'Ollama',
  provider_options = {
    model = 'codestral:22b',
    prompt = function(lines_before)
      return lines_before
    end,
    suffix = function(lines_after)
      return lines_after
    end,
  },
  notify = true,
  notify_callback = function(msg)
	notify.notify(msg, vim.log.levels.INFO, {
		title = 'Ollama codestral',
		render = 'compact',
	})
  end,
  run_on_every_keystroke = true,
})

-- meeehdi-dev/bropilot.nvim
-- commented out to avoid enabling it by default
-- local bropilot = require("bropilot")
-- bropilot.setup({
-- 	model = "codellama:7b-code",
-- 	model_params = {
-- 		-- to avoid long completions which takes forever
-- 		num_predict = 20,
-- 	},
-- 	keymap = {
-- 		suggest = "<leader>i",
-- 		accept_block = "<leader>u",
-- 	},
-- })

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
