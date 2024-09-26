-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local opts = { noremap = true, silent = true }
local nvim_lsp = require('lspconfig')

-- keymaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  client = client
  -- navbuddy.attach(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)

  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  -- debounce_text_changes = 150,
}
require('lspconfig')['pylsp'].setup {
  autostart = true,
  on_attach = on_attach,
  cmd = { 'pylsp.cmd' },
  filetypes = { 'python' },
  capabilities = capabilities
}
require('lspconfig')['ts_ls'].setup {
  on_attach = on_attach,
  cmd = { 'typescript-language-server.cmd', '--stdio' },
  filetypes = {
    "javascript", "javascriptreact", "javascript.jsx",
    "typescript", "typescriptreact", "typescript.tsx" },
  capabilities = capabilities,
  root_dir = nvim_lsp.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
  single_file_support = true,
  init_options = { hostInfo = 'neovim' }
}
-- require('lspconfig')['denols'].setup {
--   on_attach = on_attach,
--   cmd = { 'deno.cmd', 'lsp' },
--   filetypes = {
--     "javascript", "javascriptreact", "javascript.jsx",
--     "typescript", "typescriptreact", "typescript.tsx" },
--   capabilities = capabilities,
--   cmd_env = {
--     NO_COLOR = true
--   },
--   single_file_support = true,
--   root_dir = nvim_lsp.util.root_pattern { "deno.json", "deno.jsonc", ".git" },
--   init_options = { hostInfo = 'neovim' }
-- }
require('lspconfig')['marksman'].setup {
  on_attach = on_attach,
  -- flags = lsp_flags,
  cmd = { 'marksman.cmd' },
  filetypes = { 'markdown', 'quarto' },
  capabilities = capabilities
}
require('lspconfig')['lua_ls'].setup {
  autostart = true,
  on_attach = on_attach,
  -- flags = lsp_flags,
  cmd = { 'lua-language-server.cmd' },
  -- let the server recognize global variable vim
  settings = {
    Lua = {
      diagnostics = {
        globals = { 'vim' }
      }
    }
  },
  capabilities = capabilities
}
require('lspconfig')['julials'].setup {
  autostart = true,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { 'julia-lsp.cmd' },
  filetypes = { 'julia' },
  capabilities = capabilities
}
require('lspconfig')['r_language_server'].setup {
  autostart = true,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { 'Rterm.exe', '--slave', '-e', 'languageserver::run()' },
  -- cmd = { 'r-languageserver.cmd' },
  filetypes = { 'r', 'quarto' },
  capabilities = capabilities
}
require('lspconfig')['jsonls'].setup {
  autostart = true,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { 'vscode-json-language-server.cmd', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  capabilities = capabilities
}
require('lspconfig')['powershell_es'].setup {
  autostart = true,
  on_attach = on_attach,
  flags = lsp_flags,
  bundle_path = "C:\\Users\\DSET\\AppData\\Local\\nvim-data\\mason\\packages\\powershell-editor-services",
  shell = "pwsh.exe",
  filetypes = { 'ps1' },
  capabilities = capabilities
}
require('lspconfig')['bashls'].setup {
  autostart = true,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { 'bash-language-server.cmd', 'start' },
  filetypes = { 'sh' },
  capabilities = capabilities,
  settings = {
    bashIde = {
      globPattern = "*@(.sh|.inc|.bash|.command)"
    }
  },
  single_file_support = true
}
require('lspconfig')['html'].setup {
  autostart = true,
  on_attach = on_attach,
  flags = lsp_flags,
  cmd = { 'vscode-html-language-server.cmd', '--stdio' },
  filetypes = { 'html', 'templ' },
  capabilities = capabilities,
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true
    },
    provideFormatter = true
  },
  single_file_support = true
}
