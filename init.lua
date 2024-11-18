-- Configurações básicas
vim.opt.number = true             -- Mostrar números das linhas
vim.opt.relativenumber = false    -- Números relativos
vim.opt.tabstop = 4               -- Tamanho do tab em 4 espaços
vim.opt.shiftwidth = 4            -- Identação com 4 espaços
vim.opt.expandtab = true          -- Usa espaços em vez de tabs
vim.opt.smartindent = true        -- Identação inteligente
vim.opt.cursorline = true         -- Destaque da linha do cursor
vim.opt.wrap = false              -- Não quebra linha automaticamente
vim.opt.mouse = 'a'               -- Habilita o uso do mouse
vim.opt.clipboard = 'unnamedplus' -- Compartilha clipboard com o sistema
vim.opt.termguicolors = true      -- Habilita cores 24 bits

-- Atalhos globais
vim.g.mapleader = ' '                      -- Configura o espaço como líder
vim.keymap.set('n', '<leader>w', ':w<CR>') -- Salvar com <Leader> + w
vim.keymap.set('n', '<leader>q', ':q<CR>') -- Sair com <Leader> + q

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
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { desc = 'Abrir/Fechar a árvore' })

-- Plugin manager básico: Packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      'git',
      'clone',
      '--depth',
      '1',
      'https://github.com/wbthomason/packer.nvim',
      install_path
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Configuração de plugins
require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'    -- Packer em si
  use 'neovim/nvim-lspconfig'
  use 'nvim-lualine/lualine.nvim' -- Barra de status estilosa
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate' -- Atualiza os parsers automaticamente
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use {
    'hrsh7th/nvim-cmp',               -- Core do autocomplete
    requires = {
      { 'hrsh7th/cmp-nvim-lsp' },     -- Integração com LSP
      { 'hrsh7th/cmp-buffer' },       -- Sugestões de texto do buffer atual
      { 'hrsh7th/cmp-path' },         -- Sugestões de caminhos de arquivos
      { 'hrsh7th/cmp-cmdline' },      -- Sugestões no comando
      { 'L3MON4D3/LuaSnip' },         -- Suporte a snippets
      { 'saadparwaiz1/cmp_luasnip' }, -- Integração com LuaSnip
    }
  }
  use {
    'akinsho/bufferline.nvim',
    requires = 'nvim-tree/nvim-web-devicons'
  }
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- Ícones bacanas (opcional, mas estiloso)
    }
  }

  -- Adicione mais plugins aqui depois


  if packer_bootstrap then
    require('packer').sync()
  end
end)

require('bufferline').setup {}

-- Configurando o Telescope
require('telescope').setup {}
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = "Buscar arquivos" })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = "Grep ao vivo" })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = "Buscar buffers" })

local lspconfig = require('lspconfig')

-- Configurações globais pra LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Ir para definição' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Mostrar documentação' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Renomear símbolo' })


-- Configura o servidor de exemplo (pyright pra Python)
lspconfig.pyright.setup {}

-- Configurando o Treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua",
    "javascript",
    "python",
    "go",
    "html",
    "css",
    "json",
    "markdown",
    "markdown_inline",
    "bash",
    "yaml",
    "toml",
    "rust",
    "c",
    "cpp",
    "java",
    "sql",
    "typescript",
    "tsx",
  },                             -- Idiomas básicos
  highlight = { enable = true }, -- Ativar highlight
  indent = { enable = true },    -- Melhora a indentação
}

-- Configurando o Lualine
require('lualine').setup {
  options = {
    theme = 'gruvbox', -- Troque para outro tema se quiser
    section_separators = '',
    component_separators = ''
  }
}

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

-- Configuração adicional pro LSP
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['<seu_servidor>'].setup {
  capabilities = capabilities,
}

-- Configuração do NvimTree
require('nvim-tree').setup({
  view = {
    width = 30,    -- Largura da tree
    side = 'left', -- Posição (pode ser 'right' também)
  },
  renderer = {
    icons = {
      glyphs = {
        default = '📄',
        symlink = '🔗',
        folder = {
          default = '📂',
          open = '📂',
        },
      },
    },
  },
  filters = {
    dotfiles = false, -- Mostrar arquivos ocultos
  },
})
