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
        -- commit = "origin/HEAD", -- astronvim machinery prevents this from updates
        commit = "origin/main", -- astronvim machinery prevents this from updates
        build = ":TSUpdate",
        opts = {
            ensure_installed = {
                "bash",
                "c",
                "cpp",
                "diff",
                "html",
                "css",
                "cuda",
                "javascript",
                "json",
                "lua",
                "luadoc",
                "markdown",
                "markdown_inline",
                "python",
                "tsx",
                "typescript",
                "vim",
                "vimdoc",
                "xml",
                "yaml",
                "go",
                "gosum",
                "gowork",
            },
        },
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        enabled = false,
        opts = function(plugin, opts)
            -- vim.deep_tbl_extend does has a side effect of
            -- trmbling vertical navigation: pressing `k`, e.g.
            -- can occassionally move cursor up and then back
            -- I don't why though
            override_with = {
                event_handlers = {
                    { -- ~/.config/astronvim3/lua/plugins/neo-tree.lua
                        event = "neo_tree_buffer_enter",
                        handler = function(_)
                            vim.opt_local.signcolumn = "auto"
                        end,
                    },
                    { -- https://github.com/nvim-neo-tree/neo-tree.nvim/discussions/843
                        event = "neo_tree_buffer_enter",
                        handler = function(arg)
                            vim.opt.relativenumber = true
                        end,
                    },
                },
            }

            opts.event_handlers = override_with.event_handlers
            return opts
        end,
    },
}
