-- LSP icons
-- local icons = {
--   -- Text           = ' (text)',
--   Text           = ' (text)',
--   Method         = ' (method)',
--   Function       = ' (func)',
--   -- Constructor   = ' (ctor)',
--   Constructor    = ' (ctor)',
--   Field          = ' (field)',
--   Variable       = ' (var)',
--   -- Class          = ' (class)',
--   -- Class          = ' (class)',
--   Class          = ' (class)',
--   -- Interface      = ' (interface)',
--   Interface      = 'ﰮ (interface)',
--   Module         = ' (module)',
--   Property       = ' (property)',
--   -- Unit           = ' (unit)',
--   -- Unit           = ' (unit)',
--   -- Unit           = ' (unit)',
--   Unit           = 'ﰩ (unit)',
--   Value          = ' (value)',
--   -- Enum           = '練(enum)',
--   Enum           = 'ﬧ (enum)',
--   EnumMember     = ' (enum member)',
--   -- Keyword        = ' (keyword)',
--   Keyword        = ' (keyword)',
--   -- Snippet        = ' (snippet)',
--   Snippet        = '﬌ (snippet)',
--   -- Color          = ' (color)',
--   Color          = ' (color)',
--   File           = ' (file)',
--   Folder         = ' (folder)',
--   -- Reference      = ' (ref)',
--   Reference      = ' (ref)',
--   -- Constant       = ' (const)',
--   -- Constant       = ' (const)',
--   -- Constant       = '(const)',
--   -- Constant       = '洞(const)',
--   Constant       = 'ﱃ (const)',
--   Struct         = ' (struct)',
--   Event          = ' (event)',
--   Operator       = '璉(operator)',
--   TypeParameter  = ' (type param)',
-- }

local icons = {
  Text            = '',    -- 
  Method          = '',
  Function        = '',
  Constructor     = '',    -- 
  Field           = '',    --  
  Variable        = "",    --   
  Class           = '',    --   ﴯ  
  Interface       = '',    --  ﰮ
  Module          = '',
  Property        = '',
  Unit            = 'ﰩ',    --       塞
  Value           = '',
  Enum            = '',    -- ﬧ   練
  EnumMember      = '',
  Keyword         = '',    -- 
  Snippet         = '﬌',    --  
  Color           = '',    --   
  File            = '',
  Folder          = '',
  Reference       = '',    --  
  Constant        = "",    -- ﱃ 洞     π
  Struct          = "פּ",    -- 
  Event           = '',
  Operator        = '璉',   -- 
  TypeParameter   = '',
}

for kind, symbol in pairs(icons) do
  local kinds = vim.lsp.protocol.CompletionItemKind
  local index = kinds[kind]

  if index ~= nil then
    kinds[index] = symbol
  end
end
