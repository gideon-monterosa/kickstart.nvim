return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'hrsh7th/nvim-cmp',
    'nvim-treesitter',
  },
  opts = {
    workspaces = {
      {
        name = 'notes',
        path = '~/Documents/notes/',
      },
    },

    daily_notes = {
      folder = 'daily',
      date_format = '%d-%m-%Y',
      default_tags = { 'daily-notes' },
    },
  },
}
