return {
    {
        "ggandor/leap.nvim",

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

        opts = {
            enable_close_on_slash = true,
        },
    },
    {
        "windwp/nvim-ts-autotag",
        opts = {},
    },
    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
    },
}
