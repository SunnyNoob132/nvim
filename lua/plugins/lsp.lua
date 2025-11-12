return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = { "lua_ls" },

            servers = {
                lua_ls = {
                    single_file_support = true
                }
            },

            notifications = {
                window = {
                    avoid = { "neo-tree" }
                }
            }
        },

        dependencies = {
            {
                "mason-org/mason.nvim",
                opts = {}
            },

            "neovim/nvim-lspconfig"
        }
    },
    {
        {
            "j-hui/fidget.nvim",
            opts = {}
        }
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
            require("tiny-inline-diagnostic").setup {
                preset = "modern",

                options = {
                    show_source = { enabled = true },
                    enable_on_insert = true,
                    enable_on_select = true
                },

                signs = {
                    diag = " "
                }
            }

            vim.diagnostic.config { virtual_text = false }
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },

        config = function()
            local lint = require "lint"

            lint.linters_by_ft = {
                lua = { "luacheck" }
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    lint.try_lint()
                end
            })
        end
    },
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" }
            },

            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback"
            }
        }
    }
}
