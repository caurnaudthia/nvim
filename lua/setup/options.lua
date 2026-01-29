-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

local options =
{
  -- tabbing and whitespace autoindent = true, -- automated indentation
  expandtab = true, -- tab -> whitespace
  tabstop = 2, -- size of tab
  softtabstop = 2, -- how many spaces equals a tab
  shiftwidth = 2, -- width of autotab
  wrap = true, -- wrap oversized lines
  linebreak = true,
  textwidth = 0,

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
  termguicolors = true, -- allows for 24 bit colors
}

vim.g.mapleader = ' '
vim.g.mmaplocalleader = ' '
funcs.setAll(options)
