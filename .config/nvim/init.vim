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

" List of plugins to install with Plug
call plug#begin('~/.vim/plugged')

"cmd = 'StartupTime'
" Plug 'tweekmonster/startuptime.vim'
" Plug 'dstein64/vim-startuptime'

Plug 'lewis6991/impatient.nvim'
Plug 'rebelot/kanagawa.nvim'
Plug 'echasnovski/mini.nvim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'nvim-lua/plenary.nvim'
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'TimUntersberger/neogit'
Plug 'akinsho/toggleterm.nvim'
"lf requires floaterm
Plug 'voldikss/vim-floaterm'
Plug 'ptzz/lf.vim'
Plug 'mbbill/undotree'
Plug 'ggandor/lightspeed.nvim'
"required by lualine
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'

"""Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf'
Plug 'ibhagwan/fzf-lua'
" required by telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-telescope/telescope.nvim'
" required by telekasten
Plug 'renerocksai/calendar-vim'
Plug 'renerocksai/telekasten.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-telescope/telescope-media-files.nvim'

Plug 'neovim/nvim-lspconfig'
"required by lspkind
Plug 'famiu/bufdelete.nvim'
Plug 'onsails/lspkind-nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'simrat39/symbols-outline.nvim'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'lukas-reineke/cmp-rg'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'

"needs to have NodeJS version 16 apparently and not 18, setup with nvm
Plug 'github/copilot.vim'
Plug 'zbirenbaum/copilot.lua'
Plug 'zbirenbaum/copilot-cmp'

Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
Plug 'nvim-treesitter/nvim-treesitter-textobjects'
Plug 'RRethy/nvim-treesitter-endwise'
Plug 'windwp/nvim-ts-autotag'

"requires junegunn/fzf
Plug 'kevinhwang91/nvim-bqf'
Plug 'RRethy/vim-illuminate'
Plug 'SmiteshP/nvim-navic'
Plug 'folke/todo-comments.nvim'
Plug 'ahmedkhalf/project.nvim'
Plug 'folke/which-key.nvim'
Plug 'rcarriga/nvim-notify'
Plug 'rhysd/conflict-marker.vim'
"to use :CheatSH
Plug 'Djancyp/cheat-sheet'
"easy alignment with gl=
Plug 'tommcdo/vim-lion'
Plug 'shuntaka9576/preview-swagger.nvim'
Plug 'norcalli/nvim-colorizer.lua'

Plug 'hashivim/vim-terraform'
Plug 'ray-x/go.nvim'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" -- DAP
" -- Python requires debugpy to be installed in the virtualenv
" Plug 'mfussenegger/nvim-dap'
" Plug 'mfussenegger/nvim-dap-python'
" Plug 'leoluz/nvim-dap-go'
" Plug 'rcarriga/nvim-dap-ui'
" Plug 'theHamsta/nvim-dap-virtual-text'

call plug#end()

"source $HOME/.config/nvim/mappings.vim
"source $HOME/.config/nvim/commands.vim
"source $HOME/.config/nvim/settings.vim

lua require('init')
