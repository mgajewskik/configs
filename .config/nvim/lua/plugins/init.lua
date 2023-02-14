return {
   {
      "rebelot/kanagawa.nvim",
      lazy = false,
      priority = 1000,
      config = function()
         local overrides = {
            Search = { fg = "#0F1F28", bg = "#FF9E3B" },
            -- Visual = { bg = "#717C7C" }
            Visual = { bg = "#54546D" },
         }
         require("kanagawa").setup({ overrides = overrides })
         vim.cmd("colorscheme kanagawa")
      end,
   },
   {
      "nvim-lua/plenary.nvim",
      lazy = true,
   },
}
