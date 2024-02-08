-- functions file
local ok1, funcs = pcall(require, 'functions.luarc')
if not ok1 then print('luarc functions failed to load') end
funcs.protectedCall('plugins')

-- options
local options =
{
  -- tabbing and whitespace
  autoindent = true, -- automated indentation
  expandtab = true, -- tab -> whitespace
  tabstop = 2, -- size of tab
  softtabstop = 2, -- how many spaces equals a tab
  shiftwidth = 2, -- width of autotab
  wrap = true, -- wrap oversized lines

  -- window
  titlestring = 'vim', -- window title
  title = true, -- use title?
  number = true, -- number lines absolutely?
  relativenumber = true, -- number lines relatively
  signcolumn = 'yes', -- error column
  cursorline = true, -- highlight cursor line
  cc = '100', -- column size indicator
  showtabline = 2, -- always show the tab line
  laststatus = 2, -- always show statusline

  -- search
  showmatch = true, -- show matches
  ignorecase = true, -- ignore case in search
  hlsearch = true, -- highlight searches
  incsearch = true, -- update search as / value changes

  -- other
  mouse = 'a', -- enable mouse whereever
  undofile = true, -- enable saving undo stack to file
  compatible = false, -- disable compatibility mods
  clipboard = 'unnamedplus', -- allows for normal copy paste to function 
  termguicolors = true -- allows for 24 bit colors
}

vim.g.mapleader = ' '
vim.g.mmaplocalleader = ' '
funcs.setAll(options)

-- keymaps

-- telescope
local ok, builtin = funcs.protectedCall('telescope.builtin')
if ok then
  funcs.nmap('<leader>ff', builtin.find_files, {})
  funcs.nmap('<leader>fg', builtin.live_grep, {})
  funcs.nmap('<leader>fb', builtin.buffers, {})
  funcs.nmap('<leader>fh', builtin.help_tags, {})
end

-- markdown
funcs.nmap('<leader>md', '<Plug>MarkdownPreviewToggle')

-- colorscheme

vim.cmd([[
  syntax enable
  colorscheme duskfox
  set tgc
]])

-- language servers

funcs.protectedSetup('mason', {})
funcs.protectedSetup('mason-lspconfig', {})

-- navigation

local ok, telescope = funcs.protectedSetup('telescope', {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
funcs.protectedFuncCall('telescope.load_extension', 'fzf')

funcs.protectedSetup('gitsigns', {})

-- treesitter

funcs.protectedSetup('nvim-treesitter.configs', {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "regex", "java", "c_sharp", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  }
})

-- appearance

funcs.protectedCall('ui.feline')
funcs.protectedCall('ui.tabby')

-- function version control

local date = os.date('%x')
local file = io.open('lua/lastchanged', 'r')

if file then
  local lastDate = file:read()
  if not lastDate == date then
    vim.cmd([[
      PackerUpdate
    ]])
    io.close()
    file = io.open('lua/lastchanged', 'w')
    io.write(date)
    io.close()
  end
end
if not file then
  file = io.open('lua/lastchanged', 'w')
  io.write(date)
  io.close()
end


