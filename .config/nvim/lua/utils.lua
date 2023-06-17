local M = {}

-- Search through home directories and explore without performance issues
function M.home_fzf(cmd)
   local fzf_lua = require("fzf-lua")
   local opts = {}
   opts.cwd = vim.fn.expand("$HOME")
   opts.prompt = "~ cd $HOME/"
   opts.fn_transform = function(x)
      return fzf_lua.utils.ansi_codes.magenta(x)
   end
   opts.actions = {
      ["default"] = function(selected)
         fzf_lua.files({ cwd = vim.fn.expand("$HOME/" .. selected[1]) })
      end,
      ["ctrl-d"] = function(selected)
         vim.cmd("cd " .. "$HOME/" .. selected[1])
      end,
      ["ctrl-s"] = function(selected)
         fzf_lua.live_grep_glob({ cwd = vim.fn.expand("$HOME/" .. selected[1]) })
      end,
   }
   -- fzf_lua.fzf_exec("fd --type d -H -i -L -E 'venv' -E '.venv' -E '.git'", opts)
   fzf_lua.fzf_exec("fd --type d -i -L -E 'venv'", opts)
   -- find all dirs and sort by creation date
   -- fzf_lua.fzf_exec("fd --type d -i -L -E 'venv' -x stat -c '%W %n' | sort -nr | cut -d ' ' -f 2-", opts)
   -- fzf_lua.fzf_live(cmd, opts)
   -- fzf_lua.fzf_exec(cmd, opts)
end

function M.format()
   local buf = vim.api.nvim_get_current_buf()
   local ft = vim.bo[buf].filetype
   local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

   -- possibly not needing deep extend because no options given
   vim.lsp.buf.format(vim.tbl_deep_extend("force", {
      bufnr = buf,
      filter = function(client)
         if have_nls then
            return client.name == "null-ls"
         end
         return client.name ~= "null-ls"
      end,
      -- TODO add formatting options here if necessary
   }, {}))
end

function M.on_attach(on_attach)
   vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
         local buffer = args.buf
         local client = vim.lsp.get_client_by_id(args.data.client_id)
         on_attach(client, buffer)
         -- fixes formatting with gq
         -- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/1131
         vim.bo[buffer].formatexpr = nil
      end,
   })
end

function M.format_on_attach(client, bufnr)
   if client.supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
         group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
         buffer = bufnr,
         callback = function()
            -- remove formatting on save for yaml and sh files
            -- TODO think if this can be done better
            local ft = vim.bo[bufnr].filetype
            if ft == "yaml" or ft == "sh" then
               return
            else
               M.format()
            end
         end,
      })
   end
end

function M.keymaps_on_attach(client, bufnr)
   local map = vim.keymap.set
   local opts = { noremap = true, silent = true }
   local winopts = "{ float =  { border = 'rounded' } }"

   map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
   map("n", "gD", "<cmd>vsplit<CR> <cmd>lua vim.lsp.buf.definition()<CR>", opts)
   -- map(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
   map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   -- map(bufnr, "n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

   map("n", "[d", ("<cmd>lua vim.diagnostic.goto_prev(%s)<CR>"):format(winopts), opts)
   map("n", "]d", ("<cmd>lua vim.diagnostic.goto_next(%s)<CR>"):format(winopts), opts)

   -- Formatting
   map("n", "gf", "<cmd>lua require('utils').format()<CR>", opts)
end

-- toggle quickfixlist
M.toggle_qf = function()
   local windows = vim.fn.getwininfo()
   local qf_exists = false
   for _, win in pairs(windows) do
      if win["quickfix"] == 1 then
         qf_exists = true
      end
   end
   if qf_exists == true then
      vim.cmd("cclose")
      return
   end
   if M.isNotEmpty(vim.fn.getqflist()) then
      vim.cmd("copen")
   end
end

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

return M
