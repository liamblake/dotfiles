local M = {}

M.config = function()
	local pairs = require("nvim-autopairs")
	local Rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")

	pairs.setup({ disable_filetype = { "TelescopePrompt" }, ignored_next_char = '[%w%."]' })

	-- Pair definitions
	pairs.add_rules({
		-- LaTeX
		Rule("\\(", "\\)", { "latex" }):with_cr(cond.none()),
		Rule("\\[", "\\]", { "latex" }),
		Rule("(", ")"):with_pair(cond.not_after_regex_check("//")),
		Rule("[", "]"):with_pair(cond.not_after_regex_check("//")),
		Rule("\\left(", "\\right)", { "tex", "latex" }):with_cr(cond.none()),
		Rule("``", "''", { "tex", "latex" }):with_cr(cond.none()),
		-- Python
		Rule('"""', '"""', { "python" }),
	})

	-- Play nice with completion
end

return M
