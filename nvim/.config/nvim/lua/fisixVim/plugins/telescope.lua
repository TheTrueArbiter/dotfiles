-- telescope.lua
return {
  "nvim-telescope/telescope.nvim",       -- The main plugin repo name (GitHub path)

  tag = "0.1.5",                          -- Pinning the plugin to a specific version tag

  dependencies = {
    "nvim-lua/plenary.nvim"              -- Telescope needs this helper library plugin
  },

  config = function()                    -- Configuration function that runs after loading the plugin
    require("telescope").setup({})       -- Call telescope’s setup method (empty config here)

    local builtin = require("telescope.builtin")  -- Shortcut to telescope’s built-in pickers

    -- Key mappings for normal mode ('n'):
    vim.keymap.set("n", "<leader>pf", builtin.find_files, {})     -- <leader>pf will open file finder
    vim.keymap.set("n", "<leader>fw", builtin.live_grep, {})      -- <leader>fw to live grep
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})           -- Ctrl+p opens git-tracked files finder

    -- Map <leader>pws to grep for the word under the cursor (normal word)
    vim.keymap.set("n", "<leader>pws", function()
      local word = vim.fn.expand("<cword>")                      -- get current word under cursor
      builtin.grep_string({ search = word })                     -- search for it
    end)

    -- Map <leader>pWs to grep for the WORD under the cursor (including punctuation)
    vim.keymap.set("n", "<leader>pWs", function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)

    -- Map <leader>ps to prompt the user for a search string, then grep it
    vim.keymap.set("n", "<leader>ps", function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end)

    -- Map <leader>vh to open Telescope’s help tag search
    vim.keymap.set("n", "<leader>vh", builtin.help_tags, {})
  end,
}

