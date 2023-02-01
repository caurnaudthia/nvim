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

  -- display
  use 'lukas-reineke/indent-blankline.nvim'
  use 'romgrk/barbar.nvim'
  use 'feline-nvim/feline.nvim'
  
  -- navigation
  use 'ggandor/lightspeed.nvim'
  use 'nanozuki/tabby.nvim'
  use 'tpope/vim-repeat'
  use {'folke/which-key.nvim', config = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
    require("which-key").setup() end}
  use {'nvim-telescope/telescope.nvim', tag = '0.1.1'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  -- completion
  use {'ms-jpq/coq_nvim', branch = 'coq'}
    use {'ms-jpq/coq.artifacts', branch = 'artifacts'}
    use {'ms-jpq/coq.thirdparty', branch = '3p'}


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
