local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- package manager
  use 'wbthomason/packer.nvim'
  use 'williamboman/mason.nvim'

  -- core
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }

  -- language server
  use 'williamboman/mason-lspconfig.nvim'
  use 'mfussenegger/nvim-jdtls'
  use { 'neovim/nvim-lspconfig', config = function() 
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { "lua_ls", "html", "jsonls", "pyright", "vimls" }
    })

    -- see :h mason-lspconfig-automatic-server-setup
    require('mason-lspconfig').setup_handlers({
      function (server_name)
        local on_attach = function(client, bufnr) 
            vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            vim.api.nvim_buf_set_option(0, "formatexpr", "v:lua.vim.lsp.formatexpr()")
            require('config.lsp.keymaps').setup(client, bufnr)
        end
        require('lspconfig')[server_name].setup({
          on_attach = on_attach,
          flags = {
            debounce_text_changes = 150, 
          },
        })
      end
    })
  end}

  -- display
  use 'lukas-reineke/indent-blankline.nvim'
  use 'feline-nvim/feline.nvim'
  
  -- navigation
  use 'ggandor/lightspeed.nvim'
  use 'nanozuki/tabby.nvim'
  use 'tpope/vim-repeat'
  use {'folke/which-key.nvim', config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup() end}
  use 'BurntSushi/ripgrep' 
  use {'nvim-telescope/telescope.nvim', tag = '0.1.1'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  -- completion
  -- use {'ms-jpq/coq_nvim', branch = 'coq'}
  --   use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
  --   use {'ms-jpq/coq.thirdparty', branch = '3p'}


  -- themes
  -- use 'bluz71/vim-nightfly-colors'
  -- use 'drewtempelmeyer/palenight.vim'
  -- use 'unrealjo/neovim-purple'
  -- use 'edeneast/nightfox.nvim'
  -- use 'lunarvim/horizon.nvim'
  use 'EdenEast/nightfox.nvim'

  -- misc
  use 'lewis6991/gitsigns.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'kyazdani42/nvim-web-devicons'

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
