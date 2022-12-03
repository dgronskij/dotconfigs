local M = {}

local ok, t_builtin = pcall(require, "telescope.builtin")

if ok then
    function M.find_all_files()
        local opts = {
            hidden = true,
            -- no_ignore = true,
            follow = true,
        }
        return t_builtin.find_files(opts)
    end
else
    function M.find_all_files()
        error ("no telescope found!")
    end
end

return M
