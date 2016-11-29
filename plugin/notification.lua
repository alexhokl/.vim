local notify = require('notify')
notify.setup({
  timeout = 10000,
})

local telescope = require('telescope')
telescope.load_extension('notify')
