return {
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        keys = [[<D-\>]],
        version = "*",

        opts = {
            open_mapping = [[<D-\>]],
            size = 20,

            -- Prevents the terminal being overridden by other windows
            on_open = function(term)
                vim.wo[term.window].winfixbuf = true
            end,
        },
    },
}
