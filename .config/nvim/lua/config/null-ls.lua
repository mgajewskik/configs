local nls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
nls.setup({
  sources = {
    nls.builtins.formatting.stylua,
    nls.builtins.diagnostics.actionlint,
    nls.builtins.diagnostics.cfn_lint,
    nls.builtins.diagnostics.yamllint,
    nls.builtins.diagnostics.flake8,
    -- nls.builtins.formatting.prettier.with({
    -- 	extra_args = { "--single-quote", "false" },
    -- }),
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    nls.builtins.formatting.prettierd.with({
      filetypes = {
        "json",
        "yaml",
        "jsonc",
      },
    }),
    -- nls.builtins.formatting.fixjson,
    nls.builtins.formatting.shfmt,
    nls.builtins.formatting.terraform_fmt,
    nls.builtins.formatting.black,
    nls.builtins.formatting.isort,
    nls.builtins.formatting.goimports,
    nls.builtins.formatting.gofumpt,
    nls.builtins.code_actions.shellcheck,
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
