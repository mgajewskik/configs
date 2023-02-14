local M = {}

function M.on_attach(on_attach)
   vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
         local buffer = args.buf
         local client = vim.lsp.get_client_by_id(args.data.client_id)
         on_attach(client, buffer)
      end,
   })
end

function M.custom_lsp_attach(client, bufnr)
   if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, bufnr)
   end

   -- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
   if client.supports_method("textDocument/formatting") then
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")
      -- TODO refactor this
      if filetype ~= "json" and filetype ~= "yaml" and filetype ~= "sh" then
         vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
         vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
               vim.lsp.buf.format({
                  filter = function(client)
                     return client.name == "null-ls"
                  end,
                  bufnr = bufnr,
               })
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
