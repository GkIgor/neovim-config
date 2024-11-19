-- Configurações básicas
vim.opt.number = true             -- Mostrar números das linhas
vim.opt.relativenumber = false    -- Números relativos
vim.opt.tabstop = 2               -- Tamanho do tab em 4 espaços
vim.opt.shiftwidth = 2            -- Identação com 4 espaços
vim.opt.expandtab = true          -- Usa espaços em vez de tabs
vim.opt.smartindent = true        -- Identação inteligente
vim.opt.cursorline = true         -- Destaque da linha do cursor
vim.opt.wrap = false              -- Não quebra linha automaticamente
vim.opt.mouse = 'a'               -- Habilita o uso do mouse
vim.opt.clipboard = 'unnamedplus' -- Compartilha clipboard com o sistema
vim.opt.termguicolors = true      -- Habilita cores 24 bits

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

-- imports
require('bufferline').setup {}
require('telescope').setup {}
local lspconfig = require('lspconfig')

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
  use('mrjones2014/smart-splits.nvim')
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use({ 'projekt0n/github-nvim-theme' })
  use 'rafamadriz/friendly-snippets'
  use {
    'L3MON4D3/LuaSnip',
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
    end
  }
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'ryanoasis/vim-devicons'
  use 'sheerun/vim-polyglot'
  use {
    'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Formatação para C++
          null_ls.builtins.formatting.clang_format,
          -- Diagnóstico para C++
          null_ls.builtins.diagnostics.clang_check,
        },
        on_attach = function(client, bufnr)
          -- Atalho pra formatar
          vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = "Formatar código" })
          -- Formatar ao salvar
          if client.server_capabilities.documentFormattingProvider then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function() vim.lsp.buf.format() end,
            })
          end
        end,
      })
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup {}
    end
  }

  -- use 'preservim/nerdtree'
  -- use {
  --   "folke/which-key.nvim",
  --   config = function()
  --     require("which-key").setup {
  --       -- your configuration comes here
  --       -- or leave it empty to use the default settings
  --       -- refer to the configuration section below
  --     }
  --   end
  -- }

  -- Adicione mais plugins aqui depois


  if packer_bootstrap then
    require('packer').sync()
  end
end)

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
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- require('lspconfig')['<seu_servidor>'].setup {
--   capabilities = capabilities,
-- }

-- Configura o servidor de exemplo (pyright pra Python)
lspconfig.pyright.setup {
  capabilities = capabilities,
}

-- local project_library_path = "/home/user/meu-projeto-angular/node_modules"
-- local cmd = { "ngserver", "--stdio", "--tsProbeLocations", project_library_path, "--ngProbeLocations",
--   project_library_path }

-- lspconfig.angularls.setup {
--   cmd = cmd,
--   on_new_config = function(new_config, new_root_dir)
--     new_config.cmd = cmd
--   end,
-- }

lspconfig.bashls.setup {
  capabilities = capabilities,
}
lspconfig.clangd.setup {
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
  -- capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  capabilities = capabilities,
}
lspconfig.cssls.setup {
  capabilities = capabilities,
}
lspconfig.html.setup {
  capabilities = capabilities,
}
lspconfig.jsonls.setup {
  capabilities = capabilities,
}
lspconfig.rust_analyzer.setup {
  capabilities = capabilities,
}
lspconfig.ts_ls.setup {
  capabilities = capabilities,
}
lspconfig.css_variables.setup {
  capabilities = capabilities,
}
lspconfig.tailwindcss.setup {
  capabilities = capabilities,
}
lspconfig.dartls.setup {
  capabilities = capabilities,
}
lspconfig.eslint.setup({
  --- ...
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      command = "EslintFixAll",
    })
  end,
})
lspconfig.java_language_server.setup {
  capabilities = capabilities,
}
lspconfig.gopls.setup {
  capabilities = capabilities,
}
lspconfig.clangd.setup {
  capabilities = capabilities,
}
-- lspconfig.ccls.setup {
--   capabilities = capabilities,
-- }
require 'lspconfig'.cmake.setup {}

-- Configuração do NvimTree
require('nvim-tree').setup({
  view = {
    width = 35,    -- Largura da tree
    side = 'left', -- Posição (pode ser 'right' também)
  },
  -- renderer = {
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
  -- },
  filters = {
    dotfiles = true, -- Mostrar arquivos ocultos
  },
})

require('smart-splits').setup({
  ignore_bufter_types = {
    'terminal',
    'nofile',
    'quickfix',
    'prompt',
  },
  ignored_filetypes = { 'NvimTree' },
  default_amount = 3,
  at_edge = 'wrap',
  float_win_behavior = 'previous',
  move_cursor_same_row = false,
  cursor_follows_swapped_bufs = false,
  resize_mode = {
    quit_key = '<ESC>',
    resize_keys = { 'h', 'j', 'k', 'l' },
    silent = false,
    hooks = {
      on_enter = nil,
      on_leave = nil,
    },
  },
  ignored_events = {
    'BufEnter',
    'WinEnter',
  },
  multiplexer_integration = nil,
  disable_multiplexer_nav_when_zoomed = true,
  kitty_password = nil,
  log_level = 'info',


})

require('smart-splits').setup({
  resize_mode = {
    hooks = {
      on_enter = function()
        vim.notify('Entering resize mode')
      end,
      on_leave = function()
        vim.notify('Exiting resize mode, bye')
      end,
    },
  },
})

local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule') -- Importa a função Rule

-- Configuração básica
npairs.setup {
  check_ts = true,                                             -- Habilita integração com Treesitter
  disable_filetype = { "TelescopePrompt", "markdown", "txt" }, -- Desativa em alguns tipos de arquivo
}

-- Adiciona regras personalizadas
npairs.add_rules {
  Rule("<", ">"),  -- Adiciona <> como par automático
  Rule("/*", "*/") -- Adiciona /* */ para comentários
}

-- Integração com nvim-cmp (se usar autocomplete)
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

-- keymaps

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

-- NERDTree
-- Abrir/fechar o NERDTree
-- vim.keymap.set('n', '<C-b>', ':NERDTreeToggle<CR>', { desc = 'Alternar NERDTree' })

-- Localizar o arquivo atual no NERDTree
-- vim.keymap.set('n', '<leader>nf', ':NERDTreeFind<CR>', { desc = 'Encontrar arquivo atual no NERDTree' })

-- Configurando CMDs
require("autocmds")