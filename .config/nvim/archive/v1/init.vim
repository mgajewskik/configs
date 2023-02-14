" =========================================================================
" Standard Configuration Settings
" =========================================================================
"
syntax on
syntax enable

set ma
set cursorline
" set cursorcolumn
set clipboard+=unnamedplus
set t_Co=256 " 256 colors in the terminal
set noerrorbells
set tabstop=4 softtabstop=4 " number of spaces per tab
set shiftwidth=4
set expandtab " tabs are spaces
set smartindent
set nu " line numbers
set relativenumber " set relative line numbers
set nowrap
set smartcase " include only uppercase words with uppercase letter
set noswapfile
set nobackup " backup and swap turned off
set nowritebackup
set undofile
set ignorecase " search uppercase as lowercase
set smartcase " include only uppercase words with uppercase letter
set bs=2 " normal backspace use
set hidden " work with buffers
set mouse=a " mouse on
set scrolloff=8 " display x lines above below when scrolling with a mouse
set cmdheight=1 " more space for displaying messages
set updatetime=50 " short update screen time (ms)
set lazyredraw
set showmatch " highlight matching brackets / noshowmatch
set showmode
set grepprg=rg\ --vimgrep
set shortmess+=c " dont pass messages to ins-completion-menu
" set signcolumn=yes " always show signcolumns
" set 7 lines from beginning and end of file
set so=7
set undolevels=700 " undo levels

set termguicolors
set showtabline=2
set guioptions-=e
set laststatus=2
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" ============================================================================
" Plugin Management and config
" ===========================================================================

" automatic Plug installation for nvim
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" disable polyglot for certain filetypes
let g:polyglot_disabled = ['csv']

" List of plugins to install with Plug
call plug#begin('~/.vim/plugged')

Plug 'nvim-lua/completion-nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'norcalli/snippets.nvim'
Plug 'preservim/nerdcommenter'
Plug 'lifepillar/vim-gruvbox8'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree'
Plug 'rbong/vim-crystalline'
Plug 'sheerun/vim-polyglot'
Plug 'ThePrimeagen/vim-be-good'
Plug 'luochen1990/rainbow'
Plug 'psliwka/vim-smoothie'
Plug 'Yggdroot/indentLine'
Plug 'mechatroner/rainbow_csv'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'justinmk/vim-sneak'
Plug 'cocopon/vaffle.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

call plug#end()

"let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

set noshowmode
colorscheme gruvbox8
set background=dark

set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 1
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'path', 'snippet', 'tags', 'tabnine' ]},
    \]
\}

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1

"lua require'lspconfig'.pyls_ms.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.pyls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.sqlls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.dockerls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.bashls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.jsonls.setup{ on_attach=require'completion'.on_attach }
"lua require'lspconfig'.vimls.setup{ on_attach=require'completion'.on_attach }
"lua require'snippets'.use_suggested_mappings()
  "local lsp_status = require('lsp-status')
  "lsp_status.register_progress()
  "lsp_status.config({
    "indicator_errors = 'E',
    "indicator_warnings = 'W',
    "indicator_info = 'i',
    "indicator_hint = '?',
    "indicator_ok = 'Ok',
  "})
    "handlers = lsp_status.extensions.pyls_ms.setup(),
    "on_attach = lsp_status.on_attach,
    "capabilities = lsp_status.capabilities


:lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(_, bufnr)
    require('completion').on_attach() local opts = { noremap=true, silent=true }
    print("LSP started.");
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  end

  local servers = {'jsonls', 'vimls', 'dockerls', 'sqlls', 'bashls'}
  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
      on_attach = on_attach,
    }
  end

  nvim_lsp.pyls.setup {
    enable = true,
    plugins = {
      pyls_mypy = {
        enabled = true,
        live_mode = false
      }
    },
    on_attach = on_attach,
  }
EOF

