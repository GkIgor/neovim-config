function GetWordAtCol(line, col)
  local words = {}
  for word in line:gmatch("%S+") do
    table.insert(words, word)
  end

  -- Encontra a palavra correspondente à coluna
  local current_pos = 1
  for _, word in ipairs(words) do
    local word_start = current_pos
    local word_end = word_start + #word - 1
    if col >= word_start and col <= word_end then
      return word
    end
    current_pos = word_end + 2 -- Inclui o espaço
  end
  return "nenhuma"
end
