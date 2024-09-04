require('render-markdown').setup({
  file_types = { 'markdown', 'quarto', 'vimwiki' }
})
vim.treesitter.language.register('markdown', 'quarto', 'vimwiki')
