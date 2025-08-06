return {
    "tpope/vim-fugitive",
    config = function()
        -- Map <leader>gs to open Git status view using Fugitive
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

        -- Create an augroup for Fugitive-specific autocmds (named after ThePrimeagen)
        local ThePrimeagen_Fugitive = vim.api.nvim_create_augroup("ThePrimeagen_Fugitive", {})

        local autocmd = vim.api.nvim_create_autocmd

        -- Set up keybindings only when a fugitive buffer is opened
        autocmd("BufWinEnter", {
            group = ThePrimeagen_Fugitive,
            pattern = "*",
            callback = function()
                -- Exit if the buffer is not a Fugitive buffer
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local bufnr = vim.api.nvim_get_current_buf()
                local opts = {buffer = bufnr, remap = false}

                -- Map <leader>p to push current branch to remote
                vim.keymap.set("n", "<leader>p", function()
                    vim.cmd.Git('push')
                end, opts)

                -- Map <leader>P to pull with rebase (preferred workflow)
                vim.keymap.set("n", "<leader>P", function()
                    vim.cmd.Git({'pull', '--rebase'})
                end, opts)

                -- Map <leader>t to push to a remote and set upstream (handy for new branches)
                vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
            end,
        })

        -- Map `gu` to get changes from the left side of diff (usually "ours" in merge conflicts)
        vim.keymap.set("n", "gu", "<cmd>diffget //2<CR>")

        -- Map `gh` to get changes from the right side of diff (usually "theirs" in merge conflicts)
        vim.keymap.set("n", "gh", "<cmd>diffget //3<CR>")
    end
}

