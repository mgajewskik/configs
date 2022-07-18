-- -- enable filetypee.lua
-- -- This feature is currently opt-in
-- -- as it does not yet completely match all of the filetypes covered by filetype.vim
-- vim.g.do_filetype_lua = 1
-- -- disable filetype.vim
-- vim.g.did_load_filetypes = 0
--
--
-- Map leader to <space>
--vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- We do this to prevent the loading of the system fzf.vim plugin. This is
-- present at least on Arch/Manjaro/Void
vim.api.nvim_command("set rtp-=/usr/share/vim/vimfiles")

require("plugins")
require("keymaps")
require("options")
require("autocmd")

-- set colorscheme to gruvbox
vim.g.colorscheme_terminal_italics = true
vim.o.background = "dark" -- or "light" for light mode

local overrides = {
	Search = { fg = "#0F1F28", bg = "#FF9E3B" },
	-- Visual = { bg = "#717C7C" }
	Visual = { bg = "#54546D" },
}
require("kanagawa").setup({ overrides = overrides })
pcall(vim.cmd, [[colorscheme kanagawa]])
