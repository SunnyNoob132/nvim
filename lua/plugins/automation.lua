return {
    {
        "andyg/leap.nvim",
        url = "https://codeberg.org/andyg/leap.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        config = function()
            local leap = require("leap")
            local user = require("leap.user")
            local remote = require("leap.remote")

            vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)")
            vim.keymap.set("n", "S", "<Plug>(leap-from-window)")

            vim.keymap.set({ "n", "o" }, "gs", function()
                remote.action({
                    -- Automatically enter Visual mode when coming from Normal.
                    input = vim.fn.mode(true):match("o") and "" or "v",
                })
            end)

            -- Forced linewise version (`gS{leap}jjy`):
            vim.keymap.set({ "n", "o" }, "gS", function()
                remote.action({ input = "V" })
            end)

            vim.keymap.set({ "x", "o" }, "R", function()
                require("leap.treesitter").select({
                    opts = user.with_traversal_keys("R", "r"),
                })
            end)

            -- Highly recommended: define a preview filter to reduce visual noise
            -- and the blinking effect after the first keypress
            -- (`:h leap.opts.preview`). You can still target any visible
            -- positions if needed, but you can define what is considered an
            -- exceptional case.
            -- Exclude whitespace and the middle of alphabetic words from preview:
            --   foobar[baaz] = quux
            --   ^----^^^--^^-^-^--^
            leap.opts.preview = function(ch0, ch1, ch2)
                return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
            end

            -- Define equivalence classes for brackets and quotes, in addition to
            -- the default whitespace group:
            leap.opts.equivalence_classes = {
                " \t\r\n",
                "([{",
                ")]}",
                "'\"`",
            }

            -- Use the traversal keys to repeat the previous motion without
            -- explicitly invoking Leap:
            user.set_repeat_keys("<enter>", "<backspace>")
        end,
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",

        opts = {
            enable_close_on_slash = true,
        },
    },
    {
        "windwp/nvim-ts-autotag",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = {},
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
        ---@module 'overseer'
        ---@type overseer.SetupOpts
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
