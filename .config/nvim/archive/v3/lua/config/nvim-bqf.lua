require("bqf").setup({
  auto_enable = true,
  auto_resize_height = true,
  preview = {
    win_height = 12,
    win_vheight = 12,
    delay_syntax = 80,
    border_chars = { "┃", "┃", "━", "━", "┏", "┓", "┗", "┛", "█" },
    should_preview_cb = function(bufnr, qwinid)
      local ret = true
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      local fsize = vim.fn.getfsize(bufname)
      if fsize > 100 * 1024 then
        -- skip file size greater than 100k
        ret = false
      elseif bufname:match("^fugitive://") then
        -- skip fugitive buffer
        ret = false
      end
      return ret
    end,
  },
})


-- -- 'zf' requires fzf
-- -- since changing fzf.vim for fzf-lua we don't need this anymore
-- -- use `:lua require('fzf-lua').quickfix()` instead
-- -- pcall(vim.cmd, [[PackerLoad fzf]])
--
-- require('bqf').setup({
--     auto_enable = true,
--     auto_resize_height = true,
--     preview = {
--         auto_preview = false,
--     },
--     func_map = {
--         ptoggleauto = '<F2>',
--         ptogglemode = '<F3>',
--         split       = '<C-s>',
--         vsplit      = '<C-v>',
--         pscrollup   = '<S-up>',
--         pscrolldown = '<S-down>',
--     },
--     filter = {
--         fzf = {
--             action_for = {['ctrl-s'] = 'split'},
--             extra_opts = {'--bind', 'ctrl-a:toggle-all', '--prompt', '> '}
--         }
--     }
-- })
