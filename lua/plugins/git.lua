return {
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        opts = {
            signcolumn = true,
            current_line_blame = true,
        },
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim",
        },
    },
}
