-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

local function concatWKEntry(target, mapping, desc, opts, override)
  -- generate concatenated key
  local key = ''
  for _, v in pairs(target) do
    key = key .. v
  end
  -- generate mapping string
  if not override then
    mapping = '<cmd>' .. mapping .. '<cr>'
  end
  -- generate binding table
  local binding = {key, mapping, desc = desc}
  -- if additional options are needed, add the following
  if opts ~= nil then
    for k, v in pairs(opts) do
      binding[k] = v
    end
  end
  return binding
end

local LEADER = '<leader>'
local _, wk = funcs.protectedCall('which-key')

-- unleaded keybinds
wk.add({
  concatWKEntry({'-'}, 'Oil', 'open file parent'),
  concatWKEntry({'<c-`>'}, '<C-\\><C-n>', 'escape terminal', {mode = 't'}, true), 
  concatWKEntry({'s'}, '<Plug>(leap)', 'leap current window', {mode = {'n', 'x', 'o'}}, true),
  {'s', '<Plug>(leap)', desc = 'leap current window', mode = {'n', 'x', 'o'}},
  concatWKEntry({'S'}, '<Plug>(leap-from-window)', 'leap other windows', {mode = {'n', 'x', 'o'}}, true),
})

-- ungrouped keybinds
local pre = LEADER
wk.add({
  concatWKEntry({pre, 'n'}, 'noh', 'clear search highlights'),
  concatWKEntry({pre, 'm'}, 'Mason', 'load lsp manager'),
  concatWKEntry({pre, 'p'}, 'Lazy home', 'plugin manager'),
  concatWKEntry({pre, 'z'}, 'ZenMode', 'focus mode'),
  concatWKEntry({pre, 'W'}, 'g<c-g>', 'get word count'),
  concatWKEntry({pre, 'h'}, 'set tw=0', 'disable text autowrap'),
})

-- telescope / search / files keybinds
pre = LEADER .. 'f'
wk.add({
  {pre, group = 'telescope/search/files'},
  concatWKEntry({pre, 'b'}, 'Telescope file_browser path=%:p:h select_buffer=true', 'telescope file browser'),
  concatWKEntry({pre, 'o'}, 'Oil --float', 'open file parent in floating window'),
  concatWKEntry({pre, 'p'}, 'lua require"telescope".extensions.project.project{}', 'open projects picker'),
})

-- diagnostic keybinds
pre = LEADER .. 'd'
wk.add({
  {pre, group = 'diagnostics'},
  concatWKEntry({pre, 'f'}, 'lua vim.diagnostic.goto_prev()', 'go to previous diagnostic'),
  concatWKEntry({pre, 'j'}, 'lua vim.diagnostic.goto_next()', 'go to next diagnostic'),
  concatWKEntry({pre, 'F'}, 'lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})', 'go to previous error'),
  concatWKEntry({pre, 'J'}, 'lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR}))', 'go to next error'),
})

-- tab keybinds
pre = LEADER .. 'a'
wk.add({
  {pre, group = 'tabs'},
  concatWKEntry({pre, 't'}, '$tabnew', 'open new tab'),
  concatWKEntry({pre, 'w'}, 'tabclose', 'close tab'),
  concatWKEntry({pre, 'W'}, 'tabonly', 'close all other tabs'),
  concatWKEntry({pre, '<tab>'}, 'tabn', 'next tab'),
  concatWKEntry({pre, '<s-tab>'}, 'tabp', 'previous tab'),
  concatWKEntry({pre, ','}, 'move tab left'),
  concatWKEntry({pre, '.'}, 'move tab right'),
  concatWKEntry({pre, '0'}, 'tabl', 'open last tab'),
})
for i=1,9 do wk.add({concatWKEntry({pre, i}, 'tabn ' .. i, 'open tab ' .. i)}) end

-- language server actions
pre = LEADER .. 'l'
wk.add({
  {pre, group = 'language server actions'},
  concatWKEntry({pre, 'r'}, 'lua vim.lsp.buf.rename()', 'rename'),
  concatWKEntry({pre, 'a'}, 'lua vim.lsp.buf.code_action()', 'code action'),
  concatWKEntry({pre, 'd'}, 'lua vim.diagnostic.open_float()', 'line diagnostics'),
  concatWKEntry({pre, 'i'}, 'LspInfo', 'LSP info'),
  concatWKEntry({pre, 'c'}, 'COQnow -s', 'start autocomplete'),
  concatWKEntry({pre, 'f'}, 'lua vim.lsp.buf.format()', 'reformat'),
})

-- goto actions
pre = LEADER .. 'g'
wk.add({
  {pre, group = 'goto actions'},
  concatWKEntry({pre, 'd'}, 'lua vim.lsp.buf.definition()', 'definition'),
  concatWKEntry({pre, 'D'}, 'lua vim.lsp.buf.declaration()', 'declaration'),
  concatWKEntry({pre, 's'}, 'lua vim.lsp.buf.signarure_map()', 'signature help'),
  concatWKEntry({pre, 'i'}, 'lua vim.lsp.buf.implementation()', 'implementation'),
  concatWKEntry({pre, 't'}, 'lua vim.lsp.buf.type_definition()', 'type definition'),
})

-- whichkey actions
pre = LEADER .. 'w'
wk.add({
  {pre, group = 'whichkey'},
  concatWKEntry({pre, 'a'}, 'WhichKey', 'show all normal'),
  concatWKEntry({pre, 'A'}, 'WhichKey \'\' v', 'show all visual'),
  concatWKEntry({pre, 'r'}, 'WhichKey "', 'show all registers'),
  concatWKEntry({pre, 'm'}, 'WhichKey `', 'show all marks'),
})

-- session actions
pre = LEADER .. 's'
wk.add({
  {pre, group = 'session'},
  concatWKEntry({pre, 's'}, 'mks! .vimsess', 'save current folder'),
  concatWKEntry({pre, 'l'}, 'so .vimsess', 'load current folder'),
})
