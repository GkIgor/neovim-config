local npairs = require('nvim-autopairs')
local Rule = require('nvim-autopairs.rule')
local cmp = require('cmp')
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
npairs.setup {
  check_ts = true,                                             -- Habilita integração com Treesitter
  disable_filetype = { "TelescopePrompt", "markdown", "txt" }, -- Desativa em alguns tipos de arquivo
}

npairs.add_rules {
  Rule("<", ">"),  -- Adiciona <> como par automático
  Rule("/*", "*/") -- Adiciona /* */ para comentários
}

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
