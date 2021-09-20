local M = {}

M.install_servers = function()
	for lang in { "cmake", "cpp", "html", "latex", "lua", "python", "typescript", "julials" } do
		require("lspinstall").install_server(lang)
	end
end

local on_attach = function(client)
	-- Format on save
	if client.resolved_capabilities.document_formatting then
		vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
	end
end

-- Install language servers
M.setup_servers = function()
	require("lspinstall").setup()
	local servers = require("lspinstall").installed_servers()
	for _, server in pairs(servers) do
		require("lspconfig")[server].setup({on_attach = on_attach})
	end

	-- Additional language servers not supported by lsp-install
	-- Note: Formatting of Julia is handled by a Vim command, so the custom on_attach is not needed.
	require("lspconfig").julials.setup({})

	-- null-ls
	require("lspconfig")["null-ls"].setup({ on_attach = on_attach })
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
