local M = {}

-- Python requires debugpy to be installed in the virtualenv

function M.setup(_)
    require("dap-python").setup("~/.virtualenvs/debugpy/bin/python", {})
    table.insert(require("dap").configurations.python, {
        type = "python",
        request = "launch",
        name = "My custom launch configuration",
        program = "${file}",
    })
end

return M
