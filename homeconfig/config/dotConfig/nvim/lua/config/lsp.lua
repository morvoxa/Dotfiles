local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("lua_ls", {
	cmd = { "lua-language-server" },
	capabilities = capabilities,
	settings = {
		formatting = {
			command = { "stylua" },
		},
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = filtered_paths,
				checkThirdParty = false, -- matikan scanning library pihak ketiga
			},
			telemetry = { enable = false },
		},
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false })
	end,
})
vim.o.updatetime = 250

-- Should enable
vim.lsp.enable("lua_ls")
vim.lsp.enable("nixd")
vim.lsp.enable("bashls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("clangd")
--web
vim.lsp.enable("html")
vim.lsp.enable("cssls")
vim.lsp.enable("jsonls")
vim.lsp.enable("eslint")
vim.lsp.enable("ts_ls")
vim.lsp.enable("tailwindcss")
vim.lsp.enable("emmet_ls")
vim.lsp.enable("svelte")
