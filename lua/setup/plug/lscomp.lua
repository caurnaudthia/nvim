-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

-- completion setup

vim.g.coq_settings = { auto_start = 'shut-up' }
local _, coq = funcs.protectedCall('coq')

-- language servers 
funcs.protectedSetup('mason')
funcs.protectedSetup('mason-lspconfig')
local coqCap = coq.lsp_ensure_capabilities({
  flags = {
    debounce_text_changes = 150
  }
})

vim.lsp.config('lua_ls', {
  Lua = {
    diagnostics = {
      globoals = { "vim" },
    },
  },
})
vim.lsp.config('lua_ls', coqCap)
vim.lsp.enable('lua_ls')

vim.lsp.config('bashls', {filetypes = {'sh', 'zsh'}})
vim.lsp.config('bashls', coqCap)
vim.lsp.enable('bashls')

-- customize signs to be something other than just text
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚',
      [vim.diagnostic.severity.WARN] = '󰀪',
      [vim.diagnostic.severity.HINT] = '󰌶',
      [vim.diagnostic.severity.INFO] = '',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ERRMSG',
      [vim.diagnostic.severity.WARN] = 'WARNMSG',
      [vim.diagnostic.severity.HINT] = 'HINTMSG',
      [vim.diagnostic.severity.INFO] = 'INFOMSG',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'ERRMSG',
      [vim.diagnostic.severity.WARN] = 'WARNMSG',
      [vim.diagnostic.severity.HINT] = 'HINTMSG',
      [vim.diagnostic.severity.INFO] = 'INFOMSG',
    },
  },
})
