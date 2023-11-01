local M = {}
local NIL = "<NIL>"
local function or_NIL(value)
    if value == nil then
        return NIL
    end
    return value
end

local unpack = table.unpack or unpack

M.ARC_REPO_ROOT_ENV = "ARC_ROOT"

M._arc_repo_roots = {
    "/a", -- this is symlink to /data/a
    "/data/a",
}

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

function M.is_ok_root_dir(path)
    local util = require("dgronskiy_nvim.util")
    local logger = require("dgronskiy_nvim.logger")

    if util.path.is_fs_root(path) then
        return false
    end

    if path == os.getenv("HOME") then
        return false
    end

    -- No-Go's:
    -- * /data/a/trunk
    -- * /data/a/dev
    -- * /data/a/MLDWH-XXX
    local path_and_parent = { path, util.path.dirname(path) }
    for _, check_against in ipairs(M._arc_repo_roots) do
        if util.table.find(path_and_parent, check_against) then
            return false
        end
    end

    return true
end

-- TODO: move ok_root_dirs into global config file

-- root_dir function in terms of `lspconfig`. Get inspiration here:
-- https://github.com/neovim/nvim-lspconfig/tree/bfdf2e91e7297a54bcc09d3e092a12bff69a1cf4/lua/lspconfig/util.lua#L268
function M.guarded_pyright_root_directory(startpath)
    local logger = require("dgronskiy_nvim.logger")
    local log_events = {}

    local is_inside_arc = M.is_inside_arc(startpath)
    local root_dir = nil

    if is_inside_arc then
        local util = require("lspconfig.util")
        root_dir = util.root_pattern("pyrightconfig.json")(startpath)
    else
        -- use default from here
        -- https://github.com/neovim/nvim-lspconfig/tree/bfdf2e91e7297a54bcc09d3e092a12bff69a1cf4/lua/lspconfig/server_configurations/pyright.lua#L36
        root_dir = require("lspconfig.server_configurations.pyright").default_config.root_dir(startpath)
    end
    log_events.root_dir_inferred = or_NIL(root_dir)

    local is_ok_root_dir = M.is_ok_root_dir(root_dir)
    root_dir = is_ok_root_dir and root_dir or nil

    log_events = vim.tbl_extend("force", log_events, {
        startpath = or_NIL(startpath),
        is_inside_arc = or_NIL(is_inside_arc),
        is_ok_root_dir = or_NIL(is_ok_root_dir),
        root_dir_final = or_NIL(root_dir),
    })
    logger:debug("guarded_pyright_root_directory", log_events)

    -- if not M.is_ok_root_dir(root_dir) then
    --     logger:warn("patching
    --     vim.notify(
    --         "Inside Arc="
    --         .. tostring(is_inside_arc)
    --         .. "\nFile= "
    --         .. startpath
    --         .. "\nRoot dir= "
    --         .. root_dir
    --         .. "\n\nPatching root_dir to nil"
    --     )
    --     root_dir = nil
    -- end
    return root_dir
end

return M
