return {
	{
		"tzachar/local-highlight.nvim",
		event = "VeryLazy",
		opts = {
			hlgroup = "CursorLine",
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		lazy = true,
		cmd = "ColorizerToggle",
		config = true,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"RRethy/nvim-treesitter-endwise",
		},
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			highlight = {
				enable = true, -- false will disable the whole extension
				-- disable = { "vim" }, -- list of language that will be disabled
			},
			ensure_installed = {
				"bash",
				"css",
				"cmake",
				"make",
				"dockerfile",
				"go",
				"gomod",
				"gowork",
				"proto",
				"hcl",
				"terraform",
				"html",
				"javascript",
				"typescript",
				"json",
				"latex",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"toml",
				"yaml",
				"rego",
				"comment",
				"diff",
				"gitcommit",
				"gitignore",
				"regex",
				"sql",
			}, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<CR>",
					node_incremental = "<CR>",
					scope_incremental = "<S-CR>",
					node_decremental = "<BS>",
					-- init_selection = "<CR>",
					-- node_incremental = "<TAB>",
					-- scope_incremental = "<CR>",
					-- node_decremental = "<S-TAB>",
				},
			},
			endwise = {
				enable = true,
			},
			indent = { enable = true },
			autopairs = { enable = true },
			rainbow = {
				enable = true,
				extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
				max_file_lines = 2000, -- Do not enable for files with more than specified lines
			},
			-- should be in editor config but it can't
			textobjects = {
				select = {
					enable = true,
					-- Automatically jump forward to textobj, similar to targets.vim
					lookahead = true,
					keymaps = {
						-- You can use the capture groups defined in textobjects.scm
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",
						["ir"] = "@parameter.inner",
						["ar"] = "@parameter.outer",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
