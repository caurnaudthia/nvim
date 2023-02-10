-- required files
local ok1, funcs = pcall(require, 'functions.luarc')
if not ok1 then print('luarc functions failed to load') end
local ok2, plugins = pcall(require, 'plugins')
if not ok2 then print('plugins file failed to load') end
local ok4, blankline = pcall(require, 'indent_blankline')
if not ok4 then print('blankline failed to load') end

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
  cc = '100', -- column size indicator
  showtabline = 2, -- always show the tab line

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

-- keybinds

funcs.setAll(options)

-- colorscheme
vim.cmd([[
  syntax enable
  colorscheme duskfox
]])

-- plugin initialization

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.g.coq_settings = {["auto_start"] = "shut-up", ["clients.lsp.enabled"] = true}
require('mason').setup()
require('mason-lspconfig').setup()

require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = false,
    show_current_context_start = false,
}

-- appearance

require('gitsigns').setup()
require('ui.feline')
require('ui.tabby')
