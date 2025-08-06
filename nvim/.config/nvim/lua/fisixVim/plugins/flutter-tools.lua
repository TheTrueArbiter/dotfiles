return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    config = function()
      require("flutter-tools").setup({
        dart = {
          sdk_path = "/home/fisix/flutter/bin/flutter",
        },
        debugger = {
          enabled = false,
          run_via_dap = true, -- when 'FlutterRun' command used dap ui will be brought up, use 'FlutterDebug'
          print("value of run_via_dap is"),
          exception_breakpoints = { "uncaught", "raised" },
        },
        widget_guides = { enabled = true },
        closing_tags = { enabled = true },
      })
    end,
  },
}
