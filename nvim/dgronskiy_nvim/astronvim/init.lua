config = {
    -- colorscheme = "default_theme",
    -- colorscheme = "gruvbox",
    colorscheme = "rose-pine",
    options = require('dgronskiy_nvim.sets').export_astronvim(),

    lsp = {
        servers = {},
        formatting = {
            format_on_save = {
                enable = false,
            },
            disabled = {},
        },
        mappings = function(astronvim_defaults)
            -- see  lua/core/utils/lsp.lua

            astronvim_defaults.n['K'] = nil
            return astronvim_defaults
        end,
        ["server-settings"] = {},
    },

    diagnostics = {
        virtual_text = false,
    },

    mappings = require("dgronskiy_nvim.astronvim.mappings").astronvim_mappings_callback,
    plugins = {
        --
        -- https://github.com/wbthomason/packer.nvim#specifying-plugins
        --
        init = {
            -- configuratino of plugins shipped with Astronvim
            ["goolord/alpha-nvim"] = { disable = true },

            -- my plugins

            -- this is installed by astronvim itself
            -- {
            --     -- this requires setup in `polish`
            --     "nvim-telescope/telescope-fzf-native.nvim",
            --     requires = { "nvim-telescope/telescope.nvim" },
            --     run = "make",
            -- },
            ["folke/trouble.nvim"] = {
                requires = "kyazdani42/nvim-web-devicons",
                config = function()
                    require("trouble").setup {
                        -- your configuration comes here
                        -- or leave it empty to use the default settings
                        -- refer to the configuration section below
                    }
                end
            },
            -- ["ray-x/lsp_signature.nvim"] = {
            --     config = function() require "lsp_signature".setup() end,
            -- },
            ['https://github.com/junegunn/fzf'] = {},
            ['https://github.com/junegunn/fzf.vim'] = {},
            ['https://github.com/iautom8things/gitlink-vim'] = {},
            ['gruvbox-community/gruvbox'] = {},
            ['rose-pine/neovim'] = {
                as = 'rose-pine',
                -- config = function()
                --     vim.cmd('colorscheme rose-pine')
                -- end
            },
        },
        ["mason-lspconfig"] = {
            ensure_installed = { "pyright", "sumneko_lua", "bashls", "gopls", },
            automatic_installation = true,
        },
        ["null-ls"] = function(defaults)
            local null_ls = require("null-ls")
            defaults.sources = {

                -- bash
                null_ls.builtins.code_actions.shellcheck,
                null_ls.builtins.diagnostics.shellcheck,

                -- python
                null_ls.builtins.diagnostics.flake8,
                -- null_ls.builtins.diagnostics.pyproject_flake8,
                null_ls.builtins.diagnostics.mypy,
                -- null_ls.builtins.diagnostics.pycodestyle,
                -- null_ls.builtins.diagnostics.pydocstyle,
                -- null_ls.builtins.diagnostics.pylint,
                null_ls.builtins.formatting.black,
                -- null_ls.builtins.formatting.isort,

            }

            return defaults

        end,

        telescope = {
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
    polish = function()
        vim.cmd [[ set wildmode=longest:full,full ]] -- https://vi.stackexchange.com/a/11424/7248




        -- vim.cmd [[ autocmd FileType * nnoremap <nowait> <buffer> <leader>f :lua print("another one")<CR> ]]
        -- vim.cmd [[ autocmd FileType * nnoremap <nowait> <buffer> <leader>f :lua print("another one") ]]
        -- vim.cmd [[ autocmd FileType * lua print("auto!")<CR> ]]
        --
        -- local cnt = 0
        --
        -- vim.api.nvim_create_autocmd("BufAdd", {
        --     callback = function()
        --         cnt = cnt + 1
        --         print("wowowowowo " .. tostring(cnt))
        --         vim.keymap.set("n", "<leader>f", function() print("here we go111") end, { buffer = true, nowait = true})
        --     end
        -- })

        -- vim.keymap.set("n", "<leader>f", function() print("here we go") end, {nowait = true, buffer = true})
        vim.cmd [[ nnoremap * :keepjumps normal! mi*`i<CR> """ * ]]
        vim.cmd [[ command GitLink :echo gitlink#GitLink() ]]

        vim.cmd [[ command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0) ]]
        vim.cmd [[ command! -bang -nargs=* FindExact call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0) ]]

        vim.cmd [[ vnoremap <Leader>cat :'<,'>w !tee<CR> ]]
        vim.cmd [[ vnoremap <Leader>cp  :'<,'>w !~/.iterm2/it2copy<CR> ]]

        vim.cmd [[ nnoremap <Leader>find :Find  ]]

        -- vim.cmd [[ nnoremap K :FindExact <C-R><C-W><CR> ]]


        --     vnoremap K "vy :FindExact <C-R>v<CR>
        --     nnoremap <Leader>find :Find
        --     nnoremap <Leader>/ :BLines<CR>
        --     vnoremap <Leader>/ "vy :BLines '<C-R>v<CR>
        -- ]]
    end,

}

return config
