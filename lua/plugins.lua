-- lua/plugins.lua
return {
  -- Plugin Manager (lazy.nvim manages itself)
  { "folke/lazy.nvim",       version = "*",         lazy = false },

  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]]) -- Set Tokyonight as the default colorscheme
    end,
  },

  -- Which-Key (leader cheat-sheet)
  {
    "folke/which-key.nvim",
    dependencies = { "echasnovski/mini.icons" }, -- Icons for which-key
    event = "VeryLazy",
    config = function()
      require("which-key").setup({ plugins = { spelling = { enabled = true } } })
    end,
    keys = {
      { "<leader>n", "<CMD>Oil --float<CR>", desc = "Open file explorer" }, -- Open file explorer with leader+n
    },
  },

  -- Formatting & lint helpers
  { "stevearc/conform.nvim", event = "BufWritePre", config = false }, -- real config lives in lua/config/format.lua

  -- Fuzzy Finder (files, grep, etc.)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "alexhokl/nvim-md-header-telescope-picker",
    },
    -- Lazy‑load on these keymaps -------------------------------------------
    keys = {
      {
        "<C-p>",
        function()
          local builtin = require("telescope.builtin")
          -- recurse_submodules = true so git submodule contents are listed
          -- Try submodules first (requires *no* --others flag)
          local ok = pcall(builtin.git_files, { recurse_submodules = true })
          if not ok then
            -- Fallback: root-only but include untracked files
            ok = pcall(builtin.git_files, { show_untracked = true })
          end
          if not ok then
            builtin.find_files()
          end
          if not ok then
            builtin.find_files()
          end
        end,
        desc = "Find files (incl. dot‑files)",
      },
      {
        "<C-t>",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Grep specified string",
      },
      {
        "<leader>b",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fs",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "Find Symbols from treesitter",
      },
      {
        "<leader>fm",
        function()
          require("telescope.builtin").treesitter({
            symbols = { "function", "method" },
          })
        end,
        desc = "Find methods/functions",
      },
      {
        "<leader>ft",
        function()
          require("nvim-md-header-telescope-picker").markdown_header_picker({})
        end,
        desc = "Find headers",
      },
      {
        "<leader>fh",
        function()
          require("telescope.builtin").help_tags()
        end,
        desc = "Help tags",
      },
      {
        "<leader>F",
        function()
          require("telescope.builtin").grep_string()
        end,
        desc = "Grep current string",
      },
      {
        "<leader>m",
        function()
          require("telescope.builtin").keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>j",
        function()
          require("telescope.builtin").jumplist()
        end,
        desc = "Jump list",
      },
      {
        "<leader>fb",
        function()
          require("telescope.builtin").git_branches()
        end,
        desc = "Git branches",
      },
      {
        "<leader>glr",
        function()
          require("telescope.builtin").git_commits({
            git_command = { "git", "log", "--pretty=format:%h %s [%ad] [%cn]\n", "--date=short", "--", "." },
          })
        end,
        desc = "git log of repository",
      },
      {
        "<leader>gcb",
        function()
          require("telescope").extensions.git_worktree.git_worktrees()
        end,
        desc = "Git worktrees",
      },
      {
        "<leader>gpb",
        function()
          require("telescope").extensions.git_worktree.create_git_worktree()
        end,
        desc = "Git worktree create",
      },
    },
    config = function()
      local trouble = require("trouble.sources.telescope")
      local actions = require("telescope.actions")
      local telescope = require("telescope")
      telescope.setup({
        ---------------------------------------------------------------------
        -- Defaults apply to *all* pickers ----------------------------------
        ---------------------------------------------------------------------
        defaults = {
          prompt_prefix = "� ",
          file_ignore_patterns = {
            "^%.git/", -- keep .git ignored
            "^%.idea/",
            "^%.vscode/",
            "^%.venv/",
            "^node_modules/",
            "^%.cache/",
            "%.DS_Store$",
            "^docs/html/",
          },
          mappings = {
            i = {
              ["<Esc>"] = actions.close
            },
            n = {
              ["<c-t>"] = trouble.open,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          ['ui-select'] = {}
        },

        ---------------------------------------------------------------------
        -- Picker‑specific overrides ----------------------------------------
        ---------------------------------------------------------------------
        pickers = {
          -- :Telescope find_files
          find_files = {
            hidden = true,     -- include dot‑files / dot‑dirs
            follow = true,     -- follow symlinks
            no_ignore = false, -- still respect .gitignore & friends
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob",
              "!.git/*",    -- keep .git out
              "--glob",
              ".github/**", -- BUT keep everything under .github
              "--exclude",
              "docs/html/**",
            },
          },

          -- :Telescope live_grep
          -- live_grep = {
          --   additional_args = function()
          --     return {
          --       "--hidden",
          --       "--glob",
          --       "!.git/*",
          --       "--glob",
          --       ".github/**",
          --       "--exclude",
          --       "docs/html/**",
          --     }
          --   end,
          -- },
        },
      })
      telescope.load_extension("ui-select")
      telescope.load_extension("yaml_schema")
    end,
  },

  -- Dashboard (start screen)
  {
    "nvimdev/dashboard-nvim", -- new repo name
    lazy = false,             -- load immediately
    priority = 1001,          -- after colorscheme (1000), before the rest
    config = function()
      local db = require("dashboard")
      db.setup({
        theme = "doom",
        config = {
          header = { "�  Baby Yosh Dashboard  �" },
          center = {
            { desc = "  Find File           ", action = "Telescope find_files" },
            { desc = "  Live Grep           ", action = "Telescope live_grep" },
            { desc = "  File Explorer       ", action = "Oil" },
            { desc = "  Quit                ", action = "qa" },
          },
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Statusline and Bufferline
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
      require("lualine").setup({
        options = { theme = "tokyonight", section_separators = "", component_separators = "" },
        sections = {
          lualine_b = { 'branch', 'diff', 'lsp_status', 'diagnostics' },
          lualine_c = {
            {
              function()
                local cur_buf = vim.api.nvim_get_current_buf()
                return require("hbac.state").is_pinned(cur_buf) and "�" or ""
                -- tip: nerd fonts have pinned/unpinned icons!
              end,
              color = { fg = "#ef5f6b", gui = "bold" },
            }
          },
          lualine_x = {
            {
              'encoding',
              show_bomb = true,
            },
            'fileformat',
            'filetype',
          },
        },
        extensions = {
          "quickfix",
          "fugitive",
          "mason",
          "oil",
          "trouble",
        },
      })
    end,
    dependencies = {
      "axkirillov/hbac.nvim",
      "nvim-tree/nvim-web-devicons"
    },
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "none",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = false,
          show_close_icon = false,
          separator_style = "slant",
        },
      })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        current_line_blame = true,
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigate hunks with ]c/[c
          vim.keymap.set("n", "]c", function()
            gs.next_hunk()
          end, { buffer = bufnr, desc = "Next hunk" })
          vim.keymap.set("n", "[c", function()
            gs.prev_hunk()
          end, { buffer = bufnr, desc = "Prev hunk" })
          -- Stage/undo stage hunk
          vim.keymap.set("n", "<Leader>hs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
          vim.keymap.set("n", "<Leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          -- Preview hunk
          vim.keymap.set("n", "<Leader>gd", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
        end,
      })
    end,
  },

  -- LSP (Language Server Protocol) and related plugins
  {
    "neovim/nvim-lspconfig", -- Collection of configurations for built-in LSP client
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      -- LSP UI enhancements
      { "nvimdev/lspsaga.nvim", config = true }, -- LSP UIs (hover docs, code actions, rename, diagnostics, and floating terminal)
      "williamboman/mason.nvim",
      "quangnguyen30192/cmp-nvim-ultisnips",
      -- Automatically install LSP servers (optional, e.g., mason.nvim could be used here)
    },
    config = function()
      -- Customize diagnostic display (virtual text, signs, etc.)
      -- enable diagnostics to show in virtual lines (not virtual text)
      vim.diagnostic.config({
        virtual_lines = {
          current_line = false,
        },
        signs = true,
        float = {
          border = "rounded",
        },
      })

      -- uncomment to enable debug logs
      -- to view logs use `:lua vim.cmd('e'..vim.lsp.get_log_path())`
      -- vim.lsp.set_log_level("debug")

      local format_on_save_filetypes = {
        "*.tf",
        "*.tfvars",
        "*.go",
        "*.rs",
        "*.lua",
        "*.py",
        "*.cs",
      }

      local enabled_lsp_clients = {
        "bashls",
        "clangd",
        "cmake",
        -- "csharp_ls",
        "docker_compose_language_service",
        "dockerls",
        "eslint",
        "gopls",
        "html",
        "jsonls",
        "ocamllsp",
        -- "omnisharp",
        "powershell_es",
        "pyright",
        -- "roslyn_ls",
        "rust_analyzer",
        "lua_ls",
        "sqls",
        "terraformls",
        "tflint",
        "vimls",
        "yamlls",
      }

      -- enable formatting on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = format_on_save_filetypes,
        callback = function()
          vim.lsp.buf.format();
        end,
      })

      -- enable auto-completion
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if not client then
            return
          end
          if client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
          end
        end,
      })

      -- enable LSP clients
      vim.lsp.enable(enabled_lsp_clients)
    end,
  },

  -- Autocompletion framework and snippet engine
  {
    "petertriho/cmp-git",
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {
      filetypes = { "gitcommit" },
      remotes = { "upstream", "origin" }, -- in order of most to least prioritized
      -- defaults
      remote = "origin",
      git = {
        commits = {
          limit = 100,
        },
      },
      github = {
        issues = {
          filter = "all", -- assigned, created, mentioned, subscribed, all, repos
          limit = 100,
          state = "open", -- open, closed, all
        },
        mentions = {
          limit = 100,
        },
        pull_requests = {
          limit = 100,
          state = "open", -- open, closed, merged, all
        },
      },
    },
    init = function()
      table.insert(require("cmp").get_config().sources, { name = "git" })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",         -- LSP source for nvim-cmp
      "hrsh7th/cmp-buffer",           -- Buffer words completion
      "hrsh7th/cmp-path",             -- File path completion
      "f3fora/cmp-spell",             -- Spell suggestions source
      "saadparwaiz1/cmp_luasnip",     -- Snippet completions
      "L3MON4D3/LuaSnip",             -- Snippet engine (LuaSnip, replacing vim-vsnip)
      "rafamadriz/friendly-snippets", -- Collection of snippets for many languages
      "kristijanhusak/vim-dadbod-completion",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")
      require("luasnip.loaders.from_vscode").lazy_load() -- Load VSCode-style snippets from friendly-snippets

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Use LuaSnip to expand snippet
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<Down>"] = cmp.mapping(
            cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
            { "i" }
          ),
          ["<Up>"] = cmp.mapping(
            cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
            { "i" }
          ),
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          -- { name = "nvim_lsp" },
          { name = "luasnip",              keyword_length = 2 },
          { name = "path" },
          { name = "buffer",               keyword_length = 5 },
          -- { name = "spell" },
          { name = 'treesitter' },
          { name = 'cmdline' },
          { name = 'git' },
          { name = 'ultisnips' },
          { name = 'vim-dadbod-completion' },
          -- { name = 'cmp_ai' }, -- promising but the suggestions are not that great yet
        }),

        formatting = {
          format = lspkind.cmp_format({
            with_text = true,
            menu = {
              nvim_lsp = "",
              treesitter = "",
              path = "",
              -- spell = "�",
              buffer = "",
              Ollama = "�",
            },
            maxwidth = 50,
          })
        }
      })

      cmp.setup.filetype({ "sql" }, {
        sources = {
          { name = 'vim-dadbod-completion' },
          { name = 'buffer' },
        },
      })
    end,
  },

  -- AI Assistant (GitHub Copilot) - using Lua plugin for better integration
  {
    "zbirenbaum/copilot.lua",
    enabled = true,
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>"
          }
        },
        filetypes = {
          yaml = true,
          markdown = true,
          gitcommit = true,
          gitrebase = true,
        },
      })
    end,
  },

  -- Editing enhancements
  { "kylechui/nvim-surround", event = "VeryLazy",                                                   config = true }, -- Surround text objects easily (replaces tpope/vim-surround)
  { "tpope/vim-endwise",      ft = { "ruby", "vim", "lua", "bash", "c", "cpp", "make", "snippets" } },               -- Automatically add "end" in certain filetypes (Ruby, etc.)
  { "stevearc/dressing.nvim", event = "VeryLazy",                                                   config = true }, -- Better UI for vim.ui (input/select) dialogs
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl", -- tells lazy.nvim the module name changed
    event = "BufReadPost",
    opts = {
      indent = { char = "│" }, -- or leave blank for default ▏
      scope = { enabled = false }, -- disable rainbow scope lines if you like
      exclude = {
        filetypes = {
          "markdown",
        },
      },
    },
  },

  -- Syntax and Language Support (Tree-sitter and filetype plugins)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "ziontee113/syntax-tree-surfer",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "bash",
          "c",
          "c_sharp",
          "cmake",
          "cpp",
          "css",
          "csv",
          "dart",
          "diff",
          "dockerfile",
          "gitcommit",
          "gitignore",
          "go",
          "gomod",
          "hcl",
          "hjson",
          "html",
          "http",
          "java",
          "javascript",
          "jinja",
          "jsdoc",
          "json",
          "json5",
          "jsonc",
          "kotlin",
          "latex",
          "lua",
          "make",
          "markdown",
          "markdown_inline",
          "ninja",
          "nginx",
          "nix",
          "python",
          "proto",
          "python",
          "query",
          "regex",
          "ruby",
          "rust",
          "scala",
          "scss",
          "terraform",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        highlight = { enable = true },
        indent = { enable = true },
        query_linter = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
              ["<leader>df"] = "@function.outer",
              ["<leader>dF"] = "@class.outer",
            },
          },
        },
        modules = {},
        sync_install = false,
        auto_install = true,
        ignore_install = {},
      })
    end,
  },
}
