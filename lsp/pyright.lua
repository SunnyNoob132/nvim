return {
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },

    on_init = function(client)
        local python = require("venv-selector").python()

        if python then
            client.config.settings.python.pythonPath = python
        else
            vim.notify("No venv selected, open venv-selector (,v) to pick one :)")
        end
    end,
}
