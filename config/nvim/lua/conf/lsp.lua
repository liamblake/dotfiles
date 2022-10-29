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
		autocmd CursorHold * lua vim.diagnostic.open_float({focusable=false})
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

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	local custom_on_attach = function(client, bufnr)
		local opts = { buffer = bufnr }

		--Keybindings
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

		-- Formatting
		if client.supports_method("textDocument/formatting") then
			vim.keymap.set("n", "<leader>df", vim.lsp.buf.format, opts)
		end
	end

	-- Runtime path, for Lua development
	local runtime_path = vim.split(package.path, ";")
	table.insert(runtime_path, "lua/?.lua")
	table.insert(runtime_path, "lua/?/init.lua")

	-- Configure servers installed with LSP-Installer
	lsp_installer.on_server_ready(function(server)
		local opts = { on_attach = custom_on_attach, capabilities = capabilities }

		-- Some additional configuration for these servers
		if server.name == "sumneko_lua" then
			-- Handled by stylua and null-ls
			opts.on_attach = function(client, bufnr)
				custom_on_attach(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
			end
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
			-- Handled by prettier and null-ls
			opts.on_attach = function(client, bufnr)
				custom_on_attach(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
			end
		elseif server.name == "html" then
			-- Handled by prettier and null-ls
			opts.on_attach = function(client, bufnr)
				custom_on_attach(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
			end
		elseif server.name == "rust_analyzer" then
			opts.on_attach = function(client, bufnr)
				custom_on_attach(client, bufnr)
				client.server_capabilities.document_formatting = false
				client.server_capabilities.document_range_formatting = false
			end
		elseif server.name == "texlab" then
			opts.settings = {
				texlab = {
					auxDirectory = "build",
					build = {
						args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "-outdir=build", "%f" },
						executable = "latexmk",
						forwardSearchAfter = false,
						onSave = false,
					},
				},
				diagnosticsDelay = 50,
				chktex = {
					onEdit = false,
					onOpenAndSave = true,
				},
			}
		end

		server:setup(opts)
		vim.cmd([[ do User LspAttachBuffers ]])
	end)
end

return M
