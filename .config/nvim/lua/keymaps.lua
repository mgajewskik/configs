local map = vim.keymap.set
local default_options = { silent = true }
local expr_options = { expr = true, silent = true }

-- lazy
map("n", "<leader>ll", "<cmd>:Lazy<cr>", { noremap = true })

-- remap ESC key in insert mode only
map("i", "jj", "<Esc>l", { noremap = true })
map("i", "jk", "<Esc>l", { noremap = true })
map("i", "kj", "<Esc>l", { noremap = true })

-- 0 goes to first non-blank character
map("n", "0", "^", { noremap = true })
map("n", "^", "0", { noremap = true })

-- w!! to save with sudo
map("c", "w!!", "<esc>:lua require'utils'.sudo_write()<CR>", { silent = true })

-- Beginning and end of line in `:` command mode
map("c", "<C-a>", "<home>", {})
map("c", "<C-e>", "<end>", {})

-- Arrows in command line mode (':') menus
map("c", "<down>", '(pumvisible() ? "\\<C-n>" : "\\<down>")', { noremap = true, expr = true })
map("c", "<up>", '(pumvisible() ? "\\<C-p>" : "\\<up>")', { noremap = true, expr = true })

-- Terminal mappings
map("t", "<C-w>e", [[<C-\><C-n>]], { noremap = true })
--map('t', '<C-w>', [[<C-\><C-n><C-w>]], { noremap = true })
map("t", "<M-r>", [['<C-\><C-N>"'.nr2char(getchar()).'pi']], { noremap = true, expr = true })
map("n", "<leader>tt", ":tabnew<CR>:terminal<CR>i", { noremap = true })

