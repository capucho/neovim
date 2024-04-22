-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  --
  -- Configure LazyVim to load tokyonight
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- ident blankline
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
}
