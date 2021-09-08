local M = {}

M.install_servers = function()
	for lang in { "cmake", "cpp", "html", "latex", "lua", "python", "typescript", "julials" } do
		require("lspinstall").install_server(lang)
	end
end

-- Install language servers
M.setup_servers = function()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()
	for _, server in pairs(servers) do
		require("lspconfig")[server].setup({})
	end

	-- Additional language servers not supported by lsp-install
	require("lspconfig").julials.setup({})
end

-- Symbols
M.lspkind_setup = function()
	require("lspkind").init({
		with_text = false,
		preset = "codicons",
		symbol_map = {
			Text = "",
			Method = "",
			Function = "",
			Constructor = "",
			Field = "ﰠ",
			Variable = "",
			Class = "ﴯ",
			Interface = "",
			Module = "",
			Property = "ﰠ",
			Unit = "塞",
			Value = "",
			Enum = "",
			Keyword = "",
			Snippet = "",
			Color = "",
			File = "",
			Reference = "",
			Folder = "",
			EnumMember = "",
			Constant = "",
			Struct = "פּ",
			Event = "",
			Operator = "",
			TypeParameter = "",
		},
	})
end
-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require("lspinstall").post_install_hook = function()
	setup_servers() -- reload installed servers
	vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

return M
