-- https://yazi-rs.github.io/docs/tips/#folder-rules

local function setup()
   ps.sub("cd", function()
      -- https://yazi-rs.github.io/docs/plugins/context
      local cwd = cx.active.current.cwd
      -- if cwd:ends_with("notes") then
      if tostring(cwd):find("obsidian") then
         -- changing from mtime to btime for tests
         ya.emit("sort", { "btime", reverse = true, dir_first = true })
      else
         ya.emit("sort", { "alphabetical", reverse = false, dir_first = true })
      end
   end)
end

return { setup = setup }
