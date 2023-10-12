local module = {}

-- map a key given mode shortcut command
function module.map(mode, shortcut, command)
	vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- set a vim setting
function module.set(setting, value)
	vim.opt[setting] = value
end

-- map a key in normal mode
function module.nmap(shortcut, command)
	module.map('n', shortcut, command)
end

-- map a key in insert mode
function module.imap(shortcut, command)
	module.map('i', shortcut, command)
end

-- set all settings in a table
function module.setAll(settings)
	for k, v in pairs(settings) do module.set(k, v) end
end

-- protected call to setup function
function module.protectedSetup(plugName, setup)
  local ok, plugin = pcall(require, plugName)
  if ok then plugin.setup(setup) else print(pluginName .. ' failed to load') end
  return ok, plugin
end

function module.protectedCall(scriptName)
  local ok, script = pcall(require, scriptName)
  if not ok then print(scriptName .. ' failed to load') end
  return ok, script
end

return module
