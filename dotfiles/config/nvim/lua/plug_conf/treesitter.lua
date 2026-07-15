local DISABLE_HIGHLIGHT_THRESHOLD = 30000

local ts = require("nvim-treesitter")

local ensure_installed = {
  "bash",
  "c",
  "cpp",
  "css",
  "go",
  "html",
  "javascript",
  "lua",
  "python",
  "ruby",
  "rust",
  "sql",
  "typescript",
  "yaml",
}

ts.install(ensure_installed)

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("TreesitterHighlight", {}),
  callback = function(args)
    local buf = args.buf
    if vim.api.nvim_buf_line_count(buf) > DISABLE_HIGHLIGHT_THRESHOLD then
      return
    end
    local lang = vim.treesitter.language.get_lang(vim.bo[buf].filetype)
    if not lang or not vim.tbl_contains(ts.get_available(), lang) then
      return
    end
    -- auto-install missing parsers, then attach (no-op install if present)
    ts.install(lang):await(function()
      if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.treesitter.start, buf, lang)
      end
    end)
  end,
})
