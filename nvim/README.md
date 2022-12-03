TODO: autosymlinking

How to install:

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
