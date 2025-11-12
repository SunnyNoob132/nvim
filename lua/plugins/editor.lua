return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        lazy = false,

        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        opts = {
            options = {
                theme = "catppuccin",
                component_separators = "",
                section_separators = { left = "", right = "" },
            },

            sections = {
                lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
                lualine_b = { "filename", "branch" },

                lualine_c = {
                    {
                        "diagnostics",
                        symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                    },
                },

                lualine_x = { "lsp_status" },
                lualine_y = { "filetype", "progress" },

                lualine_z = {
                    { "location", separator = { right = "" }, left_padding = 2 },
                },
            },

            inactive_sections = {
                lualine_a = { "filename" },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },

            tabline = {},
            extensions = { "neo-tree" },
        },
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local mocha = require("catppuccin.palettes").get_palette("mocha")

            require("bufferline").setup({
                highlights = require("catppuccin.special.bufferline").get_theme({
                    custom = {
                        all = {
                            fill = { bg = mocha.mantle },
                        },
                    },
                }),

                options = {
                    indicator = { style = "underline" },
                    diagnostics = "nvim_lsp",

                    diagnostics_indicator = function(count, level, diagnostics_dict, context)
                        local icon = level:match("error") and " " or " "
                        return " " .. icon .. count
                    end,

                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "File Explorer",
                            text_align = "center",
                            separator = true,
                        },
                    },

                    hover = {
                        enabled = true,
                        delay = 200,
                        reveal = { "close" },
                    },
                },
            })
        end,
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",

        opts = {
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                },
            },

            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        },

        dependencies = {
            "MunifTanjim/nui.nvim",
            {
                "rcarriga/nvim-notify",

                opts = {
                    stages = "fade",
                },
            },
        },
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",

        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
}
