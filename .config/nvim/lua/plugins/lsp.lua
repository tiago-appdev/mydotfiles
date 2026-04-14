return {
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- 🔥 EL PLUGIN QUE SE MENCIONA AL FINAL DEL VIDEO
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			require("mason-tool-installer").setup({
				ensure_installed = {
					-- Tus LSPs actuales
					"angularls",
					"ts_ls",
					"html",
					"cssls",
					"intelephense",
					"pyright",
					"lua_ls",
					"pint",
					"blade-formatter",

					-- A partir de ahora, puedes agregar formateadores y linters aquí sin errores.
					-- Ejemplos (puedes descomentarlos cuando los necesites):
					-- "eslint_d",
					"prettier",
					"stylua",
				},
				-- Opciones recomendadas para que funcione transparente
				auto_update = false,
				run_on_start = true,
			})
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim" },
		config = function()
			-- OJO: Ya no usamos "ensure_installed" aquí.
			-- Lo hemos delegado a mason-tool-installer arriba.
			require("mason-lspconfig").setup({
				automatic_installation = false,
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"saghen/blink.cmp",
		},

		config = function()
			-- 🔥 CAPABILITIES PRO (blink)
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- 🔥 KEYMAPS SOLO CUANDO HAY LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(ev)
					local map = vim.keymap.set
					local opts = { buffer = ev.buf }

					map("n", "K", vim.lsp.buf.hover, opts)
					map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename variable/word" })
					map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code actions" })
					local organize_opts = vim.tbl_extend("force", opts, { desc = "Organize Imports" })
					map("n", "<leader>co", function()
						vim.lsp.buf.code_action({
							apply = true,
							context = {
								only = { "source.organizeImports" },
								diagnostics = {},
							},
						})
					end, organize_opts)
				end,
			})

			-- 🔥 CONFIG GLOBAL (esto es clave)
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			-- 🔥 SERVERS

			-- TypeScript / React / Angular
			vim.lsp.config("ts_ls", {})
			vim.lsp.enable("ts_ls")

			-- Angular 🔥
			vim.lsp.config("angularls", {})
			vim.lsp.enable("angularls")

			-- HTML / CSS
			vim.lsp.config("html", {})
			vim.lsp.enable("html")

			vim.lsp.config("cssls", {})
			vim.lsp.enable("cssls")

			-- PHP (Laravel / Blade)
			vim.lsp.config("intelephense", {
				-- Es crucial pasarle los filetypes para que despierte en Blade
				filetypes = { "php", "blade", "php_only" },
				settings = {
					intelephense = {
						files = {
							maxSize = 5000000,
						},
					},
				},
			})
			vim.lsp.enable("intelephense")

			-- Python
			vim.lsp.config("pyright", {})
			vim.lsp.enable("pyright")

			-- Lua (Neovim config)
			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.lsp.enable("lua_ls")
		end,
	},
}
