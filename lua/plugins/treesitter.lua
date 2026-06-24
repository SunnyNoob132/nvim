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
            })

            -- Fixes garbage treesitter-caused indentation in JSDoc
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "javascript", "javascriptreact" },

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
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }

            ---@type rainbow_delimiters.config
            vim.g.rainbow_delimiters = { highlight = highlight }

            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
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
        opts = {},

        config = function(_, opts)
            require("origami").setup(opts)

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
