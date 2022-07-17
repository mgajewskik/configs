vim.opt_local.wrap = true

vim.wo.conceallevel = 0
vim.wo.spell        = false
vim.wo.foldexpr     = ""

-- match and highlight hyperlinks
vim.fn.matchadd("matchURL", [[http[s]\?:\/\/[[:alnum:]%\/_#.-]*]])
vim.cmd("hi matchURL guifg=DodgerBlue")
