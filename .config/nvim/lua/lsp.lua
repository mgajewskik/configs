local nvim_lsp = require('lspconfig')
local coq = require('coq')
local on_attach = function(_, bufnr)
  print("LSP started.");
end


nvim_lsp.pyright.setup(coq.lsp_ensure_capabilities({
  cmd = { "pyright-langserver", "--stdio" };
  filetypes = { "python" };
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true
      },
      linting = {
        enabled = true,
        pylintEnabled = true
      },
      formatting = {
        enabled = true,
        provider = black
      },
    },
  },
  on_attach = on_attach,
}))


nvim_lsp.gopls.setup(coq.lsp_ensure_capabilities({
  cmd = { "gopls", "serve" };
  filetypes = { "go", "gomod" };
  root_dir = nvim_lsp.util.root_pattern('go.mod', '.git');
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  on_attach = on_attach,
}))


nvim_lsp.terraformls.setup(coq.lsp_ensure_capabilities({
  cmd = { "terraform-ls", "serve" };
  filetypes = { "terraform", "tf", "tfvars" };
  root_dir = nvim_lsp.util.root_pattern('.git');
  on_attach = on_attach,
}))


nvim_lsp.groovyls.setup(coq.lsp_ensure_capabilities({
  cmd = { "java", "-jar", "/home/mgajewskik/repos/cloned/groovy-language-server/build/libs/groovy-language-server-all.jar" };
  filetypes = { "groovy" };
  root_dir = nvim_lsp.util.root_pattern('.git');
  on_attach = on_attach,
}))


--local saga = require 'lspsaga'
--saga.init_lsp_saga()









--require'lspconfig'.pyls_ms.setup{ on_attach=require'completion'.on_attach }
--require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
--require'lspconfig'.sqlls.setup{ on_attach=require'completion'.on_attach }
--require'lspconfig'.dockerls.setup{ on_attach=require'completion'.on_attach }
--require'lspconfig'.bashls.setup{ on_attach=require'completion'.on_attach }
--require'lspconfig'.jsonls.setup{ on_attach=require'completion'.on_attach }
--require'lspconfig'.vimls.setup{ on_attach=require'completion'.on_attach }
--require'snippets'.use_suggested_mappings()
  --local lsp_status = require('lsp-status')
  --lsp_status.register_progress()
  --lsp_status.config({
    --indicator_errors = 'E',
    --indicator_warnings = 'W',
    --indicator_info = 'i',
    --indicator_hint = '?',
    --indicator_ok = 'Ok',
  --})
    --handlers = lsp_status.extensions.pyls_ms.setup(),
    --on_attach = lsp_status.on_attach,
    --capabilities = lsp_status.capabilities
    --
    --
    --
    --
--local servers = {'jsonls', 'dockerls', 'sqlls', 'bashls'}
--for _, lsp in ipairs(servers) do
  --nvim_lsp[lsp].setup {
    --on_attach = on_attach,
  --}
--end


--nvim_lsp.pyls.setup {
  --enable = true,
  --plugins = {
    --pyls_black = {
      --enabled = true,
    --},
    --pyls_isort = {
      --enabled = true,
    --},
  --},
  --on_attach = on_attach,
--}


--nvim_lsp.pyls.setup {
  --enable = true,
  --plugins = {
    --pyls_mypy = {
      --enabled = true,
      --live_mode = false
    --}
  --},
  --on_attach = on_attach,
--}


--nvim_lsp.pyls.setup {
  --enable = true,
  --plugins = {
    --pyls_mypy = {
      --enabled = true,
      --live_mode = false
    --},
    --pyls_black = {
      --enabled = true,
    --},
    --pyls_isort = {
      --enabled = true,
    --},
  --},
  --on_attach = on_attach,
--}

--nvim_lsp.pyright.setup {
  --cmd = { "pyright-langserver", "--stdio" };
  --filetypes = { "python" };
  --settings = {
    --python = {
      --analysis = {
        --autoSearchPaths = true,
        --useLibraryCodeForTypes = true
      --},
    --},
  --},
  --on_attach = on_attach,
--}


  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)


  --root_dir = nvim_lsp.util.root_pattern('.git');
  --cmd = { "gopls", "serve" };
  --settings = {
    --gopls = {
      --analyses = {
        --unusedparams = true,
      --},
      --staticcheck = true,
    --},
  --},

  --vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
  --vim.lsp.diagnostic.on_publish_diagnostics, {
    --underline = true,
    --virtual_text = true,
    --signs = true,
    --update_in_insert = false,
  --}
  --)

  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  --vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)

--highlight LspDiagnosticsDefaultError guifg='DarkRed' guibg='LightRed'
--highlight LspDiagnosticsDefaultWarning guifg='DarkRed' guibg='LightRed'

 --possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
--let g:completion_enable_snippet = 'snippets.nvim'
