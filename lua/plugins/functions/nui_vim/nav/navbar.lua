local Popup = require("nui.popup")

local navbar = Popup({
  position = "0%",
  size = {
    width = "100%",
    height = 1,
  },
  enter = false,
  focusable = false,
  zindex = 50,
  border = {
    style = "none",
  },
  buf_options = {
    modifiable = true,
    readonly = false,
  },
})

navbar:mount()

-- Atualiza o conteúdo da "navbar"
vim.api.nvim_buf_set_lines(navbar.bufnr, 0, 1, false, {
  " Arquivo | Editar | Navegação | Exibir | Ferramentas ",
})

local function handle_click(row, col)
  if col >= 1 and col <= 7 then
    print("Menu Arquivo selecionado")
    -- Tu pode abrir um menu com opções, tipo:
    -- create_menu("file")
  elseif col >= 10 and col <= 15 then
    print("Menu Editar selecionado")
  elseif col >= 18 and col <= 27 then
    print("Menu Navegação selecionado")
  elseif col >= 30 and col <= 37 then
    print("Menu Exibir selecionado")
  elseif col >= 40 and col <= 50 then
    print("Menu Ferramentas selecionado")
  end
end

vim.api.nvim_buf_attach(navbar.bufnr, false, {
  on_mouse = function(_, _, _, button, row, col)
    if button == "left" then
      handle_click(row, col)
    end
  end,
})
