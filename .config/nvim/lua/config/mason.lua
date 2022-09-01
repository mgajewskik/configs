require("mason").setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
		keymaps = {
			-- Keymap to expand a package
			toggle_package_expand = "<CR>",
			-- Keymap to install the package under the current cursor position
			install_package = "i",
			-- Keymap to reinstall/update the package under the current cursor position
			update_package = "u",
			-- Keymap to check for new version for the package under the current cursor position
			check_package_version = "c",
			-- Keymap to update all installed packages
			update_all_packages = "U",
			-- Keymap to check which installed packages are outdated
			check_outdated_packages = "C",
			-- Keymap to uninstall a package
			uninstall_package = "X",
			-- Keymap to cancel a package installation
			cancel_installation = "<C-c>",
			-- Keymap to apply language filter
			apply_language_filter = "<C-f>",
		},
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"dockerls",
		"bashls",
		"bashls",
		"dockerls",
		"jsonnet_ls",
		"jsonls",
		"pyright",
		"sumneko_lua",
		"texlab",
		"tsserver",
		"yamlls",
		"gopls",
		"terraformls",
		-- "groovyls",
		"tflint",
		"diagnosticls",
		-- "textlab",
		-- "grammarly",
		"marksman",
		"remark_ls",
		-- "jedi_language_server",
		-- "pylsp",
		"tflint",
	},
	automatic_installation = true,
})
