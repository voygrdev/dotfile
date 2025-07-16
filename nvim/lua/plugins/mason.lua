return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    local ensure = {
      "gofumpt",
      "shfmt",
      "stylua",
      "gopls",
      "json-lsp",
      "lua-language-server",
      "tailwindcss-language-server",
      "vtsls",
    }

    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, ensure)
  end,
}
