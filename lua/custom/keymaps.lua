local map = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.

-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

map('n', 'H', '<cmd>bprev<CR>')
map('n', 'L', '<cmd>bnext<CR>')

map('v', '<Tab>', '>gv', { desc = 'increase indent of marked lines' })
map('v', '<S-Tab>', '<gv', { desc = 'decrease indent of marked lines' })
