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

                conventional_commits = {
                    action = function(entry)
                        vim.print(entry)
                    end,

                    include_body_and_footer = true,
                },
            },
        },
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
    },
    {
        "olacin/telescope-cc.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },

        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "gitcommit",
                callback = function()
                    vim.keymap.set("n", "<leader>cc", function()
                        local actions = require("telescope._extensions.conventional_commits.actions")
                        local picker = require("telescope._extensions.conventional_commits.picker")

                        local opts = {
                            action = actions.prompt,
                            include_body_and_footer = true,
                        }

                        picker(opts)
                    end, { buffer = true, desc = "Create conventional commit message" })
                end,
            })
        end,
    },
}
