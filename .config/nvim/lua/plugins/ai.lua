return {
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
      "MunifTanjim/nui.nvim",
   },
   {
      "jackMort/ChatGPT.nvim",
      requires = {
         -- for some reason does not get installed from here
         "MunifTanjim/nui.nvim",
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope.nvim",
      },
      lazy = true,
      cmd = { "ChatGPT" },
      keys = {
         { "<leader>sa", ":ChatGPT<CR>", { noremap = true, silent = true } },
      },
      config = function()
         require("chatgpt").setup({
            keymaps = {
               submit = "<C-J>",
            },
         })
      end,
      -- <C-Enter> to submit.
      -- <C-c> to close chat window.
      -- <C-u> scroll up chat window.
      -- <C-d> scroll down chat window.
      -- <C-y> to copy/yank last answer.
      -- <C-k> to copy/yank code from last answer.
      -- <C-o> Toggle settings window.
      -- <C-n> Start new session.
      -- <Tab> Cycle over windows.
      -- <C-i> [Edit Window] use response as input.
   },
}
