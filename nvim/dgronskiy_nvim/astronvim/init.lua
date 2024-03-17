if vim.fn.has("nvim-0.10") == 0 then
    error("Please install nvim >= 0.10")
end

config = {
    lazy = {
        -- by default, lazy.nvim keeps lock file in stdpath("config"),
        -- which is usually a git repo (works for lazyvim, kickstart.nvim)
        -- Astronvim, on the other hand, keeps its own files in stdpath("config")
        -- and all hooking takes place in the /lua/user/ subdirectory
        lockfile = vim.fn.stdpath("config") .. "/lua/user/lazy-lock.json",
    },
    updater = {
        -- couldn't update nvim-lspconfig because of default behaviour
        -- pin_plugins = false,
    },
    -- colorscheme = "default_theme",
    colorscheme = "gruvbox",
    -- colorscheme = "rose-pine",
    options = require("dgronskiy_nvim.sets").export_astronvim(),
    lsp = {
        servers = {
            "pyright",
        },

        -- formatting = {
        --     -- control auto formatting on save
        --     format_on_save = {
        --         enabled = true, -- enable or disable format on save globally
        --         allow_filetypes = { -- enable format on save for specified filetypes only
        --         -- "go",
        --     },
        --     ignore_filetypes = { -- disable format on save for specified filetypes
        --     -- "python",
        --     },
        -- },
        -- disabled = { -- disable formatting capabilities for the listed language servers
        --             -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        --             -- "lua_ls",
        -- },
        -- timeout_ms = 1000, -- default format timeout
        -- -- filter = function(client) -- fully override the default formatting function
        -- --   return true
        -- -- end
        -- },

        formatting = {
            format_on_save = {
                enable = false,
            },
            disabled = {},
        },
        mappings = function(astronvim_defaults)
            -- see  lua/core/utils/lsp.lua

            astronvim_defaults.n["K"] = nil
            return astronvim_defaults
        end,
        config = {
            -- https://github.com/microsoft/pyright/blob/main/docs/settings.md
            pyright = {
                autostart = true,
                -- autostart = false,
                -- autostart = (function ()
                --     local val = os.getenv("NVIM_ENABLE_LSP_PYRIGHT")
                --     return val ~= nil and #val ~= 0
                -- end)(),
                root_dir = require("dgronskiy_nvim.ytils").guarded_pyright_root_directory,
                -- root_ir = function()
                --     return "/home/dgronskiy" -- for some reason large workspace hangs everything
                -- end,
                -- analysis = {
                --     logLevel = "Trace",
                -- },
            },
            gopls = { autostart = false },
        },
    },
    diagnostics = {
        virtual_text = false,
        underline = false,
    },
    mappings = require("dgronskiy_nvim.astronvim.mappings").astronvim_mappings_callback,
    -- plugins = {
    --     --
    --     -- https://github.com/wbthomason/packer.nvim#specifying-plugins
    --     --
    --     init = {
    --         -- configuratino of plugins shipped with Astronvim
    --         ["goolord/alpha-nvim"] = { disable = true },
    --         -- ["Darazaki/indent-o-matic"] = { disable = true },
    --
    --         -- my plugins
    --
    --         -- this is installed by astronvim itself
    --         -- {
    --         --     -- this requires setup in `polish`
    --         --     "nvim-telescope/telescope-fzf-native.nvim",
    --         --     requires = { "nvim-telescope/telescope.nvim" },
    --         --     run = "make",
    --         -- },
    --         ["folke/trouble.nvim"] = {
    --             requires = "kyazdani42/nvim-web-devicons",
    --             config = function()
    --                 require("trouble").setup {
    --                     -- your configuration comes here
    --                     -- or leave it empty to use the default settings
    --                     -- refer to the configuration section below
    --                 }
    --             end
    --         },
    --         -- ["ray-x/lsp_signature.nvim"] = {
    --         --     config = function() require "lsp_signature".setup() end,
    --         -- },
    --         ['https://github.com/junegunn/fzf'] = {},
    --         ['https://github.com/junegunn/fzf.vim'] = {},
    --         -- ['https://github.com/iautom8things/gitlink-vim'] = {},
    --
    --         ['https://github.com/dgronskij/gitlink-vim'] = {},
    --         -- ['https://github.com/ruifm/gitlinker.nvim'] = {
    --         --     requires = 'nvim-lua/plenary.nvim',
    --         --     config = function() require("gitlinker").setup() end,
    --         -- },
    --         ['https://github.com/ggandor/leap.nvim'] = {
    --             config = function()
    --                 require('leap').add_default_mappings()
    --             end,
    --         },
    --         -- do not enable until https://github.com/elihunter173/dirbuf.nvim#notes is resolved
    --         -- ["https://github.com/elihunter173/dirbuf.nvim"] = {}
    --         ['https://github.com/tpope/vim-fugitive'] = {},
    --         ['https://github.com/ThePrimeagen/harpoon'] = {
    --             config = function()
    --                 require("harpoon").setup({})
    --             end
    --         },
    --         ['https://github.com/editorconfig/editorconfig-vim'] = {},
    --         ['ojroques/nvim-osc52'] = {},
    --     },
    --     -- ["mason-lspconfig"] = {
    --     --     ensure_installed = { "pyright", "sumneko_lua", "bashls", "gopls", },
    --     --     automatic_installation = true,
    --     -- },
    --     ["null-ls"] = function(defaults)
    --         local null_ls = require("null-ls")
    --         defaults.sources = {
    --
    --             -- bash
    --             null_ls.builtins.code_actions.shellcheck,
    --             null_ls.builtins.diagnostics.shellcheck,
    --
    --             -- python
    --             null_ls.builtins.diagnostics.flake8,
    --             -- null_ls.builtins.diagnostics.pyproject_flake8,
    --             null_ls.builtins.diagnostics.mypy,
    --             -- null_ls.builtins.diagnostics.pycodestyle,
    --             -- null_ls.builtins.diagnostics.pydocstyle,
    --             -- null_ls.builtins.diagnostics.pylint,
    -- null_ls.builtins.formatting.black,
    --             null_ls.builtins.formatting.isort,
    --
    --         }
    --
    --         return defaults
    --     end,
    --     telescope = {
    --         defaults = {
    --             extensions = {
    --                 fzf = {
    --                     fuzzy = true,                   -- false will only do exact matching
    --                     override_generic_sorter = true, -- override the generic sorter
    --                     override_file_sorter = true,    -- override the file sorter
    --                     case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
    --                 },
    --             },
    --         },
    --     },
    --     notify = {
    --         -- https://github.com/rcarriga/nvim-notify/blob/master/lua/notify/config/init.lua#L22
    --         -- default is 5000ms, which is TOO long
    --         -- for some reason, 1000ms waits longer than expected, so I just put the smallest possible value here
    --         timeout = 1,
    --     },
    -- },
    polish = function()
        vim.cmd([[ set wildmode=longest:full,full ]]) -- https://vi.stackexchange.com/a/11424/7248

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

        -- on * key pressed, hightlight cword, but do not immediately jump
        -- https://stackoverflow.com/a/49944815/539570
        vim.cmd([[nnoremap <silent> * :let @/= '\<' . expand('<cword>') . '\>' <bar> set hls <cr>]])
        -- vim.cmd([[ nnoremap <silent> / normal! zz/]])
        -- vim.cmd([[ nnoremap <silent> / normal! /]])
        vim.cmd([[ command GitLink :echo gitlink#GitLink() ]])

        vim.cmd(
            [[ command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0) ]]
        )
        vim.cmd(
            [[ command! -bang -nargs=* FindExact call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0) ]]
        )

        vim.cmd(
            -- + case-insensitive
            [[ command! -bang -nargs=* ArcFind call fzf#vim#grep('ya tool cs -i --current-folder --no-contrib --no-junk --max all  --color "always" -- '.shellescape(<q-args>), 1, <bang>0) ]]
        )
        vim.cmd(
            [[ command! -bang -nargs=* ArcFindExact call fzf#vim#grep('ya tool cs --current-folder --no-contrib --no-junk --max all -F --color "always" -- '.shellescape(<q-args>), 1, <bang>0) ]]
        )

        -- FIXME: this uses grep format (see that period symbol before --file) and corresponding fzf command
        -- Unfortunately, fzf#vim#file is not dynamically configurable
        -- fzf-lua does
        -- edially, this is the case for telescope live-grep fuctionality where on each input update the request to `cs` tool is made (since its pretty fast)
        -- TODO: remove `.` search pattern
        --       remove -g1 (max match per file)
        vim.cmd(
            -- + case-insensitive
            [[ command! -bang -nargs=* ArcFiles call fzf#vim#grep('ya tool cs -i --current-folder --no-contrib --no-junk --max 1000 --color "always" . -g1 --file '.shellescape(<q-args>), 1, <bang>0) ]]
        )
        -- vim.cmd(
        -- -- + case-insensitive
        --     [[ command! -bang -nargs=* ProjectFiles call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, <bang>0) ]]
        -- )

        vim.cmd([[ vnoremap <Leader>cat :'<,'>w !tee<CR> ]])

        vim.cmd([[ nnoremap <Leader>find :Find  ]])
        vim.cmd([[ nnoremap <Leader>fd :Find  ]])
        vim.cmd([[ nnoremap <Leader>cs :ArcFind  ]])

        vim.cmd([[
          map <Leader>dark :set background=dark<CR>
          map <Leader>light :set background=light<CR>
        ]])

        vim.cmd([[nnoremap <Leader>b :Buffers<CR>]])
        vim.cmd([[nnoremap <Leader>h :History<CR>]])

        -- open dgronskiy_nvim.log ; go to end
        vim.cmd(
            [[ command DGronskiyNvimLog :execute "e " .. expand(stdpath("log")) .. "/dgronskiy_nvim.log | normal \<S-G>" ]]
        )

        vim.api.nvim_create_user_command("Cd", function(args)
            local target_dir = vim.fn.expand("%:p:h")
            vim.cmd.cd(target_dir)
            vim.print(":cd " .. target_dir)
        end, { desc = "[C]hange [D]irectory to currently opened file" })
        vim.cmd([[nnoremap  <leader>cd    :Cd<CR>]])

        vim.api.nvim_create_user_command("Lcd", function(args)
            local target_dir = vim.fn.expand("%:p:h")
            vim.cmd.lcd(target_dir)
            vim.print(":lcd " .. target_dir)
        end, { desc = "[L]ocal [C]hange [D]irectory to currently opened file" })
        vim.cmd([[nnoremap  <leader>lcd  :Lcd<CR>]])

        vim.cmd([[ vnoremap > >gv ]])
        vim.cmd([[ vnoremap < <gv ]])

        vim.cmd([[nnoremap  <leader>t<CR>  :Tags '<C-R><C-W> <CR>]])
        vim.cmd([[vnoremap  <leader>t<CR> "vy :Tags '<C-R>v <CR>]])

        -- ["<S-Tab>"] = { "<gv", desc = "Unindent line" },
        -- ["<Tab>"] = { ">gv", desc = "Indent line" },

        -- vim.cmd [[ nnoremap K :FindExact <C-R><C-W><CR> ]]

        --     vnoremap K "vy :FindExact <C-R>v<CR>
        --     nnoremap <Leader>find :Find
        --     nnoremap <Leader>/ :BLines<CR>
        --     vnoremap <Leader>/ "vy :BLines '<C-R>v<CR>
        -- ]]

        -- vim.cmd [[ vnoremap <Leader>cp  :'<,'>w !~/.iterm2/it2copy<CR> ]]
        -- vim.keymap.set('n', '<leader>c', require('osc52').copy_operator, {expr = true})
        -- vim.keymap.set('n', '<leader>cc', '<leader>c_', {remap = true})

        -- TODO: move to key = .. in the plugin spec
        -- vim.keymap.set('v', '<leader>cp', require('osc52').copy_visual)

        -- https://stackoverflow.com/questions/12315612/move-forward-backwards-one-word-in-command-mode
        vim.cmd([[
            cnoremap <C-a> <Home>
            cnoremap <C-e> <End>
            "cnoremap <C-p> <Up>
            "cnoremap <C-n> <Down>
            "cnoremap <C-b> <Left>
            "cnoremap <C-f> <Right>
            "cnoremap <M-b> <S-Left>
            "cnoremap <M-f> <S-Right>
        ]])

        ; (function()
            -- https://github.com/Wansmer/langmapper.nvim
            local function escape(str)
                -- You need to escape these characters to work correctly
                local escape_chars = [[;,."|\]]
                local escape_chars = [[;,"|\]]
                return vim.fn.escape(str, escape_chars)
            end

            -- Recommended to use lua template string
	    -- IMPORTANT:
	    -- this is still a hack without knowing actual active keyboard layout;
	    -- one cannot map e.g. `.` (russian layout) into `/` (corresponding character in english layout)
	    -- since that mapping would "work" (= break everything) with english layout too
            local en = [[qwertyuiop[]asdfghjkl;'zxcvbnm,.]]
            local ru = [[йцукенгшщзхъфывапролджэячсмитьбю]]
            local en_shift = [[QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
            local ru_shift = [[ЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

            vim.opt.langmap = vim.fn.join({
                -- | `to` should be first     | `from` should be second
                escape(ru_shift) .. ';' .. escape(en_shift),
                escape(ru) .. ';' .. escape(en),
            }, ',')
        end)();

        vim.lsp.set_log_level("info")
    end,
}

return config
