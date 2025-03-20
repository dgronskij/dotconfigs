if vim.fn.has("nvim-0.10") == 0 then
    error("Please install nvim >= 0.10")
end

-- vim.g.max_file = {  -- this is read by Aerial.nvim astronvim configuration
--     lines = 10000,
--     size = 3 * 1000 * 1000,
-- }

local config = {
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
    -- colorscheme = "gruvbox",
    colorscheme = "pustota",
    -- colorscheme = "rose-pine",
    options = require("dgronskiy_nvim.sets").export_astronvim(),
    lsp = {
        servers = {
            "pyright",
            "gopls",
            "clangd",
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
            disabled = {
                "lua_ls", -- prefer stylua
            },
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
                capabilities = (function()
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false
                    return capabilities
                end)(),
            },
            gopls = {
                autostart = true,
                cmd = { "ya", "tool", "gopls" },
                settings = {
                    gopls = {
                        -- directoryFilters = { "-", "+[ваша папка]" },
                        expandWorkspaceToModule = false,
                    },
                },
            },
            clangd = {
                -- https://github.com/neovim/nvim-lspconfig/tree/b0852218bc5fa6514a71a9da6d5cfa63a263c83d/lua/lspconfig/server_configurations/clangd.lua#L45
                -- disable for .proto files as clang complains about invalid AST
                filetypes = { "c", "cpp" },
            },
        },
    },
    diagnostics = {
        virtual_text = false,
        underline = false,
    },
    mappings = require("dgronskiy_nvim.astronvim.mappings").astronvim_mappings_callback,
    polish = function()
        vim.cmd([[ set path+=/a/trunk ]])

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
            [[ command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )
        vim.cmd(
            [[ command! -bang -nargs=* FindExact call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )

        vim.cmd(
            -- + case-insensitive
            [[ command! -bang -nargs=* ArcFind call fzf#vim#grep('ya tool cs -i --current-folder --no-contrib --no-junk --max all  --color "always" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )
        vim.cmd(
            -- + case-insensitive
            [[ command! -bang -nargs=* ArcFindAll call fzf#vim#grep('ya tool cs -i --current-folder --max all  --color "always" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )
        vim.cmd(
            [[ command! -bang -nargs=* ArcFindExact call fzf#vim#grep('ya tool cs --current-folder --no-contrib --no-junk --max all -F --color "always" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )
        vim.cmd(
            [[ command! -bang -nargs=* ArcFindExactAll call fzf#vim#grep('ya tool cs --current-folder --max all -F --color "always" -- '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )

        -- FIXME: this uses grep format (see that period symbol before --file) and corresponding fzf command
        -- Unfortunately, fzf#vim#file is not dynamically configurable
        -- fzf-lua does
        -- edially, this is the case for telescope live-grep fuctionality where on each input update the request to `cs` tool is made (since its pretty fast)
        -- TODO: remove `.` search pattern
        --       remove -g1 (max match per file)
        vim.cmd(
            -- + case-insensitive
            [[ command! -bang -nargs=* ArcFiles call fzf#vim#grep('ya tool cs -i --current-folder --no-contrib --no-junk --max 5000 --color "always" . -g1 --file '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        )
        -- vim.cmd(
        -- -- + case-insensitive
        --     [[ command! -bang -nargs=* ProjectFiles call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --smart-case  --hidden --follow  --color "always" '.shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0) ]]
        -- )

        vim.cmd([[ vnoremap <Leader>cat :'<,'>w !tee<CR> ]])

        vim.cmd([[ nnoremap <Leader>find :Find ]])
        vim.cmd([[ nnoremap <Leader>fd :Find ]])
        vim.cmd([[ nnoremap <Leader>cs :ArcFind ]])

        vim.cmd([[ nnoremap <Leader>al :ArcLink<CR> ]])
        vim.cmd([[ vnoremap <Leader>al :ArcLink<CR> ]])

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

        vim.cmd([[nnoremap <silent> z. :<C-u>normal! zszH<CR>]]) -- https://unix.stackexchange.com/a/585098

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

        vim.cmd([[nnoremap  <leader>cda :cd $A \| :pwd<CR>]])

        vim.cmd([[ vnoremap > >gv ]])
        vim.cmd([[ vnoremap < <gv ]])

        vim.cmd([[nnoremap  <leader>t<CR>  :Tags '<C-R><C-W> <CR>]])
        vim.cmd([[vnoremap  <leader>t<CR> "vy :Tags '<C-R>v <CR>]])

        -- greatest remap ever
        -- -- vim.keymap.set("x", "<leader>p", [["_dP]])
        vim.cmd([[vnoremap <leader>p "_dP]])

        vim.api.nvim_create_user_command("CopyFileName", function(opts)
            local file_path = vim.fn.expand("%") ---@type string
            vim.fn.setreg("+", file_path) -- copy to system clipboard
            print("Copied filename: ", file_path)
        end, { force = true, range = true })
        vim.cmd([[nnoremap <leader>cfn <cmd>CopyFileName<CR>]])

        vim.api.nvim_create_user_command("CopyFQN", function(opts)
            local word_under_cursor = vim.fn.expand("<cword>")
            local module_path = vim.fn.expand("%:r") ---@type string
            local module_path = require("textcase").api.to_dot_case(module_path)

            local res = module_path .. "." .. word_under_cursor
            vim.fn.setreg("+", res) -- copy to system clipboard
            print("Copied FQN: ", res)
        end, { force = true, range = true })
        vim.cmd([[nnoremap <leader>cfqn <cmd>CopyFQN<CR>]])

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

        if true then
            (function()
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
                    escape(ru_shift)
                        .. ";"
                        .. escape(en_shift),
                    escape(ru) .. ";" .. escape(en),
                }, ",")

                vim.opt.keymap = "russian-jcukenwin" -- https://neovim.io/doc/user/russian.html
                vim.opt.iminsert = 0 -- english by default
            end)()
        end

        if true then
            (function()
                -- local lasso = require("lasso")
                -- lasso.setup({
                -- 	marks_tracker_path = "/home/dgronskiy/vims/.lasso-marks",
                -- })
                --
                -- -- Mark current file
                -- vim.keymap.set("n", vim.g.mapleader .. "m", function()
                -- 	lasso.mark_file()
                -- end)
                --
                -- -- Go to marks tracker (editable, use `gf` to go to file under cursor)
                -- vim.keymap.set("n", vim.g.mapleader .. "M", function()
                -- 	lasso.open_marks_tracker()
                -- end)
                --
                -- -- Jump to n-th marked file (n-th line of marks tracker)
                -- vim.keymap.set("n", vim.g.mapleader .. "1", function()
                -- 	lasso.open_marked_file(1)
                -- end)
                -- vim.keymap.set("n", vim.g.mapleader .. "2", function()
                -- 	lasso.open_marked_file(2)
                -- end)
                -- vim.keymap.set("n", vim.g.mapleader .. "3", function()
                -- 	lasso.open_marked_file(3)
                -- end)
                -- vim.keymap.set("n", vim.g.mapleader .. "4", function()
                -- 	lasso.open_marked_file(4)
                -- end)
            end)()
        end

        -- https://www.reddit.com/r/vim/comments/9iwr41/store_quickfix_list_as_a_file_and_load_it/
        vim.cmd([[
            function! s:load_file(type, bang, file) abort
                let l:efm = &l:efm
                let &l:errorformat = "%-G%f:%l: All of '%#%.depend'%.%#,%f%.%l col %c%. %m"
                let l:cmd = a:bang ? 'getfile' : 'file'
                exec a:type.l:cmd.' '.a:file
                let &l:efm = l:efm
            endfunction

            command! -complete=file -nargs=1 -bang Cfile call <SID>load_file('c', <bang>0, <f-args>)
            command! -complete=file -nargs=1 -bang Lfile call <SID>load_file('l', <bang>0, <f-args>)
            ]])

        vim.cmd([[nnoremap ]c :cnext<CR>]])
        vim.cmd([[nnoremap [c :cprev<CR>]])

        vim.lsp.set_log_level("info")
    end,
}

return config
