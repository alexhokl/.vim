return {

  {
    "dkarter/bullets.vim",
    ft = "markdown",
    init = function()
      vim.g.bullets_set_mappings = 0
      vim.g.bullets_auto_indent_after_colon = 0
    end,
    config = function()
      local map = function(mode, keys, command, desc)
        vim.keymap.set(mode, keys, command, {
          noremap = true,
          silent = true,
          desc = desc,
          buffer = true,
        })
      end

      map({ "n", "x" }, "<leader>>", "<Plug>(bullets-demote)<cr>", "Increase indent of a bullet")
      map({ "n", "x" }, "<leader><", "<Plug>(bullets-promote)<cr>", "Decrease indent of a bullet")
    end,
  },

	{
		"alexhokl/nvim-md-open-link",
		opts = {
			keymap = "gb",
		},
	},

	{
		"alexhokl/nvim-md-header-telescope-picker",
	},

  {
    "godlygeek/tabular",
    ft = "markdown",
    config = function()
      vim.keymap.set("x", "<leader>t", ":Tabularize /|<CR>", {
        noremap = true,
        silent = true,
        desc = "Format markdown table",
        buffer = true,
      })
    end,
  },

  {
    "plasticboy/vim-markdown",
    ft = "markdown",
    init = function()
      vim.g.vim_markdown_math = 1
      vim.g.vim_markdown_new_list_item_indent = 2
      vim.g.vim_markdown_folding_level = 5
      vim.g.vim_markdown_fenced_languages = { "csharp=cs" }
      vim.g.vim_markdown_strikethrough = 1
      vim.g.vim_markdown_folding_disabled = 0
      vim.g.vim_markdown_toc_autofit = 1
      vim.g.vim_markdown_conceal = 0
      vim.g.vim_markdown_conceal_code_blocks = 0
      vim.g.vim_markdown_follow_anchor = 1
      vim.g.vim_markdown_frontmatter = 1
      vim.g.vim_markdown_toml_frontmatter = 1
      vim.g.vim_markdown_json_frontmatter = 1
    end,
    config = function()
      vim.keymap.set("n", "<leader>co", function()
        vim.cmd("normal! I```")
        vim.cmd("normal! o```")
        vim.cmd("normal! k")
        vim.cmd("startinsert!")
      end, { noremap = true, silent = true, desc = "Insert code block", buffer = true })

      vim.keymap.set("x", "<leader>co", function()
        vim.cmd("normal! dO```")
        vim.cmd("normal! o```")
        vim.cmd("normal! Pk")
        vim.cmd("startinsert!")
      end, { noremap = true, silent = true, desc = "Wrap in code block", buffer = true })

      vim.keymap.set("n", "<leader>k", function()
        vim.cmd("normal! i<kbd>")
        vim.cmd("normal! la</kbd>")
        vim.cmd("normal! l")
      end, { noremap = true, silent = true, desc = "Insert markdown of kbd", buffer = true })
    end,
  },

	{
		"alexhokl/nvim-md-toc",
		opts = {
			keymap = "<leader>rm",
		},
		config = function()
			local plugin = require("nvim-md-toc")
			plugin.setup({
				keymap = "<leader>rm",
			})

			-- Utility function for mapping keys
			local map = function(mode, keys, command, desc)
				vim.keymap.set(mode, keys, command, { noremap = true, silent = true, desc = desc })
			end

			local level_4 = function()
				plugin.refresh_toc(4)
			end
			map("n", "<leader>rrm", level_4, "Refresh table of contents")
		end,
	},

	{
		"alexhokl/nvim-web-search",
		opts = {
			visual_mode_keymaps = {
				["<leader>ji"] = "https://jisho.org/search/{}",
				["<leader>jt"] = "https://translate.google.com/?sl=ja&tl=en&op=translate&text={}",
				["<leader>go"] = "https://www.google.com/search?q={}",
			},
			normal_mode_keymaps = {
				["<leader>ji"] = "https://jisho.org/search/{}",
			},
		},
	},

	{
		"alexhokl/nvim-kanji-to-hiragana",
		-- dir = "/nvim-kanji-to-hiragana/",
		ft = "markdown",
		opts = {},
	},

	{
		"alexhokl/nvim-header-formatter",
		ft = "markdown",
		opts = {},
	},
}
