-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

-- shortcuts
local pc = funcs.protectedCall

-- options
pc('setup.options')

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
pc('setup.plug.lscomp')

-- navigation
pc('setup.plug.navigation')

-- keys setup and extensions keymap
pc('setup.plug.keymaps')

-- apperance
pc('ui.setup')
