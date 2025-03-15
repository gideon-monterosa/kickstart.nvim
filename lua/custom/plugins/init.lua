return {
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>', desc = 'Move focus to the left window' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>', desc = 'Move focus to the lower window' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>', desc = 'Move focus to the upper window' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>', desc = 'Move focus to the right window' },
    },
  },

  {
    'stevearc/oil.nvim',
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {},
    dependencies = { { 'echasnovski/mini.icons', opts = {} } },
    -- dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
    keys = {
      { '-', '<CMD>Oil --float<CR>', mode = 'n', desc = 'Open parent directory' },
    },
    config = function()
      require('oil').setup()

      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'oil',
        callback = function()
          -- Map double Escape to close the floating Oil window
          vim.keymap.set('n', '<Esc><Esc>', '<Cmd>q<CR>', {
            buffer = true,
            desc = 'Close Oil floating window',
          })
        end,
      })
    end,
  },
}
