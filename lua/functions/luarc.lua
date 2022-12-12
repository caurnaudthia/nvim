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

return module
