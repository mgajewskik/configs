local M = {}

local my_opts = {
   cwd = vim.fn.expand("$HOME/dropbox/obsidian"),
   grep = {
      -- NOTE those options do not work here and are taken from the main config
      rg_opts = "--column --line-number --no-heading --color=always --smart-case",
   },
}

function M.setup()
   local fzf = require("fzf-lua")
   local opts = vim.tbl_deep_extend("force", my_opts, opts or {})
   local map = vim.keymap.set
   local map_opts = { noremap = true, silent = true }

   map("n", "<leader>zf", function()
      -- fzf.files({
      --    -- cwd = opts.home_dir,
      --    -- TODO insert link from this action and keep all default ones
      --    -- this overwrites whole settings
      --    -- actions = {
      --    --    ["ctrl-i"] = function(selected)
      --    --       return "edit " .. selected[1]
      --    --    end,
      --    -- },
      -- })
      fzf.files(opts)
   end, map_opts)
   map("n", "<leader>zs", function()
      -- fzf.live_grep_glob({ cwd = opts.home_dir })
      fzf.live_grep_glob(opts)
   end, map_opts)
end

return M
