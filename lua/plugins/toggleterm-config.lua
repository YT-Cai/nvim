require('toggleterm').setup({
  -- size = function(term)
  --   if term.direction == "horizontal" then
  --     return 15
  --   elseif term.direction == "vertical" then
  --     return vim.o.columns * 0.4
  --   end
  -- end,
  size = 15,
  open_mapping = [[<c-\>]],
  start_in_insert = true,
  auto_scroll = true,
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  direction = "float",
  close_on_exit = true,
  shell = "bash",
  float_opts = {
    border = "single",
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
    height = 50
  },
  winbar = {
    enabled = true,
    name_formatter = function(term)
      return term.name
    end
  }
})
