vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[ %s/\s\+$//e ]])
  end,
  desc = "Remove espacos em branco ao salvar",
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[ %s/\n\+\%$//e ]])
  end,
  desc = "Remove linhas em branco ao salvar",
})

vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  command = "checktime",
  desc = "Verificar alterações externas",
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank()
  end,
  desc = "Highlight ao copiar",
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function(data)
    local directory = vim.fn.isdirectory(data.file) == 1
    if directory then
      vim.cmd.cd(data.file)
      require("nvim-tree.api").tree.open()
    end
  end,
  desc = "Abrir NvimTree ao entrar na pasta",
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.h",
  callback = function()
    vim.bo.filetype = "cpp"
  end,
  desc = "Mudar tipo de arquivo para .cpp ao abrir arquivos .h",
})



require("highlight")

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = Highlight_word_under_cursor,
})

-- Configura os autocomandos
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI", "ModeChanged" }, {
  callback = function()
    Highlight_all_matches()
  end,
})

-- Limpa os highlights ao sair do buffer
vim.api.nvim_create_autocmd("BufLeave", {
  callback = function()
    vim.api.nvim_buf_clear_namespace(0, Ns_id, 0, -1)
  end,
})
