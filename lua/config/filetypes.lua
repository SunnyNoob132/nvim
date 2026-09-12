-- Jinja
vim.filetype.add({
    extension = {
        jinja = "jinja",
        jinja2 = "jinja",
        j2 = "jinja",
    },

    pattern = {
        [".*%.html%.j2"] = "jinja",
        [".*%.html%.jinja2?"] = "jinja",
    },
})

-- Amber
vim.filetype.add({
    extension = {
        ab = "amber",
    },
})
