-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  --

  {
    "nyoom-engineering/oxocarbon.nvim",
    build = false,
    priority = 1000,
  },

  -- Configure LazyVim to load oxocarbon
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },


  -- ident blankline
  { "lukas-reineke/indent-blankline.nvim", enabled = false },

  -- disable noice in favour of snacks.nvim
  { "folke/noice.nvim", enabled = false },
}
