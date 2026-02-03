local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end
return {
  -- CORE
  {'nvim-lua/plenary.nvim'},

  -- THEMES and APPEARANCE
  {
    --'rose-pine/neovim',
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme rose-pine]])
    end,
  },
  {'lukas-reineke/indent-blankline.nvim', main = 'ibl', opts = {} }, -- indentation hints
  {'nvim-tree/nvim-web-devicons', lazy = false}, -- icons
  {'lewis6991/gitsigns.nvim', lazy = false}, -- git actions
  {'feline-nvim/feline.nvim', lazy = false}, -- bottomline
  {'nanozuki/tabby.nvim', lazy = false}, -- tab bar
  {'folke/zen-mode.nvim', lazy = false}, -- focus mode

  -- LANGUAGE SERVERS
  {'williamboman/mason.nvim', lazy = false},
  {'williamboman/mason-lspconfig.nvim', lazy = false},
  {'neovim/nvim-lspconfig', lazy = false},

  -- LANGUAGE UTILITIES
  {"folke/lazydev.nvim", ft = "lua", lazy = false,
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {'iamcco/markdown-preview.nvim',
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {"hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        jump_next_row = { "<Enter>", mode = { "n", "v" } },
        jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },

  -- COMPLETION
  {'ms-jpq/coq_nvim', lazy = false, branch = 'coq'},
  {'ms-jpq/coq.artifacts', lazy = false, branch = 'artifacts'},
  {'ms-jpq/coq.thirdparty', lazy = false, branch = '3p'},

  -- NAVIGATION
  {'tpope/vim-repeat', lazy = false},
  {'andyg/leap.nvim', url='https://codeberg.org/andyg/leap.nvim.git', lazy = false},
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {}
  },
  {'stevearc/oil.nvim', lazy = false},
  {
    'goolord/alpha-nvim', lazy = false,
    config = function ()
      local _, dashboard = funcs.protectedCall('alpha.themes.dashboard')
      funcs.protectedSetup('alpha', dashboard.config)
    end
  },
  {
    'nvim-telescope/telescope.nvim', lazy = false,
    branch = '0.1.x',
  },
  {'nvim-telescope/telescope-file-browser.nvim', lazy = false},

  -- SESSION MANAGEMENT
  {'nvim-telescope/telescope-project.nvim', lazy = false},
  {'folke/persistence.nvim', event = 'BufReadPre'}
}
