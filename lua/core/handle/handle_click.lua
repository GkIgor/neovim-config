require("lua.utils.get_word_at_col")

-- Detecta eventos no mouse
function HandleRightMouseClick(callback)
  local start_cursor = vim.fn.getpos(".")     -- Posição atual do cursor [buf, linha, coluna, off]

  local click_position = vim.fn.getmousepos() -- Posição do mouse

  vim.fn.setpos(".", { 0, click_position.line, click_position.column, 0 })
  local pos = vim.fn.getpos(".")

  local line = pos[2]
  local col = pos[3]
  local current_line = vim.fn.getline(line)            -- Conteúdo da linha atual
  local clicked_word = GetWordAtCol(current_line, col) -- Palavra clicada

  if callback then
    local sucess, err = pcall(callback(clicked_word, current_line, start_cursor), clicked_word)
    if not sucess then
      print("Erro ao executar callback: " .. err)
    end
  else
    return clicked_word, current_line, start_cursor
  end
end
