return {
    "tpope/vim-fugitive",
    config = function ()
        local keymap = vim.keymap

        function commit_git_diff(is_global)
            local commits = vim.fn.systemlist("git log --oneline --decorate --graph")

            vim.ui.select(commits, {
                prompt = "Select commit to diff",
                format_item = function (item)
                    return item
                end
            }, function (commit)
                    if commit == "" or commit == nil then
                        return
                    end

                    local commit_hash = string.match(commit, "^[*|\\ ]*%s*([0-9a-fA-F]+)")

                    if commit_hash == "" then
                        return
                    end

                    if is_global then
                        vim.cmd("G diff " .. commit_hash .. "~ " .. commit_hash)
                        return
                    else
                        vim.cmd("Gvdiffsplit " .. commit_hash)
                        return
                    end
                end)

        end

        keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "git status" })
        keymap.set("n", "<leader>gd", vim.cmd.Gvdiffsplit, { desc = "git diff" })
        keymap.set("n", "<leader>Gd", "<cmd>G diff<cr>", { desc = "git diff" })
        keymap.set("n", "<leader>gl", "<cmd>G log<cr>", { desc = "git log" })
        keymap.set("n", "<leader>gcd", function () commit_git_diff(false) end, { desc = "git file diff for commit" })
        keymap.set("n", "<leader>Gcd", function () commit_git_diff(true) end, { desc = "git global diff for commit" })
    end,
}
