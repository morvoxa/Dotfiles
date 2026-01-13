--===============================================================
local map = vim.keymap.set
vim.g.mapleader = " " --mengubah leader menjadi spasi
--===============================================================
map("t", "<Esc>", "<C-\\><C-n>", { silent = true, noremap = true })
-- untuk save file
--===============================================================
map("n", "<leader>w", ":w<cr>", { silent = true, noremap = true })
map("n", "<leader>e", ":Ex<cr>", { silent = true, noremap = true })
--untuk exit neovim
--===============================================================
map("n", "<leader>q", ":q<cr>", { silent = true, noremap = true })
--hapus highlight search
--===============================================================
map("n", "<Esc>", ":nohlsearch<cr>", { silent = true })
-- visual tab
--===============================================================
map("v", "<Tab>", ">gv", { noremap = true, silent = true })
--===============================================================
--telescope map
map("n", "<leader>ff", ":Telescope find_files<cr>", { silent = true, noremap = true })
map("n", "<leader>fb", ":Telescope file_browser<cr>", { silent = true, noremap = true })
map("n", "<leader><Tab>", ":bp<cr>", { silent = true, noremap = true })
map("n", "<Tab>", ":bn<cr>", { silent = true, noremap = true })
map("n", "<leader>x", ":bd<cr>", { silent = true, noremap = true })
--===============================================================

--===============================================================
-- for lua comment
vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		map("v", "<leader>/", [[:s/^/-- /<CR>]], { buffer = true, noremap = true, silent = true })
		map("v", "<leader>u", [[:s/^-- //<CR>]], { buffer = true, noremap = true, silent = true })
	end,
})
--===============================================================
-- for python comment
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		map("v", "<leader>/", [[:s/^/# /<CR>]], { buffer = true, noremap = true, silent = true })
		map("v", "<leader>u", [[:s/^# //<CR>]], { buffer = true, noremap = true, silent = true })
	end,
})
--===============================================================
vim.api.nvim_create_autocmd("FileType", {
	pattern = "rust",
	callback = function()
		map("v", "<leader>/", [[:s/^/\/\/ /<CR>]], { buffer = true, noremap = true, silent = true })
		map("v", "<leader>u", [[:s/^\/\/ //<CR>]], { buffer = true, noremap = true, silent = true })
	end,
})
