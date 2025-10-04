return {

  {
    "tpope/vim-fugitive",
    keys = {
      { "<leader>gs",  "<CMD>Git<CR>",              desc = "Open git window",              silent = true, noremap = true },
      { "<leader>ga",  "<CMD>Git add %:p<CR>",      desc = "git add",                      silent = true, noremap = true },
      { "<leader>gb",  "<CMD>Git blame<CR>",        desc = "git blame",                    silent = true, noremap = true },
      { "<leader>gw",  "<CMD>GBrowse<CR>",          desc = "Browse line in a web browser", silent = true, noremap = true },
      { "<leader>gco", "<CMD>Gread<CR>",            desc = "git checkout this file",       silent = true, noremap = true },
      { "<leader>gpp", "<CMD>Git push<CR>",         desc = "git push",                     silent = true, noremap = true },
      { "<leader>gpf", "<CMD>Git push --force<CR>", desc = "git force push",               silent = true, noremap = true },
    },
  },

  {
    "ruifm/gitlinker.nvim",
    opts = {},
  },

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = true,
    cmd = {
      "GitConflictChooseOurs",
      "GitConflictChooseTheirs",
      "GitConflictChooseBoth",
      "GitConflictChooseNone",
      "GitConflictNextConflict",
      "GitConflictPrevConflict",
      "GitConflictListQf",
      "GitConflictRefresh",
    },
    keys = {
      { 'gcf', '<CMD>GitConflictListQf<CR>',             desc = "List conflicts",            silent = true, noremap = true },
      { 'co',  '<Plug>(git-conflict-ours)',              desc = "Choose ours",               silent = true, noremap = true },
      { 'ct',  '<Plug>(git-conflict-theirs)',            desc = "Choose theirs",             silent = true, noremap = true },
      { 'cb',  '<Plug>(git-conflict-both)',              desc = "Choose both",               silent = true, noremap = true },
      { 'c0',  '<Plug>(git-conflict-none)',              desc = "Choose none",               silent = true, noremap = true },
      { ']n',  '<Plug>(git-conflict-next-conflict)',     desc = "Jump to next conflict",     silent = true, noremap = true },
      { '[n',  '<Plug>(git-conflict-previous-conflict)', desc = "Jump to previous conflict", silent = true, noremap = true },
    },
  },

  {
    "ThePrimeagen/git-worktree.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local git_worktree = require('git-worktree')
      git_worktree.setup()
      local telescope = package.loaded.telescope
      telescope.load_extension("git_worktree")
    end,
  },

  {
    "sindrets/diffview.nvim",
    opts = {
      merge_tool = {
        layout = "diff4_mixed",
      },
      keymaps = {
        file_panel = {
          { "n", "<C-c>", "<CMD>DiffviewClose<CR>", desc = "Close diffview" },
        },
        file_history_panel = {
          { "n", "<C-c>", "<CMD>DiffviewClose<CR>", desc = "Close diffview" },
        },
      },
    },
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
      "DiffviewRefresh",
      "DiffviewFileHistory",
    },
    keys = {
      { "<leader>glf", "<CMD>DiffviewFileHistory<CR>",  mode = "n", desc = "File history",    silent = true, noremap = true },
      { "<leader>gll", ":'<,'>DiffviewFileHistory<CR>", mode = "x", desc = "Line(s) history", silent = true, noremap = true },
    },
  },

}
