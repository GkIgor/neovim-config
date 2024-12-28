-- Lspconfig = require('lspconfig')

-- Capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Capabilities.textDocument.completion.completionItem.snippetSupport = true
-- Capabilities.offsetEncoding = { "utf-8" }

-- -- require('lspconfig')['<seu_servidor>'].setup {
-- --   capabilities = capabilities,
-- -- }

-- function LoadLsp()
--   require('angular.angular_lsp')
--   require('lua.lsp.bash.bash_lsp')
--   require('clang.clangd_')
--   require('cmake.cmake_lsp')
--   require('css.css_lsp')
--   require('dart.dart_lsp')
--   require('eslint.eslint_lsp')
--   require('lua.lsp.go.go_lsp')
--   require('html.html_lsp')
--   require('java.java_lsp')
--   require('json.json_lsp')
--   require('python.python_lsp')
--   require('rust.rust_lsp')
--   require('lua.lsp.typescript.ts_lsp')
-- end



Lspconfig = require('lspconfig')

Capabilities = require('cmp_nvim_lsp').default_capabilities()
Capabilities.textDocument.completion.completionItem.snippetSupport = true
Capabilities.offsetEncoding = { "utf-8" }

local function load_lsp()
  local modules = {
    'lsp.angular.angular_lsp',
    'lsp.bash.bash_lsp',
    'lsp.clang.clangd_',
    'lsp.cmake.cmake_lsp',
    'lsp.css.css_lsp',
    'lsp.dart.dart_lsp',
    'lsp.eslint.eslint_lsp',
    'lsp.go.go_lsp',
    'lsp.html.html_lsp',
    'lsp.java.java_lsp',
    'lsp.json.json_lsp',
    'lsp.python.python_lsp',
    'lsp.rust.rust_lsp',
    'lsp.typescript.ts_lsp',
  }

  for _, module in ipairs(modules) do
    local ok, err = pcall(require, module)
    if not ok then
      vim.notify('Erro ao carregar LSP: ' .. module .. '\n' .. err, vim.log.levels.ERROR)
    end
  end
end

return {
  setup = load_lsp,
}
