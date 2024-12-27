-- Atalhos globais
vim.g.mapleader = ' '                                                   -- Configura o espaço como líder
vim.keymap.set('n', '<leader>w', ':w<CR>')                              -- Salvar com <Leader> + w
vim.keymap.set('n', '<leader>q', ':q<CR>')                              -- Sair com <Leader> + q

vim.keymap.set('v', '<C-c>', '"+y', { desc = "Copiar para clipboard" }) -- Copiar com Ctrl+C

-- Colar com Ctrl+V
vim.keymap.set('n', '<C-v>', '"+p', { desc = "Colar do clipboard" })
vim.keymap.set('v', '<C-v>', '"+p', { desc = "Colar do clipboard no modo visual" })

-- Desfazer com Ctrl+Z
vim.keymap.set('n', '<C-z>', 'u', { desc = "Desfazer última ação" })
vim.keymap.set('i', '<C-z>', '<C-o>u', { desc = "Desfazer última ação no modo inserção" })

-- Duplicar linha
vim.keymap.set('n', '<leader>d', 'yyp', { desc = "Duplicar linha" })

-- Mover linhas para cima/baixo
vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = "Mover linha para baixo" })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = "Mover linha para cima" })

-- Seleção visual: mover linhas para cima/baixo
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = "Mover seleção para baixo" })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = "Mover seleção para cima" })

-- Limpar highlights de busca
vim.keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = "Limpar destaques de busca" })

-- Substituir texto sob o cursor no arquivo inteiro
vim.keymap.set('n', '<leader>r', ':%s/\\<<C-r><C-w>\\>//g<Left><Left>', { desc = "Substituir palavra" })

-- Navegar entre splits
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = "Mover para o split à esquerda" })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = "Mover para o split à direita" })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = "Mover para o split abaixo" })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = "Mover para o split acima" })

-- Criar splits rapidamente
vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = "Split vertical" })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = "Split horizontal" })

-- Ajustar tamanho dos splits
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>', { desc = "Aumentar split horizontal" })
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>', { desc = "Reduzir split horizontal" })
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>', { desc = "Reduzir split vertical" })
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>', { desc = "Aumentar split vertical" })

-- NvimTree
vim.keymap.set('n', '<C-b>', ':NvimTreeToggle<CR>', { desc = 'Abrir/Fechar a árvore' })

-- Configurando o Telescope
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Buscar arquivos" })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Grep ao vivo" })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Buscar buffers" })

-- Configurações globais pra LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Ir para definição' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Mostrar documentação' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Renomear símbolo' })

-- LSP Saga
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', { desc = "Mostrar Tooltip do LSP" })
