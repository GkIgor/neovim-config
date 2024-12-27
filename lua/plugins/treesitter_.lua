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
    "llvm",
    "asm",
  },                             -- Idiomas básicos
  highlight = { enable = true }, -- Ativar highlight
  indent = { enable = true },    -- Melhora a indentação
  folding = {
    enable = true,
    method = 'expr',
    expr = 'nvim_treesitter#foldexpr()'
  }
}
