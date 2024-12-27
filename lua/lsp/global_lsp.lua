Lspconfig = require('lspconfig')

Capabilities = require('cmp_nvim_lsp').default_capabilities()
Capabilities.textDocument.completion.completionItem.snippetSupport = true
Capabilities.offsetEncoding = { "utf-8" }

-- require('lspconfig')['<seu_servidor>'].setup {
--   capabilities = capabilities,
-- }

function LoadLsp()
  require('angular.angular_lsp')
  require('lua.lsp.bash.bash_lsp')
  require('clang.clangd_')
  require('cmake.cmake_lsp')
  require('css.css_lsp')
  require('dart.dart_lsp')
  require('eslint.eslint_lsp')
  require('lua.lsp.go.go_lsp')
  require('html.html_lsp')
  require('java.java_lsp')
  require('json.json_lsp')
  require('python.python_lsp')
  require('rust.rust_lsp')
  require('lua.lsp.typescript.ts_lsp')
end
