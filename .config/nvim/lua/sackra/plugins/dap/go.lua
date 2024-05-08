return {
    init = function()
        local dap_go = require("dap-go")
        local keymap = vim.keymap

        dap_go.setup({
            delve = {
                build_flags = "-gcflags='all=-N -l'",
            }
        })

        keymap.set("n", "<leader>dgt", dap_go.debug_test, { desc = "Debug test" })
    end
}
