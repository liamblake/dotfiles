-- Configuration for the language server protocol (LSP)
-- Heavily inspired by disrupted's dotfiles
-- https://github.com/disrupted/dotfiles/blob/master/.config/nvim/lua/conf/lsp.lua
local M = {}

require("util")

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
	local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end
end

M.config = function()
	local lspconfig = require("lspconfig")
	local lsp_installer = require("nvim-lsp-installer")

	-- Set the log level, for debugging
	-- vim.lsp.set_log_level("debug")

	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

	local custom_on_attach = function(client)
		-- Format on save
		if client.resolved_capabilities.document_formatting then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
		end

		--Keybindings
		KeyMapper("n", "gd", ":lua vim.lsp.buf.definition()<CR>")
		KeyMapper("n", "gD", ":lua vim.lsp.buf.declaration()<CR>")
		KeyMapper("n", "gi", ":lua vim.lsp.buf.implementation()<CR>")
		KeyMapper("n", "gw", ":lua vim.lsp.buf.document_symbol()<CR>")
		KeyMapper("n", "gW", ":lua vim.lsp.buf.workspace_symbol()<CR>")
		KeyMapper("n", "gt", ":lua vim.lsp.buf.type_definition()<CR>")
		KeyMapper("n", "K", ":lua vim.lsp.buf.hover()<CR>")
		KeyMapper("n", "<c-k>", ":lua vim.lsp.buf.signature_help()<CR>")
		KeyMapper("n", "<leader>af", ":lua vim.lsp.buf.code_action()<CR>")
		KeyMapper("n", "<leader>rn", ":lua vim.lsp.buf.rename()<CR>")
		KeyMapper("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
		KeyMapper("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
	end

	-- Runtime path, for Lua development
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	-- Configure servers installed with LSP-Installer
	lsp_installer.on_server_ready(function(server)
		local opts = { on_attach = custom_on_attach, capabilities = capabilities }

		-- Some additional configuration for these servers
		if server.name == "lua" then
			opts.settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
						path = runtime_path,
					},
					diagnostics = {
						-- Recognise the 'vim' global
						globals = { "vim" },
					},
					workspace = {
						library = vim.api.nvim_get_runtime_file("", true),
					},
					-- Do not send telemetry data containing a randomized but unique identifier
					telemetry = {
						enable = false,
					},
				},
			}
		elseif server.name == "pyright" then
			opts.settings = { python = { analysis = { typeCheckingMode = "off" } } }
		elseif server.name == "tsserver" then
			opts.on_attach = function(client)
				custom_on_attach(client)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end
		elseif server.name == "rust_analyzer" then
			opts.on_attach = function(client)
				custom_on_attach(client)
				client.resolved_capabilities.document_formatting = false
				client.resolved_capabilities.document_range_formatting = false
			end
		end

		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)

	-- Julia (julials), not supported by lsp-installer
	-- TODO: Configure some formatting for Julia via null-ls
	lspconfig.julials.setup({ capabilities = capabilities, on_attach = custom_on_attach })
end

return M
