vim.g.mapleader = " "
local map = vim.keymap.set
-- Mostrar diagnóstico flotante con la tecla <leader>d
-- map("n", "<leader>d", vim.diagnostic.open_float, { desc = "Mostrar error/warning (Diagnóstico)" })

----- OIL -----
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

----- Format -----
map({ "n", "v" }, "<leader>cf", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer/file" })

-- Ctrl + S en modo normal e insert
map("n", "<C-s>", function()
	require("conform").format({ async = true })
	vim.cmd("w")
end, { silent = true, desc = "Format & Save" })

-- Abre una ventana flotante con el mensaje completo del error bajo el cursor
vim.keymap.set("n", "gl", vim.diagnostic.open_float, { desc = "Show errors inline" })

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
-- vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Disable arrow keys in all modes
-- local modes = { 'n', 'i', 'v', 'c', 't', 'o', 's', 'x' } -- All possible modes
local modes = { "n", "i", "v", "o", "t", "s", "x" } -- All possible modes
local arrows = { "<Up>", "<Down>", "<Left>", "<Right>" }

for _, mode in ipairs(modes) do
	for _, key in ipairs(arrows) do
		map(mode, key, "<Nop>", { noremap = true, silent = true })
	end
end

local enabledModes = { "i", "c", "o", "t", "s", "x" }
-- Map Alt + hjkl in Insert mode
for _, mode in ipairs(enabledModes) do
	map(mode, "<A-h>", "<Left>", { noremap = true, silent = true })
	map(mode, "<A-j>", "<Down>", { noremap = true, silent = true })
	map(mode, "<A-k>", "<Up>", { noremap = true, silent = true })
	map(mode, "<A-l>", "<Right>", { noremap = true, silent = true })
end

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right" })
map("n", "<leader>wd", "<C-W>q", { desc = "Delete Window" })
