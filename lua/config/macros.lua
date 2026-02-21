-- Sync 2FA backup keys between drives
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "/Volumes/Keys/Keys/Access_Codes.txt",

    callback = function(args)
        vim.notify("Syncing access codes...")

        vim.fn.system({
            "rsync",
            "-a",
            "/Volumes/Keys/Keys/",
            "/Volumes/Sunny/Keys/",
        })
    end,
})
