return {
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      opts.keymap = opts.keymap or {}
      opts.keymap["<Tab>"] = {
        LazyVim.cmp.map({ "snippet_forward" }),
        "fallback",
      }
      opts.keymap["<C-Space>"] = { "show" }
    end,
  },
}
