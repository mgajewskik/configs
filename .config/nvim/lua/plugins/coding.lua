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
      "hashivim/vim-terraform",
      config = function()
         vim.cmd("let g:terraform_align=1")
         vim.cmd("let g:terraform_fold_sections=0")
         vim.cmd("let g:terraform_fmt_on_save=1")
         vim.cmd("let g:hcl_align=1")
      end,
   },
}
