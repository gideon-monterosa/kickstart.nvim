return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
      { '<leader>t', '', desc = 'Toggle' },
      { '<leader>tl', '<cmd>ToggleLint<cr>', desc = 'Toggle Inline Linting' },
    },
    config = function()
      local lint = require 'lint'
      lint.linters_by_ft = {
        markdown = { 'markdownlint' },
        javascript = { 'eslint_d' },
      }

      -- To allow other plugins to add linters to require('lint').linters_by_ft,
      -- instead set linters_by_ft like this:
      -- lint.linters_by_ft = lint.linters_by_ft or {}
      -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
      --
      -- However, note that this will enable a set of default linters,
      -- which will cause errors unless these tools are available:
      -- {
      --   clojure = { "clj-kondo" },
      --   dockerfile = { "hadolint" },
      --   inko = { "inko" },
      --   janet = { "janet" },
      --   json = { "jsonlint" },
      --   markdown = { "vale" },
      --   rst = { "vale" },
      --   ruby = { "ruby" },
      --   terraform = { "tflint" },
      --   text = { "vale" }
      -- }

      local lint_enabled = true
      local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
        group = lint_augroup,
        callback = function()
          if lint_enabled then
            lint.try_lint()
          end
        end,
      })

      local function toggle_lint()
        lint_enabled = not lint_enabled
        if lint_enabled then
          vim.notify('🔍 Inline Linting Enabled', vim.log.levels.INFO)
          lint.try_lint() -- Optionally run lint immediately when enabling
        else
          vim.notify('❌ Inline Linting Disabled', vim.log.levels.WARN)
          vim.diagnostic.reset(nil, vim.api.nvim_get_current_buf())
        end
      end

      vim.api.nvim_create_user_command('ToggleLint', toggle_lint, { desc = 'Toggle Inline Linting' })
    end,
  },
}
