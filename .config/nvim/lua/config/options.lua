-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.list = true --Muestra simbolos en espacios, no me gusta
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" } --Usa esos simbolos para lo anterior

-- Set highlight on search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Forzar colores personalizados para Angular y Treesitter
vim.api.nvim_create_autocmd("ColorScheme", {
	desc = "Colores personalizados para inyecciones de Treesitter",
	pattern = "*",
	callback = function()
		-- 1. Le damos color a la variable del bucle (ej: "item")
		-- Puedes cambiar "Special" por "Identifier" o "Keyword" si prefieres otro color
		vim.api.nvim_set_hl(0, "@variable.angular", { link = "Special" })

		-- 2. Le damos color a las propiedades del objeto (ej: "title", "link")
		vim.api.nvim_set_hl(0, "@property.typescript", { link = "Identifier" })

		-- 3. (Opcional) Si las llaves {} y corchetes [] se ven grises, esto los pinta
		vim.api.nvim_set_hl(0, "@punctuation.bracket", { link = "Operator" })
	end,
})

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

vim.o.shiftwidth = 2
vim.o.tabstop = 2
vim.o.expandtab = true
vim.o.softtabstop = 2

vim.o.splitbelow = true
vim.o.splitright = true

vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8 -- Keep 8 columns left/right of cursor
vim.opt.wrap = true -- wrap lines
vim.wo.signcolumn = "yes"
vim.opt.pumblend = 10 -- Popup menu transparency

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"
vim.opt.showmode = false -- Don't show mode in command line
-- vim.o.mouse = ""

-- Ignora mayúsculas/minúsculas al buscar
vim.o.ignorecase = true
-- PERO si usás mayúsculas → búsqueda sensible
vim.o.smartcase = true

-- Cuando una línea larga se corta, mantiene indentación visual
vim.o.breakindent = true

-- Guarda historial de undo en archivo
vim.o.undofile = true

-- Tiempo (ms) para eventos
vim.o.updatetime = 250

-- Tiempo para completar combinaciones de teclas
vim.o.timeoutlen = 300

-- Habilita colores truecolor (24-bit)
vim.o.termguicolors = true

-- Una sola statusline global
vim.o.laststatus = 3

-- Desactiva los mappings por defecto para PHP
vim.g.no_php_maps = 1

-- Cambia el estilo de listado
vim.g.netrw_liststyle = 0

-- Oculta el banner superior
vim.g.netrw_banner = 0

-- Highlight al hacer yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Autocmd: quitar formatoptions
vim.api.nvim_create_autocmd("FileType", {
	desc = "remove formatoptions",
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.opt.confirm = true

-- Configuración visual de Diagnósticos (Estilo LazyVim)
vim.diagnostic.config({
	-- 1. Texto en línea (Virtual Text)
	virtual_text = {
		spacing = 4, -- Espacio entre tu código y el mensaje
		source = "if_many", -- Muestra la fuente (ej: intelephense) si hay varios LSPs
		prefix = "●", -- El clásico punto de LazyVim
		-- prefix = "■",       -- (Opcional) Puedes cambiarlo por un cuadrado si prefieres
	},

	-- 2. Comportamiento
	update_in_insert = false, -- No actualizar mientras escribes (evita que el texto salte)
	severity_sort = true, -- Mostrar primero los Errores, luego Warnings
	underline = true, -- Subrayar la palabra que tiene el error

	-- 3. Íconos en el margen izquierdo (Sign Column) - Requiere Nerd Font
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = " ", -- Ícono de Error (Rojo)
			[vim.diagnostic.severity.WARN] = " ", -- Ícono de Warning (Amarillo)
			[vim.diagnostic.severity.HINT] = " ", -- Ícono de Hint (Foco/Azul)
			[vim.diagnostic.severity.INFO] = " ", -- Ícono de Info (Verde)
		},
	},
})
