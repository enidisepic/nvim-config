local M = {}

function M.setup()
  local config = require('config')

  -- Set line numbers and if wanted, relative line numbers
  vim.opt.number = true
  if config.relative_line_numbers then
    vim.opt.relativenumber = true
  end

  -- Set splitting right/below if wanted
  if config.enid_splitting then
    vim.opt.splitright = true
    vim.opt.splitbelow = true
  end

  -- Create an autocmd to save, format and lint when leaving insert mode if wanted
  if config.insert_leave_autocmd then
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      callback = function()
        vim.cmd('FormatWrite')
      end
    })

    vim.api.nvim_create_autocmd({ 'User' }, {
      pattern = 'FormatterPost',
      callback = function()
        require('lint').try_lint()
      end
    })
  end

  -- Fix line wrapping (first character + left arrow -> last character previous line)
  vim.opt.whichwrap:append('<,>,h,l,[,]')

  -- Check if we want to apply macOS-specific fixes
  local is_mac = config.is_mac == nil and vim.loop.os_uname().sysname == 'Darwin' or config.is_mac

  -- If so, fix Option + Arrow
  if is_mac then
    vim.keymap.set('', '<esc>f', 'w')
    vim.keymap.set('!', '<esc>f', '<c-o>w')
    vim.keymap.set('!', '<esc>b', '<c-o>b')
  end

  -- Set Page Up/Down to scroll without moving text unless needed in normal mode
  vim.keymap.set('n', '<pageup>', '<c-u>')
  vim.keymap.set('n', '<pagedown>', '<c-d>')

  -- Set Esc in terminal mode to leave terminal mode
  vim.keymap.set('t', '<esc>', '<c-\\><c-n>')

  -- Toggle floating term with Ctrl + X - (Ctrl +) F
  vim.keymap.set({ 'n', 't' }, '<c-x>f', '<cmd>lua require("FTerm").toggle()<cr>')
  vim.keymap.set({ 'n', 't' }, '<c-x><c-f>', '<cmd>lua require("FTerm").toggle()<cr>')
  -- Open new tab with terminal with Ctrl + X - (Ctrl +) T
  vim.keymap.set({ 'n', 't' }, '<c-x>t', '<cmd>tabnew | terminal<cr>i')
  vim.keymap.set({ 'n', 't' }, '<c-x><c-t>', '<cmd>tabnew | terminal<cr>i')

  -- Next tab with tab in normal mode, prev with shift tab, close with 'qq'
  vim.keymap.set({ 'n', 't' }, '<tab>', '<cmd>tabnext<cr>')
  vim.keymap.set({ 'n', 't' }, '<s-tab>', '<cmd>tabprevious<cr>')
  vim.keymap.set({ 'n', 't' }, 'qq', '<cmd>tabclose<cr>')
end

return M
