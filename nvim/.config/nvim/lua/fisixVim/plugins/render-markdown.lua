return {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'echasnovski/mini.nvim'
    }, -- if you use the mini.nvim suite

    config = function()
    require('render-markdown').setup({
      bullet = {
        enabled = true,
        icons = {  '●', '○', '◆', '◇'},
        render_modes = false,
        left_pad = 0,
        right_pad = 0,
        highlight = 'RenderMarkdownBullet',
      },
    })
  end,

}
