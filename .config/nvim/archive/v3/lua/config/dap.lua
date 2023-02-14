-- require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
--
-- table.insert(require("dap").configurations.python, {
-- 	type = "python",
-- 	request = "launch",
-- 	name = "My custom launch configuration",
-- 	program = "${file}",
-- })
--
-- require("dap-go").setup({
-- 	-- Additional dap configurations can be added.
-- 	-- dap_configurations accepts a list of tables where each entry
-- 	-- represents a dap configuration. For more details do:
-- 	-- :help dap-configuration
-- 	dap_configurations = {
-- 		{
-- 			-- Must be "go" or it will be ignored by the plugin
-- 			type = "go",
-- 			name = "Attach remote",
-- 			mode = "remote",
-- 			request = "attach",
-- 		},
-- 	},
-- })

local dap = require("dap")
require("dapui").setup()

-- local dap, dapui = require("dap"), require("dapui")
-- dap.listeners.after.event_initialized["dapui_config"] = function()
-- 	dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end

require("nvim-dap-virtual-text").setup({
	commented = true,
})
