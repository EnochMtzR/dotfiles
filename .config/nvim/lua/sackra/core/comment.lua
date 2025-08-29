local commentChar = {
    lua = "--",
    python = "#",
    javascript = "//",
    typescript = "//",
    html = "<!-- -->",
    css = "/* */",
    c = "//",
    cpp = "//",
    java = "//",
    ruby = "#",
    go = "//",
    rust = "//",
}

local function getCommentChar(filetype)
    for ft in pairs(commentChar) do
        if string.find(filetype, ft) then
            return commentChar[ft]
        end
    end
end

vim.keymap.set("n", "<C-/>", function()
    local currentFileType = vim.bo.filetype

    local comment = getCommentChar(currentFileType)
    local isBlockComment = comment and (comment:find(" ") ~= nil)

    if not comment then
        print("Commenting not supported for current file type: " .. currentFileType)
        return
    end

    local currentRow = vim.api.nvim_win_get_cursor(0)[1]
    local lineContent = vim.api.nvim_buf_get_lines(0, currentRow - 1, currentRow, false)[1]
    local trimmedLine = lineContent:match("^%s*(.-)%s*$")

    local function lineIsCommented(line, comment)
        if isBlockComment then
            local startComment, endComment = comment:match("^([^%s]*)%s*(.-)$")
            return line:match("^%s*" .. startComment) and line:match(endComment .. "%s*$")
        else
            return line:match("^%s*" .. comment)
        end
    end

    if lineIsCommented(lineContent, comment) then
        -- Uncomment the line
        if isBlockComment then
            -- Handle block comments (e.g., /* */ or <!-- -->)
            local startComment, endComment = comment:match("^([^%s]*)%s*(.-)$")
            local uncommentedLine = lineContent:gsub("^%s*" .. vim.pesc(startComment) .. "%s*", "", 1)
            uncommentedLine = uncommentedLine:gsub("%s*" .. vim.pesc(endComment) .. "%s*$", "", 1)
            vim.api.nvim_buf_set_lines(0, currentRow - 1, currentRow, false, { uncommentedLine })
            vim.api.nvim_feedkeys("gqq", "n", false) -- Reformat the line
            return
        else
            local uncommentedLine = lineContent:gsub("^%s*" .. vim.pesc(comment) .. "%s*", "", 1)
            vim.api.nvim_buf_set_lines(0, currentRow - 1, currentRow, false, { uncommentedLine })
            vim.api.nvim_feedkeys("gqq", "n", false) -- Reformat the line
            return
        end
    else
        -- Comment the line
        if isBlockComment then
            local startComment, endComment = comment:match("^([^%s]*)%s*(.-)$")
            local commentedLine = startComment .. " " .. trimmedLine .. " " .. endComment
            vim.api.nvim_buf_set_lines(0, currentRow - 1, currentRow, false, { commentedLine })
            vim.api.nvim_feedkeys("gqq", "n", false) -- Reformat the line
            return
        else
            local commentedLine = comment .. " " .. trimmedLine
            vim.api.nvim_buf_set_lines(0, currentRow - 1, currentRow, false, { commentedLine })
            vim.api.nvim_feedkeys("gqq", "n", false) -- Reformat the line
            return
        end
    end
end, { desc = "Toggle comment" })

vim.keymap.set("v", "<C-/>", function()
    local currentFileType = vim.bo.filetype

    local comment = getCommentChar(currentFileType)
    local isBlockComment = comment and (comment:find(" ") ~= nil)

    if not comment then
        print("Commenting not supported for current file type: " .. currentFileType)
        return
    end

    local startPos = vim.fn.getpos("v")
    local endPos = vim.fn.getpos(".")
    local startRow = math.min(startPos[2], endPos[2])
    local endRow = math.max(startPos[2], endPos[2])

    -- Check if all lines are commented
    local allCommented = true
    for row = startRow, endRow do
        local lineContent = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
        if isBlockComment then
            local startComment, endComment = comment:match("^([^%s]*)%s*(.-)$")
            if not (lineContent:match("^%s*" .. vim.pesc(startComment)) and lineContent:match(vim.pesc(endComment) .. "%s*$")) then
                allCommented = false
                break
            end
        else
            if not lineContent:match("^%s*" .. vim.pesc(comment)) then
                allCommented = false
                break
            end
        end
    end

    if allCommented then
        -- Uncomment all lines
        for row = startRow, endRow do
            local lineContent = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]

            if isBlockComment then
                local startComment, endComment = comment:match("^([^%s]*)%s*(.-)$")
                local uncommentedLine = lineContent:gsub("^%s*" .. vim.pesc(startComment) .. "%s*", "", 1)
                uncommentedLine = uncommentedLine:gsub("%s*" .. vim.pesc(endComment) .. "%s*$", "", 1)
                vim.api.nvim_buf_set_lines(0, row - 1, row, false, { uncommentedLine })
            else
                local uncommentedLine = lineContent:gsub("^%s*" .. vim.pesc(comment) .. "%s*", "", 1)
                vim.api.nvim_buf_set_lines(0, row - 1, row, false, { uncommentedLine })
            end
        end
        vim.api.nvim_feedkeys("gq", "n", false) -- Reformat the line
    else
        -- Comment all lines
        for row = startRow, endRow do
            local lineContent = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1]
            local trimmedLine = lineContent:match("^%s*(.-)%s*$")
            if isBlockComment then
                local startComment, endComment = comment:match("^([^%s]*)%s*(.-)$")
                local commentedLine = startComment .. " " .. trimmedLine .. " " .. endComment
                vim.api.nvim_buf_set_lines(0, row - 1, row, false, { commentedLine })
            else
                local commentedLine = comment .. " " .. trimmedLine
                vim.api.nvim_buf_set_lines(0, row - 1, row, false, { commentedLine })
            end
        end
        vim.api.nvim_feedkeys("gq", "n", false) -- Reformat the line
    end
end, { desc = "Toggle comment" })
