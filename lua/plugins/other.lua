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
                    require("which-key").show({ global = false })
                end,
            },
        },
    },
}
