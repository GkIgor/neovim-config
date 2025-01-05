Menu_options = {
  file = {
    { name = "Novo Arquivo",   action = "enew" },
    { name = "Abrir Arquivo",  action = "Telescope find_files" },
    { name = "Salvar",         action = "write" },
    { name = "Salvar Como",    action = function() vim.cmd("saveas") end },
    { name = "Fechar Arquivo", action = "bdelete" },
  },
  edit = {
    { name = "Desfazer",             action = "undo" },
    { name = "Refazer",              action = "redo" },
    { name = "Copiar",               action = '"+y' },
    { name = "Colar",                action = '"+p' },
    { name = "Localizar/Substituir", action = "Telescope live_grep" },
  },
  view = {
    { name = "Alternar Barra Lateral", action = "NvimTreeToggle" },
    { name = "Alternar Minimap",       action = function() print("Minimap toggled!") end },
    { name = "Ajustar Zoom",           action = function() vim.o.guifontsize = vim.o.guifontsize + 1 end },
  },
  tools = {
    { name = "Gerenciar Plugins",       action = "Lazy" },
    { name = "Abrir Terminal",          action = "split | terminal" },
    { name = "Configurações do Editor", action = "edit $MYVIMRC" },
  },
}
