local aucmd = vim.api.nvim_create_autocmd

local function augroup(name, fnc)
    fnc(vim.api.nvim_create_augroup(name, { clear = true }))
end

augroup("HighlightYankedText", function(g)
    -- highlight yanked text and copy to system clipboard
    -- TextYankPost is also called on deletion, limit to
    -- yanks via v:operator
    aucmd("TextYankPost", {
        group = g,
        pattern = "*",
        command = "if has('clipboard') && v:operator=='y' && len(@0)>0 | "
            .. "let @+=@0 | endif | "
            .. "lua vim.highlight.on_yank{higroup='IncSearch', timeout=2000}",
    })
end)

-- auto-delete fugitive buffers
augroup("Fugitive", function(g)
    aucmd("BufReadPost,", {
        group = g,
        pattern = "fugitive://*",
        command = "set bufhidden=delete",
    })
end)

augroup("NoNewlineNoAutoComments", function(g)
    aucmd("BufEnter", {
        group = g,
        pattern = "*",
        command = "setlocal formatoptions-=cro",
    })
end)

augroup("Markdown", function(g)
    aucmd("BufRead,BufNewFile", {
        group = g,
        pattern = "*.md",
        command = "setlocal textwidth=80",
    })
end)

augroup("GitCommit", function(g)
    aucmd("Filetype", {
        group = g,
        pattern = "gitcommit",
        command = "setlocal spell textwidth=72",
    })
end)

--- Remove all trailing whitespace on save
augroup("TrimWhiteSpaceGrp", function(g)
    aucmd("BufWritePre", {
        group = g,
        pattern = "*",
        command = [[:%s/\s\+$//e]],
    })
end)

augroup("ToggleSearchHL", function(g)
    aucmd("InsertEnter", {
        group = g,
        pattern = "*",
        command = ":nohl | redraw",
    })
end)

augroup("QuickClose", function(g)
    aucmd("Filetype", {
        group = g,
        pattern = "help,startuptime,qf,lspinfo,fugitive,null-ls-info",
        command = "nnoremap <buffer><silent> q :close<CR>",
    })
end)
