local ollama = require("ollama")

ollama.setup({
  model = "llama2",
  url = "http://127.0.0.1:11434",
  -- serve = {
  --   on_start = false,
  --   command = "ollama",
  --   args = { "serve" },
  --   stop_command = "pkill",
  --   stop_args = { "-SIGTERM", "ollama" },
  -- },
  -- View the actual default prompts in ./lua/ollama/prompts.lua
  prompts = {
    Sample_Prompt = {
      prompt = "This is a sample prompt that receives $input and $sel(ection), among others.",
      input_label = "> ",
      model = "llama2",
      action = "display",
    }
  }
})

vim.keymap.set("n", "<leader>oo", ":<c-u>lua require('ollama').prompt()<cr>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>oG", ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>", { noremap = true, silent = true })


-- ollama.setup({
--   url = "http://127.0.0.1:11434",
--   serve = {
--     command = "docker",
--     -- args = {
--     --   "run",
--     --   "-d",
--     --   "--rm",
--     --   "--gpus=all",
--     --   "-v",
--     --   "ollama:/root/.ollama",
--     --   "-p",
--     --   "11434:11434",
--     --   "--name",
--     --   "ollama",
--     --   "ollama/ollama",
--     -- },
--     args = {
--       "run",
--       "-d",
--       "--rm",
--       "--gpus=all",
--       "-v",
--       "ollama:/root/.ollama",
--       "-p",
--       "11434:11434",
--       "--name",
--       "ollama",
--       "ollama/ollama",
--     },
--     stop_command = "docker",
--     stop_args = { "stop", "ollama" },
--   },
-- })
