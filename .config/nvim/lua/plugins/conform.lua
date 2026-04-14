return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				php = function(bufnr)
					-- Obtenemos la ruta absoluta del archivo actual
					local bufname = vim.api.nvim_buf_get_name(bufnr)

					-- Si el archivo termina literalmente en ".blade.php", forzamos blade-formatter
					if bufname:match("%.blade%.php$") then
						return { "blade-formatter" }
					end

					-- De lo contrario, es un PHP puro, usamos el estándar de Laravel
					return { "pint" }
				end,
				blade = { "blade-formatter" },
				python = { "isort", "black" },
			},
			formatters = {
				["blade-formatter"] = {
					-- Le inyectamos la bandera de 2 espacios
					prepend_args = { "--indent-size", "2" },
				},
			},
			-- 🔥 LÓGICA INTELIGENTE PARA ARCHIVOS GRANDES

			-- 1. Guardado normal (Síncrono)
			format_on_save = function(bufnr)
				local line_count = vim.api.nvim_buf_line_count(bufnr)
				-- Si el archivo tiene más de 1500 líneas, cancelamos el formateo síncrono
				if line_count > 1500 then
					return nil
				end
				-- Si es pequeño, lo hacemos normal (bloquea la pantalla max 3 seg)
				return { timeout_ms = 3000, lsp_format = "fallback" }
			end,

			-- 2. Guardado en segundo plano (Asíncrono)
			format_after_save = function(bufnr)
				local line_count = vim.api.nvim_buf_line_count(bufnr)
				-- Si el archivo es gigante, lo formateamos asíncronamente
				if line_count > 1500 then
					return { lsp_format = "fallback" }
				end
			end,
		},
	},
}
