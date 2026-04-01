local M = {}

-- Revision of tree-sitter-gicel that this plugin's queries are compatible with.
-- Update this when tree-sitter-gicel grammar changes affect node types.
local PARSER_REVISION = "1792e9c0b590500ebc24178934fdfaa590821811"

function M.setup()
  vim.filetype.add({
    extension = { gicel = "gicel" },
  })

  local ok = pcall(require, "nvim-treesitter.parsers")
  if ok then
    -- nvim-treesitter 1.x (main branch):
    -- reload_parsers() clears the module cache on every :TSInstall/:TSUpdate,
    -- so the User TSUpdate autocmd is the only stable injection point.
    -- Setting `revision` ensures :TSUpdate detects when a rebuild is needed.
    local entry = {
      install_info = {
        url = "https://github.com/cwd-k2/tree-sitter-gicel",
        revision = PARSER_REVISION,
      },
      tier = 3,
    }

    local function inject()
      require("nvim-treesitter.parsers").gicel = entry
    end

    inject()
    vim.api.nvim_create_autocmd("User", {
      pattern = "TSUpdate",
      callback = inject,
    })
  end

  -- Start tree-sitter highlighting regardless of nvim-treesitter load order.
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "gicel",
    callback = function(args)
      vim.treesitter.start(args.buf, "gicel")
    end,
  })
end

return M
