vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

local function setTabSize()
  local size

  vim.ui.input({
    prompt = "Which Tab Size do you want?",
    default = "4",
  }, function(input)
    size = tonumber(input)

    if size ~= nil and size > 0 then
      vim.opt.tabstop = size
      vim.opt.softtabstop = size
      vim.opt.shiftwidth = size
      print("Tab Size set to " .. size)
    else
      print("Invalid Tab Size: " .. tostring(input))
    end
  end
  )
end

vim.api.nvim_create_user_command('SetTabSize', setTabSize, { desc = "Set Tab Size" })
