# Neovim Configuration

A comprehensive Neovim configuration based on [LazyVim](https://github.com/LazyVim/LazyVim) with full language support for Python, C/C++, TypeScript/JavaScript, Java, Docker, Terraform, JSON, and Rust.

## Table of Contents

- [Initial Setup](#initial-setup)
- [Common Scenarios](#common-scenarios)
- [Language-Specific Guides](#language-specific-guides)
  - [Python](#python)
  - [C/C++](#cc)
  - [TypeScript/JavaScript](#typescriptjavascript)
  - [Java](#java)
  - [Docker](#docker)
  - [Terraform](#terraform)
  - [JSON](#json)
  - [Rust](#rust)

---

## Initial Setup

### Prerequisites

Before using this configuration, ensure you have the following installed:

#### Required Tools

1. **Neovim** (v0.9.0 or higher)
   ```bash
   # macOS
   brew install neovim
   
   # Linux (Ubuntu/Debian)
   sudo apt install neovim
   
   # Arch Linux
   sudo pacman -S neovim
   ```

2. **Git** (for plugin management)
   ```bash
   # Verify installation
   git --version
   ```

3. **Node.js** (for TypeScript/JavaScript support)
   ```bash
   # Install via nvm (recommended)
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   nvm install --lts
   nvm use --lts
   ```

#### Language-Specific Tools

**Python:**
- **UV** (Python package manager) - **Required for Python projects**
  ```bash
  # macOS/Linux
  curl -LsSf https://astral.sh/uv/install.sh | sh
  ```
  
  Verify installation:
  ```bash
  uv --version
  ```

**C/C++:**
- **GCC** or **Clang** compiler
  ```bash
  # macOS
  xcode-select --install
  # or install via Homebrew
  brew install gcc
  
  # Linux (Ubuntu/Debian)
  sudo apt install build-essential gdb
  ```

**Java:**
- **JDK** (Java Development Kit) 11 or higher
  ```bash
  # macOS
  brew install openjdk@17
  # or download from https://adoptium.net/
  
  # Linux (Ubuntu/Debian)
  sudo apt install openjdk-17-jdk
  ```

**Docker:**
- **Docker** (for Dockerfile support)
  ```bash
  # macOS
  brew install --cask docker
  # or download Docker Desktop from https://www.docker.com/products/docker-desktop
  
  # Linux
  # Follow instructions at https://docs.docker.com/engine/install/
  ```

**Terraform:**
- **Terraform** CLI
  ```bash
  # macOS
  brew install terraform
  
  # Linux
  # Download from https://www.terraform.io/downloads
  ```

### First-Time Setup

1. **Clone or ensure this configuration is in place:**
   ```bash
   # If starting fresh, ensure the config directory exists
   mkdir -p ~/.config/nvim
   ```

2. **Open Neovim:**
   ```bash
   nvim
   ```

3. **LazyVim will automatically:**
   - Bootstrap Lazy.nvim plugin manager
   - Install all configured plugins
   - Set up LSP servers via Mason
   - Install language servers and debuggers

4. **Wait for installation to complete** (first launch may take a few minutes)

5. **Install Mason packages** (if prompted):
   - Type `:Mason` to open the Mason UI
   - Required packages will be auto-installed, but you can manually install others

---

## Common Scenarios

### Leader Key

The default leader key is `<Space>`. Most custom keymaps use this prefix.

### File Management

- `\` - Toggle Neo-tree file explorer (reveals current file)
- `<leader>e` - Toggle Neo-tree file explorer
- `<leader>ff` - Find files (Telescope)
- `<leader>fg` - Find Git files (Telescope)
- `<leader>fp` - Find plugin files (Telescope)
- `<leader>fr` - Find recent files
- `<leader>fb` - Find buffers

### Copy to Clipboard

- `<leader>y` - Copy selection or line to system clipboard (works in normal and visual mode)

### LSP (Language Server Protocol) - Works for All Languages

#### Code Actions & Navigation

- `gd` - Go to definition
- `gD` - Go to declaration
- `K` - Show documentation (hover)
- `<leader>ca` - Code actions
- `<leader>cr` - Rename symbol
- `<leader>cA` - Code actions (source)

#### Diagnostics

- `]d` - Next diagnostic
- `[d` - Previous diagnostic
- `<leader>xx` - Toggle diagnostics (Trouble)
- `<leader>xX` - Toggle buffer diagnostics (Trouble)
- `<leader>cd` - Show line diagnostics

#### Symbols & References

- `<leader>cs` - Symbols (Trouble)
- `<leader>cl` - LSP definitions/references (Trouble)
- `<leader>cr` - References (Trouble)

### Formatting

- `<leader>cf` - Format current buffer
- Auto-format on save is enabled by default (except for: markdown, json, yaml, terraform)

**Note:** Formatting tools are language-specific and will be installed automatically via Mason.

### Debugging (DAP) - Works for Python, C/C++, TypeScript/JavaScript, Java

#### Common Debugging Keymaps

- `<F5>` - Start/Continue debugging
- `<F1>` - Run to cursor
- `<F2>` - Step over
- `<F3>` - Step into
- `<F4>` - Step out
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Toggle conditional breakpoint
- `<leader>dc` - Continue to cursor
- `<leader>dr` - Restart debugging
- `<leader>dR` - Terminate debugging
- `<leader>du` - Toggle UI
- `<leader>dh` - Toggle breakpoint hint

### Testing

- `<leader>tt` - Run nearest test
- `<leader>tT` - Run current test file
- `<leader>ta` - Run all tests
- `<leader>ts` - Run test suite
- `<leader>tl` - Run last test
- `<leader>tL` - Debug last test
- `<leader>tw` - Run watch mode (Vitest)
- `<leader>to` - Open test output
- `<leader>tp` - Toggle output panel

### Search & Replace

- `<leader>sw` - Search word under cursor
- `<leader>sW` - Search word under cursor (regex)
- `<leader>sh` - Search help
- `<leader>sr` - Replace word under cursor

### Quick Fix & Location List

- `<leader>xq` - Quickfix list (Trouble)
- `<leader>xL` - Location list (Trouble)

---

## Language-Specific Guides

### Python

#### Setup

1. **Install UV** (if not already installed):
   ```bash
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

2. **Initialize UV project** (if starting a new project):
   ```bash
   uv init my-project
   cd my-project
   uv sync  # Creates .venv and installs dependencies
   ```

3. **For existing projects**:
   ```bash
   # Ensure dependencies are synced
   uv sync
   ```

#### Features

- **LSP:** Pyright (default) or Pylsp
- **Formatting:** Black, Ruff (auto-installed via Mason)
- **Linting:** Ruff, Mypy, Pylint, Flake8
- **Testing:** Pytest (via neotest-python)
- **Debugging:** debugpy

#### Usage

**Autocomplete & LSP:**
- Code completion appears automatically as you type
- `gd` - Go to definition
- `K` - Show documentation
- `<leader>ca` - Code actions (imports, quick fixes)

**Formatting:**
- `<leader>cf` - Format file
- Auto-format on save (enabled by default)

**Linting:**
- Errors and warnings appear inline
- `<leader>xx` - View all diagnostics

**Testing:**
- Place cursor on a test function
- `<leader>tt` - Run that test
- `<leader>tT` - Run all tests in current file
- `<leader>ta` - Run all tests in project
- `<leader>tL` - Debug test (sets breakpoints, etc.)

**Debugging:**
1. Set breakpoint: `<leader>db` or click in the gutter
2. Start debugging: `<F5>`
3. Use navigation keys: `<F2>` (step over), `<F3>` (step into), `<F4>` (step out)
4. View variables in the debug UI

**UV Integration:**
- The configuration automatically detects UV-managed projects
- It uses `.venv/bin/python` from your UV project
- Works seamlessly with `uv sync` and `uv run`
- LSP, debugging, and testing all use the correct Python interpreter

**Example workflow:**
```bash
# 1. Create and sync UV project
uv init my-python-app
cd my-python-app
uv add pytest  # Add dependencies
uv sync

# 2. Open in Neovim
nvim src/main.py

# 3. Start coding - LSP, formatting, and linting work automatically
# 4. Write tests and run with <leader>tt
# 5. Debug with <F5> after setting breakpoints
```

---

### C/C++

#### Setup

1. **Install compiler:**
   ```bash
   # macOS
   xcode-select --install
   # or
   brew install gcc
   
   # Linux (Ubuntu/Debian)
   sudo apt install build-essential gdb
   ```

2. **Ensure cpptools is installed** (via Mason - auto-installed)

#### Features

- **LSP:** clangd
- **Formatting:** clang-format
- **Debugging:** cpptools (via DAP)

#### Usage

**Autocomplete & LSP:**
- Code completion appears automatically
- `gd` - Go to definition
- `K` - Show documentation

**Formatting:**
- `<leader>cf` - Format file with clang-format
- Auto-format on save (enabled by default)

**Debugging:**
1. **Compile your program first:**
   ```bash
   g++ -g -o myprogram main.cpp
   ```

2. **Start debugging:**
   - `<F5>` - Select "Launch file" configuration
   - Enter path to executable when prompted
   - Use `<F2>`, `<F3>`, `<F4>` to step through code

3. **Attach to running process:**
   - Start your program with gdbserver:
     ```bash
     gdbserver localhost:1234 ./myprogram
     ```
   - In Neovim: `<F5>` → Select "Attach to gdbserver :1234"
   - Enter executable path when prompted

**Debugging Configurations:**
- **Launch file:** Debug a compiled executable
- **Attach to gdbserver:** Attach to a running process via gdbserver

**Build Systems:**
- For CMake projects, ensure `compile_commands.json` is generated:
  ```bash
  cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON .
  ```
- clangd will automatically use `compile_commands.json` for better IntelliSense

---

### TypeScript/JavaScript

#### Setup

1. **Install Node.js** (via nvm recommended):
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
   nvm install --lts
   nvm use --lts
   ```

2. **Initialize project** (if starting new):
   ```bash
   npm init -y
   # or
   yarn init -y
   # or
   pnpm init
   ```

3. **For ESM (ECMAScript Modules) support:**
   ```bash
   # Add to package.json
   echo '"type": "module"' >> package.json
   
   # Or use .mjs/.mts extensions for individual files
   ```

4. **Install Vitest** (recommended testing framework):
   ```bash
   npm install --save-dev vitest @vitest/ui
   # or
   yarn add -D vitest @vitest/ui
   # or
   pnpm add -D vitest @vitest/ui
   ```

5. **Optional: Install tsx** (for running TypeScript ESM files):
   ```bash
   npm install --save-dev tsx
   ```

#### Features

- **LSP:** TypeScript Language Server (tsserver) with ESM support
- **Formatting:** Prettier
- **Linting:** ESLint
- **Testing:** Vitest (primary), with full ESM support
- **Debugging:** js-debug-adapter (pwa-node) with ESM support

#### ESM (ECMAScript Modules) Support

This configuration fully supports ESM projects:

- **Automatic detection:** tsserver detects ESM based on:
  - `package.json` with `"type": "module"`
  - `.mjs` / `.mts` file extensions
  - Import/export syntax

- **Module resolution:** Configured for ESM import resolution
- **Type checking:** Full TypeScript type checking for ESM modules
- **Debugging:** Multiple debug configurations for ESM:
  - **Launch file (ESM)** - Uses ts-node/esm loader
  - **Launch via tsx (ESM)** - Uses tsx for direct ESM execution
  - **Launch file (CommonJS)** - For CommonJS projects

#### Usage

**Autocomplete & LSP:**
- Code completion with TypeScript types (ESM-aware)
- `gd` - Go to definition
- `K` - Show documentation
- `<leader>ca` - Code actions (imports, fixes)
- Inlay hints for types and parameters

**Formatting:**
- `<leader>cf` - Format with Prettier
- Auto-format on save (enabled by default)
- Prettier automatically handles ESM syntax

**Linting:**
- ESLint errors appear inline
- `<leader>xx` - View all diagnostics
- ESLint configured for ESM projects

**Testing with Vitest:**

Vitest is the primary testing framework and fully supports ESM:

- `<leader>tt` - Run nearest test
- `<leader>tT` - Run current test file
- `<leader>ta` - Run all tests
- `<leader>ts` - Run test suite
- `<leader>tl` - Run last test
- `<leader>tL` - Debug last test (with breakpoints)
- `<leader>tw` - Run watch mode (auto-reruns on changes)
- `<leader>to` - Open test output
- `<leader>tp` - Toggle output panel

**Vitest automatically detects:**
- ESM modules via `package.json` `"type": "module"`
- TypeScript files (`.ts`, `.tsx`, `.mts`)
- Test files matching patterns: `*.test.{ts,tsx,js,jsx,mts,mjs}` or `*.spec.{ts,tsx,js,jsx,mts,mjs}`

**Example Vitest test:**
```typescript
// math.test.ts
import { describe, it, expect } from 'vitest'
import { add } from './math'

describe('math', () => {
  it('should add two numbers', () => {
    expect(add(1, 2)).toBe(3)
  })
})
```

**Debugging:**

1. **Set breakpoint:** `<leader>db` or click in the gutter

2. **Start debugging:** `<F5>` - Select one of:
   - **"Launch file (ESM via tsx)"** - Recommended for ESM projects (requires `tsx` package)
   - **"Launch file (ESM via node)"** - Alternative ESM option (uses ts-node/esm loader)
   - **"Launch file (CommonJS)"** - For CommonJS projects
   - **"Attach"** - Attach to running Node process

3. **Use debug controls:**
   - `<F2>` - Step over
   - `<F3>` - Step into
   - `<F4>` - Step out
   - `<F5>` - Continue

**Example workflow (ESM project):**
```bash
# 1. Initialize ESM project
npm init -y
echo '"type": "module"' >> package.json

# 2. Install dependencies
npm install --save-dev vitest typescript @types/node
npm install --save-dev tsx  # For debugging ESM

# 3. Create tsconfig.json
cat > tsconfig.json << EOF
{
  "compilerOptions": {
    "target": "ES2022",
    "module": "ESNext",
    "moduleResolution": "node",
    "esModuleInterop": true,
    "strict": true
  }
}
EOF

# 4. Create vitest.config.ts
cat > vitest.config.ts << EOF
import { defineConfig } from 'vitest/config'

export default defineConfig({
  test: {
    globals: true,
  },
})
EOF

# 5. Open in Neovim
nvim src/index.ts

# 6. Code with full TypeScript + ESM support
# 7. Write tests, run with <leader>tt
# 8. Debug with <F5> → "Launch file (ESM via tsx)"
```

**CommonJS projects** are also fully supported - use "Launch file (CommonJS)" debug configuration.

---

### Java

#### Setup

1. **Install JDK:**
   ```bash
   # macOS
   brew install openjdk@17
   
   # Linux (Ubuntu/Debian)
   sudo apt install openjdk-17-jdk
   ```

2. **Set JAVA_HOME** (if needed):
   ```bash
   # macOS
   export JAVA_HOME=$(/usr/libexec/java_home -v 17)
   
   # Linux
   export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
   ```

3. **Ensure Java LSP and debuggers are installed** (via Mason - auto-installed)

#### Features

- **LSP:** jdtls (Eclipse JDT Language Server)
- **Debugging:** java-debug-adapter
- **Testing:** java-test (JUnit)

#### Usage

**Autocomplete & LSP:**
- Full Java IntelliSense
- `gd` - Go to definition
- `K` - Show documentation
- `<leader>ca` - Code actions

**Debugging:**
1. **Remote debugging setup:**
   - Start your Java application with debug flags:
     ```bash
     java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005 -jar myapp.jar
     ```

2. **Attach debugger:**
   - `<F5>` - Select "Debug (Attach) - Remote"
   - Debugger connects to `localhost:5005`

3. **Use debug controls:**
   - `<F2>` - Step over
   - `<F3>` - Step into
   - `<F4>` - Step out

**Project Structure:**
- Works best with Maven or Gradle projects
- Ensure `pom.xml` (Maven) or `build.gradle` (Gradle) is in project root

---

### Docker

#### Setup

1. **Install Docker:**
   ```bash
   # macOS
   brew install --cask docker
   
   # Linux
   # Follow: https://docs.docker.com/engine/install/
   ```

#### Features

- **LSP:** docker-langserver
- **Syntax highlighting:** Treesitter

#### Usage

**Autocomplete & LSP:**
- Code completion for Dockerfile commands
- `gd` - Go to definition (if available)
- Linting for Dockerfile syntax

**Example Dockerfile:**
```dockerfile
FROM node:18
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
CMD ["node", "index.js"]
```

---

### Terraform

#### Setup

1. **Install Terraform:**
   ```bash
   # macOS
   brew install terraform
   
   # Linux
   # Download from https://www.terraform.io/downloads
   ```

#### Features

- **LSP:** terraform-ls
- **Formatting:** terraform fmt (disabled by default, use manually)
- **Syntax highlighting:** Treesitter

#### Usage

**Formatting:**
- Formatting on save is **disabled** by default
- Format manually: `:!terraform fmt`
- Or use: `<leader>cf` (if enabled)

**LSP:**
- Code completion for Terraform resources
- `gd` - Go to definition
- Validation and syntax checking

**Note:** Auto-formatting is disabled to prevent Terraform from modifying your files automatically.

---

### JSON

#### Setup

No additional setup required.

#### Features

- **LSP:** jsonls
- **Schema validation:** JSON Schema Store
- **Formatting:** Disabled by default

#### Usage

**Autocomplete:**
- Schema-aware completion for `package.json`, `tsconfig.json`, etc.
- Validation against JSON schemas

**Formatting:**
- Formatting on save is **disabled** by default
- Format manually: `<leader>cf`

---

### Rust

#### Setup

1. **Install Rust:**
   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```

2. **Install rust-analyzer** (via Mason - auto-installed)

#### Features

- **LSP:** rust-analyzer (via Mason)
- **Syntax highlighting:** Treesitter

#### Usage

**Autocomplete & LSP:**
- Full Rust IntelliSense via rust-analyzer
- `gd` - Go to definition
- `K` - Show documentation
- Code completion and error checking

**Note:** For full Rust support (formatting, debugging), consider adding the Rust LazyVim extra in `lua/config/lazy.lua`:
```lua
{ import = "lazyvim.plugins.extras.lang.rust" },
```

---

## Troubleshooting

### LSP Not Working

1. **Check if LSP server is installed:**
   - Type `:Mason` to open Mason UI
   - Look for your language server (e.g., `pyright`, `clangd`)
   - Install if missing

2. **Restart LSP:**
   - `:LspRestart` - Restart LSP for current buffer
   - `:LspInfo` - Show LSP status

3. **Check LSP logs:**
   - `:LspLog` - View LSP logs

### Debugging Not Working

1. **Ensure debug adapter is installed:**
   - Type `:Mason`
   - Install: `debugpy` (Python), `cpptools` (C++), `js-debug-adapter` (JavaScript)

2. **Check DAP configurations:**
   - `<F5>` should show available configurations
   - If none appear, check `lua/plugins/nvim-dap.lua`

### Formatting Not Working

1. **Check formatter is installed:**
   - `:Mason` - Install formatter (e.g., `black`, `prettier`, `clang-format`)

2. **Check file type:**
   - Some file types have formatting disabled (markdown, json, yaml, terraform)
   - Check `lua/config/options.lua` for `autoformat_disabled_filetypes`

3. **Format manually:**
   - `<leader>cf` - Format current buffer

### Python UV Not Detected

1. **Ensure UV project is synced:**
   ```bash
   uv sync
   ```

2. **Check `.venv` exists:**
   ```bash
   ls -la .venv/bin/python
   ```

3. **Restart Neovim** after syncing UV project

### Tests Not Running

1. **Check test adapter is installed:**
   - For Python: `pytest` should be in your UV environment
   - For JavaScript/TypeScript: `vitest` should be installed

2. **Check test file structure:**
   - Python: Tests should be named `test_*.py` or `*_test.py`
   - JavaScript/TypeScript: Vitest looks for `*.test.{ts,tsx,js,jsx,mts,mjs}` or `*.spec.{ts,tsx,js,jsx,mts,mjs}`

3. **For ESM projects:**
   - Ensure `package.json` has `"type": "module"` for ESM support
   - Vitest automatically detects ESM via package.json
   - Check `vitest.config.ts` exists and is properly configured

---

## Additional Resources

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Neovim Documentation](https://neovim.io/doc/)
- [UV Documentation](https://github.com/astral-sh/uv)
- [Mason.nvim](https://github.com/williamboman/mason.nvim) - LSP/DAP installer

---

## Configuration Files

- `init.lua` - Entry point
- `lua/config/` - Core configuration
  - `lazy.lua` - Plugin manager setup
  - `keymaps.lua` - Custom keymaps
  - `options.lua` - Neovim options
- `lua/plugins/` - Plugin configurations
  - `python.lua` - UV helper functions
  - `python-lsp.lua` - Python LSP configuration
  - `nvim-dap.lua` - Debugging configuration
  - `test.lua` - Testing configuration
  - `trouble.lua` - Diagnostics UI
  - `neo-tree.lua` - File explorer
  - `telescope-fzf-native.lua` - Fuzzy finder

---

## License

See [LICENSE](LICENSE) file for details.
