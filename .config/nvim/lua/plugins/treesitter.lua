return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		-- 1. Declaramos la lista de lenguajes
		local lenguajes = {
			"c",
			"lua",
			"vim",
			"vimdoc",
			"query",
			"javascript",
			"typescript",
			"html",
			"css",
			"angular",
			"php",
			"php_only",
			"blade",
			"python",
		}

		-- 2. Instalación automática (asíncrona) si falta algún parser
		require("nvim-treesitter").install(lenguajes)

		-- 3. Definir el filetype UNA SOLA VEZ (fuera del autocmd)
		vim.filetype.add({
			pattern = {
				[".*%.blade%.php"] = {
					function(path, bufnr, ext)
						-- Leemos el buffer de forma segura para evitar crashes
						local ok, lines = pcall(vim.api.nvim_buf_get_lines, bufnr, 0, 1, false)
						local firstLine = (ok and lines[1]) or ""

						if vim.startswith(firstLine, "<?php") then
							return "php"
						end

						return "blade"
					end,
					{ priority = math.huge, name = "blade" },
				},
			},
		})
		vim.treesitter.language.register("angular", "html")

		-- 4. Autocmd para encender el resaltado en Neovim 0.12
		vim.api.nvim_create_autocmd("FileType", {
			desc = "Activar resaltado nativo de Treesitter",
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			callback = function(args)
				pcall(vim.treesitter.start, args.buf)
				vim.filetype.add({
					pattern = {
						[".*%.blade%.php"] = {
							function(path, bufnr, ext)
								local firstLine = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
								if vim.startswith(firstLine, "<?php") then
									return "php"
								end

								return "blade"
							end,
							{ priority = math.huge, name = "blade" },
						},
					},
				})
			end,
		})

		-- 5. Opciones de pliegues (folds) usando Treesitter nativo
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
		vim.opt.foldenable = false
	end,
}
-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		-- 1. Declaramos la lista de lenguajes
-- 		local lenguajes = {
-- 			"c",
-- 			"lua",
-- 			"vim",
-- 			"vimdoc",
-- 			"query",
-- 			"javascript",
-- 			"typescript",
-- 			"html",
-- 			"css",
-- 			"angular",
-- 			"php",
-- 			"php_only",
-- 			"blade",
-- 			"python",
-- 		}
--
-- 		-- 2. Instalación estándar usando la API oficial (setup)
-- 		require("nvim-treesitter.configs").setup({
-- 			ensure_installed = lenguajes,
-- 			auto_install = true,
-- 			-- Apagamos el resaltado abstracto del plugin porque más
-- 			-- abajo estás usando la API nativa de Neovim 0.12+
-- 			highlight = { enable = false },
-- 		})
--
--
-- 		-- 4. Autocmd para encender el resaltado nativo de Treesitter
-- 		vim.api.nvim_create_autocmd("FileType", {
-- 			desc = "Activar resaltado nativo de Treesitter",
-- 			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
-- 			callback = function(args)
-- 				pcall(vim.treesitter.start, args.buf)
-- 			end,
-- 		})
--
-- 		-- 5. Opciones de pliegues (folds) usando Treesitter nativo
-- 		vim.opt.foldmethod = "expr"
-- 		vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- 		vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
-- 		vim.opt.foldenable = false
-- 	end,
-- }
