return {

    -- my plugins

    -- this is installed by astronvim itself
    -- {
    --     -- this requires setup in `polish`
    --     "nvim-telescope/telescope-fzf-native.nvim",
    --     requires = { "nvim-telescope/telescope.nvim" },
    --     run = "make",
    -- },
    -- ["folke/trouble.nvim"] = {
    --     requires = "kyazdani42/nvim-web-devicons",
    --     config = function()
    --         require("trouble").setup {
    --             -- your configuration comes here
    --             -- or leave it empty to use the default settings
    --             -- refer to the configuration section below
    --         }
    --     end
    -- },
    --
    -- ["ray-x/lsp_signature.nvim"] = {
    --     config = function() require "lsp_signature".setup() end,
    -- },
    {
        "https://github.com/junegunn/fzf",
        event = "VeryLazy",
    },
    {
        "https://github.com/junegunn/fzf.vim",
        event = "VeryLazy",
    },
    {
        "https://github.com/iautom8things/gitlink-vim",
        event = "VeryLazy",
    },
    {
        "ojroques/nvim-osc52",
        event = "VeryLazy",
        config = function()
            vim.cmd([[nnoremap  <leader>y "+y]]);
            vim.cmd([[vnoremap  <leader>y "+y]]);

            (function()
                local function copy(lines, _)
                    require("osc52").copy(table.concat(lines, "\n"))
                end

                local function paste()
                    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
                end

                vim.g.clipboard = {
                    name = "osc52",
                    copy = { ["+"] = copy, ["*"] = copy },
                    paste = { ["+"] = paste, ["*"] = paste },
                }
            end)();

        end,
        keys = {
            -- {
            --     "<leader>cp",
            --     function()
            --         require("osc52").copy_visual()
            --     end,
            --     mode = "v",
            --     desc = "OSC52: [c]o[p] to cliboard",
            -- },
            -- {
            --     "<leader>y",
            --     function()
            --         require("osc52").copy_visual()
            --     end,
            --     mode = "v",
            --     desc = "OSC52: [y]ank to cliboard",
            -- },
        },
    },
    {
        "https://github.com/editorconfig/editorconfig-vim",
        event = "VeryLazy",
    },
    {
        "https://github.com/ggandor/leap.nvim",
        event = "VeryLazy",
        config = function()
            require('leap').add_default_mappings()
        end,
    },
    -- ['https://github.com/ggandor/leap.nvim'] = {
    --     config = function()
    --         require('leap').add_default_mappings()
    --     end,
    -- },
    -- do not enable until https://github.com/elihunter173/dirbuf.nvim#notes is resolved
    -- ["https://github.com/elihunter173/dirbuf.nvim"] = {}
    -- ['https://github.com/tpope/vim-fugitive'] = {},
    -- ['https://github.com/ThePrimeagen/harpoon'] = {
    --     config = function()
    --         require("harpoon").setup({})
    --     end
    -- },
    -- ["mason-lspconfig"] = {
    --     ensure_installed = { "pyright", "sumneko_lua", "bashls", "gopls", },
    --     automatic_installation = true,
    -- },
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "VeryLazy",
        opts = function(_, defaults)
            local null_ls = require("null-ls")
            defaults.sources = {

                -- bash
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.diagnostics.shellcheck,

                -- lua
                null_ls.builtins.formatting.stylua,

                -- -- python
                -- null_ls.builtins.diagnostics.flake8,
                -- -- null_ls.builtins.diagnostics.pyproject_flake8,
                -- null_ls.builtins.diagnostics.mypy,
                -- -- null_ls.builtins.diagnostics.pycodestyle,
                -- -- null_ls.builtins.diagnostics.pydocstyle,
                -- -- null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.formatting.black,
                -- null_ls.builtins.formatting.isort,
            }

            return defaults
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        opts = {
            defaults = {
                extensions = {
                    fzf = {
                        fuzzy = true, -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true, -- override the file sorter
                        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    },
                },
            },
        },
    },
    -- notify = {
    --     -- https://github.com/rcarriga/nvim-notify/blob/master/lua/notify/config/init.lua#L22
    --     -- default is 5000ms, which is TOO long
    --     -- for some reason, 1000ms waits longer than expected, so I just put the smallest possible value here
    --     timeout = 1,
    -- },

    { "nvim-zh/whitespace.nvim", lazy = false },
    { "Tastyep/structlog.nvim", lazy = false },
}
