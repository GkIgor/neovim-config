Lspconfig.clangd.setup {
  cmd = { "clangd" },
  on_attach = function(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- Ir para a definição do símbolo sob o cursor
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- Pressione "g" seguido de "d" no modo normal para navegar para a definição.

    -- Mostrar documentação ou detalhes do símbolo sob o cursor
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    -- Pressione "K" no modo normal para exibir uma janela com informações detalhadas.

    -- Renomear o símbolo sob o cursor
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    -- Use <Leader> + r + n (por padrão, espaço + r + n) para renomear variáveis, métodos, etc.

    -- Executar ações de código, como correções rápidas ou organizar imports
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    -- Use <Leader> + c + a (espaço + c + a) para abrir o menu de ações disponíveis no local.
  end,
  capabilities = Capabilities,
}
