return {
   {
      "renerocksai/telekasten.nvim",
      dependencies = {
         "renerocksai/calendar-vim",
         "nvim-telescope/telescope.nvim",
      },
      lazy = true,
      keys = {
         { "<leader>zf", "<CMD>Telekasten find_notes<CR>", { noremap = true } },
         { "<leader>zs", "<CMD>Telekasten search_notes<CR>", { noremap = true } },
         { "<leader>zd", "<CMD>Telekasten find_daily_notes<CR>", { noremap = true } },
         { "<leader>zw", "<CMD>Telekasten find_weekly_notes<CR>", { noremap = true } },
         { "<leader>zg", "<CMD>Telekasten find_friends<CR>", { noremap = true } },
         { "<leader>zt", "<CMD>Telekasten show_tags<CR>", { noremap = true } },
         { "<leader>zb", "<CMD>Telekasten show_backlinks<CR>", { noremap = true } },
         { "<leader>zc", "<CMD>Telekasten show_calendar<CR>", { noremap = true } },
         { "<leader>znn", "<CMD>Telekasten new_note<CR>", { noremap = true } },
         { "<leader>znd", "<CMD>Telekasten goto_today<CR>", { noremap = true } },
         { "<leader>znw", "<CMD>Telekasten goto_thisweek<CR>", { noremap = true } },
         { "<leader>zz", "<CMD>Telekasten follow_link<CR>", { noremap = true } },
         { "<leader>zl", "<CMD>Telekasten insert_link<CR>", { noremap = true } },
         { "<leader>zy", "<CMD>Telekasten yank_notelink<CR>", { noremap = true } },
         { "<leader>zm", "<CMD>Telekasten browse_media<CR>", { noremap = true } },
         { "<leader>zi", "<CMD>Telekasten preview_img<CR>", { noremap = true } },
         { "<leader>za", "<CMD>Telekasten toggle_todo<CR>", { noremap = true } },
         { "<leader>zr", "<CMD>Telekasten rename_note<CR>", { noremap = true } },
         { "<leader>z?", "<CMD>Telekasten panel<CR>", { noremap = true } },
      },
      init = function()
         vim.cmd([[hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline]])
         vim.cmd([[hi tkBrackets ctermfg=gray guifg=gray]])
         vim.cmd([[hi tkHighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold]])

         -- Calendar color change
         vim.cmd([[hi link CalNavi CalRuler]])
         vim.cmd([[hi tkTagSep ctermfg=gray guifg=gray]])
         vim.cmd([[hi tkTag ctermfg=175 guifg=#d3869B]])
      end,
      config = function()
         -- TODO cleanup this mess
         local home = vim.fn.expand("~/Dropbox/obsidian")

         require("telekasten").setup({
            home = home,
            install_syntax = true,
            -- if true, telekasten will be enabled when opening a note within the configured home
            take_over_my_home = true,
            -- auto-set telekasten filetype: if false, the telekasten filetype will not be used
            --                               and thus the telekasten syntax will not be loaded either
            auto_set_filetype = true,
            -- dir names for special notes (absolute path or subdir name)
            dailies = home .. "/" .. "journal/daily",
            weeklies = home .. "/" .. "journal/weekly",
            templates = home .. "/" .. "templates",
            -- image (sub)dir for pasting
            -- dir name (absolute path or subdir name)
            -- or nil if pasted images shouldn't go into a special subdir
            image_subdir = "media",
            -- markdown file extension
            extension = ".md",
            -- following a link to a non-existing note will create it
            follow_creates_nonexisting = true,
            dailies_create_nonexisting = true,
            weeklies_create_nonexisting = true,
            -- template for new notes (new_note, follow_link)
            -- set to `nil` or do not specify if you do not want a template
            template_new_note = home .. "/" .. "templates/note.md",
            -- template for newly created daily notes (goto_today)
            -- set to `nil` or do not specify if you do not want a template
            template_new_daily = home .. "/" .. "templates/daily.md",
            -- template for newly created weekly notes (goto_thisweek)
            -- set to `nil` or do not specify if you do not want a template
            template_new_weekly = home .. "/" .. "templates/weekly.md",
            -- image link style
            -- wiki:     ![[image name]]
            -- markdown: ![](image_subdir/xxxxx.png)
            image_link_style = "wiki",
            -- integrate with calendar-vim
            plug_into_calendar = true,
            calendar_opts = {
               -- calendar week display mode: 1 .. 'WK01', 2 .. 'WK 1', 3 .. 'KW01', 4 .. 'KW 1', 5 .. '1'
               weeknm = 1,
               -- use monday as first day of week: 1 .. true, 0 .. false
               calendar_monday = 1,
               -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
               calendar_mark = "left-fit",
            },
            -- telescope actions behavior
            close_after_yanking = false,
            insert_after_inserting = true,
            -- tag notation: '#tag', ':tag:', 'yaml-bare'
            tag_notation = "#tag",
            -- command palette theme: dropdown (window) or ivy (bottom panel)
            command_palette_theme = "dropdown",
            -- tag list theme:
            -- get_cursor: small tag list at cursor; ivy and dropdown like above
            show_tags_theme = "dropdown",
            -- when linking to a note in subdir/, create a [[subdir/title]] link
            -- instead of a [[title only]] link
            subdirs_in_links = false,
            -- template_handling
            -- What to do when creating a new note via `new_note()` or `follow_link()`
            -- to a non-existing note
            -- - prefer_new_note: use `new_note` template
            -- - smart: if day or week is detected in title, use daily / weekly templates (default)
            -- - always_ask: always ask before creating a note
            template_handling = "smart",
            -- path handling:
            --   this applies to:
            --     - new_note()
            --     - new_templated_note()
            --     - follow_link() to non-existing note
            --
            --   it does NOT apply to:
            --     - goto_today()
            --     - goto_thisweek()
            --
            --   Valid options:
            --     - smart: put daily-looking notes in daily, weekly-looking ones in weekly,
            --              all other ones in home, except for notes/with/subdirs/in/title.
            --              (default)
            --
            --     - prefer_home: put all notes in home except for goto_today(), goto_thisweek()
            --                    except for notes with subdirs/in/title.
            --
            --     - same_as_current: put all new notes in the dir of the current note if
            --                        present or else in home
            --                        except for notes/with/subdirs/in/title.
            new_note_location = "smart",
            -- should all links be updated when a file is renamed
            rename_update_links = true,
            -- how to preview media files
            -- "telescope-media-files" if you have telescope-media-files.nvim installed
            -- "catimg-previewer" if you have catimg installed
            media_previewer = "telescope-media-files",
         })
      end,
   },
}