-- Pane navigation
-- map("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
-- map("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
-- map("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
-- map("n", "<leader>l", ":wincmd l<CR>", { noremap = true })

-- Tab navigation
map("n", "<leader>1", "1gt", { noremap = true })
map("n", "<leader>2", "2gt", { noremap = true })
map("n", "<leader>3", "3gt", { noremap = true })
map("n", "<leader>4", "4gt", { noremap = true })
map("n", "<leader>5", "5gt", { noremap = true })
map("n", "<leader>6", "6gt", { noremap = true })
map("n", "<leader>7", "7gt", { noremap = true })
map("n", "<leader>8", "8gt", { noremap = true })
map("n", "<leader>9", "9gt", { noremap = true })
map("n", "[t", ":tabprevious<CR>", { noremap = true })
map("n", "]t", ":tabnext<CR>", { noremap = true })
--map('n', '[T',         ':tabfirst<CR>',    { noremap = true })
--map('n', ']T',         ':tablast<CR>',     { noremap = true })
map("n", "<Leader>tn", ":tabnew<CR>", { noremap = true })
map("n", "<Leader>tc", ":tabclose<CR>", { noremap = true })
map("n", "<Leader>to", ":tabonly<CR>", { noremap = true })
-- Jump to first tab & close all other tabs. Helpful after running Git difftool.
map("n", "<Leader>tO", ":tabfirst<CR>:tabonly<CR>", { noremap = true })

-- Navigate buffers
map("n", "[b", ":bprevious<CR>", { noremap = true })
map("n", "]b", ":bnext<CR>", { noremap = true })
map("n", "[B", ":bfirst<CR>", { noremap = true })
map("n", "]B", ":blast<CR>", { noremap = true })
-- Quickfix list mappings
-- map("n", "<leader>q", "<cmd>lua require'utils'.toggle_qf('q')<CR>", { noremap = true })
-- map("n", "<C-k>", ":cp<CR>", { noremap = true })
-- map("n", "<C-j>", ":cn<CR>", { noremap = true })
map("n", "[q", ":cprevious<CR>", { noremap = true })
map("n", "]q", ":cnext<CR>", { noremap = true })
map("n", "[Q", ":cfirst<CR>", { noremap = true })
map("n", "]Q", ":clast<CR>", { noremap = true })
-- Location list mappings
-- map("n", "<leader>Q", "<cmd>lua require'utils'.toggle_qf('l')<CR>", { noremap = true })
map("n", "[l", ":lprevious<CR>", { noremap = true })
map("n", "]l", ":lnext<CR>", { noremap = true })
map("n", "[L", ":lfirst<CR>", { noremap = true })
map("n", "]L", ":llast<CR>", { noremap = true })

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
map("n", "d", '"_d', { noremap = true })
map("n", "<leader>d", "d", { noremap = true })
map("v", "d", '"_d', { noremap = true })
map("v", "<leader>d", "d", { noremap = true })
map("n", "<leader>D", '"_D', { noremap = true })
map("n", "<leader>c", '"_c', { noremap = true })
map("n", "<leader>C", '"_C', { noremap = true })
map("v", "<leader>c", '"_c', { noremap = true })

-- Map `Y` to copy to end of line
-- conistent with the behaviour of `C` and `D`
map("n", "Y", "y$", { noremap = true })
map("v", "Y", "<Esc>y$gv", { noremap = true })

-- keep visual selection when (de)indenting
map("v", "<", "<gv", { noremap = true })
map("v", ">", ">gv", { noremap = true })

-- Move selected lines up/down in visual mode
map("x", "K", ":move '<-2<CR>gv=gv", { noremap = true })
map("x", "J", ":move '>+1<CR>gv=gv", { noremap = true })

-- Select last pasted/yanked text
map("n", "g<C-v>", "`[v`]", { noremap = true })

-- Keep matches center screen when cycling with n|N
map("n", "n", "nzzzv", { noremap = true })
map("n", "N", "Nzzzv", { noremap = true })

-- any jump over 5 modifies the jumplist
-- so we can use <C-o> <C-i> to jump back and forth
for _, c in ipairs({ "j", "k" }) do
   map(
      "n",
      c,
      ([[(v:count > 5 ? "m'" . v:count : "") . '%s']]):format(c),
      { noremap = true, expr = true, silent = true }
   )
end

-- -- move along visual lines, not numbered ones
-- -- without interfering with {count}<down|up>
-- for _, m in ipairs({ "n", "v" }) do
-- 	for _, c in ipairs({ "<up>", "<down>" }) do
-- 		map(m, c, ([[v:count == 0 ? 'g%s' : '%s']]):format(c, c), { noremap = true, expr = true, silent = true })
-- 	end
-- end

-- --Remap for dealing with visual line wraps
map("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
map("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- Search and Replace
-- 'c.' for word, '<leader>c.' for WORD
map("n", "c.", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { noremap = true })
map("n", "<leader>c.", [[:%s/\<<C-r><C-a>\>//g<Left><Left>]], { noremap = true })

-- Turn off search matches with double-<Esc>
map("n", "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { noremap = true, silent = true })
map("n", "<leader>/", "<Esc>:nohlsearch<CR>", { noremap = true, silent = true })

-- Toggle colored column at 81
map(
   "n",
   "<leader>|",
   ':execute "set colorcolumn=" . (&colorcolumn == "" ? "81" : "")<CR>',
   { noremap = true, silent = true }
)

-- Map <leader>o & <leader>O to newline without insert mode
map("n", "<leader><CR>", "o<Esc>", { noremap = true })
-- map("n", "<leader>o", ':<C-u>call append(line("."), repeat([""], v:count1))<CR>', { noremap = true, silent = true })
map("n", "<leader>O", ':<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>', { noremap = true, silent = true })

-- vim.cmd([[command! Jfmt :%!jq .]])

-- Resizing panes
map("n", "<C-Left>", ":vertical resize +2<CR>", default_options)
map("n", "<C-Right>", ":vertical resize -2<CR>", default_options)
map("n", "<C-Up>", ":resize -2<CR>", default_options)
map("n", "<C-Down>", ":resize +2<CR>", default_options)

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
map("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
