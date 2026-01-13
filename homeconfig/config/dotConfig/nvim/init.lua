require("core.keymaps-conf")
require("core.options-conf")
require("core.plugins-reg-conf")
require("config.colorscheme")
require("config.blink")
require("config.treesiter")
--Lsp and formatters is intaled on nix
require("config.lsp")
require("config.conform")
require("config.telescope")
require("nvim-autopairs").setup()
require("ibl").setup()
require("luasnip.loaders.from_vscode").lazy_load()
require("transparent").setup({
	extra_groups = {
		"StatusLine",
		"StatusLineNC",
		"SLRed",
		"SLYellow",
		"SLGreen",
	},
})
require("config.statusline-custom")

--require("staline").setup({})
