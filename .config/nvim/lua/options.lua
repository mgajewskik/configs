local utils = require("utils")
local o = vim.opt
local wo = vim.wo
local fn = vim.fn

vim.cmd("set inccommand=split")

--o.mouse             = ''        -- disable the mouse
o.exrc = false -- ignore '~/.exrc'
o.secure = true
o.modelines = 1 -- read a modeline at EOF
o.errorbells = false -- disable error bells (no beep/flash)
o.termguicolors = true -- enable 24bit colors

o.updatetime = 50 -- decrease update time
o.autoread = true -- auto read file if changed outside of vim
o.fileformat = "unix" -- <nl> for EOL
o.switchbuf = "useopen"
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.backspace = { "eol", "start", "indent" }
o.matchpairs = { "(:)", "{:}", "[:]", "<:>" }

-- recursive :find in current dir
vim.cmd([[set path=.,,,$PWD/**]])

-- DO NOT NEED ANY OF THIS, CRUTCH THAT POULLUTES REGISTERS
-- vim clipboard copies to system clipboard
-- unnamed     = use the * register (cmd-s paste in our term)
-- unnamedplus = use the + register (cmd-v paste in our term)
o.clipboard = "unnamedplus"

o.showmode = true -- show current mode (insert, etc) under the cmdline
o.showcmd = true -- show current command under the cmd line
o.cmdheight = 1 -- cmdline height
o.cmdwinheight = math.floor(vim.o.lines / 2) -- 'q:' window height
o.laststatus = 2 -- 2 = always show status line (filename, etc)
o.scrolloff = 3 -- min number of lines to keep between cursor and screen edge
o.sidescrolloff = 5 -- min number of cols to keep between cursor and screen edge
o.textwidth = 78 -- max inserted text width for paste operations
o.linespace = 0 -- font spacing
o.ruler = true -- show line,col at the cursor pos
o.number = true -- show absolute line no. at the cursor pos
o.relativenumber = true -- otherwise, show relative numbers in the ruler
o.cursorline = true -- Show a line where the current cursor is
o.signcolumn = "auto" -- Show sign column as first column
vim.g.colorcolumn = 79 -- global var, mark column 81
o.colorcolumn = tostring(vim.g.colorcolumn)
o.wrap = true -- wrap long lines
o.breakindent = true -- start wrapped lines indented
o.linebreak = true -- do not break words on line wrap

-- Characters to display on ':set list',explore glyphs using:
-- `xfd -fa "InputMonoNerdFont:style:Regular"` or
-- `xfd -fn "-misc-fixed-medium-r-semicondensed-*-13-*-*-*-*-*-iso10646-1"`
-- input special chars with the sequence <C-v-u> followed by the hex code
o.list = false
o.listchars = {
	tab = "→ ",
	eol = "↲",
	nbsp = "␣",
	lead = " ",
	space = " ",
	trail = "␣",
	-- lead      = '␣'   ,
	-- space     = '␣'   ,
	-- trail     = '•'   ,
	extends = "⟩",
	precedes = "⟨",
}
o.showbreak = "↪ "

-- -- enable or disable listchars
-- -- o.list = true
-- -- which list chars to schow
-- -- M.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣"
-- o.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"

-- show menu even for one item do not auto select/insert
o.completeopt = { "menu", "noinsert", "menuone", "noselect" }
o.wildmenu = true
o.wildmode = "longest:full,full"
o.wildoptions = "pum" -- Show completion items using the pop-up-menu (pum)
o.pumblend = 15 -- completion menu transparency

o.joinspaces = true -- insert spaces after '.?!' when joining lines
o.autoindent = true -- copy indent from current line on newline
o.smartindent = true -- add <tab> depending on syntax (C/C++)
o.startofline = false -- keep cursor column on navigation

o.tabstop = 4 -- Tab indentation levels every two columns
o.softtabstop = 4 -- Tab indentation when mixing tabs & spaces
o.shiftwidth = 4 -- Indent/outdent by two columns
o.shiftround = true -- Always indent/outdent to nearest tabstop
o.expandtab = true -- Convert all tabs that are typed into spaces
o.smarttab = true -- Use shiftwidths at left margin, tabstops everywhere else

-- c: auto-wrap comments using textwidth
-- r: auto-insert the current comment leader after hitting <Enter>
-- o: auto-insert the current comment leader after hitting 'o' or 'O'
-- q: allow formatting comments with 'gq'
-- n: recognize numbered lists
-- 1: don't break a line after a one-letter word
-- j: remove comment leader when it makes sense
-- this gets overwritten by ftplugins (:verb set fo)
-- we use autocmd to remove 'o' in '/lua/autocmd.lua'
-- borrowed from tjdevries
o.formatoptions = o.formatoptions
	- "a" -- Auto formatting is BAD.
	- "t" -- Don't auto format my code. I got linters for that.
	+ "c" -- In general, I like it when comments respect textwidth
	+ "q" -- Allow formatting comments w/ gq
	- "o" -- O and o, don't continue comments
	+ "r" -- But do continue when pressing enter.
	+ "n" -- Indent past the formatlistpat, not underneath it.
	+ "j" -- Auto-remove comments if possible.
	- "2" -- I'm not in gradeschool anymore

o.splitbelow = true -- ':new' ':split' below current
o.splitright = true -- ':vnew' ':vsplit' right of current

o.foldenable = true -- enable folding
o.foldlevelstart = 10 -- open most folds by default
o.foldnestmax = 10 -- 10 nested fold max
o.foldmethod = "indent" -- fold based on indent level

o.undofile = true -- no undo file
o.hidden = true -- do not unload buffer when abandoned
o.autochdir = false -- do not change dir when opening a file

o.magic = true --  use 'magic' chars in search patterns
o.hlsearch = true -- highlight all text matching current search pattern
o.incsearch = true -- show search matches as you type
o.ignorecase = true -- ignore case on search
o.smartcase = true -- case sensitive when search includes uppercase
o.showmatch = true -- highlight matching [{()}]
o.inccommand = "nosplit" -- show search and replace in real time
o.wrapscan = true -- begin search from top of the file when nothing is found
vim.o.cpoptions = vim.o.cpoptions .. "x" -- stay on search item when <esc>

o.backup = false -- no backup file
o.writebackup = false -- do not backup file before write
o.swapfile = false -- no swap file

--[[
  ShDa (viminfo for vim): session data history
  --------------------------------------------
  ! - Save and restore global variables (their names should be without lowercase letter).
  ' - Specify the maximum number of marked files remembered. It also saves the jump list and the change list.
  < - Maximum of lines saved for each register. All the lines are saved if this is not included, <0 to disable pessistent registers.
  % - Save and restore the buffer list. You can specify the maximum number of buffer stored with a number.
  / or : - Number of search patterns and entries from the command-line history saved. o.history is used if it’s not specified.
  f - Store file (uppercase) marks, use 'f0' to disable.
  s - Specify the maximum size of an item’s content in KiB (kilobyte).
      For the viminfo file, it only applies to register.
      For the shada file, it applies to all items except for the buffer list and header.
  h - Disable the effect of 'hlsearch' when loading the shada file.

  :oldfiles - all files with a mark in the shada file
  :rshada   - read the shada file (:rviminfo for vim)
  :wshada   - write the shada file (:wrviminfo for vim)
]]
o.shada = [[!,'100,<0,s100,h]]
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize"
o.diffopt = "internal,filler,algorithm:histogram,indent-heuristic"

o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" -- block in normal and beam cursor in insert mode
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0 -- Time in milliseconds to wait for a key code sequence to complete
o.undodir = fn.stdpath("data") .. "/undodir" -- set undo directory
o.history = 500 -- Use the 'history' option to set the number of lines from command mode that are remembered.
o.conceallevel = 0 -- so that `` is visible in markdown files
o.showtabline = 1 -- always show tabs
-- wo.foldcolumn = "1"
-- wo.foldcolumn = "1"
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
-- wo.colorcolumn = "99999"
o.lazyredraw = true -- do not redraw screen while running macros
-- use rg instead of grep
o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]

-- MacOS clipboard
if require("utils").is_darwin() then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = {
			["+"] = "pbcopy",
			["*"] = "pbcopy",
		},
		paste = {
			["+"] = "pbpaste",
			["*"] = "pbpaste",
		},
	}
end

if require("utils").is_darwin() then
	vim.g.python3_host_prog = "/usr/local/bin/python3"
else
	vim.g.python3_host_prog = "/usr/bin/python3"
end

-- use ':grep' to send resulsts to quickfix
-- use ':lgrep' to send resulsts to loclist
if vim.fn.executable("rg") == 1 then
	-- o.grepprg = "rg --hidden --vimgrep --smart-case --"
	o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
	o.grepformat = "%f:%l:%c:%m"
end

-- Disable providers we do not care a about
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

-- Disable some in built plugins completely
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"fzf",
	-- 'matchit',
	--'matchparen',
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

vim.g.markdown_fenced_languages = {
	"vim",
	"lua",
	"cpp",
	"sql",
	"python",
	"bash=sh",
	"console=sh",
	"javascript",
	"typescript",
	"js=javascript",
	"ts=typescript",
	"yaml",
	"json",
}
