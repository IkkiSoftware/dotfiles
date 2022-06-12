require('plugins')
require'lspconfig'.clangd.setup{}

-- Set the Leader key
vim.g.mapleader = ' '

-- Global options
local opts = {
  guicursor = '',
  showmatch = false,
  showmode = false,
  hlsearch = true,
  hidden = true,
  errorbells = false,
  ignorecase = true,
  smartcase = true,
  backup = false,
  undodir = vim.fn.stdpath('data') .. '/undodir',
  incsearch = true,
  termguicolors = true,
  mouse = 'a',

  -- Open new split pames to the right and the bottom
  splitbelow = true,
  splitright = true,

  -- Better display for messages
  cmdheight = 2,

  -- Better experience for diagnostics messages
  updatetime = 400,

  -- Encoding
  encoding = 'utf-8',

  syntax = 'on',
  completeopt = 'menuone,noinsert,noselect',
}

-- Window options
local wopts = {
  -- wrap
  wrap = false,

  -- display line numbers
  number = true,

  -- display relative line numbers
  relativenumber = true,

  -- Show current line
  cursorline = true,

  -- Show physicale tabulations define by stop
  list = true,

  -- Show the sign column for git-gutter (always 1 column)
  signcolumn = 'yes:1',

  -- folding options
  foldmethod = 'manual',
  foldnestmax = 10,
  foldenable = false,
  foldlevel = 2,

  -- Show tab delimiter
  listchars = {
    tab = '| ',
    -- eol = '↴',
    -- space = '⋅',
  },
}

-- Buffer options
local bopts = {
  expandtab = false,
  swapfile = false,
  undofile = true,
  tabstop = 4,
  softtabstop = 4,
  shiftwidth = 4,
  autoindent = true,
  smartindent = true,
}

for opt, val in pairs(opts) do
  vim.api.nvim_set_option(opt, val)
end

for opt, val in pairs(wopts) do
  -- Special case of 'listchars' dictionnary
  if opt == 'listchars' then
    local tmp = nil
    for k, v in pairs(val) do
      if tmp ~= nil then
        tmp = tmp .. ',' .. k .. ':' .. v
      else
        tmp = k .. ':' .. v
      end
    end
    val = tmp
  end

  vim.api.nvim_win_set_option(0, opt, val)
  vim.api.nvim_set_option(opt, val)
end

for opt, val in pairs(bopts) do
  vim.api.nvim_buf_set_option(0, opt, val)
  vim.api.nvim_set_option(opt, val)
end

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.api.nvim_exec([[ filetype plugin on ]], false)
