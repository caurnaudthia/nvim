local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

-- options
local options =
{
  wrap = true,
  linebreak = true,
  textwidth = 0
}
funcs.setAll(options)
