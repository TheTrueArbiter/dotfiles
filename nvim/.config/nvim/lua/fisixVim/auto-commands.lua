-- Setup our JDTLS server any time we open up a java file
print("auto commands file called(does not confirm working, just called)")
vim.cmd [[
    augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua require('fisixVim.jdtls').setup_jdtls()
    augroup end
]]

-- Lua indenting and space setting
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.shiftwidth = 2  -- Number of spaces to use for each step of (auto)indent
    vim.bo.tabstop = 2     -- Number of spaces that a <Tab> counts for
    vim.bo.softtabstop = 2 -- Number of spaces a <Tab> feels like in insert mode
    vim.bo.expandtab = true -- Use spaces instead of actual tab characters
    vim.bo.smartindent = true
    vim.bo.autoindent = true

  end,
})

-- Dart indenting and space settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = "dart",
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.autoindent = true
  end,
})

-- Markdown indenting and space settings.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.shiftwidth = 4 -- Number of spaces to use for each step of (auto)indent
    vim.bo.tabstop = 4     -- Number of spaces that a <Tab> counts for
    vim.bo.softtabstop = 4 -- Number of spaces a <Tab> feels like in insert mode
    vim.bo.expandtab = true -- Use spaces instead of actual tab characters
  end,
})



