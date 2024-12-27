require('nvim-tree').setup({
  view = {
    width = 35,
    side = 'left',
  },
  sort = {
    sorter = "case_sensitive",
  },
  renderer = {
    group_empty = true,
    --   icons = {
    --     glyphs = {
    --       default = '📄',
    --       symlink = '🔗',
    --       folder = {
    --         default = '📂',
    --         open = '📂',
    --       },
    --     },
    --   },
  },
  filters = {
    dotfiles = true,
  },
})
