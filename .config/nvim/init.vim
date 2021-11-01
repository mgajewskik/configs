" =========================================================================
" Standard Configuration Settings
" =========================================================================
"
syntax on
syntax enable
filetype plugin indent on

set ma
set cursorline
" set cursorcolumn
set clipboard+=unnamedplus
"set t_Co=256 " 256 colors in the terminal
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
set so=15
set undolevels=700 " undo levels

set foldmethod=marker

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
"let g:polyglot_disabled = ['csv', 'go']
"
autocmd FileType * lua require'colorizer'.setup()

" List of plugins to install with Plug
call plug#begin('~/.vim/plugged')

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'glepnir/lspsaga.nvim'
"Plug 'norcalli/snippets.nvim'
Plug 'preservim/nerdcommenter'
Plug 'lifepillar/vim-gruvbox8'
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'ojroques/nvim-lspfuzzy'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'mbbill/undotree'
Plug 'rbong/vim-crystalline'
"Plug 'sheerun/vim-polyglot'
"Plug 'ThePrimeagen/vim-be-good'
"Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'
Plug 'mechatroner/rainbow_csv'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'justinmk/vim-sneak'
"Plug 'cocopon/vaffle.vim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'ray-x/go.nvim'
Plug 'p00f/nvim-ts-rainbow'
Plug 'kosayoda/nvim-lightbulb'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'hashivim/vim-terraform'
"Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh' }
Plug 'ptzz/lf.vim'
Plug 'voldikss/vim-floaterm'

call plug#end()

"let g:gruvbox_contrast_dark = 'hard'
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
let g:gruvbox_invert_selection='0'

set noshowmode
colorscheme gruvbox8
"set background=dark

let g:coq_settings = { 'auto_start': v:true }
lua require('lsp')
lua require('treesitter')
lua require('init')

source $HOME/.config/nvim/mappings.vim
source $HOME/.config/nvim/commands.vim
source $HOME/.config/nvim/settings.vim


" ============================================================================
" Auto commands
" ============================================================================

" Config for rainbow csv
autocmd BufWinEnter *.csv set buftype=nowrite | :%s/,/|/g
autocmd BufRead,BufNewFile *.csv set filetype=csv_pipe
" Config for git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72
"autocmd! bufwritepost init.vim source % " automatic vimrc file reload
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
"vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
"autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync()
autocmd FileType * ColorizerAttachToBuffer
au BufRead,BufNewFile *.md setlocal textwidth=80

"autocmd BufWinEnter *.py nmap <silent> <F2> :w<CR>:terminal python3 -m pdb '%:p'<CR>

autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)


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
