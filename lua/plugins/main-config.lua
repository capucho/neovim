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
    config = function()
      -- oxocarbon renders types/signatures in dim greys; brighten them
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "oxocarbon",
        callback = function()
          local set = vim.api.nvim_set_hl
          set(0, "BlinkCmpLabel", { fg = "#dde1e6" })
          set(0, "BlinkCmpLabelDetail", { fg = "#82cfff" })
          set(0, "BlinkCmpLabelDescription", { fg = "#82cfff" })
          set(0, "LspInlayHint", { fg = "#78a9ff", italic = true })
        end,
      })
    end,
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
