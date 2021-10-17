" ===========================================================================
" Key mappings
" ===========================================================================
"
" BASIC BINDINGS
" let mapleader = " "
map <Space> <leader>
" terminal settings
" esc to exit terminal
tnoremap <C-w>e <C-\><C-n>
" 0 goes to first non-blank character
nnoremap 0 ^
nnoremap ^ 0
nmap <leader><CR> O<Esc>
nmap <CR> o<Esc>
" remap ESC key in insert mode only
:inoremap jj <esc>
:inoremap jk <esc>
:inoremap kj <esc>
" move vertically by visual line
nnoremap j gj
nnoremap k gk
" movement in quickfix window
map <C-n> :cn<CR>
map <C-p> :cp<CR>
nnoremap <leader>qo :copen<CR>
nnoremap <leader>qc :ccl<CR>
nnoremap <leader>qn :cn<CR>
nnoremap <leader>qp :cp<CR>
" quickly switch between buffers
"nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
"nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
nnoremap  <silent>   <c-l>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap  <silent> <c-h>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"nnoremap <leader>n :ls<CR>:b<space>
" switch panes by leader + hjkl
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" managing tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tm :tabmove<space>
" managing terminal
"tnoremap jj <C-\><C-n>
"tnoremap <Esc> <C-\><C-n>
nnoremap <leader>tt :tabnew<CR>:terminal<CR>i
nnoremap <leader>th :call TermToggle(12)<CR>
"inoremap <leader>th <Esc>:call TermToggle(12)<CR>
tnoremap <leader>th <C-\><C-n>:call TermToggle(12)<CR>
" leader + number is now used to move through tabs
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tablast<cr>
" resize panes
nnoremap <Leader>= :vertical resize +16<CR>
nnoremap <Leader>- :vertical resize -16<CR>
" select in visual mode and move whole block with J and K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" remove highlight of the search
nnoremap <leader>/ :noh<CR>
" copy / paste to the system clipboard
" noremap <leader>y "+y
" noremap <leader>p "+p
" quicker delete inside and around parantheses
nnoremap ci( f(ci(
nnoremap di( f(di(
nnoremap ci) f)ci)
nnoremap ci) f)ci)
nnoremap ci" f"ci"
nnoremap ci' f'ci'
nnoremap ci{ f{ci{
nnoremap ci} f}ci}
nnoremap ci[ f[ci[
nnoremap ci] f]ci]
" around
nnoremap ca" f"ca"
nnoremap ca' f'ca'
 " " Shortcut to use blackhole register by default
nnoremap d "_d
vnoremap d "_d
nnoremap D "_D
vnoremap D "_D
nnoremap c "_c
vnoremap c "_c
nnoremap C "_C
vnoremap C "_C
nnoremap x "_x
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
 " Shortcut to use clipboard with <leader>
nnoremap <leader>d d
vnoremap <leader>d d
nnoremap <leader>D D
vnoremap <leader>D D
nnoremap <leader>c c
vnoremap <leader>c c
nnoremap <leader>C C
vnoremap <leader>C C
nnoremap <leader>x x
vnoremap <leader>x x
nnoremap <leader>X X
vnoremap <leader>X X

" PLUGIN BINDINGS
" nerd commenter
nmap <leader>cc :NERDCommenterComment<CR>
nmap <leader>c<space> :NERDCommenterToggle<CR>
" Trees shortcut
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>w :NvimTreeToggle<CR>
nnoremap <leader>e :Lf<CR>
nnoremap <leader>E :LfWorkingDirectory<CR>
" fzf shortcuts
nnoremap cc :Commands<CR>
nnoremap // :BLines<CR>
"nnoremap <Leader>s :Find<SPACE>
nnoremap <leader>ws :Find <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader><leader> :RG<CR>
nnoremap <leader>wf :RGsduword<CR>
nnoremap <leader>sw :RGsdu<CR>
nnoremap <Leader>b :Buffer<CR>
nnoremap <Leader>` :Buffer<CR>
nnoremap <Leader>sc :Commits<CR>
nnoremap <Leader>rf :Files ~/<CR>
nnoremap <Leader>sf :Files ~/sdu/<CR>
nnoremap <leader>f :ProjectFiles<CR>
"nnoremap <leader>f :GFiles<CR>
nnoremap <leader>sb :GBranches<CR>
nnoremap <leader>st :GTags<CR>
" Completion and snippets
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
imap <tab> <Plug>(completion_smart_tab)
imap <s-tab> <Plug>(completion_smart_s_tab)
"use <c-j> to switch to previous completion
"imap <c-j> <Plug>(completion_next_source)
"use <c-k> to switch to next completion
"imap <c-k> <Plug>(completion_prev_source)
"inoremap <c-k> <cmd>lua return require'snippets'.expand_or_advance(1)<CR>
"inoremap <c-j> <cmd>lua return require'snippets'.advance_snippet(-1)<CR>

" GoTo code navigation.
nnoremap <leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>ge :vsplit<CR> :lua vim.lsp.buf.definition()<CR>
nnoremap <leader>gD :lua vim.lsp.buf.declaration()<CR>
nnoremap <leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <leader>gt :lua vim.lsp.buf.type_definition()<CR>
nnoremap <leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <leader>as :lua vim.lsp.buf.code_action()<CR>
"nnoremap <leader>ggs :lua vim.lsp.buf.signature_help()<CR>
nnoremap <leader>rn :lua vim.lsp.buf.rename()<CR>
nnoremap <leader>af :lua vim.lsp.buf.formatting()<CR>
nnoremap <leader>ai :lua vim.lsp.buf.incoming_calls()<CR>
nnoremap <leader>ao :lua vim.lsp.buf.outgoing_calls()<CR>
nnoremap K :lua vim.lsp.buf.hover()<CR>
nnoremap <leader>gw :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <leader>gW :lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <leader>dn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <leader>dp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <leader>sd :lua vim.lsp.diagnostic.set_loclist()<CR>

"" Shortcuts for vim-go mode
"autocmd FileType go nmap <buffer> <leader>gd <plug>(go-def)
"autocmd FileType go nmap <buffer> <leader>ge :vsplit<CR><plug>(go-def)
"autocmd FileType go nmap <buffer> <leader>gr <plug>(go-referrers)
"autocmd FileType go nmap <buffer> <leader>gt <plug>(go-test)
"autocmd FileType go nmap <buffer> <leader>gi <plug>(go-import)
"autocmd FileType go nmap <buffer> <leader>rn <plug>(go-rename)
"autocmd FileType go nmap <buffer> <leader>at <plug>(go-test)
"autocmd FileType go nmap <buffer> <leader>ar <plug>(go-run)
""au filetype go inoremap <buffer> . .<C-x><C-o>
"autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gv :Gvdiffsplit!<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gl :G log<CR>
"nmap <leader>gr :Git rebase -i HEAD~5<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>sr :Git rebase -i HEAD~5<CR>

" Sneak mappings
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

nnoremap <leader>ad :let @a=expand('%')<CR>:GdbStartPDB python -m pdb <c-r>a
"cnoremap <a-q> <c-c>:let @a=expand('%')<CR>:<Up><c-r>a
