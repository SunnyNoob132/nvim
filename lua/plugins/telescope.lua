return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        module = "telescope",

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
