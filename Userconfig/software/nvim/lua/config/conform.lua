local conform = require("conform")

conform.setup({
	formatters_by_ft = {
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		svelte = { "prettierd" },
		css = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		jsonc = { "prettierd" },
		yaml = { "prettierd" },
		markdown = { "prettierd" },
		graphql = { "prettierd" },
		lua = { "stylua" },
		--python = { "isort", "black" },
		nix = { "nixfmt" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		lsp_fallback = false,
		async = false,
		timeout_ms = 500,
	},
})
