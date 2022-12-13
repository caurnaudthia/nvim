-- required files
local ok1, funcs = pcall(require, 'functions.luarc')
if not ok1 then print('luarc functions failed to load') end
local ok2, plugins = pcall(require, 'plugins')
if not ok2 then print('plugins file failed to load') end
local ok3, lualine = pcall(require, 'lualine')
if not ok3 then print('lualine failed to load') end

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

-- barbar
-- move to prev/next
funcs.nmap('<A-,>', '<CMD>BufferPrevious<CR>')
funcs.nmap('<A-.>', '<CMD>BufferNext<CR>')

-- reorder to prev/next
funcs.nmap('<A-<>', '<CMD>BufferMovePrevious<CR>')
funcs.nmap('<A->>', '<CMD>BufferMoveNext<CR>')

-- goto buffer in position
funcs.nmap('<A-1>', '<CMD>BufferGoto 1<CR>')
funcs.nmap('<A-2>', '<CMD>BufferGoto 2<CR>')
funcs.nmap('<A-3>', '<CMD>BufferGoto 3<CR>')
funcs.nmap('<A-4>', '<CMD>BufferGoto 4<CR>')
funcs.nmap('<A-5>', '<CMD>BufferGoto 5<CR>')
funcs.nmap('<A-6>', '<CMD>BufferGoto 6<CR>')
funcs.nmap('<A-7>', '<CMD>BufferGoto 7<CR>')
funcs.nmap('<A-8>', '<CMD>BufferGoto 1<CR>')
funcs.nmap('<A-9>', '<CMD>BufferGoto 9<CR>')
funcs.nmap('<A-0>', '<CMD>BufferLast<CR>')

-- wipeout commands
funcs.nmap('<c-?>', '<CMD>BufferCloseAllButCurrent<CR>')
funcs.nmap('<c-,>', '<CMD>BufferCloseBuffersLeft<CR>')
funcs.nmap('<c-.>', '<CMD>BufferCloseBuffersRight<CR>')
funcs.nmap('<c-<>', '<CMD>BufferCloseAllButPinned<CR>')
funcs.nmap('<c->>', '<CMD>BufferCloseAllButCurrentOrPinned<CR>')

-- buffer-picking mode
funcs.nmap('<C-p>', '<CMD>BufferPick<CR>')

-- autosort by...
funcs.nmap('<Space>bb', '<CMD>BufferOrderByBufferNumber<CR>')
funcs.nmap('<Space>bd', '<CMD>BufferOrderByDirectory<CR>')
funcs.nmap('<Space>bl', '<CMD>BufferOrderByLanguage<CR>')
funcs.nmap('<Space>bw', '<CMD>BufferOrderByWindowNumber<CR>')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
  let g:coq_settings = { 'auto_start': 'shut-up' }
]])

-- colorscheme
vim.cmd([[
  syntax enable
  colorscheme nightfly
]])

-- lualine

lualine.setup {
  options = { theme = require'lualine.themes.nightfly' }
}
