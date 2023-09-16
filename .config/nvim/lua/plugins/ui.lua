return {
   {
      "akinsho/toggleterm.nvim",
      lazy = true,
      keys = {
         { "<C-\\>", ":ToggleTerm<CR>", { noremap = true } },
      },
      opts = {
         open_mapping = [[<C-\>]],
         shading_factor = "1",
         direction = "float",
         float_opts = {
            border = "rounded",
            -- width = math.floor(vim.o.columns * 0.85),
            -- height = math.floor(vim.o.lines * 0.8),
            winblend = 15,
         },
      },
   },
   {
      "tzachar/local-highlight.nvim",
      event = "VeryLazy",
      opts = {
         -- hlgroup = "CursorLine",
         hlgroup = "TelescopeSelection",
      },
      -- config = function()
      --    require("local-highlight").setup()
      -- end,
   },
   {
      "winston0410/range-highlight.nvim",
      event = "VeryLazy",
      dependencies = {
         "winston0410/cmd-parser.nvim",
      },
      config = function()
         require("range-highlight").setup()
      end,
   },
   -- {
   --    "norcalli/nvim-colorizer.lua",
   --    lazy = true,
   --    cmd = "ColorizerToggle",
   --    config = true,
   -- },
   {
      "uga-rosa/ccc.nvim",
      lazy = false,
      opts = {
         highlighter = {
            auto_enable = true,
         },
      },
   },
   {
      "echasnovski/mini.indentscope",
      opts = {
         draw = {
            delay = 10,
            animation = function(_, _)
               return 5
            end,
         },
         mappings = {
            object_scope = "ii",
            object_scope_with_border = "ai",
            goto_top = "[i",
            goto_bottom = "]i",
         },
         options = {
            try_as_border = true,
         },
         -- Which character to use for drawing scope indicator
         -- alternative styles: ┆ ┊ ╎
         symbol = "╎",
      },
      config = function(_, opts)
         require("mini.indentscope").setup(opts)
      end,
   },
   {
      "nvim-lualine/lualine.nvim",
      dependencies = {
         "kyazdani42/nvim-web-devicons",
      },
      opts = function()
         -- -- use gitsigns as source info
         -- local function diff_source()
         -- 	local gitsigns = vim.b.gitsigns_status_dict
         -- 	if gitsigns then
         -- 		return {
         -- 			added = gitsigns.added,
         -- 			modified = gitsigns.changed,
         -- 			removed = gitsigns.removed,
         -- 		}
         -- 	end
         -- end
         local icons = require("icons").icons

         return {
            options = {
               -- theme = "auto",
               theme = "kanagawa",
               icons_enabled = true,
               disabled_filetypes = {},
               always_divide_middle = false,
            },
            sections = {
               -- lualine_a = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source } },
               -- lualine_b = { "branch" },
               -- lualine_b = { { "b:gitsigns_head", icon = "" }, { "diff", source = diff_source } },
               lualine_a = { "branch" },
               -- lualine_a = {},
               -- lualine_b = { "branch" },
               -- TODO could add diff here with custom icons
               lualine_b = {},
               lualine_c = {
                  {
                     "diagnostics",
                     sources = { "nvim_diagnostic" },
                     -- sections = { "error", "warn", "info", "hint" },
                     symbols = {
                        error = icons.diagnostics.Error,
                        warn = icons.diagnostics.Warn,
                        info = icons.diagnostics.Info,
                        hint = icons.diagnostics.Hint,
                     },
                  },
                  {
                     "filetype",
                     icon_only = true, -- Display only an icon for filetype
                  },
                  {
                     "filename",
                     file_status = true, -- Displays file status (readonly status, modified status)
                     path = 1, -- 0: Just the filename 1: Relative path 2: Absolute pathath
                     shorting_target = 40, -- Shortens path to leave 40 spaces in the window
                     symbols = {
                        -- modified = " [+]",
                        modified = icons.git.added,
                        readonly = icons.kinds.ReadOnly,
                     },
                  },
               },
               lualine_x = {
                  "encoding",
                  "fileformat",
                  "filesize",
               },
               lualine_y = { "progress" },
               lualine_z = { "location" },
            },
            inactive_sections = {
               lualine_a = {},
               lualine_b = {},
               lualine_c = { "filename" },
               lualine_x = { "location" },
               lualine_y = {},
               lualine_z = {},
            },
            tabline = {},
            extensions = { "nvim-tree", "toggleterm", "quickfix", "symbols-outline" },
         }
      end,
   },
   {
      "rcarriga/nvim-notify",
      opts = {
         timeout = 3000,
         max_height = function()
            return math.floor(vim.o.lines * 0.75)
         end,
         max_width = function()
            return math.floor(vim.o.columns * 0.75)
         end,
      },
      -- TODO this does not work for a while now - works when oooptions are turned off
      -- opts = {
      --    level = vim.log.levels.ERROR,
      --    -- Animation style
      --    stages = "fade_in_slide_out",
      --    -- Function called when a new window is opened, use for changing win settings/config
      --    on_open = nil,
      --    -- Function called when a window is closed
      --    on_close = nil,
      --    -- Render function for notifications. See notify-render()
      --    render = "default",
      --    -- Default timeout for notifications
      --    timeout = 2000,
      --    -- For stages that change opacity this is treated as the highlight behind the window
      --    -- Set this to either a highlight group, an RGB hex value e.g. "#000000" or a function returning an RGB code for dynamic values
      --    background_colour = "#000000",
      --    -- Minimum width for notification windows
      --    minimum_width = 30,
      --    -- Icons for the different levels
      --    -- TODO add icons from file here
      --    icons = {
      --       ERROR = "",
      --       WARN = "",
      --       INFO = "",
      --       DEBUG = "",
      --       TRACE = "✎",
      --    },
      -- },
      init = function()
         vim.notify = require("notify")
      end,
   },
}
