return {
  "mfussenegger/nvim-dap",
  optional = true,
  dependencies = {
    {
      "mason-org/mason.nvim",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "js-debug-adapter")
        table.insert(opts.ensure_installed, "debugpy")
        table.insert(opts.ensure_installed, "cpptools")
      end,
    },
  },
  opts = function()
    local dap = require("dap")
    if not dap.adapters["pwa-node"] then
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          -- 💀 Make sure to update this path to point to your installation
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }
    end

    -- TypeScript/JavaScript DAP configuration with ESM support
    for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
      if not dap.configurations[language] then
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file (ESM via tsx)",
            runtimeExecutable = "npx",
            runtimeArgs = { "tsx", "${file}" },
            cwd = "${workspaceFolder}",
            skipFiles = { "<node_internals>/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            -- Enable source maps for TypeScript
            sourceMaps = true,
            outputCapture = "std",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file (ESM via node)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeExecutable = "node",
            runtimeArgs = { "--loader", "ts-node/esm" },
            env = {
              NODE_OPTIONS = "--experimental-loader ts-node/esm",
            },
            skipFiles = { "<node_internals>/**" },
            resolveSourceMapLocations = {
              "${workspaceFolder}/**",
              "!**/node_modules/**",
            },
            sourceMaps = true,
            outputCapture = "std",
          },
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file (CommonJS)",
            program = "${file}",
            cwd = "${workspaceFolder}",
            skipFiles = { "<node_internals>/**" },
            sourceMaps = true,
            outputCapture = "std",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            skipFiles = { "<node_internals>/**" },
            sourceMaps = true,
          },
        }
      end
    end

    -- Python DAP configuration
    if not dap.adapters.python then
      local debugpy_path = require("mason-registry").get_package("debugpy"):get_install_path()
      dap.adapters.python = {
        type = "executable",
        command = debugpy_path .. "/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }
    end

    -- Import Python helper for UV support
    local python_helpers = require("config.python-helpers")

    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        python = function()
          return python_helpers.get_python_path()
        end,
        console = "integratedTerminal",
        justMyCode = false,
      },
      {
        type = "python",
        request = "attach",
        name = "Attach",
        connect = {
          port = 5678,
          host = "127.0.0.1",
        },
        pathMappings = {
          {
            localRoot = "${workspaceFolder}",
            remoteRoot = ".",
          },
        },
      },
    }

    -- C++ DAP configuration
    if not dap.adapters.cppdbg then
      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = require("mason-registry").get_package("cpptools"):get_install_path() .. "/extension/debugAdapters/bin/OpenDebugAD7",
      }
    end

    dap.configurations.cpp = {
      {
        name = "Launch file",
        type = "cppdbg",
        request = "launch",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopAtEntry = false,
        setupCommands = {
          {
            text = "-enable-pretty-printing",
            description = "enable pretty printing",
            ignoreFailures = false,
          },
        },
      },
      {
        name = "Attach to gdbserver :1234",
        type = "cppdbg",
        request = "attach",
        MIMode = "gdb",
        miDebuggerServerAddress = "localhost:1234",
        miDebuggerPath = "/usr/bin/gdb",
        cwd = "${workspaceFolder}",
        program = function()
          return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
      },
    }

    dap.configurations.c = dap.configurations.cpp
  end,
}
