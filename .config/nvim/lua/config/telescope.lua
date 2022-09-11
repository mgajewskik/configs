local telescope = require("telescope")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")

telescope.setup({

	defaults = {
		prompt_prefix = "❯ ",
		-- selection_caret = "❯ ",
		selection_caret = " ",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		--   sorting_strategy = "descending",
		scroll_strategy = "cycle",
		color_devicons = true,
		winblend = 0,
		-- path_display = { "shorten" },
		initial_mode = "insert",
		--   border = {},
		--   use_less = true,
		--   set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,

		layout_strategy = "flex",
		layout_config = {
			width = 0.95,
			height = 0.85,
			prompt_position = "top",

			horizontal = {
				-- width_padding = 0.1,
				-- height_padding = 0.1,
				width = 0.9,
				preview_cutoff = 60,
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.7)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = {
				-- width_padding = 0.05,
				-- height_padding = 1,
				width = 0.75,
				height = 0.85,
				preview_height = 0.4,
				mirror = true,
			},
			flex = {
				-- change to horizontal after 120 cols
				flip_columns = 120,
			},
		},

		mappings = {
			i = {
				["<C-x>"] = actions.delete_buffer,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<S-up>"] = actions.preview_scrolling_up,
				["<S-down>"] = actions.preview_scrolling_down,
				["<C-up>"] = actions.preview_scrolling_up,
				["<C-down>"] = actions.preview_scrolling_down,

				-- TODO: look into using 'actions.set.shift_selection'
				["<C-u>"] = actions.move_to_top,
				["<C-d>"] = actions.move_to_middle,
				["<C-b>"] = actions.move_to_top,
				["<C-f>"] = actions.move_to_bottom,

				["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-y>"] = set_prompt_to_entry_value,

				["<C-c>"] = actions.close,
				["<Esc>"] = actions.close,
				-- ["<M-m>"] = actions.master_stack,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<c-h>"] = actions.which_key,
				["<c-x>"] = actions.delete_buffer,
			},
			n = {
				["<CR>"] = actions.select_default + actions.center,
				["<C-x>"] = actions.delete_buffer,
				["<C-s>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["<S-up>"] = actions.preview_scrolling_up,
				["<S-down>"] = actions.preview_scrolling_down,
				["<C-up>"] = actions.preview_scrolling_up,
				["<C-down>"] = actions.preview_scrolling_down,

				["<C-u>"] = actions.move_to_top,
				["<C-d>"] = actions.move_to_middle,
				["<C-b>"] = actions.move_to_top,
				["<C-f>"] = actions.move_to_bottom,

				["<C-q>"] = actions.send_to_qflist,
				["<M-q>"] = actions.send_to_qflist + actions.open_qflist,

				["<C-c>"] = actions.close,
				-- ["<Esc>"] = false,
				["<Esc>"] = actions.close,
				-- ["<Tab>"] = actions.toggle_selection,
			},
		},

		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },

		file_sorter = sorters.get_fzy_sorter,
		-- we ignore individually in M.find_files()
		-- file_ignore_patterns = {"node_modules", ".pyc"},

		pickers = {
			find_files = {
				hidden = true,
			},
			buffers = {
				ignore_current_buffer = true,
				sort_lastused = true,
			},
		},

		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

		-- only for live_grep and grep_string
		vimgrep_arguments = {
			"rg",
			"--column",
			"--line-number",
			"--with-filename",
			"--no-heading",
			"--smart-case",
			"--hidden",
		},
		--     "--follow",
		--     "--color=never",
		--     "--no-ignore",
		--     "--trim",
		--   file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png" },
	},

	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
		},

		fzf_writer = {
			use_highlighter = false,
			minimum_grep_characters = 6,
		},

		frecency = {
			workspaces = {
				["conf"] = "~/.config/nvim/",
			},
		},
		media_files = {
			-- filetypes whitelist
			-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
			filetypes = { "png", "webp", "jpg", "jpeg", "mp4", "pdf" },
			find_cmd = "rg", -- find command (defaults to `fd`)
		},
	},
})

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("media_files")

local map = vim.keymap.set
local default_options = { silent = true }
map("n", "<leader>st", ":Telescope<CR>", default_options)

-- map("n", "<leader>f", ":Telescope git_files<CR>", default_options)
-- map("n", "<C-r>", ":Telescope projects<CR>", default_options)
