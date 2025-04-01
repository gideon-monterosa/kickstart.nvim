return {
  {
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = {
      { '<leader>g', '', desc = 'Git' },
      { '<leader>gg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = {
      on_attach = function(bufnr)
        local gitsigns = require 'gitsigns'

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        map('n', '<leader>g', '', { desc = 'Git' })
        map('n', '<leader>gn', function()
          if vim.asf.diff then
            vim.cmd.normal { ']c', bang = true }
          else
            gitsigns.nav_hunk 'next'
          end
        end, { desc = 'Jump to next git change' })

        map('n', '<leader>gp', function()
          if vim.wo.diff then
            vim.cmd.normal { '[c', bang = true }
          else
            gitsigns.nav_hunk 'prev'
          end
        end, { desc = 'Jump to previous git change' })

        map('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>gd', gitsigns.preview_hunk_inline, { desc = 'git preview hunk' })
        map('n', '<leader>gb', gitsigns.blame_line, { desc = 'git blame line' })

        map('n', '<leader>t', '', { desc = 'Toggle' })
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git show blame line' })
        map('n', '<leader>td', gitsigns.toggle_linehl, { desc = 'Toggle git show diff' })
      end,
    },
  },
}
