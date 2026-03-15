local M = {}

function M.setup()
  vim.filetype.add({
    extension = { gicel = "gicel" },
  })

  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if not ok then
    return
  end

  local parser_config = parsers.get_parser_configs()
  parser_config.gicel = {
    install_info = {
      url = "https://github.com/cwd-k2/tree-sitter-gicel",
      files = { "src/parser.c", "src/scanner.c" },
      branch = "main",
    },
    filetype = "gicel",
  }
end

return M
