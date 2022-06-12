return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use({
    'ellisonleao/gruvbox.nvim',
    requires = { 'rktjmp/lush.nvim' },

    config = function()
      vim.g.gruvbox_contrast_dark = 'medium'
      vim.g.gruvbox_sign_column = 'bg1'
      vim.g.gruvbox_hls_highlight = 'orange'
      vim.api.nvim_exec([[ colorscheme gruvbox ]], false)
   end,
  })
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
end)
