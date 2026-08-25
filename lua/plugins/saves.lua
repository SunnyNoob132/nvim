return {
    {
        "rmagatti/auto-session",
        lazy = false,

        opts = {
            auto_restore_last_session = false,
            auto_restore = false,

            post_restore_cmds = {
                ":Neotree show",
            },
        },
    },
}
