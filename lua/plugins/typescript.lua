-- TypeScript/JavaScript configuration with ESM support
-- This configures tsserver to properly handle ECMAScript Modules

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- Configure tsserver (TypeScript Language Server) for ESM support
      opts.servers.tsserver = vim.tbl_deep_extend("force", opts.servers.tsserver or {}, {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "minimal",
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
            preferences = {
              importModuleSpecifier = "non-relative",
              importModuleSpecifierEnding = "minimal",
            },
          },
        },
        on_attach = function(client, bufnr)
          -- Disable tsserver formatting (use Prettier instead)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
      })

      return opts
    end,
  },
}
