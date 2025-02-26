local function filenameFirst(_, path)
  local tail = vim.fs.basename(path)
  local parent = vim.fs.dirname(path)
  if parent == "." then return tail end
  return string.format("%s\t\t%s", tail, parent)
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = "TelescopeResults",
  callback = function(ctx)
    vim.api.nvim_buf_call(ctx.buf, function()
      vim.fn.matchadd("TelescopeParent", "\t\t.*$")
      vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
    end)
  end,
})
local actions = require('telescope.actions')
-- local open_with_trouble = require('trouble.sources.telescope').open
-- Use this to add more results without clearing the trouble list
-- local add_to_trouble = require("trouble.sources.telescope").add
require('telescope').setup {
  defaults = {
    path_display = { 'smart' },
    layout_strategy = "vertical",
    layout_config = {
      prompt_position = 'bottom',
    },
    mappings = {
      i = {
        -- ["<c-t>"] = open_with_trouble,
        ["<c-v>"] = 'select_vertical',
      },
      -- n = { ["<c-t>"] = open_with_trouble },
    }
  },
  pickers = {
    git_status = { path_display = filenameFirst, },
    find_files = { path_display = filenameFirst, },
    -- oldfiles = { path_display = filenameFirst, },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}
-- require('telescope').load_extension('fzf')

local builtin = require('telescope.builtin')
-- keymaps
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
