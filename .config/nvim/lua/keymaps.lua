local map = vim.keymap.set
local default_opts = { noremap = true, silent = true, unique = true }
local expr_opts = { noremap = true, silent = true, unique = true, expr = true }

map("n", "<C-s>", "<cmd>lua require'utils'.jump_to_word(false)<CR>", default_opts)

-- lazy
map("n", "<leader>ll", "<cmd>:Lazy<cr>", default_opts)

-- remap ESC key in insert mode only
map("i", "jj", "<Esc>l", default_opts)
map("i", "jk", "<Esc>l", default_opts)
map("i", "kj", "<Esc>l", default_opts)

-- 0 goes to first non-blank character
-- map("n", "0", "^", { noremap = true })
-- map("n", "^", "0", { noremap = true })

-- w!! to save with sudo
map("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", default_opts)

-- Terminal mappings
map("t", "<C-w>e", [[<C-\><C-n>]], default_opts)
--map('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true })
map("t", "<M-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], expr_opts)
map("n", "<leader>tt", ":tabnew<CR>:terminal<CR>i", default_opts)

-- Pane navigation
map("n", "<C-h>", ":wincmd h<CR>", default_opts)
map("n", "<C-j>", ":wincmd j<CR>", default_opts)
map("n", "<C-k>", ":wincmd k<CR>", default_opts)
map("n", "<C-l>", ":wincmd l<CR>", { noremap = true, silent = true })

-- Tab navigation
map("n", "<leader>1", "1gt", default_opts)
map("n", "<leader>2", "2gt", default_opts)
map("n", "<leader>3", "3gt", default_opts)
map("n", "<leader>4", "4gt", default_opts)
map("n", "<leader>5", "5gt", default_opts)
map("n", "<leader>6", "6gt", default_opts)
map("n", "<leader>7", "7gt", default_opts)
map("n", "<leader>8", "8gt", default_opts)
map("n", "<leader>9", "9gt", default_opts)
map("n", "[t", ":tabprevious<CR>", default_opts)
map("n", "]t", ":tabnext<CR>", default_opts)
--map('n', '[T',         ':tabfirst<CR>',    { noremap = true })
--map('n', ']T',         ':tablast<CR>',     { noremap = true })
map("n", "<Leader>tn", ":tabnew<CR>", default_opts)
map("n", "<Leader>tc", ":tabclose<CR>", default_opts)
map("n", "<Leader>to", ":tabonly<CR>", default_opts)
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
map("n", "<Leader>tO", ":tabfirst<CR>:tabonly<CR>", default_opts)

-- Navigate buffers
map("n", "[b", ":bprevious<CR>", default_opts)
map("n", "]b", ":bnext<CR>", default_opts)
map("n", "[B", ":bfirst<CR>", default_opts)
map("n", "]B", ":blast<CR>", default_opts)
-- Quickfix list mappings
-- map("n", "<leader>q", "<cmd>lua require'utils'.toggle_qf('q')<CR>", { noremap = true })
-- map("n", "<C-k>", ":cp<CR>", { noremap = true })
-- map("n", "<C-j>", ":cn<CR>", { noremap = true })
map("n", "[q", ":cprevious<CR>", default_opts)
map("n", "]q", ":cnext<CR>", default_opts)
map("n", "[Q", ":cfirst<CR>", default_opts)
map("n", "]Q", ":clast<CR>", default_opts)
-- Location list mappings
-- map("n", "<leader>Q", "<cmd>lua require'utils'.toggle_qf('l')<CR>", { noremap = true })
map("n", "[l", ":lprevious<CR>", default_opts)
map("n", "]l", ":lnext<CR>", default_opts)
map("n", "[L", ":lfirst<CR>", default_opts)
map("n", "]L", ":llast<CR>", default_opts)

-- Not using those as I manage my clipboard with greenclip
-- <leader>v|<leader>s act as <cmd-v>|<cmd-s>
-- <leader>p|P paste from yank register (0)
-- <leader>y|Y yank into clipboard/OSCyank
-- map({ "n", "v" }, "<leader>v", '"+p', { noremap = true })
-- map({ "n", "v" }, "<leader>V", '"+P', { noremap = true })
-- map({'n', 'v'}, '<leader>s', '"*p',   { noremap = true })
-- map({'n', 'v'}, '<leader>S', '"*P',   { noremap = true })
-- map({ "n", "v" }, "<leader>p", '"0p', { noremap = true })
-- map({ "n", "v" }, "<leader>P", '"0P', { noremap = true })
-- map({ "n", "v" }, "<leader>y", '"+y', { noremap = true })
-- map({ "n", "v" }, "y", '"+y', { noremap = true })
-- map({'n', 'v'}, '<leader>Y', ':OSCYank<CR>', { noremap = true })

-- Overloads for 'd|c' that don't pollute the unnamed registers
-- In visual-select mode 'd=delete, x=cut (unchanged)'
map("n", "d", '"_d', default_opts)
map("n", "<leader>d", "d", default_opts)
map("v", "d", '"_d', default_opts)
map("v", "<leader>d", "d", default_opts)
map("n", "<leader>D", '"_D', default_opts)
map("n", "<leader>c", '"_c', default_opts)
map("n", "<leader>C", '"_C', default_opts)
map("v", "<leader>c", '"_c', default_opts)

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
-- map("n", "Y", "y$", default_opts)
-- map("v", "Y", "<Esc>y$gv", default_opts)

-- keep visual selection when (de)indenting
map("v", "<", "<gv", default_opts)
map("v", ">", ">gv", default_opts)

-- Move selected lines up/down in visual mode
map("x", "K", ":move '<-2<CR>gv=gv", default_opts)
map("x", "J", ":move '>+1<CR>gv=gv", default_opts)

-- Select last pasted/yanked text
map("n", "g<C-v>", "`[v`]", default_opts)

-- Keep matches center screen when cycling with n|N
map("n", "n", "nzzzv", default_opts)
map("n", "N", "Nzzzv", default_opts)

-- any jump over 5 modifies the jumplist
-- so we can use <C-o> <C-i> to jump back and forth
for _, c in ipairs({ "j", "k" }) do
	map("n", c, ([[(v:count > 5 ? "m'" . v:count : "") . '%s']]):format(c), expr_opts)
end

-- -- move along visual lines, not numbered ones
-- -- without interfering with {count}<down|up>
-- for _, m in ipairs({ "n", "v" }) do
-- 	for _, c in ipairs({ "<up>", "<down>" }) do
-- 		map(m, c, ([[v:count == 0 ? 'g%s' : '%s']]):format(c, c), { noremap = true, expr = true, silent = true })
-- 	end
-- end

-- --Remap for dealing with visual line wraps
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Search and Replace
-- 'c.' for word, '<leader>c.' for WORD
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], default_opts)
map("n", "<leader>c.", [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], default_opts)

-- Turn off search matches with double-<Esc>
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", default_opts)
map("n", "<leader>/", "<Esc>:nohlsearch<CR>", default_opts)

-- Toggle colored column at 81
map("n", "<leader>|", ':execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>', default_opts)

-- Map <leader>o & <leader>O to newline without insert mode
map("n", "<leader><CR>", "o<Esc>", default_opts)
-- map("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { noremap = true, silent = true })
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', default_opts)

-- Resizing panes
map("n", "<C-Left>", ":vertical resize +2<CR>", default_opts)
map("n", "<C-Right>", ":vertical resize -2<CR>", default_opts)
map("n", "<C-Up>", ":resize -2<CR>", default_opts)
map("n", "<C-Down>", ":resize +2<CR>", default_opts)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
