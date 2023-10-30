local is_windows = vim.loop.os_uname().version:match("Windows")

local M = {}

M.path = (function()
    -- stolen form
    -- https://github.com/neovim/nvim-lspconfig/tree/71b39616b14c152da34fcc787fa27f09bf280e72/lua/lspconfig/util.lua#L124
    local function is_fs_root(path)
        if is_windows then
            return path:match("^%a:$")
        else
            return path == "/"
        end
    end

    -- stolen from https://github.com/neovim/nvim-lspconfig/tree/71b39616b14c152da34fcc787fa27f09bf280e72/lua/lspconfig/util.lua#L142
    --- @param path string
    --- @return string?
    local function dirname(path)
        local strip_dir_pat = "/([^/]+)$"
        local strip_sep_pat = "/$"
        if not path or #path == 0 then
            return
        end
        local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
        if #result == 0 then
            if is_windows then
                return path:sub(1, 2):upper()
            else
                return "/"
            end
        end
        return result
    end

    return {
        is_fs_root = is_fs_root,
        dirname = dirname,
    }
end)()

return M
