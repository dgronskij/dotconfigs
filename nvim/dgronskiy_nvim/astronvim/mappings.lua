local M = {}
local mapping = {}

-- NORMAL mode
mapping["n"] = {
    ["<leader>f<CR>"] = {
        require("dgronskiy_nvim.telescope_custom").find_all_files,
        desc = "Open file",
    },
    ["<ESC>"] = {
        function()
            vim.cmd([[ :noh ]])
        end,
    },
    -- ["S-k"] = { function() vim.cmd [[ FindExact <C-R><C-W><CR> ]] end },
    -- ["S-k"] = { function()
    --     print "hahahaha"
    --     -- vim.cmd [[ :FindExact <C-R><C-W><CR> ]]
    -- end },
    -- ["K"] = { function()
    --     print("hahahaha")
    --     local cursor_word = vim.fn.expand "<cword>"
    --     vim.cmd( ":FindExact " .. cursor_word )
    -- end },
    -- ["S-k"] = { function()
    --     print("hahahaha")
    --     -- local cursor_word = vim.fn.expand "<cword>"
    --     -- vim.cmd( ":FindExact " .. cursor_word .. "<CR>")
    -- end },
    --
    ["<S-K>"] = { ":FindExact <C-R><C-W><CR>", desc = "FZF: find the word under cursor" },
    ["<leader><S-K>"] = { ":ArcFindExact <C-R><C-W><CR>", desc = "Arc: find the word under cursor" },
    ["<leader>/"] = { ":BLines<CR>", desc = "FZF: Buffer lines" },

    -- jump to the tab by its number
    ["<leader>1"] = { "1gt", desc = "[g]o to [t]ab 1" },
    ["<leader>2"] = { "2gt", desc = "[g]o to [t]ab 2" },
    ["<leader>3"] = { "3gt", desc = "[g]o to [t]ab 3" },
    ["<leader>4"] = { "4gt", desc = "[g]o to [t]ab 4" },

    -- buffer navigation
    ["<S-L>"] = { "<Cmd>bnext<CR>", desc = "Next buffer" },
    ["<S-H>"] = { "<Cmd>bnext<CR>", desc = "Previous buffer" },

    ["<C-W><C-T>"] = { "<Cmd>tab split<CR>", desc = "open current buffer in new tab" },

    -- override astronvim defaults

    -- NOTE: this is an adoption of https://github.com/AstroNvim/AstroNvim/blob/567c01bc6a446da8150f9904d11ee9530e47e82f/lua/astronvim/mappings.lua#L168-L178
    -- All I want is a toggle functionality with position=current (i.e. occupy all buffer, not side one)
    -- toggle position=current does not reveal current file
    -- toggle position=current reveal_file=% does not work with directories
    -- focus position=current works for opening, but doesn't close
    -- original wincmd p does not jump back to empty unnamed buffer
    ["<leader>e"] = {
        function()
            if vim.bo.filetype == "neo-tree" then
                vim.cmd([[Neotree close]])
            else
                -- vim.cmd([[Neotree focus position=current]])
                vim.cmd([[Neotree source=filesystem reveal=true position=current]])
            end
        end,
        noremap = true,
        desc = "Toggle Explorer",
    },
    ["<C-q>"] = { "<C-w>q", desc = "Close window" },
}

-- VISUAL mode
mapping["v"] = {
    ["<S-K>"] = { '"vy :FindExact <C-R>v<CR>', desc = "FZF: find the selection" },
    ["<leader>cs"] = { '"vy :ArcFind <C-R>v<CR>', desc = "Arc: find the selection" },
    ["<leader>/"] = { '"vy :BLines <C-R>v<CR>', desc = "FZF: buffer lines" },
    -- ["<C-j>"] = { function()
    --     -- vim.cmd [[ "vy ]] -- this doesn' work
    --     -- print("hello: " .. vim.fn.getreg("v")) -- this works
    --
    --     vim.cmd [[ execute 'normal!' '"vy' ]]
    --     vim.cmd [[ execute 'echo "start:" @v ":end" '  ]]
    -- end },
}

-- FIXME: uncomment after fixing search higlight disappearing
-- -- ThePrimeagen: center viewport for up/down motions
-- -- https://youtu.be/KfENDDEpCsI?t=337
local M_keymap = require("dgronskiy_nvim.keymap")
-- M_keymap.nnoremap("<C-d>", "<C-d>zz")
-- M_keymap.nnoremap("<C-u>", "<C-u>zz")
-- M_keymap.nnoremap("n", "nzzzv", { silent = true })
-- M_keymap.nnoremap("N", "Nzzzv", { silent = true })

-- greatest remap ever
-- vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

function M.astronvim_mappings_callback(_)
    astronvim_defaults = M.saner_astronvim_defaults()
    merged = vim.tbl_deep_extend("force", astronvim_defaults, mapping)
    return merged
end

function M.saner_astronvim_defaults()
    return require("dgronskiy_nvim.astronvim.saner_defaults")
end

return M
