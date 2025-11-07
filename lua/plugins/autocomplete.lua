return {
    {
        "folke/lazydev.nvim",
        ft = "lua",

        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } }
            }
        }
    },
    {
        "saghen/blink.cmp",
        version = "1.*",

        dependencies = { "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },

        opts = {
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },

                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    }
                }
            },

            list = { selection = { preselect = true, auto_insert = false } },

            documentation = { auto_show = false, auto_show_delay_ms = 500 },
            ghost_text = { enabled = true },

            keymap = {
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,

                    "snippet_forward",
                    "fallback"
                }
            },

            signature = { enabled = true }
        }
    }
}
