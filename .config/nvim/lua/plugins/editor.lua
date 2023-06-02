return {
   {
      "tpope/vim-surround",
      event = "VeryLazy",
   },
   {
      "tpope/vim-repeat",
      event = "VeryLazy",
   },
   {
      "mbbill/undotree",
      keys = {
         { "<leader>u", ":UndotreeToggle<CR>:UndotreeFocus<CR>", { noremap = true } },
      },
   },
   {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      config = function()
         require("mini.comment").setup()
      end,
   },
   {
      "echasnovski/mini.indentscope",
      opts = {
         draw = {
            delay = 10,
            animation = function(_, _)
               return 5
            end,
         },
         mappings = {
            object_scope = "ii",
            object_scope_with_border = "ai",
            goto_top = "[i",
            goto_bottom = "]i",
         },
         options = {
            try_as_border = true,
         },
         -- Which character to use for drawing scope indicator
         -- alternative styles: ┆ ┊ ╎
         symbol = "╎",
      },
      config = function(_, opts)
         require("mini.indentscope").setup(opts)
      end,
   },
   {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      opts = {
         mappings = {
            ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%a\\].", register = { cr = false } },
            ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
            ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%a\\].", register = { cr = false } },
         },
      },
      config = function(_, opts)
         require("mini.pairs").setup(opts)
      end,
   },
   {
      "echasnovski/mini.ai",
      event = "VeryLazy",
      config = function()
         require("mini.ai").setup()
      end,
   },
   {
      -- easy align with gl=
      "tommcdo/vim-lion",
   },
}
