return {
   {
      "lambdalisue/suda.vim",
      cmd = {
         "SudaRead",
         "SudaWrite",
      },
   },
   {
      "tpope/vim-surround",
      event = "VeryLazy",
   },
   -- blocks searching through all directories keymap
   -- {
   --    "tpope/vim-repeat",
   --    event = "VeryLazy",
   -- },
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
      "kevinhwang91/nvim-fundo",
      dependencies = { "kevinhwang91/promise-async" },
      config = function()
         require("fundo").install()
      end,
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
   -- {
   --    "echasnovski/mini.operators",
   --    event = "VeryLazy",
   --    config = function()
   --       require("mini.operators").setup()
   --    end,
   -- },
   {
      "m4xshen/hardtime.nvim",
      event = "VeryLazy",
      dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
      opts = {
         max_count = 20,
      },
   },
   {
      "LunarVim/bigfile.nvim",
      event = "VeryLazy",
      config = true,
   },
}
