-- ~/.config/nvim/lua/fisixVim/plugins/colors.lua

function setTheme(color)
  color = color or "catppuccin"
  vim.cmd.colorscheme(color)

  -- Sets background to transparent
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        disable_background = false,
        styles = {
          italic = false,
        },
      })

      setTheme()
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- ensures it's loaded before other plugins that use highlight groups
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
        transparent_background = true,
        integrations = {
          treesitter = true,
          native_lsp = {
            enabled = true,
          },
        },
      })
    end,
  },

  {
    "Mofiqul/dracula.nvim",
    name = "dracula",
    priority = 1000,
    config = function()
      require("dracula").setup({
        transparent_bg = true,
        italic_comment = true,
      })
    end,
  },

  {
    "nickkadutskyi/jb.nvim",
    name = "jb",
    lazy = false,
    priority = 1000,
    config = function()
      require("jb").setup({
        transparent = true,
      })
    end,
  },
}

