local remap = require("utils").remap

-- -- Map leader to <space>
-- --vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent=true})
-- vim.g.mapleader      = ' '
-- vim.g.maplocalleader = ' '

-- local command = require'utils'.command

-- Shortcuts for editing the keymap file and reloading the config
--vim.cmd [[command! -nargs=* NvimEditInit split | edit $MYVIMRC]]
--vim.cmd [[command! -nargs=* NvimEditKeymap split | edit ~/.config/nvim/lua/keymaps.lua]]
--vim.cmd [[command! -nargs=* NvimSourceInit luafile $MYVIMRC]]

-- command({
--     "-nargs=*", "NvimRestart", function()
--     if not pcall(require, 'nvim-reload') then
--       require('packer').loader('nvim-reload')
--     end
--     require('nvim-reload').Restart()
--     require('plugins.nvim-reload')
--   end})

-- Use ':Grep' or ':LGrep' to grep into quickfix|loclist
-- without output or jumping to first match
-- Use ':Grep <pattern> %' to search only current file
-- Use ':Grep <pattern> %:h' to search the current file dir
--vim.cmd("command! -nargs=+ -complete=file Grep " ..
--"lua vim.api.nvim_exec([[noautocmd grep! <args> | redraw! | copen]], true)")
--vim.cmd("command! -nargs=+ -complete=file LGrep " ..
--"lua vim.api.nvim_exec([[noautocmd lgrep! <args> | redraw! | lopen]], true)")

--remap('', '<leader>ei', '<Esc>:NvimEditInit<CR>',   { silent = true })
--remap('', '<leader>ek', '<Esc>:NvimEditKeymap<CR>', { silent = true })
-- remap('', '<leader>R',  "<Esc>:NvimRestart<CR>",    { silent = true })

-- Fix common typos
vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

--remap('n', '<Space>', '<leader>', { noremap = false })

-- <ctrl-s> to Save
--remap({ 'n', 'v', 'i'}, '<C-S>', '<C-c>:update<cr>', { silent = true })

-- remap ESC key in insert mode only
remap("i", "jj", "<Esc>", { noremap = true })
remap("i", "jk", "<Esc>", { noremap = true })
remap("i", "kj", "<Esc>", { noremap = true })

-- 0 goes to first non-blank character
remap("n", "0", "^", { noremap = true })
remap("n", "^", "0", { noremap = true })

