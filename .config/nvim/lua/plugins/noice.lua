return {
	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify", -- 👈 Fundamental para ver los warnings/errores
		},
		opts = function(_, opts)
			opts.routes = opts.routes or {}

			-- Filtro que ya tenías
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
			})

			-- 🔥 AGREGÁ ESTO: Enviar errores y warnings explícitamente a notify
			table.insert(opts.routes, {
				filter = { error = true },
				view = "notify",
			})
			table.insert(opts.routes, {
				filter = { warning = true },
				view = "notify",
			})

			-- Asegurar presets
			opts.presets = opts.presets or {}
			opts.presets.lsp_doc_border = true

			-- Tu configuración de cmdline
			opts.cmdline = {
				enabled = true,
				view = "cmdline_popup",
				format = {
					cmdline = { pattern = "^:", view = "cmdline_popup" },
					search_down = { kind = "search", pattern = "^/", view = "cmdline" },
					search_up = { kind = "search", pattern = "^%?", view = "cmdline" },
				},
			}
			opts.views = opts.views or {}
			opts.views.cmdline_popup = {
				position = {
					row = "20%",
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "rounded",
				},
			}
		end,
	},
}
