require("copilot").setup({
	cmp = {
		enabled = true,
		method = "getCompletionsCycling",
	},
	panel = { -- no config options yet
		enabled = false,
	},
	ft_disable = { "markdown" },
	-- plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
	-- server_opts_overrides = {},
})
