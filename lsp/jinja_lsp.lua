return {
    cmd = { "jinja-lsp" },
    filetypes = { "jinja", "html" },

    init_options = {
        templates = "./templates",
        backend = { "./app.py" },
        lang = "python",
    },
}
