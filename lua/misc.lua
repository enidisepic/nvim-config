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
    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
      callback = function()
        vim.cmd('w')

        vim.cmd('FormatWrite')
        vim.wait(100, function() end)

        require('lint').try_lint()
      end
    })
  end

  -- Fix line wrapping (first character + left arrow -> last character previous line)
  vim.opt.whichwrap:append('<,>,h,l,[,]')

  -- Check if we want to apply macOS-specific fixes
  local is_mac = config.is_mac == nil and vim.loop.os_uname().sysname == 'Darwin' or config.is_mac

  -- If so, fix Option + Right Arrow
  if is_mac then
    vim.keymap.set('n', 'f', 'w')
  end

  -- Set Page Up/Down to scroll without moving text unless needed in normal mode
  vim.keymap.set('n', '<PageUp>', '<c-u>')
  vim.keymap.set('n', '<PageDown>', '<c-d>')

  -- Set Esc in terminal mode to leave terminal mode
  vim.keymap.set('t', '<Esc>', '<c-\\><c-n>')

  -- Toggle floating term with Ctrl + X
  vim.keymap.set('n', '<c-x>', '<CMD>lua require("FTerm").toggle()<CR>')
  vim.keymap.set('t', '<c-x>', '<CMD>lua require("FTerm").toggle()<CR>')
end

return M
