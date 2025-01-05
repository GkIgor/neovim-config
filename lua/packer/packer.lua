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
  use 'wbthomason/packer.nvim'

  use "kkharji/sqlite.lua"

  use {
    'mrjones2014/legendary.nvim',
    -- since legendary.nvim handles all your keymaps/commands,
    -- its recommended to load legendary.nvim before other plugins
    priority = 10000,
    lazy = false,
    -- sqlite is only needed if you want to use frecency sorting
    -- dependencies = { 'kkharji/sqlite.lua' },
    -- keys = {
    --   {
    --     '<C-p>',
    --     function()
    --       require('flash').jump()
    --     end
    --   },
    --   {
    --     'S',
    --     function()
    --       require('flash').jump({ search = { forward = false } })
    --     end,
    --     mode = { 'n', 'x', 'o' },
    --     desc = 'Jump backwards',
    --   },
    -- }
  }

  use 'MunifTanjim/nui.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lualine/lualine.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
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
  use ({ 'rktjmp/lush.nvim' })
  use({ 'projekt0n/github-nvim-theme' })
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'navarasu/onedark.nvim'
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
        capabilities = Capabilities,
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

  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  }

  use {
    "kwkarlwang/bufresize.nvim",
    config = function()
      require("bufresize").setup()
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
