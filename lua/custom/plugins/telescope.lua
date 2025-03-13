return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Telescope is a fuzzy finder that comes with a lot of different things that
    -- it can fuzzy find! It's more than just a "file finder", it can search
    -- many different aspects of Neovim, your workspace, LSP, and more!
    --
    -- The easiest way to use Telescope, is to start by doing something like:
    --  :Telescope help_tags
    --
    -- After running this command, a window will open up and you're able to
    -- type in the prompt window. You'll see a list of `help_tags` options and
    -- a corresponding preview of the help.
    --
    -- Two important keymaps to use while in Telescope are:
    --  - Insert mode: <c-/>
    --  - Normal mode: ?
    --
    -- This opens a window that shows you all of the keymaps for the current
    -- Telescope picker. This is really useful to discover what Telescope can
    -- do as well as how to actually do it!

    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      -- defaults = {
      --   mappings = {
      --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
      --   },
      -- },
      -- pickers = {}
      defaults = {
        -- Add file ignore patterns here
        file_ignore_patterns = {
          'package%-lock%.json', -- Ignore package-lock.json
          'node_modules', -- Ignore node_modules
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }

    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- see `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>f', '', { desc = 'Find' })
    -- vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'search help' })
    -- vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'search keymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'search files' })
    -- vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = 'search select telescope' })
    -- vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = 'search current word' })
    -- vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'search by grep' })
    -- vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'search diagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = 'search recent files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = 'find existing buffers' })
    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = 'fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>f/', function()
      local root = string.gsub(vim.fn.system 'git rev-parse --show-toplevel', '\n', '')
      if vim.v.shell_error == 0 then
        require('telescope.builtin').live_grep { cwd = root }
      else
        require('telescope.builtin').live_grep()
      end
    end, { desc = 'fuzzily search in project' })

    -- -- slightly advanced example of overriding default behavior and theme
    --
    -- -- it's also possible to pass additional configuration options.
    -- --  see `:help telescope.builtin.live_grep()` for information about particular keys
    -- vim.keymap.set('n', '<leader>s/', function()
    --   builtin.live_grep {
    --     grep_open_files = true,
    --     prompt_title = 'live grep in open files',
    --   }
    -- end, { desc = 'search / in open files' })
    --
    -- -- shortcut for searching your neovim configuration files
    -- vim.keymap.set('n', '<leader>sn', function()
    --   builtin.find_files { cwd = vim.fn.stdpath 'config' }
    -- end, { desc = 'search neovim files' })
  end,
}
