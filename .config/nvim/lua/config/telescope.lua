local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")
local fb_actions = require("telescope").extensions.file_browser.actions
local sorters = require("telescope.sorters")

telescope.setup({

	defaults = {
		prompt_prefix = "❯ ",
		selection_caret = "❯ ",
		selection_strategy = "reset",
		sorting_strategy = "ascending",
		scroll_strategy = "cycle",
		color_devicons = true,
		winblend = 0,
		-- path_display = { "shorten" },

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
				-- Experimental
				-- ["<tab>"] = actions.toggle_selection,
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
				-- mappings = {
				--   n = {
				--     ["cd"] = function(prompt_bufnr)
				--       local selection = require("telescope.actions.state").get_selected_entry()
				--       local dir = vim.fn.fnamemodify(selection.path, ":p:h")
				--       require("telescope.actions").close(prompt_bufnr)
				--       -- Depending on what you want put `cd`, `lcd`, `tcd`
				--       vim.cmd(string.format("silent lcd %s", dir))
				--     end
				--   }
				-- }
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
	},

	extensions = {
		fzy_native = {
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

	-- extensions = {
	--   fzf = {
	--     fuzzy = true, -- false will only do exact matching
	--     override_generic_sorter = true, -- override the generic sorter
	--     override_file_sorter = true, -- override the file sorter
	--     case_mode = "smart_case", -- or "ignore_case" or "respect_case" or "smart_case"
	--   },
	--   ["ui-select"] = {
	--     require("telescope.themes").get_dropdown({}),
	--   },
	--   file_browser = {
	--     mappings = {
	--       i = {
	--         ["<c-n>"] = fb_actions.create,
	--         ["<c-r>"] = fb_actions.rename,
	--         -- ["<c-h>"] = actions.which_key,
	--         ["<c-h>"] = fb_actions.toggle_hidden,
	--         ["<c-x>"] = fb_actions.remove,
	--         ["<c-p>"] = fb_actions.move,
	--         ["<c-y>"] = fb_actions.copy,
	--         ["<c-a>"] = fb_actions.select_all,
	--       },
	--     },
	--   },
	-- },
	-- pickers = {
	--   find_files = {
	--     hidden = true,
	--   },
	--   buffers = {
	--     ignore_current_buffer = true,
	--     sort_lastused = true,
	--   },
	--   -- find_command = { "fd", "--hidden", "--type", "file", "--follow", "--strip-cwd-prefix" },
	-- },
	-- defaults = {
	--   file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png" },
	--   -- used for grep_string and live_grep
	--   vimgrep_arguments = {
	--     "rg",
	--     "--follow",
	--     "--color=never",
	--     "--no-heading",
	--     "--with-filename",
	--     "--line-number",
	--     "--column",
	--     "--smart-case",
	--     "--no-ignore",
	--     "--trim",
	--   },
	--   mappings = {
	--     i = {
	--       -- Close on first esc instead of going to normal mode
	--       -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
	--       ["<esc>"] = actions.close,
	--       ["<C-j>"] = actions.move_selection_next,
	--       ["<PageUp>"] = actions.results_scrolling_up,
	--       ["<PageDown>"] = actions.results_scrolling_down,
	--       ["<C-u>"] = actions.preview_scrolling_up,
	--       ["<C-d>"] = actions.preview_scrolling_down,
	--       ["<C-k>"] = actions.move_selection_previous,
	--       ["<C-q>"] = actions.send_selected_to_qflist,
	--       ["<C-l>"] = actions.send_to_qflist,
	--       ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
	--       ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
	--       ["<cr>"] = actions.select_default,
	--       ["<c-v>"] = actions.select_vertical,
	--       ["<c-s>"] = actions.select_horizontal,
	--       ["<c-t>"] = actions.select_tab,
	--       ["<c-p>"] = action_layout.toggle_preview,
	--       ["<c-o>"] = action_layout.toggle_mirror,
	--       ["<c-h>"] = actions.which_key,
	--       ["<c-x>"] = actions.delete_buffer,
	--     },
	--   },
	--   prompt_prefix = "> ",
	--   selection_caret = " ",
	--   entry_prefix = "  ",
	--   multi_icon = "<>",
	--   initial_mode = "insert",
	--   scroll_strategy = "cycle",
	--   selection_strategy = "reset",
	--   sorting_strategy = "descending",
	--   layout_strategy = "horizontal",
	--   layout_config = {
	--     width = 0.95,
	--     height = 0.85,
	--     -- preview_cutoff = 120,
	--     prompt_position = "top",
	--     horizontal = {
	--       preview_width = function(_, cols, _)
	--         if cols > 200 then
	--           return math.floor(cols * 0.4)
	--         else
	--           return math.floor(cols * 0.6)
	--         end
	--       end,
	--     },
	--     vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
	--     flex = { horizontal = { preview_width = 0.9 } },
	--   },
	--   winblend = 0,
	--   border = {},
	--   borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
	--   color_devicons = true,
	--   use_less = true,
	--   set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	-- },
})

-- local map = vim.keymap.set
-- local default_options = { silent = true }
-- map("n", "<leader>f", ":Telescope git_files<CR>", default_options)
-- map("n", "<C-r>", ":Telescope projects<CR>", default_options)

-- local map_tele = function(mode, key, f, options, buffer)
-- 	local rhs = function()
-- 		if not pcall(require, "telescope.nvim") then
-- 			require("packer").loader("plenary.nvim")
-- 			require("packer").loader("popup.nvim")
-- 			require("packer").loader("telescope-fzy-native.nvim")
-- 			require("packer").loader("telescope.nvim")
-- 		end
-- 		require("config.telescope")[f](options or {})
-- 	end
--
-- 	local map_options = {
-- 		noremap = true,
-- 		silent = true,
-- 		buffer = buffer,
-- 	}
--
-- 	require("utils").remap(mode, key, rhs, map_options)
-- end

-- mappings
-- map_tele('n', '<leader><F1>', "help_tags")
-- map_tele('n', '<leader>ztes', "file_browser")
-- map_tele('n', '<leader>`', "buffers")
-- map_tele('n', '<leader>f', "project_files")
-- map_tele('n', '<leader>zd', "fd")
-- map_tele('n', '<leader>zg', "git_files")
-- map_tele('n', '<leader>zb', "curbuf")
-- map_tele("n", "//", "current_buffer_fuzzy_find")
-- map_tele('n', '<leader>zh', "oldfiles")
-- map_tele("n", "<leader>sx", "commands")
-- map_tele("n", "<leader>s:", "command_history")
-- map_tele("n", "<leader>s/", "search_history")
-- map_tele("n", "<leader>sm", "marks")
-- map_tele("n", "<leader>sM", "man_pages")
-- map_tele("n", "<leader>sq", "quickfix")
-- map_tele("n", "<leader>sQ", "loclist")
-- map_tele("n", '<leader>s"', "registers")
-- map_tele('n', '<leader>so', "vim_options")
-- map_tele("n", "<leader>sk", "keymaps")
-- map_tele('n', '<leader>zz', "spell_suggest")
-- map_tele('n', '<leader>zt', "current_buffer_tags")
-- map_tele('n', '<leader>zT', "tags")
-- map_tele("n", "\\\\", "live_grep")

--[[ map_tele('n', "<space>z/", "grep_last_search", {
  layout_strategy = "vertical",
}) ]]
-- map_tele("n", "<leader>ws", "grep_cword")
-- map_tele('n', '<leader>zW', "grep_cWORD")
-- map_tele('n', '<leader>zr', "grep_prompt")
-- map_tele('n', '<leader>zv', "grep_visual")
-- map_tele("v", "<leader>ws", "grep_visual")

-- Telescope Meta
-- map_tele("n", "<leader>s?", "builtin")

-- Git
-- map_tele("n", "<leader>sb", "git_branches")
-- map_tele("n", "<leader>ss", "git_status")
-- map_tele('n', '<leader>zc', "git_bcommits")
-- map_tele("n", "<leader>sc", "git_commits")

-- LSP
-- map_tele('n', '<leader>zlr', "lsp_references")
-- map_tele("n", "gr", "lsp_references")
-- map_tele("n", "<leader>sa", "lsp_code_actions")
-- map_tele('n', 'ga', "lsp_code_actions")
-- map_tele('n', '<leader>zlA', "lsp_range_code_actions")
-- map_tele('n', '<leader>zld', "lsp_definitions")
-- map_tele('n', '<leader>zlm', "lsp_implementations")
-- map_tele("n", "<leader>sd", "diagnostics", { bufnr = 0 })
-- map_tele("n", "<leader>sD", "diagnostics")
-- map_tele('n', '<leader>zls', "lsp_document_symbols")
-- map_tele('n', '<leader>zlS', "lsp_workspace_symbols")

-- Nvim & Dots
-- map_tele('n', '<leader>zen', "edit_neovim")
-- map_tele('n', '<leader>zed', "edit_dotfiles")
-- map_tele('n', '<leader>zez', "edit_zsh")
-- map_tele('n', '<leader>zep', "installed_plugins")

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("heading")
telescope.load_extension("file_browser")
telescope.load_extension("packer")
telescope.load_extension("ui-select")
telescope.load_extension("fzy_native")
telescope.load_extension("media_files")

-- local M = {}
--
-- function M.edit_neovim()
-- 	require("telescope.builtin").find_files({
-- 		prompt_title = "< VimRC >",
-- 		path_display = { "absolute" },
-- 		-- path_display = { "shorten", "absolute" },
-- 		cwd = "~/.config/nvim",
--
-- 		layout_strategy = "vertical",
-- 		layout_config = {
-- 			width = 0.9,
-- 			height = 0.8,
--
-- 			horizontal = {
-- 				width = { padding = 0.15 },
-- 			},
-- 			vertical = {
-- 				preview_height = 0.45,
-- 			},
-- 		},
--
-- 		attach_mappings = function(_, map)
-- 			map("i", "<c-y>", set_prompt_to_entry_value)
-- 			return true
-- 		end,
-- 	})
-- end
--
-- function M.edit_dotfiles()
-- 	require("telescope.builtin").find_files({
-- 		prompt_title = "~ dotfiles ~",
-- 		path_display = { "absolute" },
-- 		cwd = "~/dots",
--
-- 		attach_mappings = function(_, map)
-- 			map("i", "<c-y>", set_prompt_to_entry_value)
-- 			return true
-- 		end,
-- 	})
-- end
--
-- function M.edit_zsh()
-- 	require("telescope.builtin").find_files({
-- 		path_display = { "absolute" },
-- 		cwd = "~/.config/zsh/",
-- 		prompt = "~ zsh ~",
-- 		hidden = true,
--
-- 		layout_strategy = "vertical",
-- 		layout_config = {
-- 			horizontal = {
-- 				width = { padding = 0.15 },
-- 			},
-- 			vertical = {
-- 				preview_height = 0.75,
-- 			},
-- 		},
-- 	})
-- end
--
-- M.git_branches = function()
-- 	require("telescope.builtin").git_branches({
-- 		attach_mappings = function(_, map)
-- 			map("i", "<c-x>", actions.git_delete_branch)
-- 			map("n", "<c-x>", actions.git_delete_branch)
-- 			map("i", "<c-y>", set_prompt_to_entry_value)
-- 			return true
-- 		end,
-- 	})
-- end
--
-- function M.lsp_code_actions()
-- 	local opts = themes.get_dropdown({
-- 		winblend = 10,
-- 		border = true,
-- 		previewer = false,
-- 		path_display = { "absolute" },
-- 	})
--
-- 	require("telescope.builtin").lsp_code_actions(opts)
-- end
--
-- function M.fd()
-- 	require("telescope.builtin").fd()
-- end
--
-- function M.builtin()
-- 	require("telescope.builtin").builtin()
-- end
--
-- --[[
-- function M.live_grep()
--   require("telescope").extensions.fzf_writer.staged_grep {
--     path_display = { "absolute" },
--     previewer = false,
--     fzf_separator = "|>",
--   }
-- end
-- --]]
--
-- function M.grep_prompt()
-- 	require("telescope.builtin").grep_string({
-- 		path_display = { "absolute" },
-- 		search = vim.fn.input("Grep String ❯ "),
-- 	})
-- end
--
-- function M.grep_visual()
-- 	require("telescope.builtin").grep_string({
-- 		path_display = { "absolute" },
-- 		search = require("utils").get_visual_selection(),
-- 	})
-- end
--
-- function M.grep_cword()
-- 	require("telescope.builtin").grep_string({
-- 		path_display = { "absolute" },
-- 		word_match = "-w",
-- 		only_sort_text = true,
-- 		layout_strategy = "vertical",
-- 		sorter = sorters.get_fzy_sorter(),
-- 		-- search = vim.fn.expand("<cword>"),
-- 	})
-- end
--
-- function M.grep_cWORD()
-- 	require("telescope.builtin").grep_string({
-- 		path_display = { "absolute" },
-- 		search = vim.fn.expand("<cWORD>"),
-- 	})
-- end
--
-- function M.grep_last_search(opts)
-- 	opts = opts or {}
--
-- 	-- \<getreg\>\C
-- 	-- -> Subs out the search things
-- 	local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")
--
-- 	opts.path_display = { "absolute" }
-- 	opts.word_match = "-w"
-- 	opts.search = register
--
-- 	require("telescope.builtin").grep_string(opts)
-- end
--
-- function M.my_plugins()
-- 	require("telescope.builtin").find_files({
-- 		cwd = "~/plugins/",
-- 	})
-- end
--
-- function M.installed_plugins()
-- 	require("telescope.builtin").find_files({
-- 		cwd = vim.fn.stdpath("data") .. "/site/pack/packer/",
-- 	})
-- end
--
-- function M.project_search()
-- 	require("telescope.builtin").find_files({
-- 		previewer = false,
-- 		layout_strategy = "vertical",
-- 		cwd = require("nvim_lsp.util").root_pattern(".git")(vim.fn.expand("%:p")),
-- 	})
-- end
--
-- -- TODO adjust this to better filtering, add rg as file searcher
-- M.project_files = function()
-- 	local opts = {
-- 		hidden = true,
-- 		find_command = { "rg", "--no-ignore", "--files", "--hidden" },
-- 		file_ignore_patterns = { "node_modules", "%.pyc", "^.zinit/", "^.node-gyp/", "^.cache/", "^.git/", "git" },
-- 	} -- define here if you want to define something
-- 	local ok = pcall(require("telescope.builtin").git_files, opts)
-- 	if not ok then
-- 		require("telescope.builtin").find_files(opts)
-- 	end
-- end
--
-- function M.curbuf()
-- 	local opts = themes.get_dropdown({
-- 		winblend = 10,
-- 		border = true,
-- 		previewer = false,
-- 		path_display = { "absolute" },
-- 	})
-- 	require("telescope.builtin").current_buffer_fuzzy_find(opts)
-- end
--
-- function M.help_tags()
-- 	require("telescope.builtin").help_tags({
-- 		show_version = true,
-- 	})
-- end
--
-- function M.find_files()
-- 	require("telescope.builtin").fd({
-- 		-- find_command = { "fd", "--hidden", "--follow", "--type f" },
-- 		-- find_command = { "rg", "--no-ignore", "--files", "--hidden" },
-- 		file_ignore_patterns = { "node_modules", ".pyc" },
-- 		path_display = { "absolute" },
-- 	})
-- end
--
-- function M.search_all_files()
-- 	require("telescope.builtin").find_files({
-- 		find_command = { "rg", "--no-ignore", "--files" },
-- 	})
-- end
--
-- function M.file_browser()
-- 	local opts
--
-- 	opts = {
-- 		sorting_strategy = "ascending",
-- 		scroll_strategy = "cycle",
-- 		layout_config = {
-- 			prompt_position = "top",
-- 		},
--
-- 		attach_mappings = function(prompt_bufnr, map)
-- 			local current_picker = action_state.get_current_picker(prompt_bufnr)
--
-- 			local modify_cwd = function(new_cwd)
-- 				current_picker.cwd = new_cwd
-- 				current_picker:refresh(opts.new_finder(new_cwd), { reset_prompt = true })
-- 			end
--
-- 			map("i", "-", function()
-- 				modify_cwd(current_picker.cwd .. "/..")
-- 			end)
--
-- 			map("i", "~", function()
-- 				modify_cwd(vim.fn.expand("~"))
-- 			end)
--
-- 			local modify_depth = function(mod)
-- 				return function()
-- 					opts.depth = opts.depth + mod
--
-- 					local current_picker = action_state.get_current_picker(prompt_bufnr)
-- 					current_picker:refresh(opts.new_finder(current_picker.cwd), { reset_prompt = true })
-- 				end
-- 			end
--
-- 			map("i", "<M-=>", modify_depth(1))
-- 			map("i", "<M-+>", modify_depth(-1))
--
-- 			map("n", "yy", function()
-- 				local entry = action_state.get_selected_entry()
-- 				vim.fn.setreg("+", entry.value)
-- 			end)
--
-- 			return true
-- 		end,
-- 	}
--
-- 	require("telescope.builtin").file_browser(opts)
-- end
--
-- --[[ function M.git_status()
--   local opts = themes.get_dropdown {
--     winblend = 10,
--     border = true,
--     previewer = false,
--     path_display = { "absolute" },
--   }
--
--   -- Can change the git icons using this.
--   opts.git_icons = {
--     changed = "M"
--   }
--
--   require("telescope.builtin").git_status(opts)
-- end ]]
--
-- -- open diff for the chosen commit
-- local open_dif = function()
-- 	local selected_entry = action_state.get_selected_entry()
-- 	local value = selected_entry["value"]
-- 	-- close Telescope window properly prior to switching windows
-- 	vim.api.nvim_win_close(0, true)
-- 	local cmd = "DiffviewOpen " .. value
-- 	vim.cmd(cmd)
-- end
--
-- function M.git_commits()
-- 	require("telescope.builtin").git_commits({
-- 		winblend = 5,
-- 		attach_mappings = function(_, map)
-- 			map("n", "<c-o>", open_dif)
-- 			return true
-- 		end,
-- 	})
-- end
--
-- function M.search_only_certain_files()
-- 	require("telescope.builtin").find_files({
-- 		find_command = {
-- 			"rg",
-- 			"--files",
-- 			"--type",
-- 			vim.fn.input("Type: "),
-- 		},
-- 	})
-- end
--
-- return setmetatable({}, {
-- 	__index = function(_, k)
-- 		-- reloader()
--
-- 		if M[k] then
-- 			return M[k]
-- 		else
-- 			return require("telescope.builtin")[k]
-- 		end
-- 	end,
-- })
