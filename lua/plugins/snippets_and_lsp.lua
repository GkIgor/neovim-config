local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body) -- Usar LuaSnip como engine de snippets
    end,
  },
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),         -- Próximo item no autocomplete
    ['<C-p>'] = cmp.mapping.select_prev_item(),         -- Item anterior no autocomplete
    ['<C-y>'] = cmp.mapping.confirm({ select = true }), -- Confirma a sugestão
    ['<C-Space>'] = cmp.mapping.complete(),             -- Abre o menu de autocomplete
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- Sugestões do LSP
    { name = 'luasnip' },  -- Sugestões de snippets
  }, {
    { name = 'buffer' },   -- Sugestões do buffer atual
    { name = 'path' },     -- Sugestões de caminhos
  })
})
