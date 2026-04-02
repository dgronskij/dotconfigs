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
            { "<leader>q", "<cmd>bdelete<cr>", desc = "close current buffer (:bdelete)" },
        },
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
    },
    {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
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
