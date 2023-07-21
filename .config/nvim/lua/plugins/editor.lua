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
      -- easy align with gl=
      "tommcdo/vim-lion",
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
}
