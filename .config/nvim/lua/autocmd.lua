local aucmd = vim.api.nvim_create_autocmd

local function augroup(name, fnc)
   fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

-- augroup("TestGroup", function(g)
-- 	aucmd({ "BufReadPost" }, {
-- 		group = g,
-- 		pattern = "*",
-- 		callback = function()
-- 			if vim.bo.filetype == "" then
-- 				vim.opt_local.filetype = "bash"
-- 			end
-- 		end,
-- 	})
-- end)

-- -- TODO wtf, I cannot make this work
-- augroup("CopilotDisable", function(g)
--    aucmd("BufEnter", {
--       group = g,
--       pattern = "*",
--       callback = function()
--          vim.cmd("Copilot disable<CR>")
--       end,
--       -- command = "Copilot disable",
--    })
-- end)

augroup("HighlightYankedText", function(g)
   aucmd("TextYankPost", {
      group = g,
      callback = function()
         vim.highlight.on_yank()
      end,
   })
end)

-- auto-delete fugitive buffers
augroup("Fugitive", function(g)
   aucmd("BufReadPost", {
      group = g,
      pattern = "fugitive://*",
      command = "set bufhidden=delete",
   })
end)

augroup("NoNewlineNoAutoComments", function(g)
   aucmd("BufEnter", {
      group = g,
      pattern = "*",
      command = "setlocal formatoptions-=cro",
   })
end)

--- Remove all trailing whitespace on save
augroup("TrimWhiteSpaceGrp", function(g)
   aucmd("BufWritePre", {
      group = g,
      pattern = "*",
      command = [[:%s/\s\+$//e]],
   })
end)

--- Remove all trailing new lines on save
augroup("TrimNewLinesGrp", function(g)
   aucmd("BufWritePre", {
      group = g,
      pattern = "*",
      -- https://stackoverflow.com/a/7496112/11056842
      -- command = [[:%s#\($\n\s*\)\+\%$##]],
      -- https://stackoverflow.com/a/27552161/11056842
      command = [[:%s/\($\n\s*\)\+\%$//e]],
   })
end)

-- resize splits if window got resized
augroup("AutoResize", function(g)
   aucmd("VimResized", {
      group = g,
      callback = function()
         vim.cmd("tabdo wincmd =")
      end,
   })
end)

-- Delete [No Name] buffers
-- augroup("BufDelete", function(g)
--    aucmd("BufHidden", {
--       group = g,
--       desc = "Delete [No Name] buffers",
--       callback = function(event)
--          if event.file == "" and vim.bo[event.buf].buftype == "" and not vim.bo[event.buf].modified then
--             vim.schedule(function()
--                pcall(vim.api.nvim_buf_delete, event.buf, {})
--             end)
--          end
--       end,
--    })
-- end)
