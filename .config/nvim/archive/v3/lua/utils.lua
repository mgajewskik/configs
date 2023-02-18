-- help to inspect results, e.g.:
-- ':lua _G.dump(vim.fn.getwininfo())'
function _G.dump(...)
   local objects = vim.tbl_map(vim.inspect, { ... })
   print(unpack(objects))
end

function _G.reload(package)
   package.loaded[package] = nil
   return require(package)
end

local cmd = vim.cmd
local fn = vim.fn

local M = {}

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
   return s ~= nil and s ~= ""
end

-- toggle quickfixlist
M.toggle_qf = function()
   local windows = fn.getwininfo()
   local qf_exists = false
   for _, win in pairs(windows) do
      if win["quickfix"] == 1 then
         qf_exists = true
      end
   end
   if qf_exists == true then
      cmd("cclose")
      return
   end
   if M.isNotEmpty(fn.getqflist()) then
      cmd("copen")
   end
end

-- move over a closing element in insert mode
M.escapePair = function()
   local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
   local line = vim.api.nvim_get_current_line()
   local row, col = unpack(vim.api.nvim_win_get_cursor(0))
   local after = line:sub(col + 1, -1)
   local closer_col = #after + 1
   local closer_i = nil
   for i, closer in ipairs(closers) do
      local cur_index, _ = after:find(closer)
      if cur_index and (cur_index < closer_col) then
         closer_col = cur_index
         closer_i = i
      end
   end
   if closer_i then
      vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
   else
      vim.api.nvim_win_set_cursor(0, { row, col + 1 })
   end
end

diagnostics_active = true -- must be global since this function is called in which.lua
-- toggle diagnostics line
M.toggle_diagnostics = function()
   diagnostics_active = not diagnostics_active
   if diagnostics_active then
      vim.diagnostic.show()
   else
      vim.diagnostic.hide()
   end
end

--@author kikito
---@see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
function M.get_listed_buffers()
   local buffers = {}
   local len = 0
   for buffer = 1, vim.fn.bufnr("$") do
      if vim.fn.buflisted(buffer) == 1 then
         len = len + 1
         buffers[len] = buffer
      end
   end

   return buffers
end

function M.bufdelete(bufnum)
   require("bufdelete").bufdelete(bufnum, true)
end

-- when there is no buffer left show Alpha dashboard
vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
   pattern = "BDeletePre",
   group = "alpha_on_empty",
   callback = function(event)
      local found_non_empty_buffer = false
      local buffers = M.get_listed_buffers()

      for _, bufnr in ipairs(buffers) do
         if not found_non_empty_buffer then
            local name = vim.api.nvim_buf_get_name(bufnr)
            local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

            if bufnr ~= event.buf and name ~= "" and ft ~= "Alpha" then
               found_non_empty_buffer = true
            end
         end
      end

      if not found_non_empty_buffer then
         vim.cmd([[:Alpha]])
      end
   end,
})

