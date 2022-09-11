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

-- apparently this doesn't work with formatters, need to install them manually
require("mason-lspconfig").setup({
	ensure_installed = {
		"sumneko_lua",
		"luacheck",
		"dockerls",
		"hadolint",
		"bashls",
		"shfmt",
		"shellcheck",
		"shellharden",
		"jsonnet_ls",
		"jsonls",
		"fixjson",
		"jq",
		-- "texlab",
		"yamlls",
		"yamllint",
		"yamlfmt",
		"gopls",
		"golangci_lint_ls",
		"gofumpt",
		"goimports",
		-- "golines",
		"revive",
		"staticcheck",
		"terraformls",
		"tflint",
		"diagnosticls",
		"marksman",
		"alex",
		-- "jedi_language_server",
		-- "pylsp",
		"pyright",
		"black",
		"isort",
		"flake8",
		"pylint",
		"pyproject_flake8",
		"mypy",
		"vimls",
		"eslint_d",
		"xo",
		"tsserver",
		"actionlint",
		"cfn-lint",
		"codespell",
		"gitlint",
	},
	automatic_installation = true,
})
