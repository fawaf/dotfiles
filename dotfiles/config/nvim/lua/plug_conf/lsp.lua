require("mason").setup()

local cmp_nvim_lsp = require("cmp_nvim_lsp")

local function lspsetup(server, opts)
  vim.lsp.config(server, opts or {})
  vim.lsp.enable(server)
end

lspsetup("bashls")
lspsetup("clangd")
lspsetup("docker_compose_language_service")
lspsetup("dockerls")
lspsetup("lemminx")
lspsetup("lua_ls")
lspsetup("marksman")
lspsetup("pyright")
lspsetup("solargraph")
lspsetup("yamlls")
lspsetup("clangd")

lspsetup("gopls", {
  settings = {
    gopls = {
      env = {
          GOFLAGS = "-tags=windows,linux,unittest,integration,unit"
      }
    }
  }
})

lspsetup("sqlls", {
  root_dir = function(fname)
    return lspsetup.util.find_git_ancestor(fname) or vim.fn.getcwd()
  end,
})

lspsetup("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        disabled = { "inactive-code" },
      },
      cargo = {
        features = "all",
      },
    },
  },
})

-- web-frontend
lspsetup("tailwindcss")
lspsetup("vtsls")
lspsetup("cssls", {
  capabilities = cmp_nvim_lsp.default_capabilities(),
})
-- Need the following: npm i -g vscode-langservers-extracted
lspsetup("html", {
  capabilities = cmp_nvim_lsp.default_capabilities(),
  filetypes = { "html", "htmldjango" },
})

-- This is actually very annoying
-- lsp_signature UI tweaks
--require("lsp_signature", {
  --bind = true,
  --timer_interval = 350,
  --handler_opts = {
    --border = "rounded",
  --},
--})

-- LSP diagnostics
vim.diagnostic.config {
    float = { border = "single" },
    underline = true,
    virtual_text = false,
    virtual_lines = false
}

vim.lsp.handlers.hover = function()
  vim.lsp.handlers.hover({
    border = "single"
  })
end
vim.lsp.config('*', {
  handlers = {
    ["textDocument/hover"] = vim.lsp.handlers.hover,
}})

-- Key bindings to be set after LSP attaches to buffer
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("Userlspsetup", {}),
  callback = function(ev)
    vim.api.nvim_buf_set_option(ev.buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
    vim.api.nvim_buf_set_option(ev.buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")

    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    --vim.keymap.set("n", "gr", vim.lsp.buf.references, opts) SEE telescope.lua
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})
