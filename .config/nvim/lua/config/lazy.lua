-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Error clonando lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
		}, true, {})
		return
	end
end

vim.opt.rtp:prepend(lazypath)

-- leaders (IMPORTANTÍSIMO)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- setup
require("lazy").setup({
	spec = {
		{ import = "plugins" },
	},
})
