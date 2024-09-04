local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- setup plugins
require("lazy").setup({
  -- colorscheme
  {
    'rose-pine/neovim',
    name = 'rose-pine'
  },
  {
    'yorickpeterse/vim-paper'
  },
  {
    'projekt0n/github-nvim-theme',
  },
  {
    'cocopon/iceberg.vim'
  },
  {
    'uloco/bluloco.nvim',
    lazy = false,
    priority = 1000,
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- your optional config goes here, see below.
    end,
  },
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
  },
  {
    "bluz71/vim-moonfly-colors",
    name = "moonfly",
    lazy = false,
    priority = 1000
  },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = false,
    priority = 1000
  },
  { "Mofiqul/dracula.nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = ...
  },
  {
    'cryptomilk/nightcity.nvim',
    version = '*'
  },
  {
    "eldritch-theme/eldritch.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000
  },
  "EdenEast/nightfox.nvim",
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        -- Recommended - see "Configuring" below for more config options
        -- transparent = true,
        italic_comments = true,
        hide_fillchars = true,
        borderless_telescope = false,
        terminal_colors = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "storm",
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
  },
  { "rebelot/kanagawa.nvim" },
  { "savq/melange-nvim" },
  { 'nyoom-engineering/oxocarbon.nvim' },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000
  },
  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  -- navi-boddy
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim"
        },
        opts = { lsp = { auto_attach = true } }
      }
    },
    -- your lsp config or other stuff
  },
  -- arial_bar
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  -- sneak search
  "justinmk/vim-sneak",
  -- buffer navigation
  {
    "leath-dub/snipe.nvim",
    config = function()
      local snipe = require("snipe")
      snipe.setup({
        ui = {
          position = "cursor"
        }
      })
      vim.keymap.set("n", "<Leader>sb", snipe.create_buffer_menu_toggler())
    end
  },
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- csv file
  {
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
      'csv',
      'tsv',
      'csv_semicolon',
      'csv_whitespace',
      'csv_pipe',
      'rfc_csv',
      'rfc_semicolon'
    },
    cmd = {
      'RainbowDelim',
      'RainbowDelimSimple',
      'RainbowDelimQuoted',
      'RainbowMultiDelim'
    }
  },
  -- R lang related
  {
    "R-nvim/R.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      -- Create a table with the options to be passed to setup()
      local opts = {
        R_args = { "--quiet", "--no-save", "--mdi" },
        hook = {
          after_config = function()
            -- This function will be called at the FileType event
            -- of files supported by R.nvim. This is an
            -- opportunity to create mappings local to buffers.
            if vim.o.syntax ~= "rbrowser" then
              vim.api.nvim_buf_set_keymap(0, "n", "<Enter>", "<Plug>RDSendLine", {})
              vim.api.nvim_buf_set_keymap(0, "v", "<Enter>", "<Plug>RSendSelection", {})
              vim.api.nvim_buf_set_keymap(0, "n", "<Leader>rr", "<Cmd>RSend shell('CLS')<CR>", {})
              vim.api.nvim_buf_set_keymap(0, "n", "<Leader>hh",
                "<Cmd>lua require('r.run').action('head', 'n', ', n = 10')<CR>", {})
            end
          end
        },
        min_editor_width = 80,
        objbr_w = 30,
        objbr_place = "script,right",
        rconsole_width = 0,
        -- rconsole_height = 15,
        disable_cmds = {
          -- "RDSendLine",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
        -- RStudio_cmd = "C:\\Program Files\\RStudio\\rstudio.exe",
        R_path = "C:\\Program Files\\R\\R-4.3.2\\bin\\x64",
        Rout_more_colors = true,
        -- arrange_windows = false,
        csv_app = "terminal:visidata",
      }
      -- Check if the environment variable "R_AUTO_START" exists.
      -- If using fish shell, you could put in your config.fish:
      -- alias r "R_AUTO_START=true nvim"
      if vim.env.R_AUTO_START == "true" then
        opts.auto_start = 1
        opts.objbr_auto_start = true
      end
      require("r").setup(opts)
    end,
    lazy = false
  },
  { "R-nvim/cmp-r" },
  { "jalvesaq/cmp-nvim-r" },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", 'CmdlineEnter' }
  },
  -- quarto
  {
    'quarto-dev/quarto-nvim',
    'jmbuhr/otter.nvim',
  },
  -- repl
  { 'Vigemus/iron.nvim' },
  {
    "pappasam/nvim-repl",
    init = function()
      vim.g["repl_filetype_commands"] = {
        javascript = "node",
        python = "ipython --no-autoindent",
        julia = "julia --startup-file=no --history-file=no",
        -- quarto = "Rterm --quiet --no-save",
      }
    end,
    keys = {
      { "<leader>rt", "<cmd>ReplToggle<cr>",  desc = "Toggle nvim-repl" },
      { "<leader>rc", "<cmd>ReplRunCell<cr>", desc = "nvim-repl run cell" },
      { "<leader>rl", "<plug>ReplSendLine",   desc = "nvim-repl run line" } }
  },
  -- surround
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- icon
  { "nvim-tree/nvim-web-devicons" },
  -- auto-pair
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = function()
      require('nvim-autopairs').setup {}
      require('nvim-autopairs').remove_rule '`'
    end,
  },
  -- tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      configs.setup({
        ensure_installed = { "c", "lua", "vim", "vimdoc",
          "javascript", "html", "r", "python", "julia", "markdown", "bash",
          "rnoweb", "markdown_inline", "html", "json"
        },
        sync_install = false,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false
        },
        indent = { enable = true }
      })
    end
  },
  -- rainbow-delimiter
  { "HiPhish/rainbow-delimiters.nvim" },
  -- buffer line
  {
    'akinsho/bufferline.nvim',
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons'
  },
  -- indent blankline
  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
  -- LSP
  { "neovim/nvim-lspconfig" },
  -- mason
  { "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim" },
  -- lspkind
  { "onsails/lspkind.nvim" },
  -- LuaSnip
  {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- build = "make install_jsregexp"
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  { 'saadparwaiz1/cmp_luasnip' },
  -- nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-calc' },
  { 'hrsh7th/cmp-emoji' },
  -- signature help
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      doc_lines = 0,
      max_width = 120,
      floating_window_off_x = 3,
      handler_opts = {
        border = "single"
      },
      hint_inline = function() return 'inline' end,
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  -- comment
  {
    'numToStr/Comment.nvim',
    opts = {
      -- add any options here
    },
    lazy = false,
  },
  -- file explorer
  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- noice
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --     presets = {
  --       bottom_search = false,
  --       command_palette = false,
  --       lsp_doc_border = false
  --     },
  --     lsp = {
  --       -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --       override = {
  --         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --         ["vim.lsp.util.stylize_markdown"] = true,
  --         ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --       },
  --     },
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --     'echasnovski/mini.nvim',
  --     version = '*'
  --   }
  -- },
  -- {
  --   "rcarriga/nvim-notify",
  --   opts = {
  --     on_open = function(win)
  --       local config = vim.api.nvim_win_get_config(win)
  --       config.border = 'single'
  --       vim.api.nvim_win_set_config(win, config)
  --     end
  --   },
  -- },
  -- undo tree
  {
    "mbbill/undotree",
  },
  -- cursor movement
  { 'echasnovski/mini.nvim', version = '*' },
  -- { 'echasnovski/mini.indentscope', version = '*' },
  {
    'gen740/SmoothCursor.nvim',
    config = function()
      require('smoothcursor').setup({
        type = "matrix",
        -- fancy = {enable = true},
      })
    end
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  -- minimap
  { "wfxr/minimap.vim" },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },
  -- markdown
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   opts = {},
  --   -- config = true, -- or `opts = {}`
  -- },
  -- { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && yarn install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown", "quarto" }
  --   end,
  --   ft = { "markdown", "quarto" },
  -- },
  -- Hex code color preview
  { 'norcalli/nvim-colorizer.lua' },
  -- python related
  -- { "girishji/pythondoc.vim" },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  -- live-server
  {
    'barrett-ruth/live-server.nvim',
    build = 'npm install -g live-server',
    cmd = { 'LiveServerStart', 'LiveServerStop' },
    config = true
  },
  -- screenkey
  {
    "NStefan002/screenkey.nvim",
    lazy = false,
    version = "*", -- or branch = "dev", to use the latest commit
  },
  -- AI
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup({
        enable_chat = true,
        language_server = "C:/Users/ytcai/AppData/Local/codeium/",
      })
    end
  },
  -- note taking
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
      "nvim-treesitter/nvim-treesitter",
    } },
  },
  -- terminal
  {
   'akinsho/toggleterm.nvim',
    version = "*",
    config = true
  }
}
)
