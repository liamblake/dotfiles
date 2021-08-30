local M = {}

M.setup = function()
	local pairs = require("nvim-autopairs")
	local Rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")

	pairs.setup({ disable_filetype = { "TelescopePrompt" }, ignored_next_char = "[%w%.]" })

	-- Pair definitions
	pairs.add_rules({
		-- LaTeX
		Rule("/(", "/)", { "latex" }):with_cr(cond.none()),
		Rule("/[", "/]", { "latex" }),
		-- Python
		Rule('"""', '"""', { "python" }),
	})
end

return M
