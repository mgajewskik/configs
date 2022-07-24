local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
	return string.format('require("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer...")
	vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
	enable = true, -- enable profiling via :PackerCompile profile=true
	threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
	max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
	-- Have packer use a popup window
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

packer.startup(function(use)
	-- speed up 'require', must be the first plugin
	use({ "lewis6991/impatient.nvim", config = "if vim.fn.has('nvim-0.6')==1 then require('impatient') end" })

	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim" })
	use({ "rebelot/kanagawa.nvim" })

	-- Analyze startuptime
	-- use { 'tweekmonster/startuptime.vim', cmd = 'StartupTime' }
	-- use { 'dstein64/vim-startuptime', cmd = 'StartupTime' }

	-- -- tpope's plugins that should be part of vim
	-- -- TODO replace this with mini
	-- -- use { 'tpope/vim-surround' }
	-- -- use { 'tpope/vim-repeat' }

	-- "gc" to comment visual regions/lines
	use({
		"numToStr/Comment.nvim",
		-- config = "require('config.comment')",
		config = get_config("comment"),
		-- uncomment for lazy loading
		-- slight delay if loading in visual mode
		keys = { "gcc", "gc", "gl" },
	})

	-- needs no introduction
	use({
		"tpope/vim-fugitive",
		-- config = "require('config.fugitive')"
		config = get_config("fugitive"),
	})

	-- plenary is required by gitsigns and telescope
	-- lazy load so gitsigns doesn't abuse our startup time
	-- use { "nvim-lua/plenary.nvim", event = "BufRead" }

	use({
		"lewis6991/gitsigns.nvim",
		requires = { "nvim-lua/plenary.nvim" },
		config = get_config("gitsigns"),
	})

	-- requirement for Neogit
	use({
		"sindrets/diffview.nvim",
		cmd = {
			"DiffviewOpen",
			"DiffviewClose",
			"DiffviewToggleFiles",
			"DiffviewFocusFiles",
		},
		config = get_config("diffview"),
	})

	-- TODO what is this library?
	use({
		"TimUntersberger/neogit",
		requires = { "nvim-lua/plenary.nvim" },
		cmd = "Neogit",
		config = get_config("neogit"),
	})

	-- Neoterm (REPLs)
	use({
		"akinsho/toggleterm.nvim",
		-- config = "require('config.neoterm')",
		config = get_config("toggleterm"),
		keys = { "gxx", "gx", "<C-\\>" },
	})

	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			-- "f3fora/cmp-spell",
			-- "hrsh7th/cmp-calc",
			-- TODO remove this if causing performance issues
			"lukas-reineke/cmp-rg",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
		config = get_config("cmp"),
	})

	use({ "rafamadriz/friendly-snippets" })
	use({
		"L3MON4D3/LuaSnip",
		requires = "saadparwaiz1/cmp_luasnip",
		config = get_config("luasnip"),
	})

	-- Needed to setup copilot with ":Copilot setup"
	-- needs to have NodeJS version 16 apparently and not 18, setup with nvm
	-- use({ "github/copilot.vim" })
	use({
		"zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("config.copilot")
			end, 100)
		end,
	})
	use({
		"zbirenbaum/copilot-cmp",
		module = "copilot_cmp",
	})

	use({
		"nvim-treesitter/nvim-treesitter",
		config = get_config("treesitter"),
		run = ":TSUpdate",
	})
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("RRethy/nvim-treesitter-endwise")

	-- -- optional for fzf-lua, telescope, nvim-tree
	-- use { 'kyazdani42/nvim-web-devicons',
	--   config = "require('config.devicons')",
	--   event = 'VimEnter'
	-- }

	use({
		"ptzz/lf.vim",
		requires = "voldikss/vim-floaterm",
		config = get_config("lf"),
	})

	-- Undotree
	use({ "mbbill/undotree", config = get_config("undotree") })

	-- faster movements with lightspeed
	use({ "ggandor/lightspeed.nvim" })

	-- -- only required if you do not have fzf binary
	-- -- use = { 'junegunn/fzf', run = './install --bin', }
	use({
		"ibhagwan/fzf-lua",
		config = get_config("fzf"),
	})

	use({
		"kevinhwang91/nvim-bqf",
		requires = { { "junegunn/fzf", module = "nvim-bqf" }, config = get_config("nvim-bqf") },
	})

	use({ "neovim/nvim-lspconfig", config = get_config("lsp") })
	use({
		"williamboman/nvim-lsp-installer",
		config = get_config("lsp"),
		after = { "nvim-lspconfig" },
	})
	use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })

	-- TODO check what is it and is it working
	-- inject code LSP diagnostics
	use({
		"jose-elias-alvarez/null-ls.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
		config = get_config("null-ls"),
	})

	-- show code symbols from given file
	use({
		"simrat39/symbols-outline.nvim",
		cmd = { "SymbolsOutline" },
		config = get_config("symbols"),
	})

	use({ "hashivim/vim-terraform", config = "require('config.terraform')" })

	-- -- DAP
	-- --use { 'mfussenegger/nvim-dap',
	--     --config = "require('plugins.nvim-dap')",
	--     --keys = {'<F5>', '<F9>' }
	-- --}
	-- --use { 'leoluz/nvim-dap-go',
	--     --config = "require('dap-go').setup()",
	--     --after = { 'nvim-dap' }
	-- --}

	-- -- Colorizer
	-- -- use { 'norcalli/nvim-colorizer.lua',
	-- --     config = "require'colorizer'.setup()",
	-- --     cmd = {'ColorizerAttachToBuffer', 'ColorizerDetachFromBuffer' },
	-- --     opt = true }

	use({
		"nvim-lualine/lualine.nvim",
		config = get_config("lualine"),
		event = "VimEnter",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})

	-- TODO disable telescope altogether?
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
		config = get_config("telescope"),
	})

	use({ "jvgrootveld/telescope-zoxide" })
	use({ "crispgm/telescope-heading.nvim" })
	use({ "nvim-telescope/telescope-symbols.nvim" })
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "nvim-telescope/telescope-packer.nvim" })
	use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "nvim-telescope/telescope-fzy-native.nvim" })

	use({
		"renerocksai/telekasten.nvim",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
			{ "renerocksai/calendar-vim" },
		},
		config = get_config("telekasten"),
	})

	-- use({
	--   "akinsho/nvim-bufferline.lua",
	--   requires = "kyazdani42/nvim-web-devicons",
	--   event = "BufReadPre",
	--   config = get_config("bufferline"),
	-- })

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
		config = get_config("todo"),
	})

	use({ "ahmedkhalf/project.nvim", config = get_config("project") })

	-- TODO to remove this later
	use({ "folke/which-key.nvim", config = get_config("which-key") })

	use({ "RRethy/vim-illuminate" })

	use({ "ray-x/go.nvim", config = get_config("go"), ft = { "go" } })

	use({ "rcarriga/nvim-notify", config = get_config("notify") })

	use({ "echasnovski/mini.nvim", branch = "stable", config = get_config("mini") })

	-- easier dealing with git configs
	use({ "rhysd/conflict-marker.vim" })

	use({ "SmiteshP/nvim-navic" })

	-- to use :CheatSH
	use({ "Djancyp/cheat-sheet" })

	use({
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	})

	-- easy alignment with gl=
	use({ "tommcdo/vim-lion" })

	use({
		"karb94/neoscroll.nvim",
		config = get_config("neoscroll"),
	})
end)
