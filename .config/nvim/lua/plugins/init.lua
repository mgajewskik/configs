return {
   {
      "rebelot/kanagawa.nvim",
      lazy = false,
      priority = 1000,
      config = function()
         require("kanagawa").setup({
            overrides = function(colors)
               return {
                  Search = { fg = "#0F1F28", bg = "#FF9E3B" },
                  -- Visual = { bg = "#717C7C" }
                  Visual = { bg = "#54546D" },
                  SignColumn = { bg = "#1F1F28" },
                  LineNr = { bg = "#1F1F28" },
               }
            end,
         })
         vim.cmd("colorscheme kanagawa")
      end,
   },
   {
      "nvim-lua/plenary.nvim",
      lazy = true,
   },
}
