require "gitlinker".setup()

require('git-conflict').setup {
  default_mappings = {
    ours = 'co',
    theirs = 'ct',
    none = 'c0',
    both = 'cb',
    next = 'cn',
    prev = 'cp',
  },
}

require("git-worktree").setup({
    -- change_directory_command = <str> -- default: "cd",
    -- update_on_change = <boolean> -- default: true,
    -- update_on_change_command = <str> -- default: "e .",
    -- clearjumps_on_change = <boolean> -- default: true,
    -- autopush = <boolean> -- default: false,
})

require("telescope").load_extension("git_worktree")

local default_opts = { noremap = true, silent = true }
local telescope_builtin = require('telescope.builtin')
local actions = require "telescope.actions"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local previewers = require "telescope.previewers"
local conf = require("telescope.config").values
local Path = require "plenary.path"

local repo_commit_with_author = function()
	local opts = {}
	opts.git_command = { "git", "log", "--pretty=format:%h %s [%ad] [%cn]\n", "--date=short", "--", "." }
	telescope_builtin.git_commits(opts)
end

local buffer_commit_with_author = function()
	local opts = {}
	opts.git_command = { "git", "log", "--pretty=format:%h %s [%ad] [%cn]\n", "--date=short", "--follow" }
	telescope_builtin.git_bcommits(opts)
end

local git_line_commits = function(opts)
	opts = opts or {}

	local current_window_index = 0
	local line_index = 1

	local cursor_end_number = vim.api.nvim_win_get_cursor(current_window_index)[line_index]
	local cursor_start_number = vim.fn.line('v')
	local line_number_start = cursor_start_number > cursor_end_number and cursor_end_number or cursor_start_number
	local line_number_end = cursor_start_number > cursor_end_number and cursor_start_number or cursor_end_number

	local search_term = line_number_start .. "," .. line_number_end .. ":" .. Path.new(vim.api.nvim_buf_get_name(0)):make_relative(vim.loop.cwd())
	local git_command =
		vim.F.if_nil(opts.git_command,
			{ "git", "log", "--pretty=format:%h %s [%ad] [%cn]\n", "--no-patch", "-L", search_term, "--date=short" })
	opts.entry_maker = vim.F.if_nil(opts.entry_maker, make_entry.gen_from_git_commits(opts))

	pickers
		.new(opts, {
			prompt_title = "git line commits",
			finder = finders.new_oneshot_job(git_command, opts),
			previewer = {
				previewers.git_commit_diff_to_parent.new(opts),
				previewers.git_commit_diff_to_head.new(opts),
				previewers.git_commit_diff_as_was.new(opts),
				previewers.git_commit_message.new(opts),
			},
			sorter = conf.file_sorter(opts),
			attach_mappings = function(_, map)
				actions.select_default:replace(actions.git_checkout)
				map({ "i", "n" }, "<c-r>m", actions.git_reset_mixed)
				map({ "i", "n" }, "<c-r>s", actions.git_reset_soft)
				map({ "i", "n" }, "<c-r>h", actions.git_reset_hard)
				return true
			end,
		})
		:find()
end

vim.keymap.set('n', '<leader>fb', telescope_builtin.git_branches, default_opts)
vim.keymap.set('n', '<leader>glf', buffer_commit_with_author, default_opts)
vim.keymap.set('n', '<leader>glr', repo_commit_with_author, default_opts)
vim.keymap.set('n', '<leader>gll', git_line_commits, default_opts)
vim.keymap.set('x', '<leader>gll', git_line_commits, default_opts)

vim.keymap.set('n', '<leader>gcb', function()
  require('telescope').extensions.git_worktree.git_worktrees()
end, default_opts)

vim.keymap.set('n', '<leader>gpb', function()
  require('telescope').extensions.git_worktree.create_git_worktree()
end, default_opts)

vim.keymap.set('n', '<leader>gpp', ":Git push<CR>", default_opts)
vim.keymap.set('n', '<leader>gpf', ":Git push -f<CR>", default_opts)
