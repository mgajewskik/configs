local M = {}

local defaults = {
   icons = {
      diagnostics = {
         Error = " ",
         Warn = " ",
         Hint = " ",
         Info = " ",
      },
      git = {
         added = " ",
         modified = " ",
         removed = " ",
      },
      kinds = {
         Array = " ",
         Boolean = " ",
         Class = " ",
         Color = " ",
         Constant = " ",
         Constructor = " ",
         Copilot = " ",
         Enum = " ",
         EnumMember = " ",
         Event = " ",
         Field = " ",
         File = " ",
         Folder = " ",
         Function = " ",
         Interface = " ",
         Key = " ",
         Keyword = " ",
         Method = " ",
         Module = " ",
         Namespace = " ",
         Null = "ﳠ ",
         Number = " ",
         Object = " ",
         Operator = " ",
         Package = " ",
         Property = " ",
         Reference = " ",
         Snippet = " ",
         String = " ",
         Struct = " ",
         Text = " ",
         TypeParameter = " ",
         Unit = " ",
         Value = " ",
         Variable = " ",
         ReadOnly = " ",
      },
   },
}

local options

setmetatable(M, {
   __index = function(_, key)
      if options == nil then
         return vim.deepcopy(defaults)[key]
      end
      return options[key]
   end,
})

return M
