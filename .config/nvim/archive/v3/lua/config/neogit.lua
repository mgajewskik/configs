local neogit = require("neogit")

-- local remap = require("utils").remap
-- remap("n", "<leader>sg", ":Neogit<CR>", { noremap = true, silent = true })

neogit.setup({
	auto_refresh = true,
	disable_signs = false,
	disable_hint = false,
	disable_context_highlighting = false,
	disable_commit_confirmation = false,
	-- customize displayed signs
	signs = {
		-- { CLOSED, OPENED }
		section = { ">", "v" },
		item = { ">", "v" },
		hunk = { "", "" },
	},
	integrations = { diffview = true },
	-- override/add mappings
	mappings = {
		-- modify status buffer mappings
		status = {
			-- Adds a mapping with "B" as key that does the "BranchPopup" command
			-- ["B"] = "BranchPopup",
			-- ["C"] = "CommitPopup",
			-- ["P"] = "PullPopup",
			-- ["S"] = "Stage",
			-- ["D"] = "Discard",
			-- Removes the default mapping of "s"
			-- ["s"] = "",
		},
	},
})

-- Keybinding	Function
-- Tab	Toggle diff
-- 1, 2, 3, 4	Set a foldlevel
-- $	Command history
-- b	Branch popup
-- s	Stage (also supports staging selection/hunk)
-- S	Stage unstaged changes
-- <C-s>	Stage Everything
-- u	Unstage (also supports staging selection/hunk)
-- U	Unstage staged changes
-- c	Open commit popup
-- r	Open rebase popup
-- L	Open log popup
-- p	Open pull popup
-- P	Open push popup
-- Z	Open stash popup
-- ?	Open help popup
-- x	Discard changes (also supports discarding hunks)
-- <enter>	Go to file
-- <C-r>	Refresh Buffer
-- With diffview integration enabled
--
-- Keybinding	Function
-- d	Open diffview.nvim at hovered file
-- D (TODO)	Open diff popup
