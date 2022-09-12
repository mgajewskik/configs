-- require("copilot").setup({
-- 	cmp = {
-- 		enabled = true,
-- 		method = "getCompletionsCycling",
-- 	},
-- 	panel = { -- no config options yet
-- 		enabled = true,
-- 	},
-- 	ft_disable = { "markdown" },
-- 	copilot_node_command = "node",
-- 	plugin_manager_path = vim.env.HOME .. "/.vim/plugged",
-- 	-- plugin_manager_path = vim.fn.stdpath("data") .. "/site/autoload/plug.vim",
-- 	-- plugin_manager_path = vim.fn.stdpath("config") .. "/plugged/",
-- 	-- server_opts_overrides = {},
-- })

vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-H>", "copilot#Previous()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
