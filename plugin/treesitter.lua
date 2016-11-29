require 'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cmake",
        "cpp",
        "css",
        "dart",
        "dockerfile",
        "go",
        "gomod",
        "hcl",
        "hjson",
        "html",
        "http",
        "java",
        "javascript",
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
        "nix",
        "python",
        "query",
        "regex",
        "ruby",
        "rust",
        "scala",
        "scss",
        "terraform",
        "toml",
        "typescript",
        "vim",
        "yaml",
    },
    ignore_install = {}, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = {},  -- list of language that will be disabled
        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
    query_linter = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,

            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            -- keymaps = {
            --   -- You can use the capture groups defined in textobjects.scm
            --   ["af"] = "@function.outer",
            --   ["if"] = "@function.inner",
            --   ["ac"] = "@call.outer",
            --   ["ic"] = "@call.inner",
            --   ["ii"] = "@conditional.inner",
            --   ["ai"] = "@conditional.outer",
            --   ["il"] = "@loop.inner",
            --   ["al"] = "@loop.outer",
            --   ["ip"] = "@parameter.inner",
            -- },
        },
        -- swap = {
        --   enable = true,
        --   swap_next = {
        --     ["<leader>a"] = "@parameter.inner",
        --   },
        --   swap_previous = {
        --     ["<leader>A"] = "@parameter.inner",
        --   },
        -- },
        move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
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
    autotag = {
        enable = true,
    }
}

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.d2 = {
    install_info = {
        url = 'https://git.pleshevski.ru/pleshevskiy/tree-sitter-d2',
        revision = 'main',
        files = { 'src/parser.c', 'src/scanner.cc' },
    },
    filetype = 'd2',
};

-- local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
-- parser_config.tape = {
--   install_info = {
--     url = "https://github.com/charmbracelet/tree-sitter-vhs",
--     files = {"src/parser.c"},
--     -- optional entries:
--     branch = "main",
--     generate_requires_npm = false,
--     requires_generate_from_grammar = true, -- if folder contains pre-generated src/parser.c
--   },
--   filetype = "tape",
-- }

-- Syntax Tree Surfer
local opts = { noremap = true, silent = true }

-- Normal Mode Swapping:
-- Swap The Master Node relative to the cursor with it's siblings, Dot Repeatable
-- vim.keymap.set("n", "vU", function()
--  vim.opt.opfunc = "v:lua.STSSwapUpNormal_Dot"
--  return "g@l"
-- end, { silent = true, expr = true })
-- vim.keymap.set("n", "vD", function()
--  vim.opt.opfunc = "v:lua.STSSwapDownNormal_Dot"
--  return "g@l"
-- end, { silent = true, expr = true })

-- Swap Current Node at the Cursor with it's siblings, Dot Repeatable
vim.keymap.set("n", "vj", function()
    vim.opt.opfunc = "v:lua.STSSwapCurrentNodeNextNormal_Dot"
    return "g@l"
end, { silent = true, expr = true })
vim.keymap.set("n", "vk", function()
    vim.opt.opfunc = "v:lua.STSSwapCurrentNodePrevNormal_Dot"
    return "g@l"
end, { silent = true, expr = true })

--> If the mappings above don't work, use these instead (no dot repeatable)
-- vim.keymap.set("n", "vd", '<cmd>STSSwapCurrentNodeNextNormal<cr>', opts)
-- vim.keymap.set("n", "vu", '<cmd>STSSwapCurrentNodePrevNormal<cr>', opts)
-- vim.keymap.set("n", "vD", '<cmd>STSSwapDownNormal<cr>', opts)
-- vim.keymap.set("n", "vU", '<cmd>STSSwapUpNormal<cr>', opts)

-- Visual Selection from Normal Mode
vim.keymap.set("n", "vx", '<cmd>STSSelectMasterNode<cr>', opts)
vim.keymap.set("n", "vn", '<cmd>STSSelectCurrentNode<cr>', opts)

-- Select Nodes in Visual Mode
vim.keymap.set("x", "J", '<cmd>STSSelectNextSiblingNode<cr>', opts)
vim.keymap.set("x", "K", '<cmd>STSSelectPrevSiblingNode<cr>', opts)
vim.keymap.set("x", "H", '<cmd>STSSelectParentNode<cr>', opts)
vim.keymap.set("x", "L", '<cmd>STSSelectChildNode<cr>', opts)

-- Swapping Nodes in Visual Mode
vim.keymap.set("x", "<c-j>", '<cmd>STSSwapNextVisual<cr>', opts)
vim.keymap.set("x", "<c-k>", '<cmd>STSSwapPrevVisual<cr>', opts)

-- Syntax Tree Surfer V2 Mappings
-- Targeted Jump with virtual_text
local sts = require("syntax-tree-surfer")
vim.keymap.set("n", "gv", function() -- only jump to variable_declarations
    sts.targeted_jump({ "variable_declaration" })
end, opts)
vim.keymap.set("n", "gfu", function() -- only jump to functions
    sts.targeted_jump({ "function", "arrrow_function", "function_definition" })
    --> In this example, the Lua language schema uses "function",
    --  when the Python language uses "function_definition"
    --  we include both, so this keymap will work on both languages
end, opts)
-- vim.keymap.set("n", "gif", function() -- only jump to if_statements
--  sts.targeted_jump({ "if_statement", "elseif_statement", "else_statement", "else_clause" })
-- end, opts)
vim.keymap.set("n", "gfo", function() -- only jump to for_statements
    sts.targeted_jump({ "for_statement", "for_each_statement", "while_statement" })
end, opts)
vim.keymap.set("n", "gsw", function() -- only jump to switch_statements
    sts.targeted_jump({ "switch_statement" })
end, opts)
vim.keymap.set("n", "gj", function() -- jump to all that you specify
    sts.targeted_jump({
        "function",
        "method_declaration",
    })
end, opts)

-------------------------------
-- filtered_jump --
-- "default" means that you jump to the default_desired_types or your lastest jump types
vim.keymap.set("n", "<A-n>", function()
    sts.filtered_jump("default", true) --> true means jump forward
end, opts)
vim.keymap.set("n", "<A-p>", function()
    sts.filtered_jump("default", false) --> false means jump backwards
end, opts)

-------------------------------
-- jump with limited targets --
-- jump to sibling nodes only
vim.keymap.set("n", "-", function()
    sts.filtered_jump({
        "if_statement",
        "else_clause",
        "else_statement",
    }, false, { destination = "siblings" })
end, opts)
vim.keymap.set("n", "=", function()
    sts.filtered_jump({ "if_statement", "else_clause", "else_statement" }, true, { destination = "siblings" })
end, opts)

-- jump to parent or child nodes only
vim.keymap.set("n", "_", function()
    sts.filtered_jump({
        "if_statement",
        "else_clause",
        "else_statement",
    }, false, { destination = "parent" })
end, opts)
vim.keymap.set("n", "+", function()
    sts.filtered_jump({
        "if_statement",
        "else_clause",
        "else_statement",
    }, true, { destination = "children" })
end, opts)

-- Setup Function example:
-- These are the default options:
require("syntax-tree-surfer").setup({
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

local default_opts = { noremap = true, silent = true }
local telescope_builtin = require('telescope.builtin')

local method_search_using_treesitter = function()
    local ts_opts = {}
    ts_opts.symbols = { "function", "method" }
    telescope_builtin.treesitter(ts_opts)
end
vim.keymap.set('n', '<leader>fs', telescope_builtin.treesitter, default_opts)
vim.keymap.set('n', '<leader>fm', method_search_using_treesitter, default_opts)

