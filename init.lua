require('lua.packer.packer')

require('lua.settings.basic')

require('plugins.autopairs_')
require('lua.plugins.legendary_')
require('lua.plugins.lualine_')
require('lua.plugins.nvim_tree')
require('lua.plugins.smart_splits')
require('lua.plugins.snippets_and_lsp')
require('lua.plugins.treesitter_')

require('bufferline').setup {}
require('telescope').setup {}

require("autocmds")
require('highlight')
require("shortcuts")
require('tema')

local lspFiles = require('lsp.global_lsp')
lspFiles.setup()

