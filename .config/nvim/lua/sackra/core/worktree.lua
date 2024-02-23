function change_worktree()
    local is_bare_repo = vim.fn.system("git rev-parse --git-dir"):find(".git") == nil
    local current_dir = vim.cmd('pwd')
    local worktrees = vim.tbl_map(function(worktree_line)
        local path_elements = vim.split(worktree_line, "/")
        return {worktree_line, path_elements[#path_elements]}
    end, vim.fn.systemlist("git worktree list | grep -v 'bare)' | awk '{print $1}'"))

    if not is_bare_repo or #worktrees == 0 then
        print('No worktrees found!')
        return
    end

    vim.ui.select(worktrees, {
        prompt = 'Select worktree:',
        format_item = function(item)
            local current_dir = vim.fn.getcwd()

            if item[1] == current_dir then
                return " " .. item[2]
            else
                return item[2]
            end
        end
    }, function(choice)
            if choice == nil then
                return
            end

            vim.cmd('cd ' .. choice[1])
            vim.cmd('doautocmd BufEnter')
        end)
end

local keymap = vim.keymap

keymap.set("n", "<leader>gw", change_worktree, { noremap = true, silent = true })
