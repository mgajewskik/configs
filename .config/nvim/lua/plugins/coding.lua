return {
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
         lsp_on_attach = nil,
         -- lsp_on_attach = function(client, bufnr)
         --    require("utils").custom_lsp_attach(client, bufnr)
         -- end,
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
