local g = vim.g
local api = vim.api

-- Functional wrapper for mapping custom keybindings
function Map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- key maps
g.mapleader = " "       -- leader
g.maplocalleader = " "  -- local leader
Map('i', 'jk', '<ESC>') -- escape insert mode

-- navigation between splits
Map('n', '<C-h>', '<C-w>h')
Map('n', '<C-j>', '<C-w>j')
Map('n', '<C-k>', '<C-w>k')
Map('n', '<C-l>', '<C-w>l')

-- cursor
Map('n', '<C-d>', '<C-d>zz')
Map('n', '<C-u>', '<C-u>zz')
Map('n', 'n', 'nzzzv') -- stay in the middle when searching with n
Map('n', 'N', 'Nzzzv') -- stay in the middle when searching with N

-- vim-sneak
g['sneak#label'] = 1

-- symbol outline
Map('n', '<Leader>ll', '<cmd>AerialToggle!<CR>')
Map('n', '<Leader>n', '<cmd>Navbuddy<CR>')
-- file explorer
Map("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })

-- autocmd for file type "R"
api.nvim_create_autocmd("FileType", {
  pattern = { 'r', 'rmd', 'quarto', 'rnoweb', 'qmd' },
  callback = function()
    vim.schedule(function()
      vim.keymap.set("i", "<M-.>", " %>%", { buffer = true })
      vim.keymap.set("i", "<M-->", " <- ", { buffer = true })
      vim.keymap.set("i", "<C-`>", "<cmd>MarkdownPreview<CR>", { buffer = true })
      vim.keymap.set("n", "<C-`>", "<cmd>MarkdownPreview<CR>", { buffer = true })
    end)
  end
})

-- dismiss noice message
Map('n', '<Leader>np', '<cmd>NoiceDismiss<CR>', { desc = "Dismiss Noice Message" })

-- undo tree
Map('n', '<Leader>ud', '<cmd>UndotreeToggle<CR>', { desc = "Toggel Undotree" })

-- minimap
Map('n', '<Leader>mm', '<cmd>MinimapToggle<CR>', { desc = "Toggle Minimap" })

-- copy to clipboard
Map('n', '<Leader>y', '"+y')
Map('v', '<Leader>y', '"+y')

-- Obsidian
Map('n', '<Leader>obs', '<cmd>ObsidianSearch<CR>', { desc = "Open ObsidianSearch" })
Map('n', '<Leader>obo', '<cmd>ObsidianOpen<CR>', { desc = "Open Obsidian GUI" })
