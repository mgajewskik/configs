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

augroup("JSON", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "json" },
      callback = function()
         vim.opt_local.tabstop = 2
         vim.opt_local.shiftwidth = 2
         vim.opt_local.softtabstop = 2
         vim.opt_local.filetype = "jsonc"
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

augroup("TStfvars", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "terraform-vars" },
      callback = function()
         vim.bo.filetype = "terraform"
         vim.opt_local.tabstop = 2
         vim.opt_local.shiftwidth = 2
         vim.opt_local.softtabstop = 2
      end,
   })
end)

augroup("Terraform", function(g)
   aucmd("FileType", {
      group = g,
      pattern = { "terraform" },
      callback = function()
         vim.opt_local.tabstop = 2
         vim.opt_local.shiftwidth = 2
         vim.opt_local.softtabstop = 2
      end,
   })
end)

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