sign define LspDiagnosticsErrorSign text=✖
sign define LspDiagnosticsWarningSign text=⚠
sign define LspDiagnosticsInformationSign text=ℹ
sign define LspDiagnosticsHintSign text=➤

    "vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    "vim.lsp.diagnostic.on_publish_diagnostics, {
      "underline = true,
      "virtual_text = true,
      "signs = true,
      "update_in_insert = false,
    "}
    ")

    "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    "vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    "vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>xd', '<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>', opts)

"highlight LspDiagnosticsDefaultError guifg='DarkRed' guibg='LightRed'
"highlight LspDiagnosticsDefaultWarning guifg='DarkRed' guibg='LightRed'

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'snippets.nvim'

let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:markdown_fenced_languages = ['sql', 'python', 'bash', 'go']

" indent guides toggle on
let g:indent_guides_enable_on_vim_startup = 1

" set indentation
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" fzf settings
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Comment' } }
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --preview 'bat --color=always --style=header,grid --line-range :300 {}' --bind ctrl-s:select-all"
let FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!.tox/*" --glob "!venv/*" --glob "!.pyc" --glob "!.pyi"'
" let g:fzf_preview_window = ['up:60%']
" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let loaded_matchparen = 1
let g:rainbow_active = 1

let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#prompt = 'Sneak> '
let g:sneak#use_ic_scs = 0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:lua_tree_width = 40
let g:lua_tree_git_hl = 1
let g:lua_tree_follow = 1
let g:lua_tree_indent_markers = 1
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': ""
    \   }
    \ }

let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'gruvbox'

" ===========================================================================
" Key mappings
" ===========================================================================
"
" BASIC BINDINGS
" let mapleader = " "
map <Space> <leader>
" terminal settings
" esc to exit terminal
tnoremap jj <C-\><C-n>
" 0 goes to first non-blank character
nnoremap 0 ^
nnoremap ^ 0
nmap <leader><CR> O<Esc>
nmap <CR> o<Esc>
" remap ESC key in insert mode only
:imap jj <esc>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" movement in quickfix window
map <C-j> :cn<CR>
map <C-k> :cp<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :ccl<CR>
nnoremap <leader>qn :cn<CR>
nnoremap <leader>qp :cp<CR>
" quickly switch between buffers
"nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nnoremap  <silent>   <c-l>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <c-h>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"nnoremap <leader>n :ls<CR>:b<space>
" switch panes by leader + hjkl
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" managing tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tm :tabmove<space>
nnoremap <leader>tt :tabnew<CR>:terminal<CR>i
" leader + number is now used to move through tabs
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>
" resize panes
nnoremap <Leader>= :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
" select in visual mode and move whole block with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" remove highlight of the search
nnoremap <leader>/ :noh<CR>
" copy / paste to the system clipboard
" noremap <leader>y "+y
" noremap <leader>p "+p
" quicker delete inside and around parantheses
nnoremap ci( f(ci(
nnoremap di( f(di(
nnoremap ci) f)ci)
nnoremap ci) f)ci)
nnoremap ci" f"ci"
nnoremap ci' f'ci'
nnoremap ci{ f{ci{
nnoremap ci} f}ci}
nnoremap ci[ f[ci[
nnoremap ci] f]ci]
" around
nnoremap ca" f"ca"
nnoremap ca' f'ca'
 " " Shortcut to use blackhole register by default
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
 " Shortcut to use clipboard with <leader>
nnoremap <leader>d d
vnoremap <leader>d d
nnoremap <leader>D D
vnoremap <leader>D D
nnoremap <leader>c c
vnoremap <leader>c c
nnoremap <leader>C C
vnoremap <leader>C C
nnoremap <leader>x x
vnoremap <leader>x x
nnoremap <leader>X X
vnoremap <leader>X X

" PLUGIN BINDINGS
" nerd commenter
nmap <leader>cc :NERDCommenterComment<CR>
nmap <leader>c<space> :NERDCommenterToggle<CR>
" Trees shortcut
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>e :LuaTreeToggle<CR>
" fzf shortcuts
nnoremap cc :Commands<CR>
nnoremap // :BLines<CR>
"nnoremap <Leader>s :Find<SPACE>
nnoremap <leader>ws :Find <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader><leader> :RG<CR>
nnoremap <Leader>b :Buffer<CR>
nnoremap <Leader>` :Buffer<CR>
nnoremap <Leader>sc :Commits<CR>
nnoremap <Leader>rf :Files ~/<CR>
nnoremap <leader>f :ProjectFiles<CR>
nnoremap <leader>sb :GBranches<CR>
nnoremap <leader>st :GTags<CR>
" Completion and snippets
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
"use <c-j> to switch to previous completion
"imap <c-j> <Plug>(completion_next_source)
"use <c-k> to switch to next completion
"imap <c-k> <Plug>(completion_prev_source)
inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
inoremap <c-j> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

" GoTo code navigation.
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ge :vsplit<CR> :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>as :lua vim.lsp.buf.code_action()<CR>
"nnoremap <leader>ggs :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>af :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>ai :lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <leader>ao :lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gw :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>gW :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>dn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>dp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>sd :lua vim.lsp.diagnostic.set_loclist()<CR>

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gv :Gvdiffsplit!<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gl :G log<CR>

" Sneak mappings
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" ============================================================================
" Scripts and defined commands
" ============================================================================
"
command! V :vnew ~/.config/nvim/init.vim
command! S :source $MYVIMRC

" Define your own Find command to use ripgrep inside of fzf
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find
    \ call fzf#vim#grep(
    \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --glob "!.tox/*" --glob "!venv/*" --glob "!.pyc" --glob "!.pyi" --color "always" '.shellescape(<q-args>).'| tr -d "\017"',
    \   1, fzf#vim#with_preview(), <bang>0)

" exploratory search function
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Function to search for files from root project directory
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction

command! ProjectFiles execute 'Files' s:find_git_root()

" Script for trimming the whitespace
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 40})
augroup END

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! StatusLine(current, width)
  let l:s = ''

  if a:current
    let l:s .= crystalline#mode() . crystalline#right_mode_sep('')
  else
    let l:s .= '%#CrystallineInactive#'
  endif
  let l:s .= ' %f%h%w%m%r '
  if a:current
    let l:s .= crystalline#right_sep('', 'Fill') . ' %{fugitive#head()}'
  endif

  let l:s .= '%='
  if a:current
    let l:s .= crystalline#left_sep('', 'Fill') . ' %{&paste ?"PASTE ":""}%{&spell?"SPELL ":""}'
    let l:s .= crystalline#left_mode_sep('')
  endif
  if a:width > 80
    let l:s .= ' %{&ft}[%{&fenc!=#""?&fenc:&enc}][%{&ff}] %l/%L %c%V %P '
  else
    let l:s .= ' '
  endif

  return l:s
endfunction

function! TabLine()
  let l:vimlabel = has('nvim') ?  ' NVIM ' : ' VIM '
  return crystalline#bufferline(2, len(l:vimlabel), 1) . '%=%#CrystallineTab# ' . l:vimlabel
endfunction

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

" When using `dd` in the quickfix list, remove the item from the quickfix list.
function! RemoveQFItem()
  let curqfidx = line('.') - 1
  let qfall = getqflist()
  call remove(qfall, curqfidx)
  call setqflist(qfall, 'r')
  execute curqfidx + 1 . "cfirst"
  :copen
endfunction
:command! RemoveQFItem :call RemoveQFItem()
" Use map <buffer> to only map dd in the quickfix window. Requires +localmap
autocmd FileType qf map <buffer> dd :RemoveQFItem<cr>

" Config for rainbow csv
autocmd BufWinEnter *.csv set buftype=nowrite | :%s/,/|/g
autocmd BufRead,BufNewFile *.csv set filetype=csv_pipe
" Config for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
"autocmd! bufwritepost init.vim source % " automatic vimrc file reload
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufEnter * lua require'completion'.on_attach()
"vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync()

" =========================================================================
" Additional functionality to note
" =========================================================================
"
" visual block + I for editing visual selecion (multi cursor)
" visual block + c for editing visual selecion (multi cursor)
" J - join the lines
" % - jump to brackets
" gi - jump to insert when last used
" gUw, guw - make word upper or lowercase 1
" ctr + a / ctrl + x - increment and decrement a number
"
