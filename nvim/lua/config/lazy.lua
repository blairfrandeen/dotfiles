local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local vim = vim
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
    {
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns

                -- Standard preview
                vim.keymap.set('n', '<leader>gp', gs.preview_hunk, { buffer = bufnr })

                -- Preview with hunk navigation
                vim.keymap.set('n', '<leader>gj', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr })

                vim.keymap.set('n', '<leader>gk', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true, buffer = bufnr })

                -- Toggle hunk preview in floating window with scroll support
                vim.keymap.set('n', '<leader>gt', gs.toggle_current_line_blame, { buffer = bufnr })

                -- Open file diff in a split (easier to scroll through all changes)
                vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr })
            end,
        }
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        keys = {
            -- This is one way to lazy load the plugin when the keybinding is pressed
            { "<c-p>",      "<cmd>FzfLua files<cr>",        mode = { "n", "i", "v" }, desc = "FzfLua Files" },
            { "<c-t>",      "<cmd>FzfLua buffers<cr>",      mode = { "n", "i", "v" }, desc = "FzfLua Buffers" },
            { "<leader>gs", "<cmd>FzfLua git_status<cr>",   mode = "n",               desc = "FzfLua Git Status" },
            { "F",          "<cmd>FzfLua lgrep_curbuf<cr>", mode = "n",               desc = "FzfLua grep current buffer" },
            { "<leader>/",  "<cmd>FzfLua grep<cr>",         mode = "n",               desc = "FzfLua Grep" },
        },
        lazy = true,
    },
    {
        "ggandor/leap.nvim",
        enabled = true,
        keys = {
            { "s",  mode = { "n", "x", "o" }, desc = "Leap Forward to" },
            { "S",  mode = { "n", "x", "o" }, desc = "Leap Backward to" },
            { "gs", mode = { "n", "x", "o" }, desc = "Leap from Windows" },
        },
        config = function(_, opts)
            local leap = require("leap")
            for k, v in pairs(opts) do
                leap.opts[k] = v
            end
            leap.add_default_mappings(true)
            vim.keymap.del({ "x", "o" }, "x")
            vim.keymap.del({ "x", "o" }, "X")
        end,
    },
    -- main color scheme
    {
        "wincent/base16-nvim",
        lazy = false,    -- load at start
        priority = 1000, -- load first
        config = function()
            vim.cmd([[colorscheme gruvbox-dark-hard]])
            vim.o.background = 'dark'
            -- Make comments more prominent -- they are important.
            -- local bools = vim.api.nvim_get_hl(0, { name = 'Boolean' })
            -- vim.api.nvim_set_hl(0, 'Comment', bools)
            -- Make it clearly visible which argument we're at.
            local marked = vim.api.nvim_get_hl(0, { name = 'PMenu' })
            vim.api.nvim_set_hl(0, 'LspSignatureActiveParameter',
                { fg = marked.fg, bg = marked.bg, ctermfg = marked.ctermfg, ctermbg = marked.ctermbg, bold = true })
        end
    },
    {
        'itchyny/lightline.vim',
        lazy = false,
        config = function()
            vim.o.showmode = false
            vim.g.lightline = {
                active = {
                    left = {
                        { 'mode',     'paste' },
                        { 'readonly', 'filename', 'modified' }
                    },
                    right = {
                        { 'lineinfo' },
                        { 'percent' },
                        { 'fileencoding', 'filetype' }
                    },
                },
                component_function = {
                    filename = 'LightlineFilename'
                },
            }
            function LightlineFilenameInLua(opts)
                if vim.fn.expand('%:t') == '' then
                    return '[No Name]'
                else
                    return vim.fn.getreg('%')
                end
            end

            -- https://github.com/itchyny/lightline.vim/issues/657
            vim.api.nvim_exec(
                [[
  		function! g:LightlineFilename()
  			return v:lua.LightlineFilenameInLua()
  		endfunction
  		]],
                true
            )
        end
    },
    { import = "plugins" },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
}
)
