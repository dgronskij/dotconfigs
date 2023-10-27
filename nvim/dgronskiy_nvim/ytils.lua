local M = {}

local unpack = table.unpack or unpack

M._arc_repo_roots = {
    "/a",
    "/data/a",
}

M.ARC_REPO_ROOT_ENV = "ARC_ROOT"

if os.getenv(M.ARC_REPO_ROOT_ENV) then
    table.insert(M._arc_repo_roots, 1, os.getenv(M.ARC_REPO_ROOT_ENV))
end

function M.is_inside_arc(path)
    for _, prefix in ipairs(M._arc_repo_roots) do
        if path:find(prefix, 1, true) == 1 then
            return true
        end
    end

    return false
end

M._pyright_bad_root_dirs = { unpack(M._arc_repo_roots) } -- shallow copy
table.insert(M._pyright_bad_root_dirs, os.getenv("HOME"))

-- TODO: move ok_root_dirs into global config file

-- root_dir function in terms of `lspconfig`. Get inspiration here:
-- https://github.com/neovim/nvim-lspconfig/tree/bfdf2e91e7297a54bcc09d3e092a12bff69a1cf4/lua/lspconfig/util.lua#L268
function M.guarded_pyright_root_directory(startpath)
    local function _is_ok_root_dir(path)
        for _, check_against in ipairs(M._pyright_bad_root_dirs) do
            if check_against == path then
                return false
            end
        end
        return true
    end

    local is_inside_arc = M.is_inside_arc(startpath)
    local root_dir = ""

    if is_inside_arc then
        local util = require("lspconfig.util")
        root_dir = util.root_pattern("pyrightconfig.json")(startpath)
    else
        -- use default from here
        -- https://github.com/neovim/nvim-lspconfig/tree/bfdf2e91e7297a54bcc09d3e092a12bff69a1cf4/lua/lspconfig/server_configurations/pyright.lua#L36
        root_dir = require("lspconfig.server_configurations.pyright").default_config.root_dir(startpath)
    end

    -- vim.notify("Inside Arc=" .. tostring(is_inside_arc) .. "\nFile= " .. startpath .. "\nRoot dir= " .. tostring(root_dir))

    if not _is_ok_root_dir(root_dir) then
        vim.notify(
            "Inside Arc="
            .. tostring(is_inside_arc)
            .. "\nFile= "
            .. startpath
            .. "\nRoot dir= "
            .. root_dir
            .. "\n\nPatching root_dir to nil"
        )
        root_dir = nil
    end

    return root_dir
end

return M
