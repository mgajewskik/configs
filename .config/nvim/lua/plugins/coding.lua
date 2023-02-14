return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- NOTE: this is not a hard dependency
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		-- config = function()
		-- 	require("config.lsp")
		-- end,
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = true,
				virtual_text = { spacing = 4, prefix = "●", source = "always" },
				severity_sort = true,
			},
			-- -- Automatically format on save
			-- autoformat = true,
			-- -- options for vim.lsp.buf.format
			-- -- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- -- but can be also overridden when specified
			-- format = {
			-- 	formatting_options = nil,
			-- 	timeout_ms = nil,
			-- },
			servers = {
				jsonls = {},
				jsonnet_ls = {},
				yamlls = {},
				bashls = {},
				dockerls = {},
				-- lua_ls = {
				-- 	diagnostics = {
				-- 		globals = { "vim" },
				-- 	},
				-- },
				sumneko_lua = {
					settings = {
						Lua = {
							diagnostics = {
								-- enable = false,
								globals = { "vim" },
							},
						},
					},
				},
				pyright = {},
				terraformls = {},
				marksman = {},
				vimls = {},
			},
			setup = {},
		},
		config = function(_, opts)
			-- setup autoformat
			-- require("lazyvim.plugins.lsp.format").autoformat = opts.autoformat
			-- -- setup formatting and keymaps
			-- require("lazyvim.util").on_attach(function(client, buffer)
			-- 	require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
			-- 	require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
			-- end)
			require("utils").on_attach(function(client, buffer)
				require("utils").custom_lsp_attach(client, buffer)
			end)

			-- diagnostics
			-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization#customizing-how-diagnostics-are-displayed
			for name, icon in pairs(require("icons").icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
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

			-- not needed for sumneko lua
			-- temp fix for lspconfig rename
			-- https://github.com/neovim/nvim-lspconfig/pull/2439
			local mappings = require("mason-lspconfig.mappings.server")
			if not mappings.lspconfig_to_package.lua_ls then
				mappings.lspconfig_to_package.lua_ls = "lua-language-server"
				mappings.package_to_lspconfig["lua-language-server"] = "lua_ls"
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers()

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
			require("mason-lspconfig").setup_handlers({ setup })
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
					nls.builtins.code_actions.shellcheck,
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
					nls.builtins.diagnostics.pyproject_flake8,
					-- nls.builtins.diagnostics.checkmake,
					nls.builtins.diagnostics.codespell,
					-- nls.builtins.diagnostics.eslint_d,
					nls.builtins.diagnostics.xo,
					nls.builtins.diagnostics.gitlint,
					nls.builtins.diagnostics.golangci_lint,
					nls.builtins.diagnostics.hadolint,
					nls.builtins.diagnostics.luacheck.with({
						extra_args = {
							"--globals",
							"vim",
							-- "--config",
							-- "~/.config/nvim/.luacheckrc",
						},
					}),
					-- gives weird underlines if no package comment - managed by a config file
					nls.builtins.diagnostics.revive,
					nls.builtins.diagnostics.staticcheck,
					nls.builtins.diagnostics.trail_space,
					-- nls.builtins.diagnostics.tflint,
					nls.builtins.diagnostics.tfsec,
					-- formatters
					nls.builtins.formatting.fixjson,
					nls.builtins.formatting.jq,
					nls.builtins.formatting.yamlfmt,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.shfmt,
					nls.builtins.formatting.shellharden,
					-- this formatting is so slow
					nls.builtins.formatting.terraform_fmt,
					nls.builtins.formatting.black,
					nls.builtins.formatting.isort,
					nls.builtins.formatting.goimports,
					nls.builtins.formatting.gofumpt,
					-- changes some strings that need to be like they are
					-- nls.builtins.formatting.codespell,
					nls.builtins.formatting.eslint_d,
				},
			}
		end,
		-- config = function()
		-- 	require("config.null-ls")
		-- end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
				-- linters
				"actionlint",
				-- "alex",
				-- "cfn-lint",
				"codespell",
				"eslint_d",
				"flake8",
				"gitlint",
				"golangci-lint",
				"hadolint",
				"luacheck",
				-- "markdownlint",
				-- "mypy",
				-- "pylint",
				"pyproject-flake8",
				"revive",
				"shellcheck",
				"shellharden",
				"staticcheck",
				-- "textlint",
				"tflint",
				"xo",
				"yamllint",
				-- formatters
				-- "autopep8",
				"black",
				"fixjson",
				"gofumpt",
				"goimports",
				"isort",
				"jq",
				-- "markdownlint",
				"shellharden",
				"shfmt",
				"yamlfmt",
			},
		},
		-- @param opts MasonSettings | {ensure_installed: string[]}
		config = function(plugin, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
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
			"L3MON4D3/LuaSnip",
			-- "saadparwaiz1/cmp_luasnip",
			-- "hrsh7th/cmp-nvim-lua",
			-- "hrsh7th/cmp-calc",
			-- "hrsh7th/cmp-emoji",
			-- "hrsh7th/cmp-spell",
			-- "hrsh7th/cmp-look",
			-- "hrsh7th/cmp-treesitter",
		},
		-- event = "InsertEnter",
		-- config = function()
		-- 	require("config.cmp")
		-- end,
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
					{ name = "copilot", group_index = 2 },
					{ name = "path" },
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
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
				sources = {
					{ name = "buffer" },
				},
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
	{
		"github/copilot.vim",
		event = "VeryLazy",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.g.copilot_filetypes = { yaml = "v:true" }
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
			vim.api.nvim_set_keymap("i", "<C-H>", "copilot#Previous()", { silent = true, expr = true })
			vim.api.nvim_set_keymap("i", "<C-L>", "copilot#Next()", { silent = true, expr = true })
		end,
	},
	-- seems unnecessary if only for formatting on save
	-- {
	--     "hashivim/vim-terraform",
	--     init = function()
	--         vim.g.terraform_align = 1
	--         vim.g.terraform_fold_sections = 0
	--         vim.g.terraform_fmt_on_save = 1
	--     end,
	-- },
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		lazy = true,
		-- event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
		opts = {
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
		},
	},
	-- {
	-- 	"williamboman/mason-lspconfig.nvim",
	-- 	dependencies = {
	-- 		"williamboman/mason.nvim",
	-- 	},
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"sumneko_lua",
	-- 			"dockerls",
	-- 			"bashls",
	-- 			"jsonnet_ls",
	-- 			"jsonls",
	-- 			"yamlls",
	-- 			"gopls",
	-- 			"golangci_lint_ls",
	-- 			"terraformls",
	-- 			"tflint",
	-- 			-- "diagnosticls",
	-- 			"marksman",
	-- 			-- "jedi_language_server",
	-- 			-- "pylsp",
	-- 			"pyright",
	-- 			"vimls",
	-- 			"tsserver",
	-- 			-- Mason export
	-- 			-- bash-language-server
	-- 			-- diagnostic-languageserver
	-- 			-- dockerfile-language-server
	-- 			-- golangci-lint-langserver
	-- 			-- gopls
	-- 			-- json-lsp
	-- 			-- jsonnet-language-server
	-- 			-- lua-language-server
	-- 			-- marksman
	-- 			-- pyright
	-- 			-- remark-language-server
	-- 			-- terraform-ls
	-- 			-- tflint
	-- 			-- typescript-language-server
	-- 			-- vim-language-server
	-- 			-- yaml-language-server
	-- 		},
	-- 		automatic_installation = true,
	-- 	},
	-- },
}
