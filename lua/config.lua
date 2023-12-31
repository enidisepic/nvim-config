local formatter_installed = pcall(require, 'formatter')

local M = {
  relative_line_numbers = true, -- Enable relative line numbers

  enid_splitting = true, -- Split right for vsplit; Split below for normal split

  insert_leave_autocmd = true, -- Save, format and lint when leaving insert mode

  -- Enable macOS-specific fixes (assumes iTerm 2 + ZSH + Terminal.app compatible keymaps for iTerm 2)
  -- nil -> automatically enable fixes on macOS
  -- true/false -> enable/disable manually
  is_mac = nil,

  shell = 'zsh', -- Set to your preferred shell

  virt_column_column = '120', -- Which column to display the virtual column at

  side_window_width = 40, -- Width of nvim-tree and aerial

  terminal_height = 15, -- Height of terminal opened with Ctrl + X

  catppuccin_flavor = 'frappe', -- Flavor of Catppuccin to use

  mason_tools = {
    'black',
    'pyright',
    'prettier',
    'hadolint',
    'markdownlint',
    'isort',
    'rust_analyzer',
    'typescript-language-server',
    'yamllint',
    'shellcheck',
    'shfmt',
  }, -- Which mason packages to install

  mason_lsps = {
    'pyright',
    'rust_analyzer',
    'tsserver',
  }, -- Which mason LSPs to use (needed to use the mason LSP names instead of package names)

  nvim_lint_linters = {
    dockerfile = { 'hadolint' },
    markdown = { 'markdownlint' },
    yaml = { 'yamllint' },
    sh = { 'shellcheck' }
  }, -- Which linters to use, by file type and order of priority

  prettier_filetypes = {
    'javascript',
    'typescript',
    'html',
    'css',
    'yaml',
    'markdown'
  }, -- Which file types to format with Prettier

  other_formatters = formatter_installed and {
    python = {
      require('formatter.filetypes.python').black,
      require('formatter.filetypes.python').isort
    },
    rust = {
      require('formatter.filetypes.rust').rustfmt
    },
    sh = {
      require('formatter.filetypes.sh').shfmt
    },
    ['*'] = {
      require('formatter.filetypes.any').remove_trailing_whitespace
    }
  } or {}, -- Other formatters for different file types

  lsps = {
    'pyright',
    'rust_analyzer',
    'tsserver',
  }, -- LSPs to add to the native LSP client (need to be added to mason_tools and/or mason_lsps)

  treesitter_parsers = {
    'bash',
    'c',
    'css',
    'dockerfile',
    'gitignore',
    'html',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'nix',
    'python',
    'query',
    'requirements',
    'rust',
    'sql',
    'ssh_config',
    'terraform',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml'
  }, -- Parsers treesitter should install (c, lua, vim, vimdoc, query should always be installed)

  use_wakatime = true, -- If you want to use Wakatime
  transparent = true, -- Make nvim transparent (for custom background images and the likes)
  discord_rpc = true -- Use Discord RPC (game status)?
}

return M
