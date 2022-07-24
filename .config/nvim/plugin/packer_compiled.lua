-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/mgajewskik/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/mgajewskik/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/mgajewskik/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/mgajewskik/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/mgajewskik/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    after_files = { "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/Comment.nvim/after/plugin/Comment.lua" },
    config = { 'require("config/comment")' },
    keys = { { "", "gcc" }, { "", "gc" }, { "", "gl" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { 'require("config/luasnip")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["bufdelete.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/bufdelete.nvim",
    url = "https://github.com/famiu/bufdelete.nvim"
  },
  ["calendar-vim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/calendar-vim",
    url = "https://github.com/renerocksai/calendar-vim"
  },
  ["cheat-sheet"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cheat-sheet",
    url = "https://github.com/Djancyp/cheat-sheet"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-rg"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp-rg",
    url = "https://github.com/lukas-reineke/cmp-rg"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conflict-marker.vim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/conflict-marker.vim",
    url = "https://github.com/rhysd/conflict-marker.vim"
  },
  ["copilot-cmp"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/copilot-cmp",
    url = "https://github.com/zbirenbaum/copilot-cmp"
  },
  ["copilot.lua"] = {
    config = { "\27LJ\2\n.\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\19config.copilot\frequire-\1\0\4\0\3\0\0066\0\0\0009\0\1\0003\2\2\0)\3d\0B\0\3\1K\0\1\0\0\rdefer_fn\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["diffview.nvim"] = {
    commands = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    config = { 'require("config/diffview")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/diffview.nvim",
    url = "https://github.com/sindrets/diffview.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  fzf = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf-lua"] = {
    config = { 'require("config/fzf")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    config = { 'require("config/gitsigns")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["go.nvim"] = {
    config = { 'require("config/go")' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/go.nvim",
    url = "https://github.com/ray-x/go.nvim"
  },
  ["impatient.nvim"] = {
    config = { "if vim.fn.has('nvim-0.6')==1 then require('impatient') end" },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["kanagawa.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/kanagawa.nvim",
    url = "https://github.com/rebelot/kanagawa.nvim"
  },
  ["lf.vim"] = {
    config = { 'require("config/lf")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/lf.vim",
    url = "https://github.com/ptzz/lf.vim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { 'require("config/lualine")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["mini.nvim"] = {
    config = { 'require("config/mini")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/mini.nvim",
    url = "https://github.com/echasnovski/mini.nvim"
  },
  neogit = {
    commands = { "Neogit" },
    config = { 'require("config/neogit")' },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/neogit",
    url = "https://github.com/TimUntersberger/neogit"
  },
  ["neoscroll.nvim"] = {
    config = { 'require("config/neoscroll")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/neoscroll.nvim",
    url = "https://github.com/karb94/neoscroll.nvim"
  },
  ["null-ls.nvim"] = {
    config = { 'require("config/null-ls")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-bqf"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-bqf",
    url = "https://github.com/kevinhwang91/nvim-bqf"
  },
  ["nvim-cmp"] = {
    config = { 'require("config/cmp")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lsp-installer"] = {
    config = { 'require("config/lsp")' },
    load_after = {},
    loaded = true,
    needs_bufread = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    after = { "nvim-lsp-installer" },
    loaded = true,
    only_config = true
  },
  ["nvim-navic"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-navic",
    url = "https://github.com/SmiteshP/nvim-navic"
  },
  ["nvim-notify"] = {
    config = { 'require("config/notify")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-treesitter"] = {
    config = { 'require("config/treesitter")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-endwise"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-treesitter-endwise",
    url = "https://github.com/RRethy/nvim-treesitter-endwise"
  },
  ["nvim-treesitter-textobjects"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    config = { "\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0" },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["project.nvim"] = {
    config = { 'require("config/project")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["symbols-outline.nvim"] = {
    commands = { "SymbolsOutline" },
    config = { 'require("config/symbols")' },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telekasten.nvim"] = {
    config = { 'require("config/telekasten")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telekasten.nvim",
    url = "https://github.com/renerocksai/telekasten.nvim"
  },
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-heading.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-heading.nvim",
    url = "https://github.com/crispgm/telescope-heading.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim",
    url = "https://github.com/nvim-telescope/telescope-packer.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope-zoxide"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope-zoxide",
    url = "https://github.com/jvgrootveld/telescope-zoxide"
  },
  ["telescope.nvim"] = {
    config = { 'require("config/telescope")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { 'require("config/todo")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["toggleterm.nvim"] = {
    config = { 'require("config/toggleterm")' },
    keys = { { "", "gxx" }, { "", "gx" }, { "", "<C-\\>" } },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/opt/toggleterm.nvim",
    url = "https://github.com/akinsho/toggleterm.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  undotree = {
    config = { 'require("config/undotree")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    config = { 'require("config/fugitive")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-illuminate"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/vim-illuminate",
    url = "https://github.com/RRethy/vim-illuminate"
  },
  ["vim-lion"] = {
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/vim-lion",
    url = "https://github.com/tommcdo/vim-lion"
  },
  ["vim-terraform"] = {
    config = { "require('config.terraform')" },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/vim-terraform",
    url = "https://github.com/hashivim/vim-terraform"
  },
  ["which-key.nvim"] = {
    config = { 'require("config/which-key")' },
    loaded = true,
    path = "/home/mgajewskik/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^copilot_cmp"] = "copilot-cmp",
  ["^nvim%-bqf"] = "fzf"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Config for: project.nvim
time([[Config for project.nvim]], true)
require("config/project")
time([[Config for project.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require("config/telescope")
time([[Config for telescope.nvim]], false)
-- Config for: lf.vim
time([[Config for lf.vim]], true)
require("config/lf")
time([[Config for lf.vim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
require("config/todo")
time([[Config for todo-comments.nvim]], false)
-- Config for: telekasten.nvim
time([[Config for telekasten.nvim]], true)
require("config/telekasten")
time([[Config for telekasten.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require("config/treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: undotree
time([[Config for undotree]], true)
require("config/undotree")
time([[Config for undotree]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require("config/lsp")
time([[Config for nvim-lspconfig]], false)
-- Config for: mini.nvim
time([[Config for mini.nvim]], true)
require("config/mini")
time([[Config for mini.nvim]], false)
-- Config for: vim-fugitive
time([[Config for vim-fugitive]], true)
require("config/fugitive")
time([[Config for vim-fugitive]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
require("config/fzf")
time([[Config for fzf-lua]], false)
-- Config for: neoscroll.nvim
time([[Config for neoscroll.nvim]], true)
require("config/neoscroll")
time([[Config for neoscroll.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
require("config/gitsigns")
time([[Config for gitsigns.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
require("config/null-ls")
time([[Config for null-ls.nvim]], false)
-- Config for: vim-terraform
time([[Config for vim-terraform]], true)
require('config.terraform')
time([[Config for vim-terraform]], false)
-- Config for: nvim-ts-autotag
time([[Config for nvim-ts-autotag]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\20nvim-ts-autotag\frequire\0", "config", "nvim-ts-autotag")
time([[Config for nvim-ts-autotag]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
require("config/which-key")
time([[Config for which-key.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require("config/cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-notify
time([[Config for nvim-notify]], true)
require("config/notify")
time([[Config for nvim-notify]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require("config/luasnip")
time([[Config for LuaSnip]], false)
-- Config for: impatient.nvim
time([[Config for impatient.nvim]], true)
if vim.fn.has('nvim-0.6')==1 then require('impatient') end
time([[Config for impatient.nvim]], false)
-- Load plugins in order defined by `after`
time([[Sequenced loading]], true)
vim.cmd [[ packadd nvim-lsp-installer ]]

-- Config for: nvim-lsp-installer
require("config/lsp")

time([[Sequenced loading]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewClose lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewClose", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file SymbolsOutline lua require("packer.load")({'symbols-outline.nvim'}, { cmd = "SymbolsOutline", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewFocusFiles lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewFocusFiles", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogit lua require("packer.load")({'neogit'}, { cmd = "Neogit", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewToggleFiles lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewToggleFiles", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DiffviewOpen lua require("packer.load")({'diffview.nvim'}, { cmd = "DiffviewOpen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

-- Keymap lazy-loads
time([[Defining lazy-load keymaps]], true)
vim.cmd [[noremap <silent> gxx <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "gxx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gcc <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gcc", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gx <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "gx", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> gl <cmd>lua require("packer.load")({'Comment.nvim'}, { keys = "gl", prefix = "" }, _G.packer_plugins)<cr>]]
vim.cmd [[noremap <silent> <C-\> <cmd>lua require("packer.load")({'toggleterm.nvim'}, { keys = "<lt>C-\\>", prefix = "" }, _G.packer_plugins)<cr>]]
time([[Defining lazy-load keymaps]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType go ++once lua require("packer.load")({'go.nvim'}, { ft = "go" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au VimEnter * ++once lua require("packer.load")({'copilot.lua', 'lualine.nvim'}, { event = "VimEnter *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /home/mgajewskik/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/go.vim]], true)
vim.cmd [[source /home/mgajewskik/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/go.vim]]
time([[Sourcing ftdetect script at: /home/mgajewskik/.local/share/nvim/site/pack/packer/opt/go.nvim/ftdetect/go.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
