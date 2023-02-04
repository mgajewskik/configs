require("go").setup({
	lsp_cfg = true,
	lsp_gofumpt = true,
	lsp_on_attach = function(client, bufnr)
		require("utils").custom_lsp_attach(client, bufnr)
	end,
	lsp_codelens = false,
	lsp_keymaps = false,
	lsp_diag_update_in_insert = true,
	lsp_document_formatting = false,
	dap_debug_keymap = false,
	icons = { breakpoint = "B", currentpos = "C" }, -- setup to `false` to disable icons setup
	build_tags = "",
	run_in_floaterm = true,
	luasnip = true,
})
