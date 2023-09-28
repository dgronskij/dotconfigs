local M = {}

function M.find_all_files()
    local ok, t_builtin = pcall(require, "telescope.builtin")
    if not ok then
        error("no telescope found!")
        return
    end

    local opts = {
        hidden = true,
        -- no_ignore = true,
        follow = true,
    }
    return t_builtin.find_files(opts)
end

return M
