local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
nls.setup({
	sources = {
		nls.builtins.code_actions.shellcheck,
		-- diagnostics
		nls.builtins.diagnostics.actionlint,
		nls.builtins.diagnostics.cfn_lint,
		nls.builtins.diagnostics.yamllint,
		nls.builtins.diagnostics.flake8,
		nls.builtins.diagnostics.mypy,
		nls.builtins.diagnostics.pylint,
		nls.builtins.diagnostics.pyproject_flake8,
		nls.builtins.diagnostics.alex,
		-- nls.builtins.diagnostics.checkmake,
		nls.builtins.diagnostics.codespell,
		-- nls.builtins.diagnostics.eslint_d,
		nls.builtins.diagnostics.xo,
		nls.builtins.diagnostics.gitlint,
		nls.builtins.diagnostics.golangci_lint,
		nls.builtins.diagnostics.hadolint,
		nls.builtins.diagnostics.luacheck,
		nls.builtins.diagnostics.revive,
		nls.builtins.diagnostics.staticcheck,
		nls.builtins.diagnostics.trail_space,
		-- formatters
		nls.builtins.formatting.fixjson,
		nls.builtins.formatting.jq,
		nls.builtins.formatting.yamlfmt,
		nls.builtins.formatting.stylua,
		nls.builtins.formatting.shfmt,
		nls.builtins.formatting.shellharden,
		nls.builtins.formatting.terraform_fmt,
		nls.builtins.formatting.black,
		nls.builtins.formatting.isort,
		nls.builtins.formatting.goimports,
		nls.builtins.formatting.gofumpt,
		nls.builtins.formatting.codespell,
		nls.builtins.formatting.eslint_d,
	},
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
		require("utils").custom_lsp_attach(client, bufnr)
	end,
})
