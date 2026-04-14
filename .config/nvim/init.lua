vim.opt.rtp:append(vim.fn.stdpath("data") .. "/site")
require("config.options")
require("config.keymaps")
require("config.lazy")
