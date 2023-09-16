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
               require("utils").format_on_attach(client, buffer)
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
         vim.cmd("let g:terraform_fmt_on_save=1")
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
}
