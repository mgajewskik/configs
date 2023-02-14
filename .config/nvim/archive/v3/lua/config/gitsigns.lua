require("gitsigns").setup({
	keymaps = {
		-- Default keymap options
		noremap = false,
	},
	signs = {
		add = {
			hl = "GitSignsAdd",
			text = "│",
			numhl = "GitSignsAddNr",
			linehl = "GitSignsAddLn",
		},
		change = {
			hl = "GitSignsChange",
			text = "│",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
		delete = {
			hl = "GitSignsDelete",
			text = "_",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		topdelete = {
			hl = "GitSignsDelete",
			text = "‾",
			numhl = "GitSignsDeleteNr",
			linehl = "GitSignsDeleteLn",
		},
		changedelete = {
			hl = "GitSignsChange",
			text = "~",
			numhl = "GitSignsChangeNr",
			linehl = "GitSignsChangeLn",
		},
	},
	signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = { interval = 1000, follow_files = true },
	attach_to_untracked = true,
	-- git-blame provides also the time in contrast to gitsigns
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_formatter_opts = { relative_time = false },
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = "single",
		style = "minimal",
		relative = "cursor",
		row = 0,
		col = 1,
	},
	diff_opts = { internal = true },
	yadm = { enable = false },
	on_attach = function(bufnr)
		local map = vim.keymap.set
		local opts = { buffer = bufnr }
		local opts_expr = { buffer = bufnr, expr = true }

		-- creates too many lua func references as
		-- this is called for every bufer attach
		-- local gs = package.loaded.gitsigns
		-- map('n', ']c', function()
		--   if vim.wo.diff then vim.api.nvim_feedkeys(']c', 'n', true) end
		--   vim.schedule(function() gs.next_hunk() end)
		-- end, opts)
		--
		-- map('n', '[c', function()
		--   if vim.wo.diff then vim.api.nvim_feedkeys('[c', 'n', true) end
		--   vim.schedule(function() gs.prev_hunk() end)
		-- end, opts)

		map("n", "[c", "&diff ? '[c' : '<cmd>lua package.loaded.gitsigns.prev_hunk()<CR>'", opts_expr)
		map("n", "]c", "&diff ? ']c' : '<cmd>lua package.loaded.gitsigns.next_hunk()<CR>'", opts_expr)

		-- Actions
		map({ "n", "v" }, "<leader>ga", '<cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
		map({ "n", "v" }, "<leader>gr", '<cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
		map("n", "<leader>gA", '<cmd>lua require("gitsigns").stage_buffer()<CR>', opts)
		map("n", "<leader>gu", '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', opts)
		-- doesn't exist yet
		-- map('n', '<leader>hU', '<cmd>lua require("gitsigns").undo_stage_buffer()<CR>', opts)
		map("n", "<leader>gR", '<cmd>lua require("gitsigns").reset_buffer()<CR>', opts)
		-- map("n", "<leader>hp", '<cmd>lua require("gitsigns").preview_hunk()<CR>', opts)
		map("n", "<leader>gb", '<cmd>lua require("gitsigns").blame_line({full=true})<CR>', opts)
		-- map("n", "<leader>hB", '<cmd>lua require("gitsigns").toggle_current_line_blame()<CR>', opts)
		-- map("n", "<leader>hd", '<cmd>lua require("gitsigns").diffthis()<CR>', opts)
		-- map("n", "<leader>hD", '<cmd>lua require("gitsigns").diffthis("~1")<CR>', opts)
		-- map("n", "<leader>hx", '<cmd>lua require("gitsigns").toggle_deleted()<CR>', opts)

		-- Text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", opts)
	end,
})

-- local res, gitsigns = pcall(require, "gitsigns")
-- if not res then
--   return
-- end
--
-- gitsigns.setup {
--   signs = {
--     add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
--     change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--     delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--     topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--     changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--   },
--   numhl = true,
--   linehl = false,
--   word_diff = true,
--   keymaps = {
--     -- Default keymap options
--     noremap = true,
--     buffer = true,
--
--     ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
--     ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},
--
--     -- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
--     -- ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
--     -- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
--     ['n <leader>gu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
--     ['v <leader>gu'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
--     -- ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
--     ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
--     -- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
--
--     -- Text objects
--     ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
--     ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
--   },
--   watch_gitdir = {
--     interval = 1000
--   },
--   current_line_blame = false,
--   current_line_blame_opts = { delay = 1000, virt_text_pos = 'eol' },
--   preview_config = { border = 'rounded' },
--   diff_opts = { internal = true, },
-- }
--
-- local res, gitsigns = pcall(require, "gitsigns")
-- if not res then
--   return
-- end
--
-- -- TODO check what's new here and update
-- -- gitsigns.setup {
-- --   signs = {
-- --     add          = {hl = 'GitSignsAdd'   , text = '┃', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
-- --     change       = {hl = 'GitSignsChange', text = '┃', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
-- --     delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
-- --     topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
-- --     changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
-- --   },
-- --   numhl = false,
-- --   linehl = false,
-- --   watch_gitdir = { interval = 1000 },
-- --   current_line_blame = false,
-- --   current_line_blame_opts = { delay = 1000, virt_text_pos = 'eol' },
-- --   preview_config = { border = 'rounded' },
-- --   diff_opts = { internal = true, },
-- --   yadm = { enable = true, },
-- --   on_attach = function(bufnr)
-- --     local map = vim.keymap.set
-- --     local opts = { buffer = bufnr }
-- --     local opts_expr = { buffer = bufnr, expr = true }
-- --
-- --     -- creates too many lua func references as
-- --     -- this is called for every bufer attach
-- --     -- local gs = package.loaded.gitsigns
-- --     -- map('n', ']c', function()
-- --     --   if vim.wo.diff then vim.api.nvim_feedkeys(']c', 'n', true) end
-- --     --   vim.schedule(function() gs.next_hunk() end)
-- --     -- end, opts)
-- --     --
-- --     -- map('n', '[c', function()
-- --     --   if vim.wo.diff then vim.api.nvim_feedkeys('[c', 'n', true) end
-- --     --   vim.schedule(function() gs.prev_hunk() end)
-- --     -- end, opts)
-- --
-- --     map('n', '[c', "&diff ? '[c' : '<cmd>lua package.loaded.gitsigns.prev_hunk()<CR>'", opts_expr)
-- --     map('n', ']c', "&diff ? ']c' : '<cmd>lua package.loaded.gitsigns.next_hunk()<CR>'", opts_expr)
-- --
-- --     -- Actions
-- --     map({'n', 'v'}, '<leader>hs', '<cmd>lua require("gitsigns").stage_hunk()<CR>', opts)
-- --     map({'n', 'v'}, '<leader>hr', '<cmd>lua require("gitsigns").reset_hunk()<CR>', opts)
-- --     map('n', '<leader>hS', '<cmd>lua require("gitsigns").stage_buffer()<CR>', opts)
-- --     map('n', '<leader>hu', '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>', opts)
-- --     -- doesn't exist yet
-- --     -- map('n', '<leader>hU', '<cmd>lua require("gitsigns").undo_stage_buffer()<CR>', opts)
-- --     map('n', '<leader>hR', '<cmd>lua require("gitsigns").reset_buffer()<CR>', opts)
-- --     map('n', '<leader>hp', '<cmd>lua require("gitsigns").preview_hunk()<CR>', opts)
-- --     map('n', '<leader>hb', '<cmd>lua require("gitsigns").blame_line({full=true})<CR>', opts)
-- --     map('n', '<leader>hB', '<cmd>lua require("gitsigns").toggle_current_line_blame()<CR>', opts)
-- --     map('n', '<leader>hd', '<cmd>lua require("gitsigns").diffthis()<CR>', opts)
-- --     map('n', '<leader>hD', '<cmd>lua require("gitsigns").diffthis("~1")<CR>', opts)
-- --     map('n', '<leader>hx', '<cmd>lua require("gitsigns").toggle_deleted()<CR>', opts)
-- --
-- --     -- Text object
-- --     map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', opts)
-- --   end
-- -- }
