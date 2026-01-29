-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end
local _, wk = funcs.protectedCall('which-key')
wk.add({
  --ungrouped
  {'-', '<cmd>Oil<cr>', desc = 'open file parent'},
  {'<c-`>', '<C-\\><C-n>', desc = 'escape terminal', mode = 't'},
  {'s', '<Plug>(leap-forwards)', desc = 'leap forwards', mode = {'n', 'x', 'o'}},
  {'S', '<Plug>(leap-backwards)', desc = 'leap backwards', mode = {'n', 'x', 'o'}},
})
wk.register({
  ['-'] = {'<cmd>Oil<cr>', 'open file parent'},
})
wk.register({
  ['<c-Esc>'] = {'<C-\\><C-n>', 'escape terminal'}
}, {mode = 't'})
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
    i = {'<cmd>LspInfo<CR>', 'LSP info'},
    l = {'<cmd>lua vim.lsp.buf.hover()<CR>', 'Line Readout'},
    c = {'<cmd>COQnow -s<CR>', 'Start Autocomplete'},
    f = {'<cmd>lua vim.lsp.buf.format()<cr>', 'Reformat'},
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
  z = {'<cmd>ZenMode<cr>', 'focus mode'},
  W = {'g<c-g>', 'word count'},
  h = {'<cmd>set tw=0<cr>', 'disable linebreak insertion'},
}, {prefix = '<leader>'})
