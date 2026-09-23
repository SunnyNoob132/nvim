return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",

        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                build = ":TSUpdate",
                lazy = false,
                branch = "main",
            },
        },

        config = function()
            require("nvim-treesitter").install({
                "lua",
                "python",
                "javascript",
                "typescript",
                "jsx",
                "tsx",
                "c",
                "cpp",
                "bash",
                "zsh",
                "json",
                "yaml",
                "toml",
                "html",
                "css",
                "csv",
                "regex",
                "asm",
                "jsdoc",
                "printf",
                "gitcommit",
                "vim",
                "regex",
                "markdown",
                "markdown_inline",
                "jinja",
            })

            -- Fixes garbage treesitter-caused indentation in JSDoc
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "javascript", "javascriptreact", "python", "c", "html" },

                callback = function()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowPeach",
                "RainbowYellow",
                "RainbowGreen",
                "RainbowSapphire",
                "RainbowLavender",
            }

            vim.g.rainbow_delimiters = { highlight = highlight }

            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
                vim.api.nvim_set_hl(0, "RainbowPeach", { fg = "#fab387" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
                vim.api.nvim_set_hl(0, "RainbowSapphire", { fg = "#74c7ec" })
                vim.api.nvim_set_hl(0, "RainbowLavender", { fg = "#b4befe" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({ scope = { highlight = highlight } })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    },
    {
        "chrisgrieser/nvim-origami",
        event = "VeryLazy",

        config = function()
            require("origami").setup()

            vim.keymap.set("n", "<Left>", function()
                require("origami").h()
            end)
            vim.keymap.set("n", "<Right>", function()
                require("origami").l()
            end)
            vim.keymap.set("n", "<Home>", function()
                require("origami").caret()
            end)
            vim.keymap.set("n", "<End>", function()
                require("origami").dollar()
            end)
        end,

        init = function()
            vim.opt.foldlevel = 99
            vim.opt.foldlevelstart = 99
        end,
    },
}
