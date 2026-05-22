---@brief
--- https://biomejs.dev
---
--- Toolchain of the web. [Successor of Rome](https://biomejs.dev/blog/annoucing-biome).
---
--- ```sh
--- npm install [-g] @biomejs/biome
--- ```
---
--- ### Monorepo support
---
--- `biome` supports monorepos by default. It will automatically find the `biome.json` corresponding to the package you are working on, as described in the [documentation](https://biomejs.dev/guides/big-projects/#monorepo). This works without the need of spawning multiple instances of `biome`, saving memory.

---@type vim.lsp.Config
return {
  cmd = function(dispatchers, config)
    local cmd = 'biome'
    local local_cmd = (config or {}).root_dir and config.root_dir .. '/node_modules/.bin/biome'
    if local_cmd and vim.fn.executable(local_cmd) == 1 then
      cmd = local_cmd
    end
    return vim.lsp.rpc.start({ cmd, 'lsp-proxy' }, dispatchers)
  end,
  filetypes = {
    'astro',
    'css',
    'graphql',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'svelte',
    'typescript',
    'typescriptreact',
    'vue',
  },
  workspace_required = true,
  root_dir = function(bufnr)
    local root_markers = {
      'package-lock.json',
      'yarn.lock',
      'pnpm-lock.yaml',
      'bun.lockb',
      'bun.lock',
      'deno.lock',
      '.git',
    }
    local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

    local filename = vim.api.nvim_buf_get_name(bufnr)
    local biome_config_files = { 'biome.json', 'biome.jsonc' }

    local is_buffer_using_biome = vim.fs.find(biome_config_files, {
      path = filename,
      type = 'file',
      limit = 1,
      upward = true,
      stop = vim.fs.dirname(project_root),
    })[1]

    if not is_buffer_using_biome then
      local pkg = vim.fs.find('package.json', { path = filename, upward = true, stop = vim.fs.dirname(project_root) })[1]
      if pkg then
        local ok, content = pcall(vim.fn.readfile, pkg)
        if ok then
          local json = vim.json.decode(table.concat(content, '\n'))
          if json and (json.devDependencies and json.devDependencies['@biomejs/biome'] or json.dependencies and json.dependencies['@biomejs/biome']) then
            is_buffer_using_biome = pkg
          end
        end
      end
    end

    if not is_buffer_using_biome then
      return nil
    end

    return project_root
  end,
}
