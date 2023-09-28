if _G.astronvim then
    return require("dgronskiy_nvim.astronvim")
end

error("This module should not be required directly")
