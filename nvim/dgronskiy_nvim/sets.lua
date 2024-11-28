local M = {}
local options = {}

options.opt = {
    hidden = true,
    splitbelow = true,
    splitright = true,
    showmatch = true,
    -- guicursor = "",

    number = true,
    relativenumber = true,

    mouse = "a",

    clipboard = "",
    -- clipboard = "unnamedplus",

    errorbells = false,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,
    smartindent = true,

    wrap = false,

    swapfile = false,
    backup = false,
    -- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    undofile = false,

    hlsearch = true,
    incsearch = true,
    ignorecase = true,
    wrapscan = false,

    termguicolors = true,

    scrolloff = 8,
    signcolumn = "yes",

    -- Give more space for displaying messages.
    cmdheight = 2,

    -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
    -- delays and poor user experience.
    updatetime = 50,

    -- Don't pass messages to |ins-completion-menu|.
    -- vim.opt.shortmess:append("c"),

    colorcolumn = "80",

    -- https://dracoater.github.io/2020/03/vim-langmap
    -- langmap = "йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭяЯчЧсСмМиИтТьЬбБюЮ.\\,;qQwWeErRtTyYuUiIoOpP[{]}aAsSdDfFgGhHjJkKlL;:'\"zZxXcCvVbBnNmM\\,<.>/?"

    -- langmap = "1!2\"3№4;5%6:7?8*9(0)-_=+йЙцЦуУкКеЕнНгГшШщЩзЗхХъЪфФыЫвВаАпПрРоОлЛдДжЖэЭ\\/яЯчЧсСмМиИтТьЬбБюЮ.,;1!2@3#4$5%6^7&8*9(0)-_=+aAsSdDfFgGhHjJkKlL;:'\"\\|zZxXcCvVbBnNmM,<.>/?"


    shada="!,'10000,<50,s10,h", -- default is shada=!,'100,<50,s10,h
}

options.g = {
    mapleader = " ",

    -- astronvim defaults:
    -- https://github.com/AstroNvim/AstroNvim/tree/893665a969129eb528e54b7e4bee1e6c952d6d25/lua/core/options.lua#L60
    autopairs_enabled = false,
    autoformat_enabled = false,

    -- dgronskiy: Astronvim sets up Aerial.nvim with these options, increased thresholds
    -- AstroNvim specific global options
    max_file = { size = 1024 * 1024 * 4, lines = 10000 }, -- set global limits for large files
}

function M.export_astronvim()
    return options
end

return M
