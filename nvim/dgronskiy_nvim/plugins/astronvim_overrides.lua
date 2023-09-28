return {
    -- configuratino of plugins shipped with Astronvim
    { "goolord/alpha-nvim", enabled = false },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        commit = "origin/HEAD", -- astronvim machinery prevents this from updates
    },
    {
        "nvim-treesitter/nvim-treesitter",
        commit = "origin/HEAD", -- astronvim machinery prevents this from updates
    },
}