-- w!! to save with sudo
remap("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- Beginning and end of line in `:` command mode
remap("c", "<C-a>", "<home>", {})
remap("c", "<C-e>", "<end>", {})

-- Arrows in command line mode (':') menus
remap("c", "<down>", '(pumvisible() ? "\\<C-n>" : "\\<down>")', { noremap = true, expr = true })
remap("c", "<up>", '(pumvisible() ? "\\<C-p>" : "\\<up>")', { noremap = true, expr = true })

-- Terminal mappings
remap("t", "<C-w>e", [[<C-\><C-n>]], { noremap = true })
--remap('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true })
remap("t", "<M-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { noremap = true, expr = true })
remap("n", "<leader>tt", ":tabnew<CR>:terminal<CR>i", { noremap = true })

-- tmux like directional window resizes
-- remap('n', '<leader><Up>',    "<cmd>lua require'utils'.resize(false, -10)<CR>", { noremap = true, silent = true })
-- remap('n', '<leader><Down>',  "<cmd>lua require'utils'.resize(false,  10)<CR>", { noremap = true, silent = true })
-- remap('n', '<leader><Left>',  "<cmd>lua require'utils'.resize(true,  -10)<CR>", { noremap = true, silent = true })
-- remap('n', '<leader><Right>', "<cmd>lua require'utils'.resize(true,   10)<CR>", { noremap = true, silent = true })
-- remap('n', '<leader>=',       '<C-w>=',               { noremap = true, silent = true })

-- Pane navigation
remap("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
remap("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
remap("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
remap("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

-- Tab navigation
remap("n", "<leader>1", "1gt", { noremap = true })
remap("n", "<leader>2", "2gt", { noremap = true })
remap("n", "<leader>3", "3gt", { noremap = true })
remap("n", "<leader>4", "4gt", { noremap = true })
remap("n", "<leader>5", "5gt", { noremap = true })
remap("n", "<leader>6", "6gt", { noremap = true })
remap("n", "<leader>7", "7gt", { noremap = true })
remap("n", "<leader>8", "8gt", { noremap = true })
remap("n", "<leader>9", "9gt", { noremap = true })
--remap('n', '[t',         ':tabprevious<CR>', { noremap = true })
--remap('n', ']t',         ':tabnext<CR>',     { noremap = true })
--remap('n', '[T',         ':tabfirst<CR>',    { noremap = true })
--remap('n', ']T',         ':tablast<CR>',     { noremap = true })
remap("n", "<Leader>tn", ":tabnew<CR>", { noremap = true })
remap("n", "<Leader>tc", ":tabclose<CR>", { noremap = true })
remap("n", "<Leader>to", ":tabonly<CR>", { noremap = true })
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
remap("n", "<Leader>tO", ":tabfirst<CR>:tabonly<CR>", { noremap = true })
-- tmux <c-meta>z like
remap("n", "<Leader>tz", "<cmd>lua require'utils'.tabZ()<CR>", { noremap = true })

-- Navigate buffers
remap("n", "[b", ":bprevious<CR>", { noremap = true })
remap("n", "]b", ":bnext<CR>", { noremap = true })
remap("n", "[B", ":bfirst<CR>", { noremap = true })
remap("n", "]B", ":blast<CR>", { noremap = true })
-- Quickfix list mappings
remap("n", "<leader>q", "<cmd>lua require'utils'.toggle_qf('q')<CR>", { noremap = true })
-- remap("n", "<C-k>", ":cp<CR>", { noremap = true })
-- remap("n", "<C-j>", ":cn<CR>", { noremap = true })
remap("n", "[q", ":cprevious<CR>", { noremap = true })
remap("n", "]q", ":cnext<CR>", { noremap = true })
remap("n", "[Q", ":cfirst<CR>", { noremap = true })
remap("n", "]Q", ":clast<CR>", { noremap = true })
-- Location list mappings
remap("n", "<leader>Q", "<cmd>lua require'utils'.toggle_qf('l')<CR>", { noremap = true })
remap("n", "[l", ":lprevious<CR>", { noremap = true })
remap("n", "]l", ":lnext<CR>", { noremap = true })
remap("n", "[L", ":lfirst<CR>", { noremap = true })
remap("n", "]L", ":llast<CR>", { noremap = true })

-- Not using those as I manage my clipboard with greenclip
-- <leader>v|<leader>s act as <cmd-v>|<cmd-s>
-- <leader>p|P paste from yank register (0)
-- <leader>y|Y yank into clipboard/OSCyank
-- remap({ "n", "v" }, "<leader>v", '"+p', { noremap = true })
-- remap({ "n", "v" }, "<leader>V", '"+P', { noremap = true })
-- remap({'n', 'v'}, '<leader>s', '"*p',   { noremap = true })
-- remap({'n', 'v'}, '<leader>S', '"*P',   { noremap = true })
-- remap({ "n", "v" }, "<leader>p", '"0p', { noremap = true })
-- remap({ "n", "v" }, "<leader>P", '"0P', { noremap = true })
-- remap({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
-- remap({ "n", "v" }, "y", '"+y', { noremap = true })
-- remap({'n', 'v'}, '<leader>Y', ':OSCYank<CR>', { noremap = true })

-- Overloads for 'd|c' that don't pollute the unnamed registers
-- In visual-select mode 'd=delete, x=cut (unchanged)'
remap("n", "d", '"_d', { noremap = true })
remap("n", "<leader>d", "d", { noremap = true })
remap("v", "d", '"_d', { noremap = true })
remap("v", "<leader>d", "d", { noremap = true })
-- remap('n', '<leader>D',  '"_D',     { noremap = true })
-- remap('n', '<leader>c',  '"_c',     { noremap = true })
-- remap('n', '<leader>C',  '"_C',     { noremap = true })
-- remap('v', '<leader>c',  '"_c',     { noremap = true })

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
remap("n", "Y", "y$", { noremap = true })
remap("v", "Y", "<Esc>y$gv", { noremap = true })

-- keep visual selection when (de)indenting
remap("v", "<", "<gv", { noremap = true })
remap("v", ">", ">gv", { noremap = true })

-- Move selected lines up/down in visual mode
remap("x", "K", ":move '<-2<CR>gv=gv", { noremap = true })
remap("x", "J", ":move '>+1<CR>gv=gv", { noremap = true })

-- Select last pasted/yanked text
remap("n", "g<C-v>", "`[v`]", { noremap = true })

-- Keep matches center screen when cycling with n|N
remap("n", "n", "nzzzv", { noremap = true })
remap("n", "N", "Nzzzv", { noremap = true })

-- Break undo chain on punctuation so we can
-- use 'u' to undo sections of an edit
-- DISABLED, ALL KINDS OF ODDITIES
--[[ for _, c in ipairs({',', '.', '!', '?', ';'}) do
   remap('i', c, c .. "<C-g>u", { noremap = true })
end --]]

-- any jump over 5 modifies the jumplist
-- so we can use <C-o> <C-i> to jump back and forth
for _, c in ipairs({ "j", "k" }) do
    remap(
        "n",
        c,
        ([[(v:count > 5 ? "m'" . v:count : "") . '%s']]):format(c),
        { noremap = true, expr = true, silent = true }
    )
end

-- move along visual lines, not numbered ones
-- without interferring with {count}<down|up>
for _, m in ipairs({ "n", "v" }) do
    for _, c in ipairs({ "<up>", "<down>" }) do
        remap(m, c, ([[v:count == 0 ? 'g%s' : '%s']]):format(c, c), { noremap = true, expr = true, silent = true })
    end
end

-- Search and Replace
-- 'c.' for word, '<leader>c.' for WORD
remap("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })
remap("n", "<leader>c.", [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], { noremap = true })

-- Turn off search matches with double-<Esc>
remap("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { noremap = true, silent = true })
remap("n", "<leader>/", "<Esc>:nohlsearch<CR>", { noremap = true, silent = true })

-- search for visual selection
-- TODO this doesnt work
--remap('v', '*', 'y/\V<C-R>=escape(@",'/\')<CR><CR>', { noremap = true })

-- Toggle display of `listchars`
--remap('n', '<leader>\'', '<Esc>:set list!<CR>',   { noremap = true, silent = true })

-- Toggle colored column at 81
remap(
    "n",
    "<leader>|",
    ':execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>',
    { noremap = true, silent = true }
)

-- Change current working dir (:pwd) to curent file's folder
remap("n", "<leader>%", '<Esc>:lua require"utils".set_cwd()<CR>', { noremap = true, silent = true })

-- Map <leader>o & <leader>O to newline without insert mode
remap("n", "<leader><CR>", "o<Esc>", { noremap = true })
remap("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { noremap = true, silent = true })
remap("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })

-- Map `cp` to `xp` (transpose two adjacent chars)
-- as a **repeatable action** with `.`
-- (since the `@=` trick doesn't work
-- nmap cp @='xp'<CR>
-- http://vimcasts.org/transcripts/61/en/
--remap('n', '<Plug>TransposeCharacters',
--[[xp:call repeat#set("\<Plug>TransposeCharacters")<CR>]]
--{ noremap = true, silent = true })
--remap('n', 'cp', '<Plug>TransposeCharacters', {})

-- Mapping for plugins that are lazy loaded
remap("n", "<leader>gdh", ":DiffviewFileHistory<CR>", { noremap = true })
remap("n", "<leader>gdd", ":DiffviewOpen origin/master", { noremap = true })

remap("n", "<leader>sg", ":Neogit<CR>", { noremap = true, silent = true })

remap("n", "<leader>cc", ":CheatSH<CR>", { noremap = true, silent = true })

vim.cmd([[command! Jfmt :%!jq .]])

-- NEW MAPPINGS

-- -- more mappings are defined in `lua/config/which.lua`
-- local map = vim.keymap.set
-- local default_options = { silent = true }
-- local expr_options = { expr = true, silent = true }
--
-- --Remap space as leader key
-- map({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
-- vim.g.mapleader = " "
--
-- --Remap for dealing with visual line wraps
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)
--
-- -- paste over currently selected text without yanking it
-- map("v", "p", '"_dP', default_options)
--
-- -- Tab switch buffer
-- map("n", "<TAB>", ":BufferLineCycleNext<CR>", default_options)
-- map("n", "<S-TAB>", ":BufferLineCyclePrev<CR>", default_options)
--
-- -- Cancel search highlighting with ESC
-- map("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>", default_options)
--
-- -- Resizing panes
-- map("n", "<Left>", ":vertical resize +1<CR>", default_options)
-- map("n", "<Right>", ":vertical resize -1<CR>", default_options)
-- map("n", "<Up>", ":resize -1<CR>", default_options)
-- map("n", "<Down>", ":resize +1<CR>", default_options)
--
-- -- Autocorrect spelling from previous error
-- map("i", "<c-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u", default_options)
--
--
-- -- move over a closing element in insert mode
-- map("i", "<C-l>", function()
--   return require("functions").escapePair()
-- end, default_options)
