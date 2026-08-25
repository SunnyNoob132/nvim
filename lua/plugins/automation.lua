return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "x", "o" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                "R",
                mode = { "o", "x" },
                function()
                    require("flash").treesitter_search()
                end,
                desc = "Treesitter Search",
            },
            {
                "<c-s>",
                mode = { "c" },
                function()
                    require("flash").toggle()
                end,
                desc = "Toggle Flash Search",
            },
        },
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",

        opts = {
            enable_close_on_slash = true,
            check_ts = true,
        },
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {
            opts = { -- Bruh really? Who made this plugin lmao
                enable_close = true,
                enable_rename = true,
                enable_close_on_slash = true,
            },
        },
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {},
    },
    {
        "monaqa/dial.nvim",

        keys = {
            "<C-a>",
            "<C-x>",
            "g<C-a>",
            "g<C-x>",
        },

        config = function()
            vim.keymap.set("n", "<C-a>", function()
                require("dial.map").manipulate("increment", "normal")
            end)
            vim.keymap.set("n", "<C-x>", function()
                require("dial.map").manipulate("decrement", "normal")
            end)
            vim.keymap.set("n", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gnormal")
            end)
            vim.keymap.set("n", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gnormal")
            end)
            vim.keymap.set("x", "<C-a>", function()
                require("dial.map").manipulate("increment", "visual")
            end)
            vim.keymap.set("x", "<C-x>", function()
                require("dial.map").manipulate("decrement", "visual")
            end)
            vim.keymap.set("x", "g<C-a>", function()
                require("dial.map").manipulate("increment", "gvisual")
            end)
            vim.keymap.set("x", "g<C-x>", function()
                require("dial.map").manipulate("decrement", "gvisual")
            end)
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        cmd = "Rename",

        opts = {
            cmd_name = "Rename",
        },
    },
    {
        "stevearc/overseer.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        opts = {
            component_aliases = {
                default = {
                    "on_exit_set_status",
                    { "on_complete_notify", statuses = { "FAILURE" }, system = "never" },
                    "on_complete_dispose",
                },
            },
        },
    },
}
