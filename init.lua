require('packer.packer')

require('settings.basic')

require('plugins.autopairs_')
require('plugins.legendary_')
require('plugins.lualine_')
require('plugins.nvim_tree')
require('plugins.smart_splits')
require('plugins.snippets_and_lsp')
require('plugins.treesitter_')
require('plugins.indent_blankline')
require('bufferline').setup {}
require('telescope').setup {}

require("autocmds")
require('highlight')
require("shortcuts")
require('tema')

local lspFiles = require('lsp.global_lsp')
lspFiles.setup()
