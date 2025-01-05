Lspconfig.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' }, -- Diz pro LSP que 'vim' é global
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true), -- Inclui as APIs do Vim
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
