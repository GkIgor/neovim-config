function Highlight_word_under_cursor()
  -- local line = vim.api.nvim_get_current_line()
  -- local col = vim.fn.col(".") - 1
  -- local char = line:sub(col, col)

  -- if not char:match("[%p%s]") then
  --   local word = vim.fn.expand("<cword>")
  --   vim.cmd("match Search /\\<" .. word .. "\\>/")
  -- else
  --   vim.cmd("match none")
  -- end
end

Ns_id = vim.api.nvim_create_namespace("highlight_matches")

function Highlight_all_matches()
  -- -- Remove highlights anteriores
  -- vim.api.nvim_buf_clear_namespace(0, Ns_id, 0, -1)

  -- -- Verifica se há uma seleção ativa
  -- local mode = vim.fn.mode()
  -- local word = ""

  -- if mode == "v" or mode == "V" or mode == string.char(22) then
  --   -- Palavra selecionada
  --   local start_pos = vim.fn.getpos("'<")
  --   local end_pos = vim.fn.getpos("'>")
  --   local start_line = start_pos[2]
  --   local start_col = start_pos[3] - 1
  --   local end_line = end_pos[2]
  --   local end_col = end_pos[3]

  --   if start_line == end_line then
  --     -- Mesma linha
  --     word = vim.api.nvim_get_current_line():sub(start_col + 1, end_col)
  --   end
  -- else
  --   -- Palavra sob o cursor
  --   word = vim.fn.expand("<cword>")
  -- end

  -- -- Se não há palavra, retorna
  -- if word == "" or word:match("^%s+$") then return end

  -- -- Adiciona highlights em todas as ocorrências da palavra
  -- local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  -- for line_num, line in ipairs(lines) do
  --   local start_idx = 1
  --   while true do
  --     local s, e = line:find("%f[%w]" .. vim.pesc(word) .. "%f[%W]", start_idx)
  --     if not s then break end
  --     vim.api.nvim_buf_add_highlight(0, Ns_id, "Search", line_num - 1, s - 1, e)
  --     start_idx = e + 1
  --   end
  -- end
end
