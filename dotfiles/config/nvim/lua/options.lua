local opt = vim.opt
opt.encoding = "utf-8"
opt.expandtab = true
opt.nu = true
opt.errorbells = true
opt.wrap = true
opt.smartcase = true
opt.swapfile = true
opt.backup = true
opt.incsearch = true
opt.autoindent = true
opt.hlsearch = false
opt.completeopt = "menu,menuone,noselect"
opt.sw = 2
opt.ts = 2
opt.sts = 2
opt.fillchars = {eob = " "}
opt.cmdheight = 0
opt.ignorecase = true
opt.undodir = "/tmp/nvim-undo/"

vim.o.laststatus = 0
vim.o.signcolumn = "yes:1"
vim.opt.backupdir = "/tmp/nvim-backup/"

-- Add timestamp as extension for backup files
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('timestamp_backupext', { clear = true }),
  desc = 'Add timestamp to backup extension',
  pattern = '*',
  callback = function()
    vim.opt.backupext = '-' .. vim.fn.strftime('%Y%m%d%H%M')
  end,
})
