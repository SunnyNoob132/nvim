return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        lazy = false,
        priority = 1000,

        config = function()
            require("catppuccin").setup({
                auto_integrations = true,
                no_italic = true,
            })

            vim.cmd.colorscheme("catppuccin")
        end,
    },
}
