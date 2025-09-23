local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

AutoFormatEnabled = true

vim.api.nvim_create_user_command("ToggleAutoFormat", function()
  AutoFormatEnabled = not AutoFormatEnabled
  if AutoFormatEnabled then
    print("Autoformatting enabled")
  else
    print("Autoformatting disabled")
  end
end, {})

vim.keymap.set("n", "<leader>ft", ":ToggleAutoFormat<CR>", { desc = "Toggle Autoformat" })

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  callback = function()
    if not AutoFormatEnabled then
      return
    end

    vim.lsp.buf.format()
  end,
})
