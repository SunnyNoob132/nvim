return {
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },

        config = function()
            local alpha = require("alpha")
            local theme = require("alpha.themes.dashboard")

            theme.section.header.val = {
                "                                                     ",
                "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
                "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
                "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
                "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
                "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
                "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
                "                                                     ",
                os.date("               %d-%m-%Y      %I:%M %p"),
            }

            theme.section.buttons.val = {
                theme.button("e", "󰝒  New file", ":ene <BAR> startinsert <CR>"),
                theme.button("l", "  Last session", ":AutoSession restore<CR>"),
                theme.button("r", "  Recent", ":Telescope oldfiles<CR>"),
                theme.button("f", "󰥨  Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
                theme.button("w", "  Find word", ":Telescope live_grep<CR>"),
                theme.button("u", "  Update plugins", ":Lazy update<CR>"),
                theme.button("s", "  Settings", ":e $MYVIMRC | :cd %:p:h | :Neotree show<CR>"),
                theme.button("q", "  Quit", ":qa<CR>"),
            }

            vim.api.nvim_create_autocmd("User", {
                once = true,
                pattern = "LazyVimStarted",
                callback = function()
                    local stats = require("lazy").stats()
                    local version = vim.version()

                    theme.section.footer.val = {
                        "",
                        "",
                        "⚡ Neovim "
                            .. version.major
                            .. "."
                            .. version.minor
                            .. "."
                            .. version.patch
                            .. " loaded "
                            .. stats.loaded
                            .. "/"
                            .. stats.count
                            .. " plugins in "
                            .. math.floor(stats.startuptime + 0.5)
                            .. "ms",
                        "",
                        '  "Finally I don\'t have to use VSBloat" - Me',
                    }

                    pcall(vim.cmd.AlphaRedraw)
                end,
            })

            alpha.setup(theme.opts)

            vim.cmd([[
                autocmd FileType alpha setlocal nofoldenable
            ]])
        end,
    },
}
