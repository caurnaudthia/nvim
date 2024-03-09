-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end
local _, banner = funcs.protectedCall('ui.banners')
--funcs.protectedCall('plugins')

-- options
local options =
{
  -- tabbing and whitespace
  autoindent = true, -- automated indentation
  expandtab = true, -- tab -> whitespace
  tabstop = 2, -- size of tab
  softtabstop = 2, -- how many spaces equals a tab
  shiftwidth = 2, -- width of autotab
  wrap = true, -- wrap oversized lines

  -- window
  titlestring = 'vim', -- window title
  title = true, -- use title?
  number = true, -- number lines absolutely?
  relativenumber = true, -- number lines relatively
  signcolumn = 'yes', -- error column
  cursorline = true, -- highlight cursor line
  cc = '200', -- column size indicator
  showtabline = 2, -- always show the tab line
  laststatus = 2, -- always show statusline

  -- search
  showmatch = true, -- show matches
  ignorecase = true, -- ignore case in search
  hlsearch = true, -- highlight searches
  incsearch = true, -- update search as / value changes

  -- other
  mouse = 'a', -- enable mouse whereever
  undofile = true, -- enable saving undo stack to file
  compatible = false, -- disable compatibility mods
  clipboard = 'unnamedplus', -- allows for normal copy paste to function 
  termguicolors = true -- allows for 24 bit colors
}

vim.g.mapleader = ' '
vim.g.mmaplocalleader = ' '
funcs.setAll(options)

-- plugins
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

local lazy = require('lazy')
lazy.setup({
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

  -- LANGUAGE SERVERS
  {'williamboman/mason.nvim', lazy = false},
  {'williamboman/mason-lspconfig.nvim', lazy = false},
  {'neovim/nvim-lspconfig', lazy = false},

  -- COMPLETION
  {'ms-jpq/coq_nvim', lazy = false, branch = 'coq'},
  {'ms-jpq/coq.artifacts', lazy = false, branch = 'artifacts'},
  {'ms-jpq/coq.thirdparty', lazy = false, branch = '3p'},

  -- NAVIGATION
  {'tpope/vim-repeat', lazy = false},
  {'ggandor/leap.nvim', lazy = false},
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
    'goolord/alpha-nvim',
    config = function ()
      local _, dashboard = funcs.protectedCall('alpha.themes.dashboard')
      funcs.protectedSetup('alpha', dashboard.config)
    end
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
  },
  {'nvim-telescope/telescope-file-browser.nvim'},

  -- SESSION MANAGEMENT
  {'nvim-telescope/telescope-project.nvim'},
  {'folke/persistence.nvim', event = 'BufReadPre'}
})

-- keys setup and extensions keymap
local _, wk = funcs.protectedCall('which-key')
wk.register({
  ['-'] = {'<cmd>Oil<cr>', 'open file parent'},
})
wk.register({
  f = {
    name = 'telescope/search',
    b = {'<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>', 'telescope file browser'},
    o = {'<cmd>Oil --float<cr>', 'open file parent in floating window'},
    p = {'<cmd>lua require"telescope".extensions.project.project{}<cr>', 'open projects picker'}
  },
  d = {
    name = 'diagnostics',
    f = {'<cmd>lua vim.diagnostic.goto_prev()<CR>'},
    j = {'<cmd>lua vim.diagnostic.goto_next()<CR>'},
    F = {
      '<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>'},
    J = {
      '<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>'}
  },
  a = {
    name = 'tabs',
    t = {'<cmd>$tabnew<cr>', 'open new tab'},
    w = {'<cmd>tabclose<cr>', 'close tab'},
    W = {'<cmd>tabonly<cr>', 'close other tabs'},
    ['<tab>'] = {'<cmd>tabn<cr>', 'next tab'},
    ['<s-tab>'] = {'<cmd>tabp<cr>', 'previous tab'},
    [','] = {'<cmd>-tabmove<cr>', 'move tab left'},
    ['.'] = {'<cmd>+tabmove<cr>', 'move tab right'}
  },
  l = {
    name = 'language server actions',
    r = {'<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename'},
    a = {'<cmd>lua vim.lsp.buf.code_action()<CR>', 'Code Action'},
    d = {'<cmd>lua vim.diagnostic.open_float()<CR>', 'Line Diagnostics'},
    i = {'<cmd>LspInfo<CR>', 'LSP info'}
  },
  g = {
    name = 'goto actions',
    d = {'<cmd>lua vim.lsp.buf.definition()<CR>', 'Definition'},
    D = {'<cmd>lua vim.lsp.buf.declaration()<CR>', 'Declaration'},
    s = {'<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature Help'},
    I = {'<cmd>lua vim.lsp.buf.implementation()<CR>', 'Implementation'},
    t = {'<cmd>lua vim.lsp.buf.type_definition()<CR>', 'Type Definition'}
  },
  w = {
    name = 'whichkey',
    a = {'<cmd>WhichKey<CR>', 'show all normal'},
    A = {'<cmd>WhichKey \'\' v<CR>', 'show all visual'},
    r = {'<cmd>WhichKey "<CR>', 'show all registers'},
    m = {'<cmd>WhichKey `<CR>', 'show all marks'}
  },
  s = {
    name = 'sessions',
    s = {'<cmd>mks! .vimsess<cr>', 'save current folder'},
    l = {'<cmd>so .vimsess<cr>', 'load current folder'}
  },
  n = {'<cmd>noh<cr>', 'clear search highlights'},
  m = {'<cmd>Mason<cr>', 'load lsp manager'},
  p = {'<cmd>Lazy home<cr>', 'plugin manager'},
}, {prefix = '<leader>'})

-- completion setup

vim.g.coq_settings = { auto_start = 'shut-up' }
local _, coq = funcs.protectedCall('coq')


-- language servers 
funcs.protectedSetup('mason')
local _, masonlsp = funcs.protectedSetup('mason-lspconfig')
local _, lspconfig = funcs.protectedCall('lspconfig')
masonlsp.setup_handlers({
  function(server_name)
    local on_attach = function(client, bufnr)
    end
    lspconfig[server_name].setup(coq.lsp_ensure_capabilities({
      on_attach = on_attach,
      flags = {
        debounce_text_changes = 150
      }
    }))
  end,
  ['grammarly'] = function()
    lspconfig.grammarly.setup{
      filetypes = {
        'markdown',
        'text'
      }
    }
  end
})
-- customize signs to be something other than just text
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- navigation
funcs.protectedSetup('oil')
local _, telescope = funcs.protectedSetup('telescope', {

})
telescope.load_extension('file_browser')
telescope.load_extension('project')


-- apperance

funcs.protectedCall('ui.feline')
funcs.protectedCall('ui.tabby')
funcs.protectedSetup('ibl', {
  exclude = { filetypes = {
    'lspinfo',
    'packer',
    'checkhealth',
    'help',
    '',
    'dashboard',
    'mason'
  }}
})
