return {
    {
        "mason-org/mason-lspconfig.nvim",

        opts = {
            ensure_installed = {
                -- Lua
                "lua_ls",
                --"luacheck",
                "stylua",

                -- Python
                "pyright",
                "ruff",

                -- Javascript + Typescript
                "ts_ls",
                "biome",

                -- C/C++
                "clangd",
                -- "clang-format",

                -- Shell
                "bashls",
                -- "shfmt",
                -- "shellcheck",

                -- JSON
                "jsonls",

                -- YAML
                "yamlls",
                -- "yamlfmt",

                -- TOML
                "tombi",

                -- HTML
                "superhtml",
                -- "htmlhint",

                -- CSS
                -- "stylelint",
                "cssls",

                -- Tailwind
                "tailwindcss",
                -- "rustywind",

                -- Django
                "djls",
                -- "djlint",

                -- API
                -- "spectral",
            },

            notifications = {
                window = {
                    avoid = { "neo-tree" },
                },
            },
        },

        config = function(_, opts)
            require("mason-lspconfig").setup(opts)

            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Disable native LSP document color highlighting",

                callback = function(args)
                    vim.lsp.document_color.enable(false, { bufnr = args.buf })
                end,
            })
        end,

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
                json = { "jsonlint" },
                yaml = { "yamllint" },
                toml = { "tombi" },
                html = { "htmlhint" },
                css = { "stylelint" },
                htmldjango = { "djlint" },
            }

            lint.linters.clangtidy.args = {
                "-std=c++23",
                "-I/usr/include/c++/v1",
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
                python = { "ruff_format", "ruff_organize_imports" },
                javascript = { "biome", "biome-organize-imports" },
                typescript = { "biome", "biome-organize-imports" },
                javascriptreact = { "biome", "biome-organize-imports", "rustywind" },
                typescriptreact = { "biome", "biome-organize-imports", "rustywind" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                bash = { "shfmt" },
                zsh = { "shfmt" },
                json = { "biome" },
                yaml = { "yamlfmt" },
                toml = { "tombi" },
                html = { "biome", "rustywind" },
                css = { "biome" },
                htmldjango = { "djlint" },
            },

            format_on_save = {
                timeout_ms = 1000,
                lsp_format = "fallback",
            },
        },
    },
}
