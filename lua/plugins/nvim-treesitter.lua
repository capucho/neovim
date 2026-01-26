return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "dockerfile",
        "yaml",
        "toml",
        "terraform",
        "hcl",
        "typescript",
        "tsx",
        "go",
        "json",
        "json5",
        "jsonc",
        "markdown",
        "markdown_inline",
        "python",
        "cpp",
        "c",
      })
    end
  end,
}
