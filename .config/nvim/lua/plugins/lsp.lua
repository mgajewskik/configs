return {
   {
      "neovim/nvim-lspconfig",
      dependencies = {
         { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
         "mason.nvim",
         "williamboman/mason-lspconfig.nvim",
         "hrsh7th/cmp-nvim-lsp",
      },
      event = { "BufReadPre", "BufNewFile" },
      opts = {
         diagnostics = {
            underline = true,
            update_in_insert = true,
            virtual_text = { spacing = 4, prefix = "●", source = "always" },
            severity_sort = true,
         },
         servers = {
            jsonls = {},
            yamlls = {
               settings = {
                  yaml = {
                     -- FIX mapKeyOrder warning
                     keyOrdering = false,
                  },
               },
            },
            bashls = {},
            dockerls = {},
            gopls = {
               -- filetypes = { "go", "gomod", "gohtmltmpl", "gotexttmpl" },
               settings = {
                  gopls = {
                     analyses = {
                        shadow = true,
                        unusedparams = true,
                        unusedvariable = true,
                     },
                     staticcheck = true,
                     formatting = {
                        gofumpt = true,
                     },
                  },
               },
            },
            lua_ls = {
               settings = {
                  Lua = {
                     diagnostics = {
                        globals = { "vim", "require" },
                     },
                     completion = {
                        callSnippet = "Replace",
                     },
                  },
               },
            },
            pyright = {},
            ruff_lsp = {
               -- https://pypi.org/project/ruff/0.0.47/
               init_options = {
                  settings = {
                     args = {
                        "--config",
                        "$HOME/.config/ruff.toml",
                     },
                  },
               },
            },
            tflint = {},
            marksman = {},
            vimls = {},
            bufls = {},
            spectral = {},
         },
         setup = {},
      },
      config = function(_, opts)
         require("utils").on_attach(function(client, buffer)
            require("utils").format_on_attach(client, buffer)
            require("utils").keymaps_on_attach(client, buffer)
         end)

         -- diagnostics
         -- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
         for name, icon in pairs(require("icons").icons.diagnostics) do
            name = "DiagnosticSign" .. name
            vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
         end
         vim.diagnostic.config(opts.diagnostics)

         local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
         capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
         }

         local servers = opts.servers

         local function setup(server)
            local server_opts = vim.tbl_deep_extend("force", {
               capabilities = vim.deepcopy(capabilities),
            }, servers[server] or {})

            if opts.setup[server] then
               if opts.setup[server](server, server_opts) then
                  return
               end
            elseif opts.setup["*"] then
               if opts.setup["*"](server, server_opts) then
                  return
               end
            end
            require("lspconfig")[server].setup(server_opts)
         end

         -- get all the servers that are available thourgh mason-lspconfig
         local have_mason, mlsp = pcall(require, "mason-lspconfig")
         local all_mslp_servers = {}
         if have_mason then
            all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
         end

         local ensure_installed = {} ---@type string[]
         for server, server_opts in pairs(servers) do
            if server_opts then
               server_opts = server_opts == true and {} or server_opts
               -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
               if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                  setup(server)
               else
                  ensure_installed[#ensure_installed + 1] = server
               end
            end
         end

         if have_mason then
            mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
         end
      end,
   },
   {
      "jose-elias-alvarez/null-ls.nvim",
      dependencies = {
         "mason.nvim",
      },
      event = { "BufReadPre", "BufNewFile" },
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
      opts = function()
         local nls = require("null-ls")
         return {
            sources = {
               -- code actions
               nls.builtins.code_actions.shellcheck,
               nls.builtins.code_actions.gitsigns,
               -- nls.builtins.code_actions.gomodifytags,
               -- diagnostics
               nls.builtins.diagnostics.actionlint,
               nls.builtins.diagnostics.cfn_lint,
               nls.builtins.diagnostics.yamllint,
               nls.builtins.diagnostics.flake8.with({
                  extra_args = {
                     "--max-line-length=120",
                  },
               }),
               -- turning off as throwing too many errors
               -- nls.builtins.diagnostics.mypy,
               -- nls.builtins.diagnostics.pylint,
               -- nls.builtins.diagnostics.pyproject_flake8,
               -- nls.builtins.diagnostics.ruff,
               -- nls.builtins.diagnostics.checkmake,
               -- nls.builtins.diagnostics.codespell,
               nls.builtins.diagnostics.gitlint,
               nls.builtins.diagnostics.commitlint,
               nls.builtins.diagnostics.golangci_lint,
               -- gives weird underlines if no package comment - managed by a config file
               nls.builtins.diagnostics.revive,
               -- nls.builtins.diagnostics.staticcheck,
               nls.builtins.diagnostics.luacheck.with({
                  extra_args = {
                     "--globals",
                     "vim",
                  },
               }),
               nls.builtins.diagnostics.trail_space,
               nls.builtins.diagnostics.tfsec,
               -- nls.builtins.diagnostics.terraform_validate,
               nls.builtins.diagnostics.buf,
               nls.builtins.diagnostics.checkmake,
               -- nls.builtins.diagnostics.dotenv_linter,
               nls.builtins.diagnostics.hadolint,
               nls.builtins.diagnostics.jsonlint,
               nls.builtins.diagnostics.opacheck,
               nls.builtins.diagnostics.sqlfluff.with({
                  extra_args = {
                     "--dialect",
                     "postgres",
                  },
               }),
               nls.builtins.diagnostics.djlint,
               -- formatters
               -- json formatting doesnt work
               -- nls.builtins.formatting.fixjson,
               nls.builtins.formatting.jq.with({
                  extra_args = {
                     "--indent",
                     "4",
                  },
               }),
               nls.builtins.formatting.yamlfmt,
               nls.builtins.formatting.stylua.with({
                  extra_args = {
                     "--indent-type",
                     "Spaces",
                     "--indent-width",
                     "3",
                  },
               }),
               nls.builtins.formatting.shfmt,
               nls.builtins.formatting.shellharden,
               -- nls.builtins.formatting.terraform_fmt,
               nls.builtins.formatting.isort,
               nls.builtins.formatting.ruff,
               nls.builtins.formatting.black,
               -- nls.builtins.formatting.goimports,
               -- nls.builtins.formatting.gofumpt,
               -- nls.builtins.formatting.goimports_reviser,
               -- nls.builtins.formatting.golines,
               -- changes some strings that need to be like they are
               -- nls.builtins.formatting.codespell,
               nls.builtins.formatting.buf,
               nls.builtins.formatting.cbfmt,
               nls.builtins.formatting.djlint,
               nls.builtins.formatting.packer,
               nls.builtins.formatting.rego,
               nls.builtins.formatting.sqlfluff,
               nls.builtins.formatting.taplo,
               nls.builtins.formatting.trim_newlines,
               nls.builtins.formatting.trim_whitespace,
            },
         }
      end,
   },
   {
      "williamboman/mason.nvim",
      cmd = "Mason",
      opts = {
         ensure_installed = {
            -- "gomodifytags",
            -- linters
            "actionlint",
            "codespell",
            "flake8",
            "gitlint",
            "commitlint",
            "golangci-lint",
            "luacheck",
            -- "mypy",
            -- "pylint",
            "pyproject-flake8",
            "revive",
            "shellcheck",
            "shellharden",
            -- "staticcheck",
            -- "textlint",
            "tflint",
            "yamllint",
            "cfn-lint",
            "buf",
            "jsonlint",
            "hadolint",
            "ruff",
            "sqlfluff",
            "djlint",
            -- formatters
            "black",
            -- "fixjson",
            -- "gofumpt",
            -- "goimports",
            -- "goimports-reviser",
            -- "golines",
            "isort",
            "jq",
            "shellharden",
            "shfmt",
            "yamlfmt",
            "cbfmt",
            "taplo",
         },
      },
      config = function(_, opts)
         require("mason").setup(opts)
         local mr = require("mason-registry")
         local function ensure_installed()
            for _, tool in ipairs(opts.ensure_installed) do
               local p = mr.get_package(tool)
               if not p:is_installed() then
                  p:install()
               end
            end
         end
         if mr.refresh then
            mr.refresh(ensure_installed)
         else
            ensure_installed()
         end
      end,
   },
   {
      "simrat39/symbols-outline.nvim",
      lazy = true,
      cmd = "SymbolsOutline",
      config = true,
   },
   {
      "folke/trouble.nvim",
      cmd = { "TroubleToggle", "Trouble" },
      opts = { use_diagnostic_signs = true },
   },
   {
      "hrsh7th/nvim-cmp",
      dependencies = {
         "neovim/nvim-lspconfig",
         "onsails/lspkind-nvim",
         "hrsh7th/cmp-buffer",
         "hrsh7th/cmp-nvim-lsp",
         "hrsh7th/cmp-path",
         "hrsh7th/cmp-cmdline",
         "lukas-reineke/cmp-rg",
         "hrsh7th/cmp-nvim-lsp-signature-help",
         "hrsh7th/cmp-nvim-lsp-document-symbol",
         "L3MON4D3/LuaSnip",
         "hrsh7th/cmp-nvim-lua",
         "petertriho/cmp-git",
      },
      config = function()
         local cmp = require("cmp")
         local lspkind = require("lspkind")

         -- not sure this works as the group for copilot is not configured properly in cmp
         vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

         cmp.setup({
            formatting = {
               format = lspkind.cmp_format({
                  with_text = false,
                  maxwidth = 50,
                  mode = "symbol",
                  menu = {
                     buffer = "BUF",
                     rg = "RG",
                     nvim_lsp = "LSP",
                     path = "PATH",
                     luasnip = "SNIP",
                     calc = "CALC",
                     spell = "SPELL",
                     copilot = " COP",
                  },
                  before = function(entry, vim_item)
                     if entry.source.name == "copilot" then
                        -- vim_item.kind = "[] Copilot"
                        vim_item.kind_hl_group = "CmpItemKindCopilot"
                        return vim_item
                     end
                     return vim_item
                  end,
               }),
            },
            snippet = {
               expand = function(args)
                  require("luasnip").lsp_expand(args.body)
               end,
            },
            mapping = {
               ["<C-d>"] = cmp.mapping.scroll_docs(-4),
               ["<C-u>"] = cmp.mapping.scroll_docs(4),
               ["<C-Space>"] = cmp.mapping.complete(),
               ["<C-e>"] = cmp.mapping.close(),
               ["<CR>"] = cmp.mapping.confirm({
                  behavior = cmp.ConfirmBehavior.Replace,
                  select = false,
               }),
               ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                     cmp.select_next_item()
                  else
                     fallback()
                  end
               end, { "i", "s" }),
               ["<S-Tab>"] = cmp.mapping(function()
                  if cmp.visible() then
                     cmp.select_prev_item()
                  end
               end, { "i", "s" }),
            },
            sources = {
               -- { name = "copilot", group_index = 2 },
               { name = "nvim_lua" },
               { name = "path" },
               { name = "nvim_lsp" },
               { name = "nvim_lsp_signature_help" },
               { name = "git" },
               { name = "buffer", keyword_length = 5 },
               { name = "luasnip" },
               -- { name = "calc" },
               -- { name = "spell", keyword_length = 5 },
               { name = "rg", keyword_length = 5 },
            },
         })

         -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline("/", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
               { name = "nvim_lsp_document_symbol" },
            }, {
               { name = "buffer" },
            }),
         })

         -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
         cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
               { name = "path" },
            }, {
               { name = "cmdline" },
            }),
         })
      end,
   },
}
