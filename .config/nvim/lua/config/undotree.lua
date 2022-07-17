local remap = require'utils'.remap

remap('n', '<leader>u', ':UndotreeToggle<CR>:UndotreeFocus<CR>', { noremap = true })
-- remap('n', '<C-u>', ':UndotreeToggle<CR>:UndotreeFocus<CR>', { noremap = true })
