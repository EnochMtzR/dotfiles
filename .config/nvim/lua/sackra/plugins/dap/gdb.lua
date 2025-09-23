local dap = require('dap')

local function setOutputRadix(radix)
  local session = dap.session()
  if not session then
    print("No active DAP session")
    return
  end

  session:evaluate({
    expression = "set output-radix " .. radix,
    context = "repl"
  }, function(err, response)
    if err then
      print("Error: " .. err.message)
      return
    end

    vim.cmd("DapuiUpdateHover")
    vim.cmd("DapuiUpdateScopes")
    vim.cmd("DapuiUpdateWatches")

    print("Result: " .. vim.inspect(response.result))
  end)
end

local function viewDecimal()
  setOutputRadix(10)
end

local function viewHex()
  setOutputRadix(16)
end

return {
  init = function()
    dap.adapters.gdb = {
      type = 'executable',
      command = "gdb",
      name = "gdb",
      args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
    }

    dap.configurations.c = {
      {
        name = "Launch file",
        type = "gdb",
        request = "launch",
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = "${workspaceFolder}",
        stopAtBeginningOfMainSubProgram = false,
      }
    }
    dap.configurations.cpp = dap.configurations.c

    vim.keymap.set('n', '<leader>dvd', viewDecimal, { desc = "Set GDB output as decimal" })
    vim.keymap.set('n', '<leader>dvh', viewHex, { desc = "Set GDB output as decimal" })
  end
}
