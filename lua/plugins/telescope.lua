return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        module = "telescope",

        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find Buffers" },
        },

        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
}
