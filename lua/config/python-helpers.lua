-- Python configuration with UV support
-- This file provides helper functions to detect and use UV-managed Python environments

local M = {}

-- Helper function to find UV Python interpreter
-- Priority: 1. UV .venv in project root, 2. UV .venv in parent dirs, 3. System python
function M.get_python_path()
  local cwd = vim.fn.getcwd()
  local current_file = vim.fn.expand("%:p:h")

  -- Check for .venv in current file's directory and walk up
  local dir = current_file
  while dir ~= "/" and dir ~= "" do
    local venv_python = dir .. "/.venv/bin/python"
    if vim.fn.executable(venv_python) == 1 then
      return venv_python
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  -- Check for .venv in cwd and walk up
  dir = cwd
  while dir ~= "/" and dir ~= "" do
    local venv_python = dir .. "/.venv/bin/python"
    if vim.fn.executable(venv_python) == 1 then
      return venv_python
    end
    dir = vim.fn.fnamemodify(dir, ":h")
  end

  -- Try UV run (if UV is available)
  if vim.fn.executable("uv") == 1 then
    -- Check if we're in a UV project (has uv.toml or pyproject.toml)
    local uv_toml = cwd .. "/uv.toml"
    local pyproject = cwd .. "/pyproject.toml"
    if vim.fn.filereadable(uv_toml) == 1 or vim.fn.filereadable(pyproject) == 1 then
      -- Try to get Python from UV's virtual environment
      -- UV creates .venv in the project root when you run `uv sync` or `uv venv`
      local uv_venv_python = cwd .. "/.venv/bin/python"
      if vim.fn.executable(uv_venv_python) == 1 then
        return uv_venv_python
      end
      
      -- Also check parent directories for UV projects
      dir = cwd
      while dir ~= "/" and dir ~= "" do
        uv_venv_python = dir .. "/.venv/bin/python"
        if vim.fn.executable(uv_venv_python) == 1 then
          return uv_venv_python
        end
        dir = vim.fn.fnamemodify(dir, ":h")
      end
      
      -- As a fallback, try `uv run which python` (requires UV sync to have been run)
      local uv_python = vim.fn.system("cd " .. vim.fn.shellescape(cwd) .. " && uv run which python 2>/dev/null"):gsub("%s+", "")
      if uv_python ~= "" and vim.fn.executable(uv_python) == 1 then
        return uv_python
      end
    end
  end

  -- Fallback to system Python
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "/usr/bin/python3"
end

-- Helper function to check if UV is managing the current project
function M.is_uv_project()
  local cwd = vim.fn.getcwd()
  local uv_toml = cwd .. "/uv.toml"
  local pyproject = cwd .. "/pyproject.toml"
  local venv = cwd .. "/.venv"

  if vim.fn.filereadable(uv_toml) == 1 then
    return true
  end

  if vim.fn.filereadable(pyproject) == 1 then
    -- Check if pyproject.toml mentions UV (basic check)
    local content = vim.fn.readfile(pyproject)
    for _, line in ipairs(content) do
      if line:match("uv") or line:match("astral%-sh") then
        return true
      end
    end
  end

  -- Check if .venv exists (UV creates this)
  if vim.fn.isdirectory(venv) == 1 then
    return true
  end

  return false
end

return M
