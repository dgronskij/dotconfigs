return {
    {
        -- https://github.com/ellisonleao/gruvbox.nvim#configuration
        "ellisonleao/gruvbox.nvim",
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
}
