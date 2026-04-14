return {
  {
    "saghen/blink.cmp",
    version = "1.*",

    dependencies = {
      "rafamadriz/friendly-snippets",
    },

    opts = {
      keymap = {
        ["<CR>"] = { "select_and_accept", "fallback" },

        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },

        ["<C-space>"] = { "show", "fallback" },
        ["<C-e>"] = { "hide", "fallback" },
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
    },
  },
}
