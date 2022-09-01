local M = {}

-- Python requires debugpy to be installed in the virtualenv

function M.setup(_)
  require("dap-python").setup("python3", {})
end

return M
