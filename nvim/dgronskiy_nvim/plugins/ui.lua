return {
    { 'gruvbox-community/gruvbox' },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
    },
    {
        "famiu/bufdelete.nvim",
        cmd = { "Bdelete" },
        keys = {
            { "<leader>q", "<cmd>Bdelete<cr>", desc = "Close current buffer (:Bdelete)" }
        },
    }
}
