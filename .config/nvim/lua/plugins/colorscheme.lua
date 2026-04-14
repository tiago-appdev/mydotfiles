return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- se carga primero
    config = function()
      require("tokyonight").setup({
        style = "storm", -- storm / night / moon
        transparent = false,
      })

      vim.cmd("colorscheme tokyonight")
    end,
  },
}
