TODO: autosymlinking

# Installation

```bash
# install Astronvim
NVIM_CONF_ROOT=~/.config/nvim
# dump $NVIM_CONF_ROOT/lua/user if needed

rm -r $NVIM_CONF_ROOT/lua/user
mkdor $NVIM_CONF_ROOT/lua/user

cat <<EOF > $NVIM_CONF_ROOT/lua/user/init.lua
return require("dgronskiy_nvim.astronvim")
EOF

rm $NVIM_CONF_ROOT/lua/dgronskiy_nvim
ln -s ~/.dotfiles/nvim/dgronskiy_nvim $NVIM_CONF_ROOT/lua/dgronskiy_nvim
```

# Troubleshooting
## Common commands
- `:Lazy` -- check if module is loaded
- `:Nullls{Info, ...}` commands
- `:Lsp{Info, ...}` commands

## How to run no configuration vim

- `vim --clean` -- absolutely no configuration
- `vim -u <configuration_file>` -- use custom init.lua, see the example below
 - do not forget to set `XDG_XXX_VARIABLES`

## How to troublshoot distro-agnostic

This is a template stolen from https://github.com/nvim-neo-tree/neo-tree.nvim/issues/new

```
Minimal init.lua to reproduce this issue. Save as repro.lua and run with nvim -u repro.lua
```

```lua
-- DO NOT change the paths and don't remove the colorscheme
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath, })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
local plugins = {
  "folke/tokyonight.nvim",
  -- add any other plugins here
}

local neotree_config = {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "nvim-tree/nvim-web-devicons", "nvim-lua/plenary.nvim" },
  cmd = { "Neotree" },
  keys = {
    { "<Leader>e", "<Cmd>Neotree<CR>" }, -- change or remove this line if relevant.
  },
  opts = {
    -- Your config here
    -- ...
  },
}

table.insert(plugins, neotree_config)
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})

vim.cmd.colorscheme("tokyonight")
-- add anything else here
```
