return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        -- Optional dependencies
        "hrsh7th/cmp-nvim-lsp",             -- For autocompletion
        { "folke/neodev.nvim", opts = {} }, -- Lua LSP settings
    },
    config = function()
        -- Setup language servers
        local lspconfig = require('lspconfig')

        -- Common LSP settings
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        if pcall(require, 'cmp_nvim_lsp') then
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        end

        -- Example: Setup for lua_ls (Lua)
        lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            },
        })

        -- Add more language servers as needed
        -- lspconfig.tsserver.setup({capabilities = capabilities})
        -- lspconfig.rust_analyzer.setup({capabilities = capabilities})

        -- Global mappings
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                local opts = { buffer = ev.buf }

                vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, opts)
                vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
                vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, opts)
                vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
                vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, opts)
            end,
        })
    end
}
