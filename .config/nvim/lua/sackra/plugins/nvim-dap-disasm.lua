return {
  "Jorenar/nvim-dap-disasm",
  config = function()
    require("dap-disasm").setup({
      dapui_register = true,
      sign = "DapStopped",
      use_dap_request = true,
      dap_request = {
        instructionCount = 16,
        instructionOffset = 0,
        resolveSymbols = true,
      },
      columns = {
        "address",
        "instructionBytes",
        "instruction",
      }
    })

    vim.keymap.set("n", "<leader>dd", function()
      local dap = require("dap")
      local session = dap.session()

      if not session then
        print("No active DAP session")
        return
      end

      local frame = session.current_frame
      if not frame then
        print("No current frame")
        return
      end

      local currentInstruction = frame.instructionPointerReference;

      vim.ui.input({ prompt = "Enter start address: " }, function(input)
        if not input or input == "" then
          return
        end

        local offsetToRip = tonumber(input, 16) - tonumber(currentInstruction, 16)

        vim.cmd("DapDisasmSetMemref " .. input .. " 0 " .. " " .. offsetToRip * 2)
      end)
    end, { desc = "Set disassembly start address" })
  end,
}
