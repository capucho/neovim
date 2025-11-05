return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "marilari88/neotest-vitest",
      "nvim-neotest/neotest-python",
    },
    keys = {
      {
        "<leader>tl",
        function()
          require("neotest").run.run_last()
        end,
        desc = "Run Last Test",
      },
      {
        "<leader>tL",
        function()
          require("neotest").run.run_last({ strategy = "dap" })
        end,
        desc = "Debug Last Test",
      },
      {
        "<leader>tw",
        function()
          require("neotest").run.run({ strategy = "watch" })
        end,
        desc = "Run Watch (Vitest)",
      },
      {
        "<leader>to",
        function()
          require("neotest").output.open({ enter = true })
        end,
        desc = "Open Test Output",
      },
      {
        "<leader>tp",
        function()
          require("neotest").output_panel.toggle()
        end,
        desc = "Toggle Output Panel",
      },
    },
    opts = function(_, opts)
      opts.adapters = opts.adapters or {}

      -- Prioritize Vitest as the main testing framework
      -- Vitest automatically detects ESM modules via package.json "type": "module"
      table.insert(opts.adapters, require("neotest-vitest")({
        -- Vitest automatically handles ESM when package.json has "type": "module"
        -- or when using .mjs/.mts extensions
        filter_dir = function(name, rel_path, root)
          return name ~= "node_modules"
        end,
      }))

      -- Import Python helper for UV support
      local python_helpers = require("config.python-helpers")
      table.insert(opts.adapters, require("neotest-python")({
        runner = "pytest",
        python = function()
          return python_helpers.get_python_path()
        end,
      }))
    end,
  },
}
