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
      "Bryley/neoai.nvim",
      dependencies = {
         "MunifTanjim/nui.nvim",
      },
      cmd = {
         "NeoAI",
         "NeoAIOpen",
         "NeoAIClose",
         "NeoAIToggle",
         "NeoAIContext",
         "NeoAIContextOpen",
         "NeoAIContextClose",
         "NeoAIInject",
         "NeoAIInjectCode",
         "NeoAIInjectContext",
         "NeoAIInjectContextCode",
      },
      keys = {
         { "<leader>as", desc = "summarize text" },
         { "<leader>ag", desc = "generate git message" },
         { "<leader>sa", ":NeoAI<CR>", { noremap = true, silent = true } },
      },
      config = function()
         require("neoai").setup({
            -- Options go here
         })
      end,
   },
   -- {
   --    "jackMort/ChatGPT.nvim",
   --    requires = {
   --       -- for some reason does not get installed from here
   --       "MunifTanjim/nui.nvim",
   --       "nvim-lua/plenary.nvim",
   --       "nvim-telescope/telescope.nvim",
   --    },
   --    lazy = true,
   --    cmd = { "ChatGPT" },
   --    keys = {
   --       { "<leader>sa", ":ChatGPT<CR>", { noremap = true, silent = true } },
   --    },
   --    config = function()
   --       require("chatgpt").setup({
   --          keymaps = {
   --             submit = "<C-CR>",
   --          },
   --       })
   --    end,
   --    -- <C-Enter> to submit.
   --    -- <C-c> to close chat window.
   --    -- <C-u> scroll up chat window.
   --    -- <C-d> scroll down chat window.
   --    -- <C-y> to copy/yank last answer.
   --    -- <C-k> to copy/yank code from last answer.
   --    -- <C-o> Toggle settings window.
   --    -- <C-n> Start new session.
   --    -- <Tab> Cycle over windows.
   --    -- <C-i> [Edit Window] use response as input.
   -- },
}
