return {
    {
        "lewis6991/gitsigns.nvim",

        opts = {
            signcolumn = true,
            current_line_blame = true
        }
    },
    {
        "NeogitOrg/neogit",

        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",
            "nvim-telescope/telescope.nvim"
        },
    }
}