function M.custom_lsp_attach(client, bufnr)
   -- disable formatting for LSP clients as this is handled by null-ls
   client.server_capabilities.document_formatting = false
   client.server_capabilities.document_range_formatting = false
   -- enable illuminate to intelligently highlight
   require("illuminate").on_attach(client)
   -- enable navic for displaying current code context
   if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
   end

   local map = vim.api.nvim_buf_set_keymap
   local opts = { noremap = true, silent = true }

   -- some keymaps are defined and used through fzf

   -- this one works better than the default, because it jumps to lib definition in Go
   map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   map(bufnr, "n", "gD", "<cmd>vsplit<CR> <cmd>lua vim.lsp.buf.definition()<CR>", opts)
   -- map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   -- map(bufnr, "n", "<leader>k", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   -- default for K is showing manual for the word under cursor
   -- map(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   -- standard gr works from some other binding, the one below opens quickfix
   map(bufnr, "n", "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
   -- map(bufnr, "n", "<leader>as", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
   -- map(bufnr, 'v', 'gA', '<cmd>lua vim.lsp.buf.range_code_action()<CR>', opts)
   -- not sure what it does
   -- map(bufnr, "n", "gm", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
   -- no default binding for the type definition
   map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   -- map(bufnr, 'n', 'gR', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
   -- map(bufnr, "n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   -- use our own rename popup implementation
   -- map(bufnr, 'n', '<leader>rn', '<cmd>lua require("lsp.rename").rename()<CR>', opts)
   map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   --     R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
   -- map(bufnr, 'n', '<leader>lR', '<cmd>lua require("lsp.rename").rename()<CR>', opts)
   -- map(bufnr, "n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
   -- map(bufnr, "n", "K", '<cmd>lua require("lsp.handlers").peek_definition()<CR>', opts)
   -- throws an error
   -- map(bufnr, "n", "<leader>K", '<cmd>lua require("lsp.handlers").peek_definition()<CR>', opts)

   -- {async=true}
   map(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
   map(bufnr, "v", "gf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
   -- map(bufnr, "v", "gf", "<cmd>lua vim.lsp.buf.range_formatting({ async = true })<CR>", opts)

   -- using fzf-lua instead
   --map(bufnr, 'n', '<leader>ls', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
   --map(bufnr, 'n', '<leader>lS', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)

   -- map(bufnr, 'n', '<leader>lt', "<cmd>lua require'lsp.diag'.virtual_text_toggle()<CR>", opts)

   -- neovim PR #16057
   -- https://github.com/neovim/neovim/pull/16057
   if not vim.diagnostic then
      local winopts = "{ popup_opts =  { border = 'rounded' } }"
      map(bufnr, "n", "[d", ("<cmd>lua vim.lsp.diagnostic.goto_prev(%s)<CR>"):format(winopts), opts)
      map(bufnr, "n", "]d", ("<cmd>lua vim.lsp.diagnostic.goto_next(%s)<CR>"):format(winopts), opts)
      -- map(bufnr, 'n', '<leader>lc', '<cmd>lua vim.lsp.diagnostic.clear(0)<CR>', opts)
      -- map(bufnr, 'n', '<leader>ll', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
      -- map(bufnr, 'n', '<leader>lq', '<cmd>lua vim.lsp.diagnostic.set_qflist()<CR>', opts)
      -- map(bufnr, 'n', '<leader>lQ', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
   else
      local winopts = "{ float =  { border = 'rounded' } }"
      map(bufnr, "n", "[d", ("<cmd>lua vim.diagnostic.goto_prev(%s)<CR>"):format(winopts), opts)
      map(bufnr, "n", "]d", ("<cmd>lua vim.diagnostic.goto_next(%s)<CR>"):format(winopts), opts)
      -- map(bufnr, 'n', '<leader>lc', '<cmd>lua vim.diagnostic.reset()<CR>', opts)
      -- map(bufnr, 'n', '<leader>ll', '<cmd>lua vim.diagnostic.open_float(0, { scope = "line", border = "rounded" })<CR>', opts)
      -- map(bufnr, 'n', '<leader>lq', '<cmd>lua vim.diagnostic.setqflist()<CR>', opts)
      -- map(bufnr, 'n', '<leader>lQ', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
   end

   -- if client.server_capabilities.document_formatting then
   --   map(bufnr, 'n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   -- end
   -- if client.server_capabilities.document_range_formatting then
   --   map(bufnr, 'v', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
   -- end

   -- if client.resolved_capabilities.code_lens then
   --   map(bufnr, "n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
   --   vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
   -- end

   -- Per buffer LSP indicators control
   if vim.b.lsp_virtual_text_enabled == nil then
      vim.b.lsp_virtual_text_enabled = true
   end

   if vim.b.lsp_virtual_text_mode == nil then
      vim.b.lsp_virtual_text_mode = "SignsVirtualText"
   end

   -- if not vim.diagnostic then
   --   require('lsp.diag').virtual_text_set()
   --   require('lsp.diag').virtual_text_redraw()
   -- end

   -- local wk = require("which-key")
   -- local default_options = { silent = true }
   -- wk.register({
   --   l = {
   --     name = "LSP",
   --     D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
   --     I = {
   --       "<cmd>lua vim.lsp.buf.implementation()<cr>",
   --       "Show implementations",
   --     },
   --     R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
   --     a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
   --     d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition" },
   --     e = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
   --     -- f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
   --     i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
   --     k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
   --     l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
   --     n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
   --     p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
   --     q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix Diagnostics" },
   --     r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
   --     s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
   --     t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
   --     w = {
   --       name = "workspaces",
   --       a = {
   --         "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
   --         "Add Workspace Folder",
   --       },
   --       d = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
   --       l = {
   --         "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
   --         "List Workspace Folders",
   --       },
   --       r = {
   --         "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
   --         "Remove Workspace Folder",
   --       },
   --       s = {
   --         "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
   --         "Workspace Symbols",
   --       },
   --     },
   --   },
   -- }, { prefix = "<leader>", mode = "n", default_options })
end

-- OLD FUNCTIONS HERE

function M._echo_multiline(msg)
   for _, s in ipairs(vim.fn.split(msg, "\n")) do
      vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
   end
end

function M.info(msg)
   vim.cmd("echohl Directory")
   M._echo_multiline(msg)
   vim.cmd("echohl None")
end

function M.warn(msg)
   vim.cmd("echohl WarningMsg")
   M._echo_multiline(msg)
   vim.cmd("echohl None")
end

function M.err(msg)
   vim.cmd("echohl ErrorMsg")
   M._echo_multiline(msg)
   vim.cmd("echohl None")
end

function M.has_neovim_v05()
   return (vim.fn.has("nvim-0.5") == 1)
end

function M.is_root()
   return (vim.loop.getuid() == 0)
end

function M.is_darwin()
   local os_name = vim.loop.os_uname().sysname
   return os_name == "Darwin"
end

function M.shell_error()
   return vim.v.shell_error ~= 0
end

function M.have_compiler()
   if
      vim.fn.executable("cc") == 1
      or vim.fn.executable("gcc") == 1
      or vim.fn.executable("clang") == 1
      or vim.fn.executable("cl") == 1
   then
      return true
   end
   return false
end

function M.git_cwd(cmd, cwd)
   if not cwd then
      return cmd
   end
   cwd = vim.fn.expand(cwd)
   local arg_cwd = ("-C %s "):format(vim.fn.shellescape(cwd))
   cmd = cmd:gsub("^git ", "git " .. arg_cwd)
   return cmd
end

function M.git_root(cwd, noerr)
   local cmd = M.git_cwd("git rev-parse --show-toplevel", cwd)
   local output = vim.fn.systemlist(cmd)
   if M.shell_error() then
      if not noerr then
         M.info(unpack(output))
      end
      return nil
   end
   return output[1]
end

function M.is_git_repo(cwd, noerr)
   return not not M.git_root(cwd, noerr)
end

function M.set_cwd(pwd)
   if not pwd then
      local parent = vim.fn.expand("%:h")
      pwd = M.git_root(parent, true) or parent
   end
   if vim.loop.fs_stat(pwd) then
      vim.cmd("cd " .. pwd)
      M.info(("pwd set to %s"):format(vim.fn.shellescape(pwd)))
   else
      M.warn(("Unable to set pwd to %s, directory is not accessible"):format(vim.fn.shellescape(pwd)))
   end
end

-- Can also use #T ?
function M.tablelength(T)
   local count = 0
   for _ in pairs(T) do
      count = count + 1
   end
   return count
end

function M.get_visual_selection()
   -- this will exit visual mode
   -- use 'gv' to reselect the text
   local _, csrow, cscol, cerow, cecol
   local mode = vim.fn.mode()
   if mode == "v" or mode == "V" or mode == "" then
      -- if we are in visual mode use the live position
      _, csrow, cscol, _ = unpack(vim.fn.getpos("."))
      _, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
      if mode == "V" then
         -- visual line doesn't provide columns
         cscol, cecol = 0, 999
      end
      -- exit visual mode
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
   else
      -- otherwise, use the last known visual position
      _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
      _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
   end
   -- swap vars if needed
   if cerow < csrow then
      csrow, cerow = cerow, csrow
   end
   if cecol < cscol then
      cscol, cecol = cecol, cscol
   end
   local lines = vim.fn.getline(csrow, cerow)
   -- local n = cerow-csrow+1
   local n = M.tablelength(lines)
   if n <= 0 then
      return ""
   end
   lines[n] = string.sub(lines[n], 1, cecol)
   lines[1] = string.sub(lines[1], cscol)
   return table.concat(lines, "\n")
end

function M.toggle_colorcolumn()
   local wininfo = vim.fn.getwininfo()
   for _, win in pairs(wininfo) do
      local ft = vim.api.nvim_buf_get_option(win["bufnr"], "filetype")
      if ft == nil or ft == "TelescopePrompt" then
         return
      end
      local colorcolumn = ""
      if win["width"] >= vim.g.colorcolumn then
         colorcolumn = tostring(vim.g.colorcolumn)
      end
      -- TOOD: messes up tab highlighting, why?
      -- vim.api.nvim_win_set_option(win['winid'], 'colorcolumn', colorcolumn)
      vim.api.nvim_win_call(win["winid"], function()
         vim.wo.colorcolumn = colorcolumn
      end)
   end
end

-- 'q': find the quickfix window
-- 'l': find all loclist windows
function M.find_qf(type)
   local wininfo = vim.fn.getwininfo()
   local win_tbl = {}
   for _, win in pairs(wininfo) do
      local found = false
      if type == "l" and win["loclist"] == 1 then
         found = true
      end
      -- loclist window has 'quickfix' set, eliminate those
      if type == "q" and win["quickfix"] == 1 and win["loclist"] == 0 then
         found = true
      end
      if found then
         table.insert(win_tbl, { winid = win["winid"], bufnr = win["bufnr"] })
      end
   end
   return win_tbl
end

-- open quickfix if not empty
function M.open_qf()
   local qf_name = "quickfix"
   local qf_empty = function()
      return vim.tbl_isempty(vim.fn.getqflist())
   end
   if not qf_empty() then
      vim.cmd("copen")
      vim.cmd("wincmd J")
   else
      print(string.format("%s is empty.", qf_name))
   end
end

-- enum all non-qf windows and open
-- loclist on all windows where not empty
function M.open_loclist_all()
   local wininfo = vim.fn.getwininfo()
   local qf_name = "loclist"
   local qf_empty = function(winnr)
      return vim.tbl_isempty(vim.fn.getloclist(winnr))
   end
   for _, win in pairs(wininfo) do
      if win["quickfix"] == 0 then
         if not qf_empty(win["winnr"]) then
            -- switch active window before ':lopen'
            vim.api.nvim_set_current_win(win["winid"])
            vim.cmd("lopen")
         else
            print(string.format("%s is empty.", qf_name))
         end
      end
   end
end

-- toggle quickfix/loclist on/off
-- type='*': qf toggle and send to bottom
-- type='l': loclist toggle (all windows)
function M.toggle_qf(type)
   local windows = M.find_qf(type)
   if M.tablelength(windows) > 0 then
      -- hide all visible windows
      for _, win in pairs(windows) do
         vim.api.nvim_win_hide(win.winid)
      end
   else
      -- no windows are visible, attempt to open
      if type == "l" then
         M.open_loclist_all()
      else
         M.open_qf()
      end
   end
end

-- taken from:
-- https://www.reddit.com/r/neovim/comments/o1byad/what_lua_code_do_you_have_to_enhance_neovim/
--
-- tmux like <C-b>z: focus on one buffer in extra tab
-- put current window in new tab with cursor restored
local _tabZ = nil

M.tabZ = function()
   if _tabZ then
      if _tabZ == vim.api.nvim_get_current_tabpage() then
         M.tabclose()
      end
      _tabZ = nil
   else
      _tabZ = M.tabedit()
   end
end

M.tabedit = function()
   -- skip if there is only one window open
   if vim.tbl_count(vim.api.nvim_tabpage_list_wins(0)) == 1 then
      print("Cannot expand single buffer")
      return
   end

   local buf = vim.api.nvim_get_current_buf()
   local view = vim.fn.winsaveview()
   -- note: tabedit % does not properly work with terminal buffer
   vim.cmd([[tabedit]])
   -- set buffer and remove one opened by tabedit
   local tabedit_buf = vim.api.nvim_get_current_buf()
   vim.api.nvim_win_set_buf(0, buf)
   vim.api.nvim_buf_delete(tabedit_buf, { force = true })
   -- restore original view
   vim.fn.winrestview(view)
   return vim.api.nvim_get_current_tabpage()
end

-- restore old view with cursor retained
M.tabclose = function()
   local buf = vim.api.nvim_get_current_buf()
   local view = vim.fn.winsaveview()
   vim.cmd([[tabclose]])
   -- if we accidentally land somewhere else, do not restore
   local new_buf = vim.api.nvim_get_current_buf()
   if buf == new_buf then
      vim.fn.winrestview(view)
   end
end

-- expand or minimize current buffer in a more natural direction (tmux-like)
-- ':resize <+-n>' or ':vert resize <+-n>' increases or decreasese current
-- window horizontally or vertically. When mapped to '<leader><arrow>' this
-- can get confusing as left might actually be right, etc
-- the below can be mapped to arrows and will work similar to the tmux binds
-- map to: "<cmd>lua require'utils'.resize(false, -5)<CR>"
M.resize = function(vertical, margin)
   local cur_win = vim.api.nvim_get_current_win()
   -- go (possibly) right
   vim.cmd(string.format("wincmd %s", vertical and "l" or "j"))
   local new_win = vim.api.nvim_get_current_win()

   -- determine direction cond on increase and existing right-hand buffer
   local not_last = not (cur_win == new_win)
   local sign = margin > 0
   -- go to previous window if required otherwise flip sign
   if not_last == true then
      vim.cmd([[wincmd p]])
   else
      sign = not sign
   end

   sign = sign and "+" or "-"
   local dir = vertical and "vertical " or ""
   local cmd = dir .. "resize " .. sign .. math.abs(margin) .. "<CR>"
   vim.cmd(cmd)
end

M.sudo_exec = function(cmd, print_output)
   local password = vim.fn.inputsecret("Password: ")
   if not password or #password == 0 then
      M.warn("Invalid password, sudo aborted")
      return false
   end
   local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
   if vim.v.shell_error ~= 0 then
      print("\r\n")
      M.err(out)
      return false
   end
   if print_output then
      print("\r\n", out)
   end
   return true
end

M.sudo_write = function(tmpfile, filepath)
   if not tmpfile then
      tmpfile = vim.fn.tempname()
   end
   if not filepath then
      filepath = vim.fn.expand("%")
   end
   if not filepath or #filepath == 0 then
      M.err("E32: No file name")
      return
   end
   -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
   -- Both `bs=1M` and `bs=1m` are non-POSIX
   local cmd = string.format("dd if=%s of=%s bs=1048576", vim.fn.shellescape(tmpfile), vim.fn.shellescape(filepath))
   -- no need to check error as this fails the entire function
   vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
   if M.sudo_exec(cmd) then
      M.info(string.format('\r\n"%s" written', filepath))
      vim.cmd("e!")
   end
   vim.fn.delete(tmpfile)
end

-- Credit to uga-rosa@github
-- https://github.com/uga-rosa/dotfiles/blob/main/.config/nvim/lua/utils.lua

---Return a string for vim from a lua function.
---Functions are stored in _G.myluafunc.
---@param func function
---@return string VimFunctionString
_G.myluafunc = setmetatable({}, {
   __call = function(self, idx, args, count)
      return self[idx](args, count)
   end,
})

local func2str = function(func, args)
   local idx = #_G.myluafunc + 1
   _G.myluafunc[idx] = func
   if not args then
      return ("lua myluafunc(%s)"):format(idx)
   else
      -- return ("lua myluafunc(%s, <q-args>)"):format(idx)
      return ("lua myluafunc(%s, <q-args>, <count>)"):format(idx)
   end
end

M.t = function(str)
   return vim.api.nvim_replace_termcodes(str, true, true, true)
end

-- TODO to simplify this function? What does it even do?
---API for key mapping.
---
---@param lhs string
---@param modes string|table
---@param rhs string|function
---@param opts string|table
--- opts.buffer: current buffer only
--- opts.cmd: command (format to <cmd>%s<cr>)
M.remap = function(modes, lhs, rhs, opts)
   modes = type(modes) == "string" and { modes } or modes
   opts = opts or {}
   opts = type(opts) == "string" and { opts } or opts

   local fallback = function()
      return vim.api.nvim_feedkeys(M.t(lhs), "n", true)
   end

   local _rhs = (function()
      if type(rhs) == "function" then
         opts.noremap = true
         opts.cmd = true
         return func2str(function()
            rhs(fallback)
         end)
      else
         return rhs
      end
   end)()

   for key, opt in ipairs(opts) do
      opts[opt] = true
      opts[key] = nil
   end

   local buffer = (function()
      if opts.buffer then
         opts.buffer = nil
         return true
      end
   end)()

   _rhs = (function()
      if opts.cmd then
         opts.cmd = nil
         return ("<cmd>%s<cr>"):format(_rhs)
      else
         return _rhs
      end
   end)()

   for _, mode in ipairs(modes) do
      if buffer then
         vim.api.nvim_buf_set_keymap(0, mode, lhs, _rhs, opts)
      else
         vim.api.nvim_set_keymap(mode, lhs, _rhs, opts)
      end
   end
end

---API for command mappings
-- Supports lua function args
---@param args string|table
M.command = function(args)
   if type(args) == "table" then
      for i = 2, #args do
         if vim.fn.exists(":" .. args[2]) == 2 then
            vim.cmd("delcommand " .. args[2])
         end
         if type(args[i]) == "function" then
            args[i] = func2str(args[i], true)
         end
      end
      args = table.concat(args, " ")
   end
   vim.cmd("command! " .. args)
end

function M.custom_lsp_attach(client, bufnr)
   if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
   end

   -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
   if client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

      local ft = vim.bo[bufnr].filetype
      local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

      -- TODO refactor this
      if filetype ~= "json" and filetype ~= "yaml" and filetype ~= "sh" then
         -- vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
         vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
               -- vim.lsp.buf.format({ bufnr = bufnr })
               -- TODO has problems with detaching
               -- vim.lsp.buf.format({
               --    filter = function(client)
               --       return client.name == "null-ls"
               --    end,
               --    bufnr = bufnr,
               -- })
               -- TODO LazyVim copy - also doesn't work
               vim.lsp.buf.format(vim.tbl_deep_extend("force", {
                  bufnr = bufnr,
                  filter = function(client)
                     if have_nls then
                        return client.name == "null-ls"
                     end
                     return client.name ~= "null-ls"
                  end,
               }, {}))
            end,
         })
      end
   end

   local map = vim.api.nvim_buf_set_keymap
   local opts = { noremap = true, silent = true }
   local winopts = "{ float =  { border = 'rounded' } }"

   -- this one works better than the default, because it jumps to lib definition in Go
   map(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   map(bufnr, "n", "gD", "<cmd>vsplit<CR> <cmd>lua vim.lsp.buf.definition()<CR>", opts)
   -- map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   map(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   map(bufnr, "n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   map(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   -- map(bufnr, "n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

   map(bufnr, "n", "[d", ("<cmd>lua vim.diagnostic.goto_prev(%s)<CR>"):format(winopts), opts)
   map(bufnr, "n", "]d", ("<cmd>lua vim.diagnostic.goto_next(%s)<CR>"):format(winopts), opts)

   -- Formatting
   map(bufnr, "n", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
   if client.server_capabilities.document_range_formatting then
      -- TODO seems to not work?
      map(bufnr, "v", "gf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
   else
      map(bufnr, "v", "gf", "<cmd>lua vim.lsp.buf.format()<CR>", opts)
   end

   -- if client.resolved_capabilities.code_lens then
   --   map(bufnr, "n", "<leader>lL", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
   --   vim.api.nvim_command [[autocmd CursorHold,CursorHoldI,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]]
   -- end

   -- Per buffer LSP indicators control
   if vim.b.lsp_virtual_text_enabled == nil then
      vim.b.lsp_virtual_text_enabled = true
   end

   if vim.b.lsp_virtual_text_mode == nil then
      vim.b.lsp_virtual_text_mode = "SignsVirtualText"
   end
end

return M
