local aucmd = vim.api.nvim_create_autocmd

local function augroup(name, fnc)
   fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- https://neovim.io/doc/user/autocmd.html#autocmd-events

-- augroup("Unknown", function(g)
-- 	aucmd("FileType", {
-- 		group = g,
-- 		pattern = { "*" },
-- 		callback = function()
--       if vim.bo.filetype == "" then
--         vim.opt_local.filetype = "bash"
--       end
-- 		end,
-- 	})
-- end)

augroup("AutoBashType", function(g)
   aucmd({ "BufReadPost" }, {
      group = g,
      pattern = "*",
      callback = function()
         if vim.bo.filetype == "" then
            vim.opt_local.filetype = "bash"
         end
      end,
   })
end)

augroup("AutoTMPLType", function(g)
   aucmd({ "BufReadPost" }, {
      group = g,
      pattern = "*.tmpl",
      callback = function()
         vim.opt_local.filetype = "gohtmltmpl"
      end,
   })
end)

augroup("JSON", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "json" },
      callback = function()
         vim.opt_local.tabstop = 2
         vim.opt_local.shiftwidth = 2
         vim.opt_local.softtabstop = 2
         -- why was this done?
         -- vim.opt_local.filetype = "jsonc"
      end,
   })
end)

augroup("YAML&VIM", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "yaml", "vim" },
      callback = function()
         vim.opt_local.tabstop = 2
         vim.opt_local.shiftwidth = 2
         vim.opt_local.softtabstop = 2
      end,
   })
end)

augroup("Lua", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "lua" },
      callback = function()
         vim.opt_local.tabstop = 3
         vim.opt_local.shiftwidth = 3
         vim.opt_local.softtabstop = 3
      end,
   })
end)

augroup("Hyprlang", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "hyprlang" },
      callback = function()
         vim.opt_local.commentstring = "# %s"
      end,
   })
end)

augroup("Nix", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "nix" },
      callback = function()
         vim.opt_local.commentstring = "# %s"
         vim.opt_local.tabstop = 2
         vim.opt_local.shiftwidth = 2
         vim.opt_local.softtabstop = 2
      end,
   })
end)

-- :verbose setlocal formatoptions? - check what is causing the markdown wrapping
augroup("Markdown", function(g)
   aucmd({ "FileType", "BufEnter" }, {
      group = g,
      pattern = { "markdown", "telekasten" },
      callback = function()
         vim.opt_local.wrap = true
         vim.opt_local.spell = true
         vim.opt_local.conceallevel = 0
         vim.opt_local.formatoptions = "jcrqn"
      end,
   })
end)

augroup("GitCommit", function(g)
   aucmd("Filetype", {
      group = g,
      pattern = { "gitcommit" },
      callback = function()
         vim.opt_local.spell = true
         vim.opt_local.textwidth = 72
      end,
   })
end)

-- TODO this does not work yet
-- augroup("TSDisable", function(g)
--    aucmd("Filetype", {
--       group = g,
--       pattern = { "fugitive" },
--       callback = function(args)
--          vim.treesitter.stop(args.buf)
--       end,
--    })
-- end)

augroup("QuickClose", function(g)
   aucmd("Filetype", {
      group = g,
      pattern = {
         "qf",
         "man",
         "help",
         "notify",
         "lspinfo",
         "fugitive",
         "startuptime",
         "null-ls-info",
         "tsplayground",
         "spectre_panel",
         "PlenaryTestPopup",
      },
      callback = function(event)
         vim.bo[event.buf].buflisted = false
         vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
      end,
   })
end)

-- Treesitter automatic Python format strings
vim.api.nvim_create_augroup("py-fstring", { clear = true })
vim.api.nvim_create_autocmd("InsertCharPre", {
   pattern = { "*.py" },
   group = "py-fstring",
   --- @param opts AutoCmdCallbackOpts
   --- @return nil
   callback = function(opts)
      -- Only run if f-string escape character is typed
      if vim.v.char ~= "{" then
         return
      end

      -- Get node and return early if not in a string
      local node = vim.treesitter.get_node()

      if not node then
         return
      end
      if node:type() ~= "string" then
         node = node:parent()
      end
      if not node or node:type() ~= "string" then
         return
      end

      vim.print(node:type())
      local row, col, _, _ = vim.treesitter.get_node_range(node)

      -- Return early if string is already a format string
      local first_char = vim.api.nvim_buf_get_text(opts.buf, row, col, row, col + 1, {})[1]
      vim.print("row " .. row .. " col " .. col)
      vim.print("char: '" .. first_char .. "'")
      if first_char == "f" then
         return
      end

      -- Otherwise, make the string a format string
      vim.api.nvim_input("<Esc>m'" .. row + 1 .. "gg" .. col + 1 .. "|if<Esc>`'la")
   end,
})
