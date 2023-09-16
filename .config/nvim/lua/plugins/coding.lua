return {
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
         goimport = "golines",
         lsp_cfg = true,
         lsp_gofumpt = true,
         -- lsp_on_attach = nil,
         -- lsp_on_attach = function(client, bufnr)
         --    require("utils").on_attach(client, bufnr)
         -- end,
         lsp_on_attach = function(client, buffer)
            require("utils").on_attach(function(client, buffer)
               -- require("utils").format_on_attach(client, buffer)
               require("utils").keymaps_on_attach(client, buffer)
            end)
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
         lsp_inlay_hints = {
            enable = false,
            -- -- Only show inlay hints for the current line
            -- only_current_line = true,
            -- -- Event which triggers a refersh of the inlay hints.
            -- -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- -- not that this may cause higher CPU usage.
            -- -- This option is only respected when only_current_line and
            -- -- autoSetHints both are true.
            -- only_current_line_autocmd = "CursorHold",
            -- -- whether to show variable name before type hints with the inlay hints or not
            -- -- default: false
            -- show_variable_name = true,
            -- -- prefix for parameter hints
            -- parameter_hints_prefix = "󰊕 ",
            -- show_parameter_hints = true,
            -- -- prefix for all the other hints (type, chaining)
            -- other_hints_prefix = "=> ",
            -- -- whether to align to the lenght of the longest line in the file
            -- max_len_align = false,
            -- -- padding from the left if max_len_align is true
            -- max_len_align_padding = 1,
            -- -- whether to align to the extreme right or not
            -- right_align = false,
            -- -- padding from the right if right_align is true
            -- right_align_padding = 6,
            -- -- The color of the hints
            -- highlight = "Comment",
         },
      },
   },
   {
      "hashivim/vim-terraform",
      config = function()
         vim.cmd("let g:terraform_align=1")
         vim.cmd("let g:terraform_fold_sections=0")
         vim.cmd("let g:terraform_fmt_on_save=0")
         vim.cmd("let g:hcl_align=1")
      end,
   },
   {
      "luckasRanarison/nvim-devdocs",
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope.nvim",
         "nvim-treesitter/nvim-treesitter",
      },
      opts = {},
   },
   {
      "stevearc/conform.nvim",
      opts = {
         formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black", "ruff" },
            go = { "golines", "gofumpt", "goimports" },
            json = { "jq" },
            yaml = { "yamlfmt" },
            sh = { "shfmt", "shellcheck", "shellharden" },
            toml = { "taplo" },
            sql = { "pg_format" },
            gohtmltmpl = { "djlint" },
            terraform = { "terraform_fmt" },
            hcl = { "terraform_fmt" },
            ["*"] = { "trim_whitespace", "trim_newlines" },
         },
         notify_on_error = true,
         format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
               return
            end
            return { timeout_ms = 500, lsp_fallback = "always" }
         end,
      },
      config = function(_, opts)
         local util = require("conform.util")
         require("conform").setup(opts)

         -- require("conform.formatters.jq").args = { "--indent", "4" }
         local jq = require("conform.formatters.jq")
         require("conform").formatters.jq = vim.tbl_deep_extend("force", jq, {
            args = util.extend_args(jq.args, { "--indent", "4" }),
         })

         local stylua = require("conform.formatters.stylua")
         require("conform").formatters.stylua = vim.tbl_deep_extend("force", stylua, {
            args = util.extend_args(stylua.args, { "--indent-width", "3", "--indent-type", "Spaces" }),
         })

         local cmd = vim.api.nvim_create_user_command
         cmd("FormatDisable", function(args)
            if args.bang then
               -- FormatDisable! will disable formatting just for this buffer
               vim.b.disable_autoformat = true
            else
               vim.g.disable_autoformat = true
            end
         end, {
            desc = "Disable autoformat-on-save",
            bang = true,
         })

         cmd("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
         end, {
            desc = "Re-enable autoformat-on-save",
         })
      end,
   },
   {
      "mfussenegger/nvim-lint",
      opts = {
         linters_by_ft = {
            yaml = { "actionlint", "cfn_lint", "yamllint" },
            go = { "golangcilint", "revive" },
            lua = { "luacheck" },
            terraform = { "tfsec" },
            dockerfile = { "hadolint" },
            json = { "jsonlint" },
            sql = { "sqlfluff" },
         },
      },
      config = function(_, opts)
         require("lint").linters_by_ft = opts.linters_by_ft

         require("lint.linters.luacheck").args =
         { "--formatter", "plain", "--codes", "--ranges", "-", "--globals", "vim" }

         vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
               require("lint").try_lint()
            end,
         })
      end,
   },
   {
      "williamboman/mason.nvim",
      cmd = "Mason",
      opts = {
         -- https://mason-registry.dev/registry/list
         ensure_installed = {
            -- linters
            "actionlint",
            "cfn-lint",
            "yamllint",
            "golangci-lint",
            "revive",
            "luacheck",
            "tfsec",
            "hadolint",
            "jsonlint",
            "sqlfluff",
            -- formatters
            "stylua",
            "isort",
            "black",
            "ruff",
            "golines",
            "gofumpt",
            "goimports",
            "jq",
            "yamlfmt",
            "shfmt",
            "shellcheck",
            "shellharden",
            "taplo",
            "djlint",
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
}
