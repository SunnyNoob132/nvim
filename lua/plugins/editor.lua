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

        opts = {
            close_if_last_window = true,

            filesystem = {
                commands = {
                    trash = function(state)
                        local inputs = require("neo-tree.ui.inputs")
                        local utils = require("neo-tree.utils")
                        local node = state.tree:get_node()

                        if not node then
                            return
                        end

                        local path = node.path
                        local _, name = utils.split_path(path)

                        inputs.confirm(("Are you sure you want to trash '%s'?"):format(name), function(confirmed)
                            if not confirmed then
                                return
                            end

                            pcall(function()
                                vim.fn.system({ "trash", vim.fn.fnameescape(path) })

                                if vim.v.shell_error ~= 0 then
                                    vim.notify("trash command failed...", vim.log.levels.ERROR, { title = "Neo-tree" })
                                end
                            end)

                            require("neo-tree.sources.manager").refresh(state.name)
                        end)
                    end,

                    trash_visual = function(state, selected_nodes)
                        local inputs = require("neo-tree.ui.inputs")

                        inputs.confirm(
                            "Are you sure you want to trash " .. #selected_nodes .. " files?",
                            function(confirmed)
                                if not confirmed then
                                    return
                                end

                                for _, node in ipairs(selected_nodes) do
                                    pcall(function()
                                        vim.fn.system({ "trash", node:get_id() })

                                        if vim.v.shell_error ~= 0 then
                                            vim.notify(
                                                "trash command failed...",
                                                vim.log.levels.ERROR,
                                                { title = "Neo-tree" }
                                            )
                                        end
                                    end)
                                end

                                require("neo-tree.sources.manager").refresh(state.name)
                            end
                        )
                    end,
                },

                -- 2) Remap "d" to trash (and "D" for visual multi-trash)
                window = {
                    mappings = {
                        ["d"] = "trash",
                        ["D"] = "trash_visual",
                        ["x"] = "delete",
                    },
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        opts = {
            options = {
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
        dependencies = { "nvim-tree/nvim-web-devicons", { "nvim-mini/mini.bufremove", version = false } },
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

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

                    close_command = function(bufnr)
                        require("mini.bufremove").delete(bufnr, false)
                    end,
                },
            })

            vim.keymap.set("n", "<D-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next Buffer" })
            vim.keymap.set("n", "<D-j>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev Buffer" })
            vim.keymap.set("n", "<D-S-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Right" })
            vim.keymap.set("n", "<D-S-j>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer Left" })

            vim.keymap.set(
                "n",
                "<D-k>",
                "<cmd>lua require('mini.bufremove').delete(0, false)<cr>",
                { desc = "Close Buffer" }
            )

            vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Buffer Pick" })
            vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Buffer Pick Close" })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        ---@module "ibl"
        ---@type ibl.config
        opts = {},
    },
    {
        "Bekaboo/dropbar.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

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
