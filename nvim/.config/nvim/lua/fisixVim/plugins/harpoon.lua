return {
  "ThePrimeagen/harpoon",
  config = function()
    local mark = require("harpoon.mark")
    local ui = require("harpoon.ui")

    -- Add current file to Harpoon
    vim.keymap.set("n", "<leader>a", function() mark.add_file() end)

    -- Show Harpoon menu (list of marked files)
    vim.keymap.set("n", "<leader>h", function() ui.toggle_quick_menu() end)

    -- Jump to files 1–4
    vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
    vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
    vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
    vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)
  end,
}

