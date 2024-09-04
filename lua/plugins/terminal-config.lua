require('toggleterm').setup({
  open_mapping = [[<C-\>]],
  size = 20,
  direction = 'float',
  shell = 'bash',
  float_opts = {
    border = 'single',
    height = 50
  },
})
