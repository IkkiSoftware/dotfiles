return require('packer').startup(function()
	-- Packer can manage itself
	use 'wbthomason/packer.nvim' -- Package manager
	use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
	use({
		'onsails/lspkind-nvim',
		config = function()
			require('lspkind').init({
				with_text = true,
				symbol_map = {
					Text = "",
					Method = "",
					Function = "",
					Constructor = "",
					Field = "ﰠ",
					Variable = "",
					Class = "ﴯ",
					Interface = "",
					Module = "",
					Property = "ﰠ",
					Unit = "塞",
					Value = "",
					Enum = "",
					Keyword = "",
					Snippet = "",
					Color = "",
					File = "",
					Reference = "",
					Folder = "",
					EnumMember = "",
					Constant = "",
					Struct = "פּ",
					Event = "",
					Operator = "",
					TypeParameter = ""
				},
			})
		end,
	})

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
