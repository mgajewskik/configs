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
   -- fzf_lua.fzf_live(cmd, opts)
   -- fzf_lua.fzf_exec(cmd, opts)
end

function M.format()
   local buf = vim.api.nvim_get_current_buf()
   local ft = vim.bo[buf].filetype
   local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

   -- TODO can I add some filtering?
   -- for i = 1, #{"json", "yaml", "sh"} do
   --    if ft == {"json", "yaml", "sh"}[i] then
   --       return
   --    end
   -- end

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
            M.format()
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
   map("n", "<C-k>", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
   map("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
   map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
   -- map(bufnr, "n", "<leader>K", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)

   map("n", "[d", ("<cmd>lua vim.diagnostic.goto_prev(%s)<CR>"):format(winopts), opts)
   map("n", "]d", ("<cmd>lua vim.diagnostic.goto_next(%s)<CR>"):format(winopts), opts)

   -- Formatting
   map("n", "gf", "<cmd>lua require('utils').format()<CR>", opts)
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
