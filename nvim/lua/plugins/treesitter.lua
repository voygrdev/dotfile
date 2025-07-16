return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local ensure = {
      "lua",
      "go",
      "json",
      "javascript",
      "rust",
      "typescript",
      "tsx",
      "html",
      "css",
      "bash",
    }

    opts.ensure_installed = opts.ensure_installed or {}
    vim.list_extend(opts.ensure_installed, ensure)
  end,
}
