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
   aucmd("BufReadPost,", {
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

-- resize splits if window got resized
augroup("AutoResize", function(g)
   aucmd("VimResized", {
      group = g,
      callback = function()
         vim.cmd("tabdo wincmd =")
      end,
   })
end)
