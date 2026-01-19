local Path = "LuaW/main.luau"
local Url = "https://raw.githubusercontent.com/fgdergewrgegr/LuaW/refs/heads/main/roblox.luau"

loadstring("https://raw.githubusercontent.com/fgdergewrgegr/LuaW/refs/heads/main/unc_fixer.luau")()

local function safe_execute(code)
    local Success = pcall(function()
        loadstring(code)()
    end)
    return Success
end

if not getgenv().__luaw__ then
    local executed = false
    if isfile(Path) then
        executed = safe_execute(readfile(Path))
    end

    if executed then
        local data = game:HttpGet(Url)
        write(Path, data)
    else
        local data = game:HttpGet(Url)
        if safe_execute(data) then
            write(Path, data)
        end
    end
end

Path = nil
Url = nil