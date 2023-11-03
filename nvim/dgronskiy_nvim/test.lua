-- HOW TO RUN FROM WITHIN VIM
--
-- open the file, then
-- `:luafile %`
--
-- `vim -u test.lua` -- use test.lua instead of default init.lua for configuration

t = {
    a = 4,
}

t2 = vim.tbl_extend("force", t, { b = 10 })

print(vim.inspect(t2))
