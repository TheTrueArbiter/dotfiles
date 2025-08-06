return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("noice").setup({
      lsp = {
        -- Override markdown rendering so cmp and other plugins use Treesitter
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- Requires nvim-cmp
        },
      },
      presets = {
        bottom_search = true,         -- Use a classic bottom cmdline for search
        command_palette = true,       -- Position the cmdline and popupmenu together
        long_message_to_split = true, -- Long messages go to split
        inc_rename = false,           -- Input dialog for inc-rename.nvim
        lsp_doc_border = false,       -- Add border to hover docs and signature help
      },
      cmdline = {
        view = "cmdline_popup", -- Moves cmdline to center
      },
      views = {
        cmdline_popup = {
          position = {
            row = "50%",
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
          border = {
            style = "rounded",
          },
        },
      },
      notify = {
        enabled = false, -- disables Noice’s override of vim.notify
      },
    })
  end,
}

