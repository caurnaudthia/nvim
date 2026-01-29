-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end
funcs.protectedCall('ui.banners')

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
