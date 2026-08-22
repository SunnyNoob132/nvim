-- Ensure correct <leader> is set before declaring keybinds
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<D-Left>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<D-Down>", "<C-w>j", { desc = "Focus lower window" })
vim.keymap.set("n", "<D-Up>", "<C-w>k", { desc = "Focus upper window" })
vim.keymap.set("n", "<D-Right>", "<C-w>l", { desc = "Focus right window" })
vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy UI" })
vim.keymap.set("n", "<leader>ls", "<cmd>Lazy sync<cr>", { desc = "Lazy sync" })
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<cr>", { desc = "Lazy update" })

-- Keep indentation when pressing return in insert
local function smart_move(key)
    return function()
        local curr_line = vim.fn.line(".")
        local target_line = key == "<Up>" and curr_line - 1 or curr_line + 1

        if target_line < 1 or target_line > vim.fn.line("$") then
            return key
        end

        local line_content = vim.fn.getline(target_line)

        if line_content:match("^%s*$") then -- Check if the target line is empty
            return key .. "<C-f>"
        end

        return key
    end
end

vim.keymap.set("i", "<Up>", smart_move("<Up>"), { expr = true })
vim.keymap.set("i", "<Down>", smart_move("<Down>"), { expr = true })

-- Auto indent on paste
local function paste_with_auto_indent(put_cmd)
    return function()
        local register = vim.v.register
        local count = vim.v.count1
        local prefix = count > 1 and tostring(count) or ""

        if register ~= nil and register ~= "" and register ~= '"' then
            prefix = '"' .. register .. prefix
        end

        vim.cmd("normal! " .. prefix .. put_cmd)
        local cursor_after_paste = vim.api.nvim_win_get_cursor(0)

        local first_line = vim.fn.line("'[")
        local last_line = vim.fn.line("']")

        if first_line > 0 and last_line >= first_line then
            vim.cmd(first_line .. "," .. last_line .. "normal! ==")
        else
            vim.cmd("normal! ==")
        end

        vim.api.nvim_win_set_cursor(0, cursor_after_paste)
    end
end

vim.keymap.set("n", "p", paste_with_auto_indent("p"), { desc = "Paste and auto indent" })
vim.keymap.set("n", "P", paste_with_auto_indent("P"), { desc = "Paste before and auto indent" })
vim.keymap.set("n", "gp", paste_with_auto_indent("gp"), { desc = "Paste after cursor and auto indent" })
vim.keymap.set("n", "gP", paste_with_auto_indent("gP"), { desc = "Paste before cursor and auto indent" })
