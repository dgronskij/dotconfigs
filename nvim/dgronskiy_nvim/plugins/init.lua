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
        "folke/trouble.nvim",
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
    },
    {
        "https://github.com/junegunn/fzf",
        event = "VeryLazy",
    },
    {
        "https://github.com/junegunn/fzf.vim",
        dependencies = {
            "https://github.com/junegunn/fzf",
        },
        event = "VeryLazy",
        config = function()
            -- https://thevaluable.dev/fzf-vim-integration/
            vim.g.fzf_vim = {}
            vim.g.fzf_vim.preview_window = { "hidden,right,50%,<70(up,40%)", "ctrl-p" }
            vim.g.fzf_preview_window = { "hidden,right,50%,<70(up,40%)", "ctrl-p" }
            vim.g.fzf_dgronskiy_dict = {
                options = '--bind "ctrl-j:down,ctrl-k:up"',
            }

            -- vim.g.fzf_vim.preview_window = { "right,10%", "ctrl-/" }
            -- vim.g.fzf_vim.preview_window = { "right,10%", "ctrl-?" }
            -- vim.g.fzf_preview_window = { "right,10%", "ctrl-?" }
            vim.g.fzf_layout = { window = { width = 0.95, height = 0.95 } }
        end,
    },
    {
        "https://github.com/iautom8things/gitlink-vim",
        event = "VeryLazy",
    },
    {
        "ojroques/nvim-osc52",
        event = "VeryLazy",
        config = function()
            vim.cmd([[nnoremap  <leader>y "+y]])
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
            end)()
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
        enabled = false,
        config = function()
            require("leap").add_default_mappings()
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        -- "https://github.com/niqodea/lasso.nvim",
        "https://github.com/dgronskij/lasso.nvim",
        commit = "dev",
        event = "VeryLazy",
        config = function()
            local lasso = require("lasso")
            lasso.setup({
                marks_tracker_path = "/home/dgronskiy/vims/.lasso-marks",
            })

            -- Mark current file
            vim.keymap.set("n", vim.g.mapleader .. "m", function()
                lasso.mark_file()
            end)

            -- Go to marks tracker (editable, use `gf` to go to file under cursor)
            vim.keymap.set("n", vim.g.mapleader .. "M", function()
                lasso.open_marks_tracker()
            end)

            -- Jump to n-th marked file (n-th line of marks tracker)
            vim.keymap.set("n", vim.g.mapleader .. "1", function()
                lasso.open_marked_file(1)
            end)
            vim.keymap.set("n", vim.g.mapleader .. "2", function()
                lasso.open_marked_file(2)
            end)
            vim.keymap.set("n", vim.g.mapleader .. "3", function()
                lasso.open_marked_file(3)
            end)
            vim.keymap.set("n", vim.g.mapleader .. "4", function()
                lasso.open_marked_file(4)
            end)
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
    {
        "zapling/mason-lock.nvim",
        event = "VeryLazy",
        config = function()
            require("mason-lock").setup({
                -- keep this in sync with lazy lockfile setup!
                -- lockfile_path = vim.fn.stdpath("config") .. "/mason-lock.json" -- (default)
                lockfile_path = vim.fn.stdpath("config") .. "/lua/user/mason-lock.json",
            })
        end,
    },
    { -- https://github.com/nvim-treesitter/nvim-treesitter-context?tab=readme-ov-file#configuration
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        opts = {
            min_window_height = 10,
            max_lines = 5,
            multiline_threshold = 1,
            mode = "topline",
        },
        -- keys = {
        --     { -- conflicts with :cprev mapping
        --         "[c",
        --         function()
        --             require("treesitter-context").go_to_context(vim.v.count1)
        --         end,
        --         mode = "n",
        --         desc = "treesitter-context: jump to context (upwards)",
        --         silent = true,
        --     },
        -- },
    },
    { -- https://github.com/theHamsta/crazy-node-movement
        "theHamsta/crazy-node-movement",
        event = "VeryLazy",
        config = function()
            require("nvim-treesitter.configs").setup({
                node_movement = {
                    enable = true,
                    keymaps = {
                        move_up = "˙", -- option-h
                        move_down = "¬", --option-l
                        move_left = "˚", -- option-k
                        move_right = "∆", -- option-j
                        -- swap_left = "<s-a-h>", -- will only swap when one of "swappable_textobjects" is selected
                        -- swap_right = "<s-a-l>",
                        select_current_node = "<leader><Cr>",
                    },
                    swappable_textobjects = { "@function.outer", "@parameter.inner", "@statement.outer" },
                    allow_switch_parents = true, -- more craziness by switching parents while staying on the same level, false prevents you from accidentally jumping out of a function
                    allow_next_parent = true, -- more craziness by going up one level if next node does not have children
                },
            })
        end,
    },
    {
        "mogelbrod/vim-jsonpath",
        event = "VeryLazy",
    },
    { -- https://github.com/johmsalas/text-case.nvim?tab=readme-ov-file#example-for-lazyvim
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            require("textcase").setup({})
            require("telescope").load_extension("textcase")
            vim.api.nvim_set_keymap("n", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
            vim.api.nvim_set_keymap("v", "ga.", "<cmd>TextCaseOpenTelescope<CR>", { desc = "Telescope" })
        end,
        cmd = {
            -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
            -- "Subs",
            "TextCaseOpenTelescope",
            -- "TextCaseOpenTelescopeQuickChange",
            -- "TextCaseOpenTelescopeLSPChange",
            -- "TextCaseStartReplacingCommand",
        },
        lazy = false,
        -- event = "VeryLazy",
    },
    {
        -- https://github.com/echasnovski/mini.files?tab=readme-ov-file
        "echasnovski/mini.files",
        version = "*",
        event = "VeryLazy",
        config = function()
            require('mini.files').setup({
                windows = {
                    preview = true,
                    width_focus = 50,
                    width_nofocus = 15,
                    width_preview = 50,
                },

            })

            -- this is from :h mini.files
            local set_cwd = function()
                local path = (MiniFiles.get_fs_entry() or {}).path
                if path == nil then return vim.notify('Cursor is not on valid entry') end
                vim.fn.chdir(vim.fs.dirname(path))
            end

            -- Yank in register full path of entry under cursor
            local yank_path = function()
                local path = (MiniFiles.get_fs_entry() or {}).path
                if path == nil then return vim.notify('Cursor is not on valid entry') end
                vim.fn.setreg(vim.v.register, path)
            end

            local go_in_close = function()
                MiniFiles.go_in({
                    close_on_file = true,
                })
            end

            -- https://github.com/nvim-mini/mini.nvim/issues/760
            -- see: https://github.com/nvim-mini/mini.nvim/blob/a683bfe8e03293e3bb079e24c94e51977756a3ec/doc/mini-files.txt#L433-L448
            local map_split = function(buf_id, lhs, direction)
                local rhs = function()
                    -- Make new window and set it as target
                    local new_target_window
                    vim.api.nvim_win_call(MiniFiles.get_target_window(), function()  -- FIXME: get_target_window is a nil value
                        vim.cmd(direction .. ' split')
                        new_target_window = vim.api.nvim_get_current_win()
                    end)

                    MiniFiles.set_target_window(new_target_window)
                    go_in_close()
                end

                -- Adding `desc` will result into `show_help` entries
                local desc = 'Split ' .. direction
                vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
            end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local b = args.data.buf_id
                    vim.keymap.set('n', 'g.', set_cwd,   { buffer = b, desc = 'Set cwd' })
                    vim.keymap.set('n', 'gy', yank_path, { buffer = b, desc = 'Yank path' })
                    vim.keymap.set('n', '<CR>', go_in_close, { buffer = b, desc = 'Go in plus' })

                    map_split(buf_id, 'gs', 'belowright horizontal')
                    map_split(buf_id, 'gv', 'belowright vertical')
                end,
            })

        end,
        keys = {
            {
                "<leader>ef",
                "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<cr>",
                desc = "MiniFiles: reveal current file",
            },
        }
        -- lazy = false,
    },
}
