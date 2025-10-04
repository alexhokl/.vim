return {

  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    keys = {
      { "<leader>dbed", ":e ~/.local/share/db_ui/connections.json", desc = "Edit database connection file (dadbod)", noremap = true, silent = true },
      { "<leader>dbc",  ":DBUIToggle<CR>",                          desc = "Toggle DB UI",                           noremap = true, silent = true },
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_table_helpers = {
        postgresql = {
          Count = 'SELECT COUNT(*) FROM "{table}"',
        },
        sqlserver = {
          Count = 'SELECT COUNT(*) FROM "{table}"',
        },
        sqlite = {
          Count = 'SELECT COUNT(*) FROM "{table}"',
        },
      }
    end,
  },

  {
    "nanotee/sqls.nvim",
    keys = {
      { "<leader>ds",   "<cmd>SqlsSwitchConnection<CR>",    mode = "n", desc = "Switch database connection (sqls)",    noremap = true, silent = true },
      { "<leader>dd",   "<cmd>SqlsSwitchDatabase<CR>",      mode = "n", desc = "Switch database (sqls)",               noremap = true, silent = true },
      { "<F5>",         "<cmd>SqlsExecuteQuery<CR>",        mode = "n", desc = "Execute query (sqls)",                 noremap = true, silent = true },
      { "<F5>",         "<cmd>SqlsExecuteQuery<CR>",        mode = "x", desc = "Execute query (sqls)",                 noremap = true, silent = true },
      { "<leader>dbes", ":e ~/.config/sqls/config.yml<CR>", mode = "n", desc = "Edit database connection file (sqls)", noremap = true, silent = true },
    },
  },

}
