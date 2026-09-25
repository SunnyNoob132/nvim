return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        branch = "main",

        dependencies = {
            {
                "nvim-treesitter/nvim-treesitter-textobjects",
                build = ":TSUpdate",
                lazy = false,
                branch = "main",
            },
        },

        config = function()
            require("nvim-treesitter").install({
                "lua",
                "python",
                "javascript",
                "typescript",
                "jsx",
                "tsx",
                "c",
                "cpp",
                "bash",
                "zsh",
                "json",
                "yaml",
                "toml",
                "html",
                "css",
                "csv",
                "regex",
                "asm",
                "jsdoc",
                "printf",
                "gitcommit",
                "vim",
                "regex",
                "markdown",
                "markdown_inline",
                "jinja",
            })

            -- Fixes garbage treesitter-caused indentation in JSDoc
            vim.api.nvim_create_autocmd("FileType", {
                pattern = { "javascript", "javascriptreact", "python", "c", "html" },

                callback = function()
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "HiPhish/rainbow-delimiters.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },

        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowPeach",
                "RainbowYellow",
                "RainbowGreen",
                "RainbowSapphire",
                "RainbowLavender",
            }

            vim.g.rainbow_delimiters = { highlight = highlight }

            local hooks = require("ibl.hooks")

            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#f38ba8" })
                vim.api.nvim_set_hl(0, "RainbowPeach", { fg = "#fab387" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#f9e2af" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#a6e3a1" })
                vim.api.nvim_set_hl(0, "RainbowSapphire", { fg = "#74c7ec" })
                vim.api.nvim_set_hl(0, "RainbowLavender", { fg = "#b4befe" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup({ scope = { highlight = highlight } })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "RRethy/vim-illuminate",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
    },
    {
        "dmtrKovalenko/fold-imports.nvim",
        event = "BufRead",

        opts = {
            auto_fold = true,
            custom_fold_text = false, -- Disable native fold text formatting

            languages = {
                typescript = {
                    enabled = true,
                    parsers = { "typescript", "tsx" },
                    queries = {
                        "(import_statement) @import",
                        "(export_statement (export_clause) @export)",
                    },
                    filetypes = { "typescript", "typescriptreact" },
                    patterns = { "*.ts", "*.tsx" },
                },
                javascript = {
                    enabled = true,
                    parsers = { "javascript", "jsx" },
                    queries = {
                        "(import_statement) @import",
                        "(export_statement (export_clause) @export)",
                    },
                    filetypes = { "javascript", "javascriptreact" },
                    patterns = { "*.js", "*.jsx", "*.mjs" },
                },
                rust = {
                    enabled = true,
                    parsers = { "rust" },
                    queries = {
                        "(use_declaration) @import",
                        "(mod_item) @import",
                    },
                    filetypes = { "rust" },
                    patterns = { "*.rs" },
                },
                c = {
                    enabled = true,
                    parsers = { "c" },

                    queries = {
                        "(preproc_include) @import",
                    },

                    filetypes = { "c" },
                    patterns = { "*.c", "*.h" },
                },
                cpp = {
                    enabled = true,
                    parsers = { "cpp" },
                    queries = {
                        "(preproc_include) @import",
                        "(using_declaration) @import",
                        "(namespace_alias_definition) @import",
                        "(linkage_specification) @import",
                    },
                    filetypes = { "cpp" },
                    patterns = { "*.cpp", "*.cxx", "*.cc", "*.hpp", "*.hxx", "*.hh" },
                },
                python = {
                    enabled = true,
                    parsers = { "python" },
                    queries = {
                        "(import_statement) @import",
                        "(import_from_statement) @import",
                        "(future_import_statement) @import",
                    },
                    filetypes = { "python" },
                    patterns = { "*.py", "*.pyi" },
                },
            },
        },

        config = function(_, opts)
            require("fold_imports").setup(opts)

            -- JetBrains style placeholder text for all folds
            vim.opt.foldtext = "v:lua.gen_jetbrains_foldtext()"
            vim.opt.fillchars:append({ fold = " " })

            _G.gen_jetbrains_foldtext = function()
                local start_line = vim.v.foldstart
                local end_line = vim.v.foldend
                local count = end_line - start_line + 1

                local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
                local keyword = "UNKNOWN IMPORT SYNTAX (EDIT CONFIG)"
                local hl_group = "@keyword"

                for _, line in ipairs(lines) do
                    if line:match("%S") then
                        -- Preprocessors
                        local preproc = line:match("^%s*#%s*(%a+)")

                        if preproc then
                            keyword = "#" .. preproc
                            hl_group = "@keyword.import.c"
                            break
                        end

                        -- Normal imports
                        local word = line:match("^%s*(%a+)")

                        if word and not line:find("^%s*//") and not line:find("^%s*/%*") then
                            keyword = word
                            break
                        end
                    end
                end

                -- Return formatted text
                return {
                    { keyword, hl_group },
                    { " … ", "Comment" },
                    { "(" .. count .. " lines)", "Comment" },
                }
            end

            -- Unfold when cursor enters the import block
            vim.opt.foldopen = { "all" }

            -- Fold when cursor exits the import block
            local group = vim.api.nvim_create_augroup("FoldImportsCursorHover", { clear = true })
            local last_line = -1

            vim.api.nvim_create_autocmd("CursorMoved", {
                group = group,

                callback = function()
                    local current_line = vim.api.nvim_win_get_cursor(0)[1]

                    if last_line ~= -1 and last_line ~= current_line then
                        if vim.fn.foldlevel(last_line) > 0 then
                            local line_count = vim.api.nvim_buf_line_count(0)
                            local top = last_line

                            while top > 1 and vim.fn.foldlevel(top - 1) == vim.fn.foldlevel(last_line) do
                                top = top - 1
                            end

                            local bottom = last_line

                            while bottom < line_count and vim.fn.foldlevel(bottom + 1) == vim.fn.foldlevel(last_line) do
                                bottom = bottom + 1
                            end

                            if current_line < top or current_line > bottom then
                                pcall(vim.cmd.foldclose, { range = { last_line } })
                            end
                        end
                    end

                    last_line = current_line
                end,
            })
        end,
    },
}
