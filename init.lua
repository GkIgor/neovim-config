require('lua.packer.packer')
require('lua.settings.basic')
require('lua.tema')
require('bufferline').setup {}
require('telescope').setup {}
require('lua.plugins.treesitter_')
require('lua.plugins.lualine_')
require('plugins.autopairs_')
require("autocmds")
local lspFiles = require('lsp.global_lsp')
lspFiles.LoadLsp()

