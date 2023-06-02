local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
   })
end
vim.opt.rtp:prepend(lazypath)

require("options")

require("lazy").setup("plugins", {
   defaults = {
      lazy = false,
   },
   install = {
      missing = true,
   },
   change_detection = {
      enabled = false,
   },
   performance = {
      rtp = {
         disabled_plugins = {
            "netrw",
            "netrwPlugin",
            "netrwSettings",
            "netrwFileHandlers",
            "gzip",
            "zip",
            "zipPlugin",
            "tar",
            "tarPlugin",
            "getscript",
            "getscriptPlugin",
            "vimball",
            "vimballPlugin",
            "2html_plugin",
            "logipat",
            "rrhelper",
            "spellfile_plugin",
            "fzf",
            -- 'matchit',
            --'matchparen',
         },
      },
   },
})

vim.api.nvim_create_autocmd("User", {
   pattern = "VeryLazy",
   callback = function()
      require("keymaps")
      require("cmd")
      require("autocmd")
      require("filetypes")
      require("fzk").setup()
   end,
})
