-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

-- options
require('setup.options')

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
lazy.setup(require('setup.plugins'))

-- completion and language setup
require('setup.plug.lscomp')

-- navigation
require('setup.plug.navigation')

-- keys setup and extensions keymap
require('setup.plug.keymaps')

-- apperance
require('ui.setup')
