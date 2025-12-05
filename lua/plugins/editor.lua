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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",

        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
        "Bekaboo/dropbar.nvim",
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
        },

        config = function()
            local dropbar_api = require("dropbar.api")
            vim.keymap.set("n", "<Leader>;", dropbar_api.pick, { desc = "Pick symbols in winbar" })
            vim.keymap.set("n", "[;", dropbar_api.goto_context_start, { desc = "Go to start of current context" })
            vim.keymap.set("n", "];", dropbar_api.select_next_context, { desc = "Select next context" })
        end,
    },
    {
        "nvzone/menu",
        keys = { "<RightMouse>" },

        dependencies = {
            {
                "nvzone/volt",
                lazy = true,
            },
        },

        config = function()
            vim.keymap.set({ "n", "v" }, "<RightMouse>", function()
                require("menu.utils").delete_old_menus()

                vim.cmd.exec('"normal! \\<RightMouse>"')

                local buf = vim.api.nvim_win_get_buf(vim.fn.getmousepos().winid)
                local options = vim.bo[buf].ft == "neo-tree" and "neo-tree" or "default"

                require("menu").open(options, { mouse = true })
            end, {})
        end,
    },
}
