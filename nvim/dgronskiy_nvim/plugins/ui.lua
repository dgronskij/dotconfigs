return {
    {
        -- https://github.com/ellisonleao/gruvbox.nvim#configuration
        "ellisonleao/gruvbox.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        -- https://github.com/pustota-theme/pustota.nvim
        "pustota-theme/pustota.nvim",
        lazy = false,
        priority = 1000,
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
    },
    {
        "famiu/bufdelete.nvim",
        cmd = { "Bdelete" },
        keys = {
            { "<leader>q", "<cmd>Bdelete<cr>", desc = "Close current buffer (:Bdelete)" },
        },
    },
    -- {   -- misbehaves
    --     -- https://github.com/camspiers/lens.vim
    --     "camspiers/lens.vim",
    --     config = function(_, _)
    --         vim.cmd([[let g:lens#disabled = 0]])
    --         vim.cmd([[let g:lens#animate = 0]])
    --     end,
    --     event = "VeryLazy",
    -- },
}
