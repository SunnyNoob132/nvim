return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                -- Lua
                "lua_ls", -- LSP
                --"luacheck", --Linter
                "stylua", -- Formatter

                -- Python
                "pyright", -- LSP
                "ruff", -- Linter + formatter

                -- Javascript + Typescript
                "ts_ls", -- LSP
                "biome", -- Linter + formatter

                -- C/C++
                "clangd", -- LSP + linter
                -- "clang-format", -- Formatter

                -- Shell
                "bashls", -- LSP
                -- "shfmt", -- Formatter
                -- "shellcheck", -- Linter
            },

            servers = {
                lua_ls = { single_file_support = true },

                clangd = {
                    cmd = { "clangd", "--background-index", "--clang-tidy" },
                },
            },

            notifications = {
                window = {
                    avoid = { "neo-tree" },
                },
            },
        },

        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {},
            },

            "neovim/nvim-lspconfig",
        },
    },
    {
        "folke/trouble.nvim",
        opts = {},
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
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,

        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "modern",

                options = {
                    show_source = { enabled = true },
                    enable_on_insert = true,
                    enable_on_select = true,
                },

                signs = {
                    diag = " ",
                },
            })

            vim.diagnostic.config({ virtual_text = false })
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local lint = require("lint")

            lint.linters_by_ft = {
                lua = { "luacheck" },
                python = { "ruff" },
                javascript = { "biomejs" },
                typescript = { "biomejs" },
                javascriptreact = { "biomejs" },
                typescriptreact = { "biomejs" },
                c = { "clangtidy" },
                cpp = { "clangtidy" },
                bash = { "shellcheck" },
                zsh = { "shellcheck" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "ruff_format" },
                javascript = { "biome", "biome-organize-imports" },
                typescript = { "biome", "biome-organize-imports" },
                javascriptreact = { "biome", "biome-organize-imports" },
                typescriptreact = { "biome", "biome-organize-imports" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        },
    },
}
