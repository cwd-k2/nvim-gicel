# nvim-gicel

Neovim support for [GICEL](https://github.com/cwd-k2/gicel) via [tree-sitter](https://github.com/cwd-k2/tree-sitter-gicel).

## Features

- Syntax highlighting (tree-sitter)
- Code folding
- Indentation
- Filetype detection (`.gicel`)

## Installation

### lazy.nvim

```lua
{
  "cwd-k2/nvim-gicel",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("gicel").setup()
    -- Install the parser
    vim.cmd("TSInstall gicel")
  end,
}
```

### Manual

1. Add this plugin to your Neovim runtime path.
2. Run `:TSInstall gicel` to compile and install the parser.
