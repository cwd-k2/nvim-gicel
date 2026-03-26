local M = {}

function M.setup()
  vim.filetype.add({
    extension = { gicel = "gicel" },
  })

  local ok, parsers = pcall(require, "nvim-treesitter.parsers")
  if ok then
    local info = {
      url = "https://github.com/cwd-k2/tree-sitter-gicel",
      files = { "src/parser.c", "src/scanner.c" },
      branch = "main",
    }

    if type(parsers.get_parser_configs) == "function" then
      -- Legacy nvim-treesitter (master branch)
      parsers.get_parser_configs().gicel = {
        install_info = info,
        filetype = "gicel",
      }
    else
      -- nvim-treesitter 1.x (main branch)
      parsers.gicel = {
        install_info = info,
        tier = 3,
      }
    end
  end

  -- Start tree-sitter highlighting regardless of nvim-treesitter load order
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "gicel",
    callback = function(args)
      vim.treesitter.start(args.buf, "gicel")
    end,
  })
end

return M
