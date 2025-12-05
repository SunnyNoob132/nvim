return {
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
}
