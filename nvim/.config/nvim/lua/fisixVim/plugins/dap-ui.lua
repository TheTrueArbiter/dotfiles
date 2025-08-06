return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
  },
  config = function()
    local dapui = require("dapui")
    local dap = require("dap")

    dapui.setup({
           layouts = {
        {
          elements = {
            { id = "scopes", size = 0.33 },
            { id = "breakpoints", size = 0.17 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 },
          },
          size = 40,
          position = "left",
        },
        {
          elements = {
            { id = "console", size = 0.25 },
            { id = "repl", size = 0.75 },
          },
          size = 10,
          position = "bottom",
        },
      },
    })

    -- Prevent auto-opening
    dap.listeners.after.event_initialized["dapui_config"] = function() end
    dap.listeners.before.event_terminated["dapui_config"] = function() end
    dap.listeners.before.event_exited["dapui_config"] = function() end

    -- State to track toggle manually
    local is_side_open = false
    local is_console_open = false

    local side_layout = 1;
    local bottom_layout = 2

    -- Toggle side panel (stack, scopes, etc.)
    vim.keymap.set("n", "<leader>sl", function()
      if is_side_open then
        dapui.close({ layout = side_layout})
        is_side_open = false
      else
        dapui.open({ layout = side_layout})
       is_side_open = true
      end
    end, { desc = "Toggle DAP Side Panel" })

     -- Toggle console panel
    vim.keymap.set("n", "<leader>bl", function()
      if is_console_open then
        dapui.close({ layout = bottom_layout })
        is_console_open = false
      else
        dapui.open({ layout = bottom_layout})
       is_console_open = true
      end
    end, { desc = "Toggle DAP bottom layout" })

    vim.keymap.set("n", "<leader>dr", function()
      if dapui.elements.repl.is_open() then
        dapui.elements.repl.close()
      else
        dapui.elements.repl.open()
      end
    end, { desc = "Toggle DAP REPL" })

    vim.keymap.set("n", "<leader>dc", function()
      if dapui.elements.console.is_open() then
        dapui.elements.console.close()
      else
        dapui.elements.console.open()
      end
    end, { desc = "Toggle DAP Console" })
  end,
}

