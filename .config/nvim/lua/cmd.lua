local cmd = vim.api.nvim_create_user_command

-- vim.cmd([[command! Jfmt :%!jq .]])
-- vim.cmd([[command! MD :! litemdview % &]])
-- vim.cmd([[:command Md ! litemdview %:p & disown]])

cmd("Jfmt", "%!jq .", {})
cmd("MD", "! litemdview % &", {})
cmd("Md", "! litemdview %:p & disown", {})
