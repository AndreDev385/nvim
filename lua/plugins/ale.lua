return {
  "dense-analysis/ale",
  config = function()
    local g = vim.g
    g.ale_enabled = 1
    g.ale_fix_on_save = 0  -- Manual fixes to prevent auto-conflicts
    g.ale_set_highlights = 0
    g.ale_sign_error = "●"
    g.ale_sign_warning = "●"
    g.ale_linters = {
      go = { "golangci-lint" },
      rust = { "analyzer" },
      zig = { "zls" },
      typescript = { "eslint" },  -- Or "biome" for faster alternative
    }
    g.ale_fixers = {
      go = { "gofmt" },
      rust = { "rustfmt" },
      zig = { "zigfmt" },
      typescript = { "prettier" },  -- Or "biome" for combined lint/format
    }
  end,
}
