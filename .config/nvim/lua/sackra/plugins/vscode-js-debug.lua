return {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npm run compile -- dapDebugServer && mv dist out",
    config = function()
        local dap = require("dap")

        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/out/src/dapDebugServer.js", "${port}" },
            }
        }


        for _, language in pairs({ "javascript", "typescript" }) do
            dap.configurations[language] = {
                {
                    name = "Launch current file",
                    type = "pwa-node",
                    request = "launch",
                    program = "${file}",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    sourceMaps = true,
                    cwd = "${workspaceFolder}",
                },
                {
                    name = "Launch current file (TS)",
                    type = "pwa-node",
                    request = "launch",
                    program = "${workspaceFolder}/node_modules/.bin/ts-node",
                    args = { "${file}" },
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    sourceMaps = true,
                    cwd = "${workspaceFolder}",
                },
                {
                    type = "pwa-node",
                    name = "Launch current test file",
                    request = "launch",
                    args = {
                        "${fileBasenameNoExtension}",
                        "--runInBand",
                        "--watchAll=false",
                    },
                    cwd = "${workspaceFolder}",
                    console = "integratedTerminal",
                    internalConsoleOptions = "neverOpen",
                    disableOptimisticBPs = true,
                    program = "${workspaceFolder}/node_modules/.bin/jest",
                    windows = {
                        program = "${workspaceFolder}/node_modules/jest/bin/jest",
                    },
                },
            }
        end
    end
}
