return {
    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        opts = {
            render = "virtual",
            virtual_symbol = "󱓻",
            enable_tailwind = true,
            exclude_filetypes = { "lazy" },
        },
    },

    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },
}
