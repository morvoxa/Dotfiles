-- =====================================
-- statusline_macos.lua
-- FORCE macOS-style statusline
-- Tokyonight + Transparent safe
-- =====================================

-- TRUE COLOR (WAJIB WINDOWS)
vim.opt.termguicolors = true
vim.env.COLORTERM = "truecolor"

-- =====================================
-- APPLY COLORS (FORCED)
-- =====================================
local function apply_colors()
	vim.api.nvim_set_hl(0, "SLRed", {
		fg = "#ff5f57",
		ctermfg = 1,
		bold = true,
	})
	vim.api.nvim_set_hl(0, "SLYellow", {
		fg = "#ffbd2e",
		ctermfg = 3,
		bold = true,
	})
	vim.api.nvim_set_hl(0, "SLGreen", {
		fg = "#28c840",
		ctermfg = 2,
		bold = true,
	})
end

-- =====================================
-- MODE DOT (macOS)
-- =====================================
function _G.macos_mode_dot()
	local m = vim.fn.mode()
	if m == "i" or m == "t" then
		return "%#SLGreen# ● %#StatusLine#"
	elseif m == "v" or m == "V" or m == "" or m == "c" then
		return "%#SLYellow# ● %#StatusLine#"
	else
		return "%#SLRed# ● %#StatusLine#"
	end
end

-- =====================================
-- GIT (SAFE)
-- =====================================
function _G.git_branch()
	local b = vim.fn.systemlist("git branch --show-current")[1]
	if vim.v.shell_error ~= 0 or not b or b == "" then
		return ""
	end
	return " " .. b .. " "
end

-- =====================================
-- FORCE APPLY AFTER EVERYTHING
-- =====================================
vim.api.nvim_create_autocmd({ "VimEnter", "ColorScheme" }, {
	callback = function()
		apply_colors()

		-- FORCE statusline (override plugin / theme)
		vim.o.statusline = " %{v:lua.macos_mode_dot()} " .. "%{v:lua.git_branch()}" .. "%f %=%l:%c"
	end,
})

-- =====================================
-- TRANSPARENT.NVIM COMPAT
-- =====================================
pcall(function()
	require("transparent").clear_prefix("SL")
end)
