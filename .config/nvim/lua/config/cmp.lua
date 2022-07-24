-- Setup nvim-cmp.
local cmp = require("cmp")
local lspkind = require("lspkind")

-- not sure this works as the group for copilot is not configured properly in cmp
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			with_text = false,
			maxwidth = 50,
			mode = "symbol",
			menu = {
				buffer = "BUF",
				rg = "RG",
				nvim_lsp = "LSP",
				path = "PATH",
				luasnip = "SNIP",
				calc = "CALC",
				spell = "SPELL",
				copilot = " COP",
			},
			before = function(entry, vim_item)
				if entry.source.name == "copilot" then
					-- vim_item.kind = "[] Copilot"
					vim_item.kind_hl_group = "CmpItemKindCopilot"
					return vim_item
				end
				return vim_item
			end,
		}),
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-u>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = false,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "copilot", group_index = 2 },
		{ name = "path" },
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "buffer", keyword_length = 5 },
		{ name = "luasnip" },
		-- { name = "calc" },
		-- { name = "spell", keyword_length = 5 },
		{ name = "rg", keyword_length = 5 },
	},
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- local res, cmp = pcall(require, "cmp")
-- if not res then
--   return
-- end
--
-- local luasnip = require("luasnip")
--
-- local t = function(str)
--   return vim.api.nvim_replace_termcodes(str, true, true, true)
-- end
--
-- -- do not complete at start of line, after spaces and punctuation chars
-- local should_complete = function()
--   local col = vim.fn.col('.') - 1
--   return col > 0 and not vim.fn.getline('.'):sub(col, col):match('[%s%p]')
-- end
--
-- cmp.setup {
--   -- must define this if we aren't using a snippet engine
--   snippet = {
--     expand = function(args)
--       luasnip.lsp_expand(args.body)
--     end,
--   },
--
--   completion = {
--     keyword_length = 2,
--   },
--
--   sources = {
--     { name = 'nvim_lsp' },
--     { name = 'nvim_lua' },
--     { name = 'luasnip' },
--     { name = 'path' },
--     { name = 'buffer' },
--   },
--
--   mapping = {
--     ['<Tab>'] = function(fallback)
--       if vim.fn.pumvisible() == 1 then
--         vim.fn.feedkeys(t('<C-n>'), 'n')
--       elseif cmp.visible() then
--         cmp.select_next_item()
--       elseif luasnip.expand_or_jumpable() then
--         luasnip.expand_or_jump()
--       else
--         fallback()
--       end
--     end,
--     ['<S-Tab>'] = function(fallback)
--       if vim.fn.pumvisible() == 1 then
--         vim.fn.feedkeys(t('<C-p>'), 'n')
--       elseif cmp.visible() then
--         cmp.select_prev_item()
--       elseif luasnip.jumpable(-1) then
--         luasnip.jump(-1)
--       elseif should_complete() then
--         cmp.complete()
--       else
--         fallback()
--       end
--     end,
--     ['<C-p>'] = cmp.mapping.select_prev_item(),
--     ['<C-n>'] = cmp.mapping.select_next_item(),
--     ['<S-up>'] = cmp.mapping.scroll_docs(-4),
--     ['<S-down>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = function(fallback)
--       if (vim.fn.pumvisible() == 1 and not
--           vim.tbl_isempty(vim.v.completed_item)) or
--          (cmp.visible() and cmp.core.view:get_selected_entry()) then
--         cmp.confirm({
--               behavior = cmp.ConfirmBehavior.Replace,
--               select = true,
--             })
--       else
--         fallback()
--       end
--     end,
--   },
--
--   -- documentation = {
--   --   border       = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
--   --   winhighlight = 'Normal:CursorLine,FloatBorder:CursorLine',
--   -- },
--
--   formatting = {
--     deprecated = false,
--     format = function(entry, vim_item)
--         -- fancy icons and a name of kind
--         local idx = vim.lsp.protocol.CompletionItemKind[vim_item.kind] or nil
--         if tonumber(idx)>0 then
--           vim_item.kind = vim.lsp.protocol.CompletionItemKind[idx]
--         end
--
--         -- set a name for each source
--         vim_item.menu = ({
--           path = "[Path]",
--           buffer = "[Buffer]",
--           luasnip = "[LuaSnip]",
--           nvim_lua = "[Lua]",
--           nvim_lsp = "[LSP]",
--         })[entry.source.name]
--         return vim_item
--     end,
--   },
--
--   -- DO NOT ENABLE
--   -- just for testing with nvim native completion menu
--   experimental = {
--     native_menu = false,
--     ghost_text = true,
--   },
-- }
--
-- -- If you want insert `(` after select function or method item
-- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
-- cmp.event:on( 'confirm_done', cmp_autopairs.on_confirm_done({  map_char = { tex = '' } }))
--
--
-- -- add a lisp filetype (wrap my-function), FYI: Hardcoded = { "clojure", "clojurescript", "fennel", "janet" }
-- -- cmp_autopairs.lisp[#cmp_autopairs.lisp+1] = "racket"
--
-- -- local remap = require'utils'.remap
--
-- -- <esc>:    revert selection (stay in insert mode)
-- -- <ctrl-c>: revert selection (switch to normal mode)
-- -- localecategory
-- -- local function abort_logic(key, fn)
-- --   if vim.fn.pumvisible() == 1 then
-- --     -- using nvim's native completion menu
-- --     vim.fn.feedkeys(t('<C-e>'), 'n')
-- --     if fn then fn() end
-- --   elseif cmp.visible() then
-- --     -- using nvim-cmp's floating win based menu
-- --     if cmp.core.view:get_selected_entry() then
-- --       -- entry selected, revert to original text
-- --       -- abort is bugged
-- --       cmp.abort()
-- --       -- cmp.close()
-- --     else
-- --       -- no entry, just close the popup
-- --       -- if we call 'abort' here we lose all text
-- --       -- entered since popup became visible
-- --       cmp.close()
-- --     end
-- --     if fn then fn() end
-- --   else
-- --     vim.fn.feedkeys(t(key), 'n')
-- --   end
-- -- end
--
-- --[[ remap({ "i", "s" }, "<Esc>", function()
--   abort_logic('<Esc>')
-- end) ]]
--
-- --[[ remap({ "i", "s" }, "<C-c>", function()
--   -- NOTE: <C-c> clears 'cmp.core.view:get_selected_entry()'
--   -- so never actually call 'cmp.abort()'
--   abort_logic('<C-c>',
--     function()
--       vim.cmd("stopinsert")
--     end)
-- end) --]]
