vim.opt.cindent = true
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.exrc = true
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20,t:ver25-blinkon500-blinkoff500-TermCursor"
vim.opt.ignorecase = true
vim.opt.mousemoveevent = true
vim.opt.number = true
vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.softtabstop = 2
vim.opt.smoothscroll = true
vim.opt.spell = true
vim.opt.termguicolors = true
vim.opt.winborder = "rounded"
vim.opt.fillchars:append({ eob = " " })

-- Custom status column in editors

local blacklist = { "alpha", "neo-tree", "trouble", "qf", "lazy", "mason", "help", "noice", "toggleterm" }

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",

    callback = function(args)
        if not vim.tbl_contains(blacklist, args.match) then
            vim.opt_local.statuscolumn = "%= %s%l  "
        end
    end,
})
