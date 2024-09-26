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
    name = 'rose-pine',
    opts = {
      italic = false
    }
  },
  {
    'yorickpeterse/vim-paper',
    lazy = false,
    priority = 1000
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
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = true,
    opts = ...
  },
  {
    "kepano/flexoki-neovim",
    priority = 1000,
  },
  {
    'cryptomilk/nightcity.nvim',
    version = '*'
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
        borderless_telescope = true,
        terminal_colors = true,
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
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
  { "maxmx03/dracula.nvim" },
  -- status line
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      function(_, opts)
        local trouble = require("trouble")
        local symbols = trouble.statusline({
          mode = "lsp_document_symbols",
          groups = {},
          title = false,
          filter = { range = true },
          format = "{kind_icon}{symbol.name:Normal}",
          -- The following line is needed to fix the background color
          -- Set it to the lualine section you want to use
          hl_group = "lualine_c_normal",
        })
        table.insert(opts.sections.lualine_c, {
          symbols.get,
          cond = symbols.has,
        })
      end
    },
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
  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    -- tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
                "<Cmd>lua require('r.run').action('head', 'n', ', n = 5')<CR>", {})
            end
          end
        },
        min_editor_width = 80,
        objbr_w = 30,
        objbr_place = "script,right",
        rconsole_width = 0,
        rconsole_height = 10,
        disable_cmds = {
          -- "RDSendLine",
          "RCustomStart",
          "RSPlot",
          "RSaveClose",
        },
        -- active_window_warn = false,
        Rout_more_colors = true,
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
  { 'Vigemus/iron.nvim' }, -- iron
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
        ensure_installed = {
          "c", "lua", "vim", "vimdoc",
          "javascript", "html", "r", "python", "julia", "markdown", "bash",
          "rnoweb", "markdown_inline", "html", "json", "typescript"
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
    dependencies = { "rafamadriz/friendly-snippets" },
    -- build = "make install_jsregexp"
  },
  { 'saadparwaiz1/cmp_luasnip' },
  -- nvim-cmp
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-calc' },
  { 'hrsh7th/cmp-emoji' },
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      max_width = 100,
      floating_window_off_x = 3,
      handler_opts = {
        border = "single"
      },
      doc_lines = 0
    },
    config = function(_, opts) require 'lsp_signature'.setup(opts) end
  },
  -- comment
  {
    'numToStr/Comment.nvim',
    opts = {},
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
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --     'echasnovski/mini.nvim',
  --     -- version = '*'
  --   }
  -- },
  -- undo tree
  {
    "mbbill/undotree",
  },
  -- cursor movement
  -- { 'echasnovski/mini.indentscope', version = '*' },
  { 'echasnovski/mini.nvim',      version = '*' },
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
    opts = {}
  },
  -- markdown
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown', -- Only needed if you have another plugin named markdown.nvim
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    config = function()
      require('render-markdown').setup({
        file_types = { 'markdown', 'quarto', 'vimwiki', 'vimdoc' }
      })
    end,
  },
  -- {
  --   "ellisonleao/glow.nvim",
  --   config = true,
  --   cmd = "Glow"
  -- },
  -- {
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = function() vim.fn["mkdp#util#install"]() end,
  --   ft = { "markdown" },
  -- },
  -- docs
  {
    "roobert/hoversplit.nvim",
    config = function()
      require("hoversplit").setup({
        key_bindings = {
          split_remain_focused = "<leader>hs",
          vsplit_remain_focused = "<leader>hv",
          split = "<leader>hS",
          vsplit = "<leader>hV",
        },
      })
    end,
  },
  -- debuggin
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
  -- colorizer
  { 'norcalli/nvim-colorizer.lua' },
  -- python related
  -- jupyter notebook for python
  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
  },
  -- { "rcarriga/nvim-notify" }, -- optional
  { "stevearc/dressing.nvim" }, -- optional, UI for :JupyniumKernelSelect
  -- live-server for web dev
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
      })
    end
  },
  -- buffer navigation
  {
    "leath-dub/snipe.nvim",
    keys = {
      {
        "<Leader>sb",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu"
      }
    },
    opts = {
      ui = {
        position = "cursor"
      }
    }
  },
  -- note taking
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
  },
  -- terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = true
  },
  -- diagnostics
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    config = function()
      require('tiny-inline-diagnostic').setup()
    end
  },
  -- git
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",  -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
      -- "ibhagwan/fzf-lua",            -- optional
      -- "echasnovski/mini.pick",       -- optional
    },
    config = true
  }

}
)
