local M = {}

-- Revision of tree-sitter-gicel that this plugin's queries are compatible with.
-- Update this when tree-sitter-gicel grammar changes affect node types.
local PARSER_REVISION = "20cf844c1b8786e67da5796c90608d2b2c7c909f"

local defaults = {
  lsp = {
    enable = true,
    cmd = "gicel",
  },
}

function M.setup(opts)
  opts = vim.tbl_deep_extend("force", defaults, opts or {})
  M._config = opts

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

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "gicel",
    callback = function(args)
      vim.treesitter.start(args.buf, "gicel")
      M._start_lsp(args.buf)
    end,
  })
end

function M._start_lsp(buf)
  local cfg = M._config and M._config.lsp
  if not cfg or not cfg.enable then
    return
  end

  local cmd = cfg.cmd or "gicel"
  if vim.fn.executable(cmd) == 0 then
    return
  end

  vim.lsp.start({
    name = "gicel-lsp",
    cmd = { cmd, "lsp" },
    root_dir = vim.fs.root(buf, ".git") or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":h"),
  })
end

return M
