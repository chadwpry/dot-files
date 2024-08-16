local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    css = { "prettier" },
    go = { "gofumpt" },
    html = { "prettier" },
    graphql = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    json = { "prettier" },
    lua = { "stylua" },
    markdown = { "stylua" },
    python = { "isort", "black" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    yaml = { "prettier" },
  },
  format_on_save = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    conform.format({ bufnr = args.buf })
  end,
})

vim.keymap.set({ "n", "v" }, "<leader>mp", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 500,
  })
end, { desc = "Format file or range (in visual mode)" })
