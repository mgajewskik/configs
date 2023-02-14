return {
   {
      "ggandor/leap.nvim",
      event = "VeryLazy",
      config = function()
         require("leap").add_default_mappings()
      end,
   },
   {
      "ggandor/flit.nvim",
      dependencies = {
         "ggandor/leap.nvim",
      },
      event = "VeryLazy",
      config = function()
         require("flit").setup()
      end,
   },
   {
      "cbochs/portal.nvim",
      event = "VeryLazy",
      config = function()
         local map = vim.keymap.set

         map("n", "<leader>o", require("portal").jump_backward, { noremap = true })
         map("n", "<leader>i", require("portal").jump_forward, { noremap = true })
      end,
   },
   {
      "ptzz/lf.vim",
      dependencies = {
         "voldikss/vim-floaterm",
      },
      lazy = true,
      keys = {
         { "<C-e>", ":Lf<CR>", { noremap = true } },
      },
      init = function()
         vim.g.lf_map_keys = 0
         vim.g.lf_replace_netrw = 1
         -- vim.g.floaterm_opener = "vsplit"
         vim.g.floaterm_opener = "edit"
      end,
   },
   {
      "kyazdani42/nvim-tree.lua",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      lazy = true,
      keys = {
         { "<leader>e", ":NvimTreeToggle<CR>", { noremap = true } },
      },
      opts = {
         update_focused_file = {
            enable = true,
            update_root = true,
         },
         reload_on_bufenter = true,
         respect_buf_cwd = true,
         view = {
            centralize_selection = true,
         },
      },
      -- <Tab> - preview
      -- `I`               toggle_git_ignored  toggle visibility of files/folders hidden via |git.ignore| option
      -- `H`               toggle_dotfiles     toggle visibility of dotfiles via |filters.dotfiles| option
      -- `a`               create              add a file; leaving a trailing `/` will add a directory
      -- `d`               remove              delete a file (will prompt for confirmation)
      -- `D`               trash               trash a file via |trash| option
      -- `r`               rename              rename a file
      -- `<C-r>`           full_rename         rename a file and omit the filename on input
      -- `x`               cut                 add/remove file/directory to cut clipboard
      -- `c`               copy                add/remove file/directory to copy clipboard
      -- `p`               paste               paste from clipboard; cut clipboard has precedence over copy; will prompt for confirmation
      -- `y`               copy_name           copy name to system clipboard
      -- `Y`               copy_path           copy relative path to system clipboard
      -- `gy`              copy_absolute_path  copy absolute path to system clipboard
      -- `f`               live_filter         live filter nodes dynamically based on regex matching.
      -- `F`               clear_live_filter   clear live filter
      -- `<C-k>`           toggle_file_info    toggle a popup with file infos about the file under the cursor
      -- `W`               collapse_all        collapse the whole tree
      -- `E`               expand_all          expand the whole tree, stopping after expanding |actions.expand_all.max_folder_discovery| folders; this might hang neovim for a while if running on a big folder
   },
   {
      "ibhagwan/fzf-lua",
      dependencies = {
         -- "junegunn/fzf",
         -- "vijaymarupudi/nvim-fzf",
         "kyazdani42/nvim-web-devicons",
      },
      keys = {
         { "<leader>ss", ":FzfLua<CR>", { noremap = true } },
         { "<C-p>", ":FzfLua files<CR>", { noremap = true } },
         { "<leader>rf", ":FzfLua files cwd=$HOME<CR>", { noremap = true } },
         { "<leader>sn", ":FzfLua files cwd=$HOME/.config/nvim<CR>", { noremap = true } },
         { "<leader>f", ":FzfLua git_files<CR>", { noremap = true } },
         { "<leader>`", ":FzfLua buffers<CR>", { noremap = true } },
         { "<leader>\\\\", ":FzfLua grep_visual<CR>", { noremap = true } },
         { "\\\\", ":FzfLua live_grep_glob<CR>", { noremap = true } },
         { "//", ":FzfLua blines<CR>", { noremap = true } },
         { "<leader>sq", ":FzfLua quickfix<CR>", { noremap = true } },
         { "gr", ":FzfLua lsp_references<CR>", { noremap = true } },
         { "gm", ":FzfLua lsp_implementations<CR>", { noremap = true } },
         { "<leader>ls", ":FzfLua lsp_document_symbols<CR>", { noremap = true } },
         { "<leader>lS", ":FzfLua lsp_workspace_symbols<CR>", { noremap = true } },
         { "<leader>as", ":FzfLua lsp_code_actions<CR>", { noremap = true } },
         { "<leader>sd", ":FzfLua lsp_document_diagnostics<CR>", { noremap = true } },
         { "<leader>sD", ":FzfLua lsp_workspace_diagnostics<CR>", { noremap = true } },
         { "<leader>sb", ":FzfLua git_branches<CR>", { noremap = true } },
         { "<leader>sc", ":FzfLua git_commits<CR>", { noremap = true } },
         { "<leader>sC", ":FzfLua git_bcommits<CR>", { noremap = true } },
         { "<leader>sm", ":FzfLua marks<CR>", { noremap = true } },
         { "<leader>sx", ":FzfLua commands<CR>", { noremap = true } },
         { "<leader>s:", ":FzfLua command_history<CR>", { noremap = true } },
         { "<leader>s/", ":FzfLua search_history<CR>", { noremap = true } },
         { '<leader>s"', ":FzfLua registers<CR>", { noremap = true } },
         { "<leader>sk", ":FzfLua keymaps<CR>", { noremap = true } },
      },
      opts = function()
         local actions = require("fzf-lua.actions")
         return {
            winopts = {
               height = 0.85,
               width = 0.95,
               row = 0.35,
               col = 0.55,
               -- border = "single",
            },
            actions = {
               files = {
                  ["default"] = actions.file_edit_or_qf,
                  ["ctrl-s"] = actions.file_split,
                  ["ctrl-v"] = actions.file_vsplit,
                  ["ctrl-t"] = actions.file_tabedit,
                  ["ctrl-q"] = actions.file_sel_to_qf,
               },
            },
            lsp = {
               async_or_timeout = 3000,
            },
         }
      end,
      config = function(_, opts)
         require("fzf-lua").setup(opts)

         local map = vim.keymap.set
         -- doesn't work with keya mapping
         map("n", "<leader>ws", ":FzfLua grep_cword<CR>", { noremap = true })
         -- map("v", "<leader>ws", ":FzfLua grep_visual<CR>", { noremap = true })
      end,
   },
   {
      "nvim-telescope/telescope.nvim",
      dependencies = {
         -- "nvim-telescope/telescope-fzf-native.nvim", { 'do': 'make' }
         -- "nvim-telescope/telescope-media-files.nvim"
         -- "nvim-lua/popup.nvim",
         "nvim-telescope/telescope-project.nvim",
         "nvim-lua/plenary.nvim",
      },
      lazy = true,
      keys = {
         { "<leader>st", ":Telescope<CR>", { noremap = true } },
         { "<leader>sp", ":Telescope project<CR>", { noremap = true } },
      },
      opts = function()
         local actions = require("telescope.actions")
         return {
            defaults = {
               prompt_prefix = "❯ ",
               -- selection_caret = "❯ ",
               selection_caret = " ",
               selection_strategy = "reset",
               sorting_strategy = "ascending",
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

                     ["<C-u>"] = actions.move_to_top,
                     ["<C-d>"] = actions.move_to_middle,
                     ["<C-b>"] = actions.move_to_top,
                     ["<C-f>"] = actions.move_to_bottom,

                     ["<M-q>"] = actions.send_to_qflist + actions.open_qflist,
                     ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

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
            },
            extensions = {
               project = {
                  base_dirs = {},
               },
            },
         }
      end,
      config = function(_, opts)
         local telescope = require("telescope")
         telescope.setup(opts)
         -- Default mappings (insert mode):
         -- Key	Description
         -- <c-d>	delete currently selected project
         -- <c-v>	rename currently selected project
         -- <c-a>	create a project*
         -- <c-s>	search inside files within your project
         -- <c-b>	browse inside files within your project
         -- <c-l>	change to the selected project's directory without opening it
         -- <c-r>	find a recently opened file within your project
         -- <c-f>	find a file within your project (same as <CR>)
         telescope.load_extension("project")
      end,
   },
   {
      "chentoast/marks.nvim",
      event = "VeryLazy",
      opts = {
         mappings = {
            next = "]m",
            prev = "[m",
         },
      },
      -- mx              Set mark x
      -- m,              Set the next available alphabetical (lowercase) mark
      -- m;              Toggle the next available mark at the current line
      -- dmx             Delete mark x
      -- dm-             Delete all marks on the current line
      -- dm<space>       Delete all marks in the current buffer
      -- m]              Move to next mark
      -- m[              Move to previous mark
      -- m:              Preview mark. This will prompt you for a specific mark to
      --                 preview; press <cr> to preview the next mark.
      --
      -- m[0-9]          Add a bookmark from bookmark group[0-9].
      -- dm[0-9]         Delete all bookmarks from bookmark group[0-9].
      -- m}              Move to the next bookmark having the same type as the bookmark under
      --                 the cursor. Works across buffers.
      -- m{              Move to the previous bookmark having the same type as the bookmark under
      --                 the cursor. Works across buffers.
      -- dm=             Delete the bookmark under the cursor.
   },
}
