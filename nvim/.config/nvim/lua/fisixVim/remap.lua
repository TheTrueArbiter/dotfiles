vim.g.mapleader = " "

-- Move selected chunks of code
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- paste over selected chunk and not have slected become buffer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Lets <leader>y be copy to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Normal mode remap to ctrl + n
vim.keymap.set("i", "<C-h>", "<Esc>", { noremap = true, silent = true })
vim.keymap.set("v", "<C-h>", "<Esc>", { noremap = true, silent = true })

-- Displays error message in pop up window
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.open_float(nil, { focus = false, border = "rounded" })
end)

-- split screen horizontallly and open terminal on left side
vim.keymap.set("n", "<leader>tt", ":split | terminal<CR>", { desc = "Terminal (horizontal)" })

-- split screen vertially and open terminal on bottom
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Terminal (vertical)" })


-- Notifications enables and notify plugin
local notify_enabled = true
local original_notify = vim.notify
