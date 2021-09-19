local M = {}

M.setup = function()
	local pairs = require("nvim-autopairs")
	local Rule = require("nvim-autopairs.rule")
	local cond = require("nvim-autopairs.conds")

	pairs.setup({ disable_filetype = { "TelescopePrompt" }, ignored_next_char = '[%w%."]' })

	-- Integrate with compe
	require("nvim-autopairs.completion.compe").setup({})

	-- Pair definitions
	pairs.add_rules({
		-- LaTeX
		Rule("/(", "/)", { "latex" }):with_cr(cond.none()),
		Rule("/[", "/]", { "latex" }),
		Rule("(", ")"):with_pair(cond.not_after_regex_check("//")),
		Rule("[", "]"):with_pair(cond.not_after_regex_check("//")),
		Rule("left(", "\right)", { "tex", "latex" }):with_cr(cond.none()),
		-- Python
		Rule('"""', '"""', { "python" }),
	})

	-- Play nice with completion
	require("nvim-autopairs.completion.compe").setup({
		map_cr = true, --  map <CR> on insert mode
		map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
		auto_select = false, -- auto select first item
		map_char = { -- modifies the function or method delimiter by filetypes
			all = "(",
			tex = "{",
		},
	})
end

return M
