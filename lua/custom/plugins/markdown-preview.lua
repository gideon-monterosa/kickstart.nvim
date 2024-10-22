--[[
-- Im using markview.nvim for the moment becaue the solution in this reddit post currently doesnt run with wezterm
-- https://www.reddit.com/r/neovim/comments/1g7rhhc/render_markdown_with_live_preview_in_the_terminal/
--]]
return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
}
