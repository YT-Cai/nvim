-- yank hightlight
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- color preview
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  desc = 'Auto toggle Colore Preview',
  command = 'ColorizerAttachToBuffer',
  group = vim.api.nvim_create_augroup('Color Preview', { clear = true })
})
-- stop command next line
vim.api.nvim_create_autocmd("FileType", {
  desc = 'Stop comment next line',
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
  group = vim.api.nvim_create_augroup('Comment', { clear = true })
})
