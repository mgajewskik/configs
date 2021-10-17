set completeopt=menuone,noinsert,noselect
let g:completion_enable_auto_popup = 0
let g:completion_auto_change_source = 1
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'path', 'tags', 'tabnine' ]},
    \]
\}

let g:diagnostic_virtual_text_prefix = ''
let g:diagnostic_enable_virtual_text = 1


"lua require('lspfuzzy').setup {}

sign define LspDiagnosticsErrorSign text=✖
sign define LspDiagnosticsWarningSign text=⚠
sign define LspDiagnosticsInformationSign text=ℹ
sign define LspDiagnosticsHintSign text=➤


" --- vim go (polyglot) settings.
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_fmt_autosave = 1
let g:go_fmt_command = "gofmt"
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_doc_keywordprg_enabled = 0
let g:go_doc_popup_window = 1
let g:go_list_type = "quickfix"
"let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
let g:go_addtags_transform = 'camelcase'
let g:go_gocode_unimported_packages = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1

"let g:vim_markdown_conceal = 0
"let g:vim_markdown_conceal_code_blocks = 0
"let g:markdown_fenced_languages = ['sql', 'python', 'bash', 'go']

" indent guides toggle on
let g:indent_guides_enable_on_vim_startup = 1

" set indentation
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" fzf settings
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8, 'highlight': 'Comment' } }
"let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --preview 'bat --color=always --style=header,grid --line-range :300 {}' --bind ctrl-s:select-all"
"let FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!.tox/*" --glob "!venv/*" --glob "!.pyc" --glob "!.pyi" --glob "!.venv/*"'
"let $FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git/*,.tox/*,venv/*,.pyi,.pyc,.venv/*}" 2> /dev/null'
" let g:fzf_preview_window = ['up:60%']
" CTRL-A CTRL-Q to select all and build quickfix list

function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let loaded_matchparen = 1
let g:rainbow_active = 1

let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#prompt = 'Sneak> '
let g:sneak#use_ic_scs = 0
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

let g:lua_tree_width = 40
let g:lua_tree_git_hl = 1
let g:lua_tree_follow = 1
let g:lua_tree_indent_markers = 1
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': ""
    \   }
    \ }

let g:fzf_checkout_git_options = '--sort=-committerdate'
let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \ 'rebase': {
      \   'prompt': 'Rebase> ',
      \   'execute': 'echo system("{git} rebase {branch}")',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-r',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}

let g:crystalline_enable_sep = 1
let g:crystalline_statusline_fn = 'StatusLine'
let g:crystalline_tabline_fn = 'TabLine'
let g:crystalline_theme = 'gruvbox'

let g:terraform_align=1
let g:terraform_fold_sections=0
let g:terraform_fmt_on_save=1

" We're going to define single-letter keymaps, so don't try to define them
" in the terminal window.  The debugger CLI should continue accepting text commands.
function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction

let g:nvimgdb_disable_start_keymaps = 1
let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }

let g:lf_map_keys = 0
