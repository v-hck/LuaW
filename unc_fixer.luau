local UNC_Test = {
    Required = {
		"cloneref", "gethui",

		"readfile", "writefile", "appendfile",
		"delfile", "makefolder", "isfile",
		"isfolder", "listfiles", "dofile",

		"rconsoleprint", "rconsolesettitle",
		"rconsoleinput", "rconsoleclear",

		"setclipboard", "setfpscap",
		"lz4compress", "lz4decompress"
    },

    Replaceable = {
        cloneref = function(...) return ... end,
        gethui = function() return game.CoreGui end,
        dofile = function(Path) return loadstring(readfile(Path))() end,
        setfpscap = function(fps) 
            local frame = os.clock()
            game:GetService("RunService").PreSimulation:Connect(function()
                while os.clock() - frame < 1 / fps do end
                frame = os.clock()
            end)
        end,

        setclipboard = function() warn("setclipboard tried called") end,

        rconsoleprint = function() warn("rconsoleprint tried called") end,
        rconsolesettitle = function() warn("rconsolesettitle tried called") end,
        rconsoleinput = function() warn("rconsoleinput tried called") end,
        rconsoleclear = function() warn("rconsoleclear tried called") end,
    },
    Replaced = {},
    Not_Found = {}
}
local Env = getgenv()

for _, func in UNC_Test.Required do
	if not Env[func] then
		if UNC_Test.Replaceable[func] then
			getgenv()[func] = UNC_Test.Replaceable[func]
            UNC_Test.Replaced[#UNC_Test.Replaced+1] = func
            warn(func)
		else 
			UNC_Test.Not_Found[#UNC_Test.Not_Found+1] = func
            warn(func)
		end
	end
end

if #UNC_Test.Not_Found == 0 and #UNC_Test.Replaced == 0 then return end

game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "LuaW | Exploit Error",
    Text = "Missing: ".. table.concat(UNC_Test.Not_Found, ", ") .. "\nReplaced: "..table.concat(UNC_Test.Replaced, ", "),
    Duration = 10
})

error("LuaW: UNC Functions missing: ".. table.concat(UNC_Test.Not_Found, ", "))