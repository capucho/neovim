-- Python LSP configuration with UV support
-- This configures pyright and pylsp to use UV-managed Python environments

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local python_helpers = require("config.python-helpers")

      -- Override Python LSP server configurations
      opts.servers = opts.servers or {}
      
      -- Configure pyright to use UV Python
      opts.servers.pyright = vim.tbl_deep_extend("force", opts.servers.pyright or {}, {
        settings = {
          pyright = {
            -- This will be set dynamically per project
            autoImportCompletions = true,
            typeCheckingMode = "basic",
          },
          python = {
            -- UV typically creates .venv in project root
            venvPath = ".",
            venv = ".venv",
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
        before_init = function(_, config)
          -- Set Python path dynamically when server starts
          local python_path = python_helpers.get_python_path()
          if python_path then
            config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
              python = {
                pythonPath = python_path,
              },
            })
          end
        end,
      })

      -- Configure pylsp to use UV Python
      opts.servers.pylsp = vim.tbl_deep_extend("force", opts.servers.pylsp or {}, {
        settings = {
          pylsp = {
            plugins = {
              jedi = {
                -- This will be set dynamically
                environment = nil, -- Will be set in before_init
              },
              jedi_completion = {
                eager = true,
              },
              pycodestyle = {
                enabled = false,
              },
              pyflakes = {
                enabled = true,
              },
            },
          },
        },
        before_init = function(_, config)
          -- Set Python environment dynamically when server starts
          local python_path = python_helpers.get_python_path()
          if python_path then
            config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
              pylsp = {
                plugins = {
                  jedi = {
                    environment = python_path,
                  },
                },
              },
            })
          end
        end,
      })

      return opts
    end,
  },
}
