require("mini.surround").setup({
  -- Number of lines within which surrounding is searched
  n_lines = 50,

  -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
  highlight_duration = 2000,

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    add = "zs", -- Add surrounding
    delete = "ds", -- Delete surrounding
    find = "", -- Find surrounding (to the right)
    find_left = "", -- Find surrounding (to the left)
    highlight = "", -- Highlight surrounding
    replace = "cs", -- Replace surrounding
    update_n_lines = "", -- Update `n_lines`
  },

  -- mappings = {
  --   add = "sa", -- Add surrounding
  --   delete = "sd", -- Delete surrounding
  --   find = "sf", -- Find surrounding (to the right)
  --   find_left = "sF", -- Find surrounding (to the left)
  --   highlight = "sh", -- Highlight surrounding
  --   replace = "sr", -- Replace surrounding
  --   update_n_lines = "sn", -- Update `n_lines`
  -- },
  --
  -- mappings = {
  --   add = 'ys',
  --   delete = 'ds',
  --   find = '',
  --   find_left = '',
  --   highlight = 'gs',     -- hijack 'gs' (sleep) for highlight
  --   replace = 'cs',
  --   update_n_lines = '',  -- bind for updating 'config.n_lines'
  -- },

  -- How to search for surrounding (first inside current line, then inside
  -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
  -- 'cover_or_nearest'. For more details, see `:h MiniSurround.config`.
  search_method = "cover_or_next",

  custom_surroundings = {
    -- ['('] = { output = { left = '( ', right = ' )' } },
    -- ['['] = { output = { left = '[ ', right = ' ]' } },
    -- ['{'] = { output = { left = '{ ', right = ' }' } },
    -- ['<'] = { output = { left = '< ', right = ' >' } },
    ["("] = {
      input = { find = "%(%s-.-%s-%)", extract = "^(.%s*).-(%s*.)$" },
      output = { left = "( ", right = " )" },
    },
    ["["] = {
      input = { find = "%[%s-.-%s-%]", extract = "^(.%s*).-(%s*.)$" },
      output = { left = "[ ", right = " ]" },
    },
    ["{"] = {
      input = { find = "{%s-.-%s-}", extract = "^(.%s*).-(%s*.)$" },
      output = { left = "{ ", right = " }" },
    },
    ["<"] = {
      input = { find = "<%s-.-%s->", extract = "^(.%s*).-(%s*.)$" },
      output = { left = "< ", right = " >" },
    },
    S = {
      -- lua bracketed string mapping
      -- 'ysiwS'  foo -> [[foo]]
      input = { find = "%[%[.-%]%]", extract = "^(..).*(..)$" },
      output = { left = "[[", right = "]]" },
    },
  },
})

-- require("mini.comment").setup({})

require("mini.indentscope").setup({
  draw = {
    -- Delay (in ms) between event and start of drawing scope indicator
    delay = 10,

    -- Animation rule for scope's first drawing. A function which, given next
    -- and total step numbers, returns wait time (in ms). See
    -- |MiniIndentscope.gen_animation()| for builtin options. To not use
    -- animation, supply `require('mini.indentscope').gen_animation('none')`.
    animation = function(_, _)
      return 5
    end,
  },

  -- Module mappings. Use `''` (empty string) to disable one.
  mappings = {
    -- Textobjects
    object_scope = "ii",
    object_scope_with_border = "ai",

    -- Motions (jump to respective border line; if not present - body line)
    goto_top = "[i",
    goto_bottom = "]i",
  },

  -- Options which control computation of scope. Buffer local values can be
  -- supplied in buffer variable `vim.b.miniindentscope_options`.
  options = {
    -- Type of scope's border: which line(s) with smaller indent to
    -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
    border = "both",

    -- Whether to use cursor column when computing reference indent. Useful to
    -- see incremental scopes with horizontal cursor movements.
    indent_at_cursor = true,

    -- Whether to first check input line to be a border of adjacent scope.
    -- Use it if you want to place cursor on function header to get scope of
    -- its body.
    try_as_border = true,
  },

  -- Which character to use for drawing scope indicator
  -- alternative styles: ┆ ┊ ╎
  symbol = "╎",
})

require("mini.pairs").setup({
  -- In which modes mappings from this `config` should be created
  modes = { insert = true, command = false, terminal = false },

  -- Global mappings. Each right hand side should be a pair information, a
  -- table with at least these fields (see more in |MiniPairs.map|):
  -- - <action> - one of 'open', 'close', 'closeopen'.
  -- - <pair> - two character string for pair to be used.
  -- By default pair is not inserted after `\`, quotes are not recognized by
  -- `<CR>`, `'` does not insert pair after a letter.
  -- Only parts of tables can be tweaked (others will use these defaults).
  mappings = {
    ["("] = { action = "open", pair = "()", neigh_pattern = "[^\\]." },
    ["["] = { action = "open", pair = "[]", neigh_pattern = "[^\\]." },
    ["{"] = { action = "open", pair = "{}", neigh_pattern = "[^\\]." },

    [")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
    ["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
    ["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },

    ['"'] = { action = "closeopen", pair = '""', neigh_pattern = "[^%a\\].", register = { cr = false } },
    ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "[^%a\\].", register = { cr = false } },
    ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "[^%a\\].", register = { cr = false } },
  },
})
