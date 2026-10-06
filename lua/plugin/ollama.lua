return {

	{
		"ParthSareen/vimollama",
		config = function()
			vim.g.ollama_model = "glm-5.3:cloud" -- required
		end,
		keys = {
			{ "<leader>k", mode = "v", desc = "Ollama Edit" },
			{ "<leader>K", mode = "v", desc = "Ollama Chat" },
			{ "<leader>M", desc = "Ollama Model" },
		},
	},
}
