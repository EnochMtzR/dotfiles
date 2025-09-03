-- Track manually detached LSPs per buffer to prevent auto-reattachment
local manually_detached = {}

local function is_client_attached(client_name, bufnr)
    local target_bufnr = bufnr or vim.api.nvim_get_current_buf()

    local clients = vim.lsp.get_clients({ bufnr = target_bufnr })

    for _, client in ipairs(clients) do
        if client.name == client_name and not client:is_stopped() then
            return true
        end
    end

    return false
end

local function is_manually_detached(client_name, bufnr)
    local key = bufnr .. ":" .. client_name
    return manually_detached[key] == true
end

local function set_manually_detached(client_name, bufnr, detached)
    local key = bufnr .. ":" .. client_name
    manually_detached[key] = detached
end

local function toggle_lsps_for_buffer(bufnr)
    return function()
        local lsp = vim.lsp
        local clients = lsp.get_clients()
        local clientOptions = {}
        local clientDisplayOptions = {}

        for _, client in ipairs(clients) do
            local is_stopped = not is_client_attached(client.name, bufnr)
            local status = is_stopped and "[Stopped]" or "[Running]"

            table.insert(clientDisplayOptions, string.format("%s %s", client.name, status))
            table.insert(clientOptions, {
                name = client.name,
                client_id = client.id,
                is_stopped = is_stopped
            })
        end

        vim.ui.select(clientDisplayOptions, {
            prompt = "Select LSP Client to Toggle:",
            format_item = function(item)
                return item
            end
        }, function(selected, idx)
            if selected == nil then
                return
            end

            local clientInfo = clientOptions[idx]

            if clientInfo.is_stopped then
                lsp.buf_attach_client(bufnr, clientInfo.client_id)
                set_manually_detached(clientInfo.name, bufnr, false)
                print(string.format("LSP Client '%s' attached.", clientInfo.name))
            else
                lsp.buf_detach_client(bufnr, clientInfo.client_id)
                set_manually_detached(clientInfo.name, bufnr, true)
                print(string.format("LSP Client '%s' detached.", clientInfo.name))
            end
        end)
    end
end

local function toggle_lsp()
    local current_bufnr = vim.api.nvim_get_current_buf()

    return toggle_lsps_for_buffer(current_bufnr)
end


-- Export functions for use in other modules
local M = {}
M.is_manually_detached = is_manually_detached
M.set_manually_detached = set_manually_detached
M.toggle_lsp = toggle_lsp

vim.api.nvim_create_user_command("ToggleLSP", toggle_lsp(), { desc = "Toggle LSP Clients for Current Buffer" })

-- Clean up manually_detached state when buffer is deleted
vim.api.nvim_create_autocmd("BufDelete", {
    callback = function(ev)
        local bufnr = ev.buf
        -- Clean up state for this buffer
        for key in pairs(manually_detached) do
            if key:match("^" .. bufnr .. ":") then
                manually_detached[key] = nil
            end
        end
    end,
})

return M
