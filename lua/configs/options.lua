vim.diagnostic.config({
  virtual_text = false, -- turn off the inline
  virtual_lines = { current_line = true }, -- or current_line = true depending on version
})
vim.g.mapleader = " "

vim.opt.hlsearch = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 1
vim.opt.showmode = false
vim.opt.spell = true
vim.opt.spelllang = { "en", "fr" }
vim.opt.termguicolors = true
vim.opt.sidescrolloff = 8
vim.opt.scrolloff = 8
vim.opt.undodir = vim.fn.stdpath("cache") .. "/undo"
vim.opt.undofile = true
-- Tab stuff
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search configuration
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.gdefault = true

vim.o.winborder = "rounded"
vim.opt.completeopt = { "menu", "menuone", "noselect", "preview" }
vim.opt.clipboard = "unnamed,unnamedplus"

-- Text
--
vim.o.wrap = true
vim.o.linebreak = true


vim.o.swapfile = false

vim.filetype.add({ extension = { templ = "templ" } })
vim.filetype.add({ extension = { gohtml = "html" } })

