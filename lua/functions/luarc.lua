-- object definition
local module = {}

-- local functions

local function errStr(name, err)
  return name .. ' failed to run. Stack traceback: \n' .. err
end

-- map a key given mode shortcut command
function module.map(mode, shortcut, ...)
	vim.keymap.set(mode, shortcut, ..., { noremap = true, silent = true })
end

-- set a vim setting
function module.set(setting, value)
	vim.opt[setting] = value
end

-- map a key in normal mode
function module.nmap(shortcut, ...)
	module.map('n', shortcut, ...)
end

-- map a key in insert mode
function module.imap(shortcut, ...)
	module.map('i', shortcut, ...)
end

-- set all settings in a table
function module.setAll(settings)
	for k, v in pairs(settings) do module.set(k, v) end
end

-- protected call to setup function
function module.protectedSetup(plugName, setup)
  local ok, plugin = pcall(require, plugName)
  if ok then plugin.setup(setup) else print(errStr(plugName, plugin)) end
  return ok, plugin
end

function module.protectedCall(scriptName)
  local ok, script = pcall(require, scriptName)
  if not ok then print(errStr(scriptName, script)) end
  return ok, script
end

function module.protectedFuncCall(funcName, ...)
  local ok, output = pcall(funcName, ...)
  if ok then print(errStr(funcName, output)) end
  return ok, output
end

return module
