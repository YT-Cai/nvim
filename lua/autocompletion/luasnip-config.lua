local types = require('luasnip.util.types')
require('luasnip.loaders.from_vscode').lazy_load()
require('luasnip').setup({
  history = true,
  delete_check_events = 'TextChanged',
  ext_opts = {
    [types.insertNode] = {
      unvisited = {
        virt_text = { { '|', 'Conceal' } },
        virt_text_pos = 'inline',
      },
    },
  },
})
