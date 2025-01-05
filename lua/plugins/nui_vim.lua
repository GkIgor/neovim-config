local Menu = require("nui.menu")
local event = require("nui.utils.autocmd").event

require("lua.plugins.functions.nui_vim.nav.navbar")

local itens = {
  Menu.item("Novo Arquivo"),
  Menu.item("Abrir Arquivo"),
  Menu.item("Nova Pasta"),
  Menu.item("Nova Janela"),
  Menu.item("Copiar"),
  Menu.item("Colar"),
  Menu.item("Salvar"),
  Menu.item("Sair"),
}

local menu = Menu({
  position = "50%",
  size = {
    width = 35,
    height = 20,
  },
  border = {
    style = "single",
    text = {
      top = "[Escolha uma opção]",
      top_align = "center",
    },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:Normal",
  },
}, {
  lines = itens,
  max_width = 20,
  keymap = {
    focus_next = { "j", "<Down>", "<Tab>" },
    focus_prev = { "k", "<Up>", "<S-Tab>" },
    close = { "<Esc>", "<C-c>" },
  },
  on_close = function()
    vim.notify("Menu Fechado", vim.log.levels.INFO)
  end
})

menu:on(event.BufLeave, function()
  menu:unmount()
end)

-- Detecta eventos no mouse
function HandleMouseClick()
  local pos = vim.fn.getpos(".")         -- Posição atual do cursor [buf, linha, coluna, off]
  local click_pos = vim.fn.getmousepos() -- Posição do mouse
  vim.fn.setpos(".", { 0, click_pos.line, click_pos.column, 0 })
  pos = vim.fn.getpos(".")

  local line = pos[2]
  local col = pos[3]
  local current_line = vim.fn.getline(line)            -- Conteúdo da linha atual
  local clicked_word = GetWordAtCol(current_line, col) -- Palavra clicada
  -- Select_item(clicked_word)
end

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

function NextItem()
  print("NextItem")
  vim.cmd("normal! j")
end

function PreviousItem()
  print("PreviousItem")
  vim.cmd("normal! k")
end

function Select_item(item)
  local switch = {
    Copiar = function()
      vim.cmd("normal! yy")
    end,
    Colar = function()
      vim.cmd("normal! p")
    end,
    Salvar = function()
      vim.cmd("w")
    end,
    Sair = function()
      menu:unmount()
    end
  }

  (switch[item] or function() print("Opção inválida") end)()
end

-- mount the component
function Open_context_menu()
  if not menu._.mounted then
    menu:mount()
  else
    menu:unmount()
  end
end

vim.api.nvim_set_keymap(
  "n",
  "<RightMouse>",
  ":lua Open_context_menu()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<LeftMouse>",
  ":lua HandleMouseClick()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<ScrollUp>",
  ":lua NextItem()<CR>",
  { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
  "n",
  "<ScrollDown>",
  ":lua PrevItem()<CR>",
  { noremap = true, silent = true }
)
