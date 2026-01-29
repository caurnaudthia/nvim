-- functions file
local ok, funcs = pcall(require, 'functions.luarc')
if not ok then print('luarc functions failed to load') end

-- completion setup

vim.g.coq_settings = { auto_start = 'shut-up' }
local _, coq = funcs.protectedCall('coq')

-- language servers 
funcs.protectedSetup('mason')
funcs.protectedSetup('mason-lspconfig')
vim.lsp.config('lua_ls',coq.lsp_ensure_capabilities({
  flags = {
    debounce_text_changes = 150
  }
}))
vim.lsp.enable('lua_ls')

-- customize signs to be something other than just text
local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
