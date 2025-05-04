return {

  {
    "ziontee113/syntax-tree-surfer",
    config = function()
      local surfer = require("syntax-tree-surfer")
      surfer.setup({
        highlight_group = "STS_highlight",
        disable_no_instance_found_report = false,
        default_desired_types = {
          "function",
          "arrow_function",
          "function_definition",
          "if_statement",
          "else_clause",
          "else_statement",
          "elseif_statement",
          "for_statement",
          "while_statement",
          "switch_statement",
        },
        left_hand_side = "fdsawervcxqtzb",
        right_hand_side = "jkl;oiu.,mpy/n",
        icon_dictionary = {
          ["if_statement"] = "",
          ["else_clause"] = "",
          ["else_statement"] = "",
          ["elseif_statement"] = "",
          ["for_statement"] = "ﭜ",
          ["while_statement"] = "ﯩ",
          ["switch_statement"] = "ﳟ",
          ["function"] = "",
          ["function_definition"] = "",
          ["variable_declaration"] = "",
        },
      })

      local map = function(lhs, rhs, desc)
        vim.keymap.set("n", lhs, rhs, { desc = desc, noremap = true, silent = true, expr = true })
      end

      map("vj", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
        return "g@l"
      end, "Swap key with its value (treesitter)")
      map("vk", function()
        vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
        return "g@l"
      end, "Swap value with its key (treesitter)")
    end,
    keys = {
      -- Visual Selection from Normal Mode
      { "vx",    "<cmd>STSSelectMasterNode<cr>",      mode = "n", { desc = "Select master node (treesitter)", noremap = true, silent = true } },
      { "vn",    "<cmd>STSSelectCurrentNode<cr>",     mode = "n", { desc = "Select current node (treesitter)", noremap = true, silent = true } },
      -- Select Nodes in Visual Mode
      { "J",     "<cmd>STSSelectNextSiblingNode<cr>", mode = "x", { desc = "Jump to next node (treesitter)", noremap = true, silent = true } },
      { "K",     "<cmd>STSSelectPrevSiblingNode<cr>", mode = "x", { desc = "Jump to previous node (treesitter)", noremap = true, silent = true } },
      { "H",     "<cmd>STSSelectParentNode<cr>",      mode = "x", { desc = "Expand selection to parent node (treesitter)", noremap = true, silent = true } },
      { "L",     "<cmd>STSSelectChildNode<cr>",       mode = "x", { desc = "Select first child node (treesitter)", noremap = true, silent = true } },
      -- Swapping Nodes in Visual Mode
      { "<c-j>", "<cmd>STSSwapNextVisual<cr>",        mode = "x", { desc = "Swap next node (treesitter)", noremap = true, silent = true } },
      { "<c-k>", "<cmd>STSSwapPrevVisual<cr>",        mode = "x", { desc = "Swap previous node (treesitter)", noremap = true, silent = true } },
    },
  },

  {
    "ray-x/cmp-treesitter",
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup({
        opts = {
          enable_close = true,          -- Auto close tags
          enable_rename = true,         -- Auto rename pairs of tags
          enable_close_on_slash = true, -- Auto close on trailing </
        },
        aliases = {
          ["cshtml"] = "html",
        },
      })
    end,
  },

  {
    "mfussenegger/nvim-treehopper",
    keys = {
      -- mode 'o' means operator pending, such as 'd', 'c', 'y', etc.
      { "m", ":<C-U>lua require('tsht').nodes()<CR>", mode = "o", { desc = "Select node (treesitter)", noremap = true, silent = true } },
      { "m", function() require('tsht').nodes() end,  mode = "x", { desc = "Move node (treesitter)", noremap = true, silent = true } },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

}
