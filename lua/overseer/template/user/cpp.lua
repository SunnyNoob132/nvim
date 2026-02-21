return {
    name = "dcc build",

    builder = function()
        local file = vim.fn.expand("%:p")
        local name = vim.fn.expand("%:p:r")

        return {
            components = { { "on_output_quickfix", open = true }, "default" },
            cmd = "dcc " .. file .. " -o " .. name .. " && " .. name,
        }
    end,

    condition = {
        filetype = { "c" },
    },
}
