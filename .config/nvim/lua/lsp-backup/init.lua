if not pcall(require, "lspconfig") or not pcall(require, "nvim-lsp-installer") then
  return
end

-- Setup icons & handler helper functions
require('lsp.diag')
require('lsp.icons')
require('lsp.handlers')

-- default 'on_attach' function
local on_attach = require('lsp.on_attach').on_attach

-- Enable borders for hover/signature help
vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

-- Lua settings
local lua_settings = {
  Lua = {
    runtime = {
      -- LuaJIT in the case of Neovim
      version = 'LuaJIT',
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize the `vim` global
      globals = {
        'vim',
        'root',         -- awesomeWM
        'awesome',      -- awesomeWM
        'screen',       -- awesomeWM
        'client',       -- awesomeWM
        'clientkeys',   -- awesomeWM
        'clientbuttons',-- awesomeWM
      },
    },
    workspace = {
      -- Make the server aware of Neovim runtime files
      library = {
        [vim.fn.expand('$VIMRUNTIME/lua')] = true,
        [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
      },
    },
  }
}

-- local pyright_settings = {
--   cmd = { "pyright-langserver", "--stdio" };
--     filetypes = { "python" };
--     settings = {
--       python = {
--         analysis = {
--           autoSearchPaths = true,
--           useLibraryCodeForTypes = true
--         },
--         linting = {
--           enabled = true,
--           pylintEnabled = true
--         },
--         formatting = {
--           enabled = true,
--           provider = black
--         },
--       },
--     },
--     on_attach = on_attach,
-- }
--
-- local gopls_settings = {
--   cmd = { "gopls", "serve" };
--   filetypes = { "go", "gomod" };
--   root_dir = on_attach.util.root_pattern('go.mod', '.git');
--   settings = {
--     gopls = {
--       analyses = {
--         unusedparams = true,
--       },
--       staticcheck = true,
--     },
--   },
--   on_attach = on_attach,
-- }
--
-- local terraformls_settings = {
--   cmd = { "terraform-ls", "serve" };
--   filetypes = { "terraform", "tf", "tfvars" };
--   root_dir = on_attach.util.root_pattern('.git');
--   on_attach = on_attach,
-- }
--
-- local groovyls_settings = {
--   cmd = { "java", "-jar", "/home/mgajewskik/repos/cloned/groovy-language-server/build/libs/groovy-language-server-all.jar" };
--   filetypes = { "groovy" };
--   root_dir = on_attach.util.root_pattern('.git');
--   on_attach = on_attach,
-- }

-- enables snippet support
local function make_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  if pcall(require, 'cmp_nvim_lsp') then
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
  end
  return {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- manually installed LSP servers
local servers = { 'gopls', 'jedi_language_server', 'terraformls', 'groovyls', "bashls", "dockerls", "jsonnet_ls", "pyright", "yamlls", "tflint", "diagnosticls" }
for _, srv in ipairs(servers) do
  local cfg = make_config()
  -- if srv == 'ccls' then
  --   cfg = vim.tbl_deep_extend("force", ccls_settings, cfg)
  -- end
  require("lspconfig")[srv].setup(cfg)
end

-- :LspInstallInfo - opens a graphical overview of your language servers
-- :LspInstall [--sync] [server] ... - installs/reinstalls language servers. Runs in a blocking fashion if the --sync argument is passed (only recommended for scripting purposes).
-- :LspUninstall [--sync] <server> ... - uninstalls language servers. Runs in a blocking fashion if the --sync argument is passed (only recommended for scripting purposes).
-- :LspUninstallAll [--no-confirm] - uninstalls all language servers
-- :LspInstallLog - opens the log file in a new tab window
-- :LspPrintInstalled - prints all installed language servers

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.settings {
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
}

lsp_installer.on_server_ready(function(server)
    local opts = make_config()

    if server.name == "sumneko_lua" then
      opts.settings = lua_settings
      opts.root_dir = function(path)
        return require'lspconfig.util'.root_pattern({".git", ".sumneko_lua"})(path)
          or vim.fn.expand('%:h')
      end
    end

    -- This setup() function is exactly the same as
    -- lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)
