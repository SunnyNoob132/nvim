return {
    {
        "rmagatti/auto-session",
        lazy = false,

        ---@module "auto-session"
        ---@type AutoSession.Config
        config = function()
            require("auto-session").setup({
                auto_restore_last_session = false,
                auto_restore = false,

                post_restore_cmds = {
                    ":Neotree show",
                },
            })
        end,
    },
}
