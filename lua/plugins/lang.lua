return {
    -- Amber
    {
        "amber-lang/amber-vim",
        ft = "amber",

        init = function()
            vim.filetype.add({
                extension = {
                    ab = "amber",
                },
            })
        end,
    },

    -- Python
    {
        "linux-cultist/venv-selector.nvim",
        ft = "python", -- Lazy loading too late breaks Noice for some reason
        event = "VeryLazy",

        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
        },

        keys = {
            { ",v", "<cmd>VenvSelect<cr>" },
        },

        opts = { -- this can be an empty lua table - just showing below for clarity.
            search = {}, -- if you add your own searches, they go here.
            options = {}, -- if you add plugin options, they go here.
        },
    },

    -- MIPS Assembly
    {
        "harenome/vim-mipssyntax",
        ft = "asm",
    },
}
