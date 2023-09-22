# nvim-config

![Image of the config in action](config.png)

This is my personal NeoVim config.

It includes essential plugins listed here and some personal preferences and niceties for macOS.

## Usage

This config is designed for macOS with iTerm 2 and the Terminal.app compatible keymap. Furthermore, it is only tested
with [Zsh](https://www.zsh.org/) and [Oh My Zsh](https://ohmyz.sh/).

1. Clone this repository inside of `~/.config/nvim`
2. Configure it to your likings (see below)
3. Open nvim and run `:PackerSync`. This may fail, if it does repeat until it doesn't. If you get messages from
   TreeSitter or Mason let them finish.
4. Enjoy :)

## Config

The configuration file can be found in `lua/config.lua`. Options inside the file are documented.

## Plugins

- [packer](https://github.com/wbthomason/packer.nvim): my preferred package manager for plugins
- [catppuccin](https://github.com/catppuccin/nvim): my preferred theme (Frappé flavor)
- [lualine](https://github.com/nvim-lualine/lualine.nvim): a nice status line at the bottom of thewindow
- [virt-column](https://github.com/lukas-reineke/virt-column.nvim): virtual column at width 120
- [rainbow](https://github.com/luochen1990/rainbow): rainbow colored matching braces
- [mason](https://github.com/williamboman/mason.nvim): package manager for anything not a plugin
- [mason-tool-installer](https://github.com/WhoIsSethDaniel/mason-tool-installer): automatically install mason packages
- [mason-lspconfig](https://github.com/williamboman/nvim-lspconfig): nvim-lspconfig compatibility for mason
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig): lsp support for nvim
- [nvim-lint](https://github.com/mfussenegger/nvim-lint): linter support for nvim
- [formatter](https://github.com/mhartington/formatter.nvim): formatter support for nvim
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter): treesitter for nvim (better highlighting and
  such)
- [nvim-cmp](https://github.com/hrsh7th/nvim-cmp): autocomplete for nvim
- [vim-sleuth](https://github.com/tpope/vim-sleuth): automatic tab width
- [markdown-preview](https://github.com/iamcco/markdown-preview.nvim): markdown preview server
- [lexima](https://github.com/cohama/lexima): automatically close braces
- [gitsigns](https://github.com/lewis6991/gitsigns.nvim): git blame on the current line
- [plenary](https://github.com/nvim-lua/plenary.nvim): lua functions for other plugins
- [todo-comments](https://github.com/folke/todo-comments.nvim): highlight comments starting with TODO
- [neotest](https://github.com/nvim-neotest/neotest): show test results within nvim
- [nvim-window-picker](https://github.com/s1n7ax/nvim-window-picker): pick a window
- [wakatime](https://github.com/wakatime/vim-wakatime): track coding time (optional)
- [FTerm](https://github.com/numToStr/FTerm.nvim): floating terminal with persistent session
- [transparent](https://github.com/xiyaowong/transparent.nvim): make nvim transparent

## Other

- PyRight as Python LSP
- isort for sorting Python imports
- Black for formatting Python code
- Prettier for formatting JS/TS/related
- hadolint for linting Dockerfiles
- markdownlint for linting Markdown files
