require("project_nvim").setup({
	-- use :ProjectRoot to change directory
	manual_mode = true,
	silent_chdir = false,
	patterns = {
		".git",
		-- "package.json",
		-- ".terraform",
		"go.mod",
		-- "requirements.yml",
		-- "pyrightconfig.json",
		"pyproject.toml",
	},
	-- detection_methods = { "lsp", "pattern" },
	detection_methods = { "pattern" },
})

local remap = require("utils").remap
local default_options = { silent = true }
remap("n", "<leader>sp", ":Telescope projects<CR>", default_options)
