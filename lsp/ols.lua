---@brief
---
--- https://github.com/DanielGavin/ols
---
--- `Odin Language Server`.

--local util = require 'lspconfig.util'

---@type vim.lsp.Config
return {
  cmd = { 'ols' },
  filetypes = { 'odin' },
  root_markers = { 'ols.json', '.git', '*.odin' },
}
