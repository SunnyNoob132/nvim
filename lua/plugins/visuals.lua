return {
    -- FIX: Changed to background as tailwindcss lsp keeps adding annoying colour highlights
    -- Will be fixed in v2

    {
        "brenoprata10/nvim-highlight-colors",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        opts = {
            render = "background",
            --virtual_symbol = "󱓻",
            enable_tailwind = true,
            exclude_filetypes = { "lazy" },
        },
    },

    {
        "nvzone/minty",
        cmd = { "Shades", "Huefy" },
    },

    {
        "3rd/image.nvim",
        build = false,

        opts = {
            backend = "kitty",
            processor = "magick_cli",
        },
    },
    {
        "brianhuster/live-preview.nvim",

        dependencies = {
            "nvim-telescope/telescope.nvim",
        },

        config = function()
            require("livepreview.config").set({
                dynamic_root = true,
            })
        end,
    },
}
