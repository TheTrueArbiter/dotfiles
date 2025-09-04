-- lua/fisixVim/language-settings.lua
--[[ 
  Language-specific indentation and tab settings:
    shiftwidth   = number of spaces per indent level
    tabstop      = number of spaces a <Tab> counts for
    softtabstop  = how many spaces a tab feels like in insert mode
    expandtab    = use spaces instead of actual tab characters
    smartindent  = enable C-style smart indentation
    autoindent   = copy indentation from previous line
]]



-- Lua
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.autoindent = true

  end,
})

-- Dart 
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

-- C++ 
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "h", "hpp" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.autoindent = true
  end,
})

-- Java script
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "typescriptreact", "javascriptreact" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.bo.smartindent = true
    vim.bo.autoindent = true
  end,
})

-- Markdown 
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.expandtab = true
  end,
})


