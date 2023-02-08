-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local zero_ok, zero = pcall(require, "lsp-zero")

-- show icons for diagnostics in the left gutter
local signs = {
  Error = "",
  Warn = "",
  Hint = "",
  Info = "",
}

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

if not zero_ok then
  return
end

local servers = { -- these will be automatically installed
  "clangd",
  "cmake",
  "sumneko_lua",
}

zero.preset('recommended')
zero.ensure_installed(servers)

zero.on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    local navic_ok, navic = pcall(require, "nvim-navic")

    if navic_ok then
      navic.attach(client, bufnr)
    end
  end
end

zero.nvim_workspace()
zero.setup()
