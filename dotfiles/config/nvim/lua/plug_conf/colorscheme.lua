local envmode = os.getenv("THEME_MODE")
local mode = require("consts").modes

require('darklight').setup({
  mode = 'colorscheme', -- Sets darklight to colorscheme mode
  light_mode_colorscheme = 'shine', -- Sets the colorscheme to use for light mode
  dark_mode_colorscheme = 'elflord', -- Sets the colorscheme to use for dark mode
})
vim.keymap.set(mode.normal, '<leader>dl', ":DarkLightSwitch<CR>", { noremap = true })

vim.o.termguicolors = true

if envmode and string.len(envmode) > 0 then
  vim.o.background = "dark"
  vim.cmd("colorscheme monoglow")
else
  vim.g.zenwritten = {
    lightness = 'bright',
    italic_comments = false,
  }
  vim.o.background = "light"

  vim.cmd("colorscheme zenwritten")
end
