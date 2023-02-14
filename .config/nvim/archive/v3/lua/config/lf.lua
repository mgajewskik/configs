vim.g.lf_map_keys = 0
vim.g.lf_replace_netrw = 1

-- use this command if floaterm or lf open files in hsplits
-- let g:floaterm_opener = 'vsplit'

local remap = require("utils").remap

-- remap("n", "<leader>e", ":Lf<CR>", { noremap = true })
remap("n", "<C-e>", ":Lf<CR>", { noremap = true })
