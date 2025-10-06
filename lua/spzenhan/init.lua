local M = {}

local config = {
  executable = nil,
  default_status = nil,
}

local function is_wsl()
  if vim.fn.has("unix") == 1 then
    local uname = vim.fn.system({ "uname", "-a" })
    if vim.v.shell_error == 0 and uname and string.find(uname, "Linux") and string.find(uname, "microsoft-standard") then
      return true
    end
  end

  return false
end

local function find_executable()
  if config.executable and vim.fn.executable(config.executable) == 1 then
    return config.executable
  end

  if vim.fn.executable("spzenhan.exe") == 1 then
    return "spzenhan.exe"
  end

  local script_path = debug.getinfo(1, "S").source
  if not script_path then return nil end
  script_path = script_path:match("@(.*)")
  if not script_path then return nil end

  local plugin_root = vim.fn.fnamemodify(script_path, ":h:h:h")
  local path = plugin_root .. "/zenhan/spzenhan.exe"
  if vim.fn.filereadable(path) == 1 then
    return path
  end

  return nil
end

function M.setup(user_config)
  config = vim.tbl_deep_extend("force", config, user_config or {})

  local is_windows = vim.fn.has("win32") == 1 or vim.fn.has("win32unix") == 1
  if not is_windows and not is_wsl() then
    return
  end

  config.executable = find_executable()
  if not config.executable then
    vim.notify("spzenhan.exe is not found in PATH or plugin directory.", vim.log.levels.ERROR, { title = "spzenhan" })
    return
  end

  local augroup = vim.api.nvim_create_augroup("SpZenHan", { clear = true })

  vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = function()
      vim.fn.system({ config.executable })
      vim.b.zenhan_ime_status = vim.F.if_nil(config.default_status, vim.v.shell_error)
    end,
  })

  vim.api.nvim_create_autocmd("InsertEnter", {
    group = augroup,
    callback = function()
      if vim.b.zenhan_ime_status == 1 then
        vim.fn.system({ config.executable, "1" })
      end
    end,
  })

  vim.api.nvim_create_autocmd("InsertLeave", {
    group = augroup,
    callback = function()
      vim.fn.system({ config.executable, "0" })
      vim.b.zenhan_ime_status = vim.F.if_nil(config.default_status, 0)
    end,
  })
end

return M
