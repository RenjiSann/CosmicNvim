-- DEFAULT USER SETTINGS
local ok, user_config = pcall(require, 'cosmic.config.config')

if not ok then
  user_config = {}
end

local default_config = {
  border = 'rounded',
  disable_builtin_plugins = {},
  add_plugins = {},
  plugins = {
    lsp_lines = {
      -- additional flag only for CosmicNvim
      -- true - loads plugin and is enabled at start
      -- false - loads plugin but is not enabled at start
      -- you may use <leader>ld to toggle
      enable_on_start = false,
    },
  },
  lsp = {
    inlay_hint = false,
    format_on_save = true, -- true/false or table of filetypes {'.ts', '.js',}
    format_timeout = 2000,
    rename_notification = true,
    -- table of callbacks pushed via plugins
    on_attach_mappings = {},
    -- lsp servers that should be installed
    ensure_installed = {
      -- 'cssls',
      -- 'eslint_d',
      -- 'gopls',
      -- 'html',
      -- 'jsonls',
      -- 'lua_ls',
      -- 'prettierd',
      -- 'pyright',
      -- 'yamlls',
    },
    -- lsp servers that should be enabled
    servers = {
      -- gopls = true,
      -- html = true,
      -- jsonls = {
      --   format = false,
      -- },
      -- lua_ls = {
      --   format = false,
      -- },
      -- pyright = true,
    },
  },
}

local u = require('cosmic.utils')
local config = u.merge(default_config, user_config)

function config.lsp.add_on_attach_mapping(callback)
  table.insert(config.lsp.on_attach_mappings, callback)
end

return config
