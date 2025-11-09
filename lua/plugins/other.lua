return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>?",
                desc = "Buffer Local Keymaps (which-key)",

                function()
                    require("which-key").show { global = false }
                end,
            }
        }
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",

        config = function()
            local persistence = require "persistence"

            persistence.setup()

            vim.keymap.set("n", "<leader>qs", function() persistence.load() end)
            vim.keymap.set("n", "<leader>qS", function() persistence.select() end)
            vim.keymap.set("n", "<leader>ql", function() persistence.load { last = true } end)
            vim.keymap.set("n", "<leader>qd", function() persistence.stop() end)
        end
    }
}
