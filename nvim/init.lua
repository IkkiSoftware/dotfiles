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

vim.api.nvim_exec([[ filetype plugin on ]], false)