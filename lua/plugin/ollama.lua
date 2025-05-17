return {

  {
    "alexhokl/collama.nvim",
    -- dir = '/collama.nvim',
    enabled = false,
    lazy = false,
    -- branch = "gemma",
    config = function()
      require('collama.preset.example').setup {
        -- this qwen model is the most stable consistent so far
        model = 'qwen2.5-coder:7b',

        -- the chance of this gemma model generate anything is small
        -- (also test with curl command)
        -- model = 'codegemma:7b-code',

        -- this llama model generates code but it is pretty random with default
        -- Ollama options; it also has a problem with always <EOT> at the end
        -- model = 'codellama:7b-code',
      }
      local keymap_options = {
        noremap = true,
        silent = true,
        desc = 'Collama: Accept suggestion',
      }
      vim.keymap.set('i', '<C-s>', require('collama.copilot').accept, keymap_options)
      -- require('collama.logger').notify = require('fidget').notify
      require('collama.logger').notify = require("noice.source.notify").notify

      -- debugging options
      -- require('collama.logger').notify = require('notify').notify
      -- require('collama.logger').level = vim.log.levels.DEBUG
    end,
  },

  {
    "David-Kunz/gen.nvim",
    opts = {
      model = "gemma3:27b-it-qat", -- The default model to use.
      quit_map = "q",              -- set keymap to close the response window
      retry_map = "<c-r>",         -- set keymap to re-send the current prompt
      accept_map = "<c-cr>",       -- set keymap to replace the previous selection with the last result
      host = "localhost",          -- The host running the Ollama service.
      port = "11434",              -- The port on which the Ollama service is listening.
      display_mode = "float",      -- The display mode. Can be "float" or "split" or "horizontal-split" or "vertical-split".
      show_prompt = false,         -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
      show_model = false,          -- Displays which model you are using at the beginning of your chat session.
      no_auto_close = false,       -- Never closes the window automatically.
      file = false,                -- Write the payload to a temporary file to keep the command short.
      hidden = false,              -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
      init = function(options) end,

      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      command = function(options)
        local body = { model = options.model, stream = true }
        return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
      end,

      result_filetype = "markdown", -- Configure filetype of the result buffer
      debug = false                 -- Prints errors and the command which is run.
    },
    config = function(_, opts)
      local gen = require("gen")
      gen.setup(opts)
      gen.prompts["Last_Line"] = {
        prompt =
        "Complete the last line by following the pattern before the last line. Repeat all lines before outputing the last line. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
        replace = true,
        extract = "```$filetype\n(.-)```",
      }
    end,
    keys = {
      { "<leader>oec", ":'<,'>Gen Enhance_Code<CR>",             mode = { "v", "x" }, desc = "Gen: Enhance Code" },
      { "<leader>oeg", ":'<,'>Gen Enhance_Grammar_Spelling<CR>", mode = { "v", "x" }, desc = "Gen: Enhance Grammar/Spelling" },
      { "<leader>oll", ":'<,'>Gen Last_Line<CR>",                mode = { "v", "x" }, desc = "Gen: Last Line" },
    },
  },

}
