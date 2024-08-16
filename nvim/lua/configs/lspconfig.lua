-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local servers = {
  html = {
    filetypes = { "htm", "html" },
  },
  cssls = {
    filetypes = { "css" },
  },
  tsserver = {
    filetypes = { "js", "jsx", "ts", "tsx" },
  },
  marksman = {
    filetypes = { "md" },
  },
  asm_lsp = {
    filetypes = { "s" },
  },
  clangd = {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    root_dir = util.root_pattern(
      ".clangd",
      ".clang-tidy",
      ".clang-format",
      "compile_commands.json",
      "compile_flags.txt",
      "configure.ac",
      ".git"
    ),
  },
  gopls = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
        gofumpt = true,
      },
    },
  },
}

-- lsps with default config
for key, lsp in pairs(servers) do
  local lsp_config = {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }

  for k, v in pairs(lsp) do
    lsp_config[k] = v
  end

  -- print(vim.inspect(lsp_config))
  lspconfig[key].setup(lsp_config)
end

-- lspconfig.gopls.setup({
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "gopls" },
--   filetypes = { "go", "gomod", "gowork", "gotmpl" },
--   root_dir = util.root_pattern("go.work", "go.mod", ".git"),
--   settings = {
--     gopls = {
--       completeUnimported = true,
--       usePlaceholders = true,
--       analyses = {
--         unusedparams = true,
--       },
--       staticcheck = true,
--       gofumpt = true,
--     },
--   },
-- })
