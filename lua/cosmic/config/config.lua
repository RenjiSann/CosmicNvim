-- Override Cosmic configuration options

-- You can require null-ls if needed
-- local null_ls = require('null-ls')

local config = {
    -- See :h nvim_open_win for possible border options
    border = 'rounded',
    -- LSP settings
    lsp = {
        -- Enable/disable inlay hints
        inlay_hint = true,
        -- True/false or table of filetypes {'.ts', '.js',}
        format_on_save = false,
        -- Time in MS before format timeout
        format_timeout = 3000,
        -- Set to false to disable rename notification
        rename_notification = true,
        -- Enable non-default servers, use default lsp config
        -- Check here for configs that will be used by default: https://github.com/williamboman/nvim-lsp-installer/tree/main/lua/nvim-lsp-installer/servers

        -- lsp servers that should be installed
        ensure_installed = {
            'rust_analyzer',
            'clangd',
            'ruff_lsp',
            'pyright',
            'gopls',
        },

        -- lsp servers that should be enabled
        servers = {
            clangd = true,
            rust_analyzer = {
                enabled = true,
                opts = {
                    root_dir = function(fname)
                        return require('lspconfig').util.root_pattern('Cargo.toml')(fname)
                    end,
                },
            },
            ruff_lsp = true,
            pyright = true,
            gopls = true,
            lua_ls = false,
            eslint = true,

            -- Config languages
            yamlls = true,
            jsonls = true,
            taplo = true, -- TOML

            -- See Cosmic defaults lsp/providers/null_ls.lua and https://github.com/jose-elias-alvarez/null-ls.nvim/
            -- If adding additional sources, be sure to also copy the defaults that you would like to preserve from lsp/providers/null_ls.lua
            null_ls = {
                enabled = false,
                -- Disable default list of sources provided by CosmicNvim
                default_cosmic_sources = true,
                -- enable formatting
                format = true,
                -- Add additional sources here
                add_sources = function()
                    local null_ls = require('null-ls')
                    return {
                        null_ls.builtins.diagnostics.shellcheck,
                        null_ls.builtins.diagnostics.djlint,
                        null_ls.builtins.formatting.djlint,
                    }
                end,
            },
        },
        -- See Cosmic defaults lua/plugins/nvim-lsp-ts-utils/setup.lua
        ts_utils = {},
    },

    -- adjust default plugin settings
    plugins = {
        -- See https://github.com/rmagatti/auto-session#%EF%B8%8F-configuration
        auto_session = {},
        -- https://github.com/numToStr/Comment.nvim#configuration-optional
        comment_nvim = {},
        -- See https://github.com/CosmicNvim/cosmic-ui#%EF%B8%8F-configuration
        cosmic_ui = {},
        -- See :h vim.diagnostic.config for all diagnostic configuration options
        diagnostic = {},
        -- See :h gitsigns-usage
        gitsigns = {},
        -- See https://git.sr.ht/~whynothugo/lsp_lines.nvim
        lsp_lines = {
            -- additional flag only for CosmicNvim
            -- true - loads plugin and is enabled at start
            -- false - loads plugin but is not enabled at start
            -- you may use <leader>ld to toggle
            enable_on_start = true,
        },
        -- See https://github.com/ray-x/lsp_signature.nvim#full-configuration-with-default-values
        lsp_signature = {},
        -- See https://github.com/nvim-lualine/lualine.nvim#default-configuration
        lualine = {
            options = {
                theme = 'onedark',
            },
        },
        -- See https://github.com/L3MON4D3/LuaSnip/blob/577045e9adf325e58f690f4d4b4a293f3dcec1b3/README.md#config
        luasnip = {
            history = false,
            region_check_events = { 'CursorMoved', 'CursorHold', 'InsertEnter' },
        },
        -- See :h telescope.setup
        telescope = {},
        -- See https://github.com/folke/todo-comments.nvim#%EF%B8%8F-configuration
        todo_comments = {},
        -- See :h nvim-treesitter-quickstart
        treesitter = {
            ensure_installed = {
                'bash',
                'c',
                'dockerfile',
                'markdown',
                'python',
                'regex',
                'rust',
                'vim',
            },
        },
        -- See :h cmp-usage
        nvim_cmp = {},
        -- See :h nvim-tree.setup
        nvim_tree = {},
    },

    -- Disable plugins default enabled by CosmicNvim
    disable_builtin_plugins = {
        'fugitive',
        'auto-session',
        'tokyonight',
        --[[
    'colorizer',
    'comment-nvim',
    'dashboard',
    'gitsigns',
    'lualine',
    'noice',
    'nvim-cmp',
    'nvim-tree',
    'telescope',
    'theme',
    'todo-comments',
    'treesitter',
    ]]
    },

    -- Add additional plugins (lazy.nvim)
    add_plugins = {
        {
            'kdheepak/lazygit.nvim',
            lazy = true,
            keys = {
                { '<leader>vg', '<cmd>LazyGit<cr>', desc = 'lazygit' },
            },
        },
        {
            'romgrk/barbar.nvim',
            event = 'VeryLazy',
            keys = {
                { '<leader>bn', '<cmd>BufferNext<CR>', desc = 'next tab' },
                { '<leader>bp', '<cmd>BufferPrevious<CR>', desc = 'previous tab' },
                { '<leader>bc', '<cmd>BufferClose<CR>', desc = 'close tab' },
            },
            dependencies = {
                'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
                'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
            },
            opts = {
                -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
                -- animation = true,
                -- insert_at_start = true,
                -- …etc.
                sidebar_filetypes = {
                    NvimTree = true,
                },
            },
        },
        {
            'navarasu/onedark.nvim',
            lazy = false,
            opts = {
                style = 'deep',
                lualine = {
                    transparent = true,
                },
            },
        },
        {
            'linux-cultist/venv-selector.nvim',
            dependencies = { 'neovim/nvim-lspconfig', 'nvim-telescope/telescope.nvim', 'mfussenegger/nvim-dap-python' },
            opts = {
                -- Your options go here
                name = {"venv", ".venv"},
                -- auto_refresh = false
            },
            event = 'VeryLazy', -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
            keys = {
                -- Keymap to open VenvSelector to pick a venv.
                { '<leader>vs', '<cmd>VenvSelect<cr>' },
                -- Keymap to retrieve the venv from a cache (the one previously used for the same project directory).
                { '<leader>vd', '<cmd>VenvSelectCached<cr>' },
            },
        },
    },
}

return config
