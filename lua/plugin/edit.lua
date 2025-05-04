return {

  {
    "mg979/vim-visual-multi",
    branch = "master",
    init = function()
      vim.g.VM_default_mappings = 0
      vim.g.VM_maps = {
        ['Find Under']         = '<C-d>', -- replace C-n
        ['Find Subword Under'] = '<C-d>', -- replace visual C-n
      }
    end,
  },

  {
    "tpope/vim-unimpaired",
  },

  {
    "machakann/vim-sandwich",
  },

  {
    "tomtom/tcomment_vim",
  },

  {
    "wellle/targets.vim",
  },

}
