-- Configuration for the language server protocol (LSP)
-- Heavily inspired by disrupted's dotfiles
-- https://github.com/disrupted/dotfiles/blob/master/.config/nvim/lua/conf/lsp.lua
local M = {}

M.setup = function()
	-- Only show diagnostics detail on hover
	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		virtual_text = false,
		underline = true,
		signs = true,
	})
	vim.cmd([[
		autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics({focusable=false})
		autocmd CursorHoldI * silent! lua vim.lsp.buf.signature_help()
	]])
	-- Use custom signs for diagnostics
	-- TODO: Move this to plugins-config/lsp.lua
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

M.config = function()
	local lspconfig = require("lspconfig")

	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local custom_on_attach = function(client)
		-- Format on save
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
		end
	end

	-- Lua (sumneko_lua)
	local system_name
	if vim.fn.has("mac") == 1 then
		system_name = "macOS"
	elseif vim.fn.has("unix") == 1 then
		system_name = "Linux"
	elseif vim.fn.has("win32") == 1 then
		system_name = "Windows"
	else
		print("Unsupported system for sumneko")
	end

	local sumneko_root_path = vim.fn.stdpath("data") .. "/lsp_servers/sumneko_lua/extension/server"
	local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name .. "/lua-language-server"

	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	lspconfig.sumneko_lua.setup({
		cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
		on_attach = custom_on_attach,
		capabilities = capabilities,
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
					-- Setup your lua path
					path = runtime_path,
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
	})

	-- Python (pyright)
	lspconfig.pyright.setup({
		capabilities = capabilities,
		on_attach = custom_on_attach,
		settings = { python = { analysis = { typeCheckingMode = "off" } } },
	})

	-- LaTeX (texlab)
	lspconfig.texlab.setup({ capabilities = capabilities, on_attach = custom_on_attach })

	-- Typescript (tsserver)
	lspconfig.tsserver.setup({
		capabilities = capabilities,
		on_attach = function(client)
			custom_on_attach(client)
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end,
	})

	-- Julia (julials)
	-- TODO: Configure some formatting for Julia via null-ls
	require("lspconfig").julials.setup({ capabilities = capabilities, on_attach = custom_on_attach })

	-- null-ls, mainly for linting and formatting
	require("conf.null_ls").setup()
	require("lspconfig")["null-ls"].setup({ capabilities = capabilities, on_attach = custom_on_attach })
end

return M
