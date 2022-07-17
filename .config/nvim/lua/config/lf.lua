local g = vim.g
-- disable default mapping
g.lf_map_keys = 0

local remap = require'utils'.remap

remap('n', '<leader>e', ':Lf<CR>', { noremap = true })
remap('n', '<C-e>', ':Lf<CR>', { noremap = true })
