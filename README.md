# nvim-gicel

Neovim support for [GICEL](https://github.com/cwd-k2/gicel) via [tree-sitter](https://github.com/cwd-k2/tree-sitter-gicel).

## Features

- Syntax highlighting (tree-sitter)
- Code folding
- Indentation
- Filetype detection (`.gicel`)
- LSP (diagnostics, hover, completion, go-to-definition, document symbols)

## Requirements

- Neovim ≥ 0.10
- [tree-sitter-gicel](https://github.com/cwd-k2/tree-sitter-gicel) parser
- [gicel](https://github.com/cwd-k2/gicel) CLI (for LSP)

## Installation

### lazy.nvim

```lua
{
  "cwd-k2/nvim-gicel",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("gicel").setup()
  end,
}
```

After installation, run `:TSInstall gicel` to compile the parser.

### Manual

1. Add this plugin to your Neovim runtime path.
2. Call `require("gicel").setup()` in your config.
3. Run `:TSInstall gicel` to compile the parser.

## LSP

If `gicel` is found in `$PATH`, the LSP server starts automatically when a `.gicel` file is opened. No extra configuration is required.

### Options

```lua
require("gicel").setup({
  lsp = {
    enable = true,       -- set false to disable LSP
    cmd = "gicel",       -- path to the gicel binary
  },
})
```

`--packs`, `--recursion`, `--module` are read from file header directives automatically. See [header directives](https://github.com/cwd-k2/gicel#file-header-directives).
