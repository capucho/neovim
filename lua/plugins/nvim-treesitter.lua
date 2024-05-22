return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "dockerfile",
        "yaml",
        "ron",
        "rust",
        "toml",
        "terraform",
        "hcl",
        "typescript",
        "tsx",
        "json",
        "json5",
        "jsonc",
        "markdown",
        "markdown_inline",
      })
    end
  end,
}
