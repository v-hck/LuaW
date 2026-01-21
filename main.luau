--init env
	getgenv().__luaw__ = {
		funcs = {
			kenrel = {},
			global = {},
			normal = {}
		},
		objs = {},
		save = {},
		cache = {},
		data = {
			props = {},
			props_reqs = {},
			methods = {},
			operators = {},
			meta = {},
			text = {
				letters = {},
				numbers = {},
				symbols = {},
				valid_combo = {}
			}
		},
		config = {
			debug = true
		}
	}

	local f = __luaw__.funcs
		local k = f.kenrel
		local g = f.global
		local n = f.normal

	local o = __luaw__.objs
	local s = __luaw__.save
	local c = __luaw__.cache
		
	local d = __luaw__.data
		local p = d.props
		local pr = d.props_reqs
		local m = d.methods
		local op = d.operators
		local mt = d.meta
		local txt = d.text
			local ltt = txt.letters
			local nms = txt.numbers
			local sbl = txt.symbols
			local vdc = txt.valid_combo
			local ltls = {l=ltt, n=nms, s=sbl}

	local cfg = __luaw__.config

--fast env set
	for a=65, 90 do ltt[#ltt+1] = string.char(a) end
	for a=97, 122 do ltt[#ltt+1] = string.char(a) end

	for a=48, 57 do nms[#nms+1] = string.char(a) end

	for a=32, 47 do sbl[#sbl+1] = string.char(a) end
	for a=58, 64 do sbl[#sbl+1] = string.char(a) end
	for a=91, 96 do sbl[#sbl+1] = string.char(a) end
	for a=123, 126 do sbl[#sbl+1] = string.char(a) end

	vdc = {"l", "n", "s", "ln", "ns", "sl", "lns", "ls", "nl", "sn", "snl"}

s["gg"] = getgenv

local function port_save(name2, ...)
	local func = s.gg()
	for _, name in {...} do func = func[name] end
	g[name2] = func
	s[name2] = func
end

--save | s["____"] = s.gg()["____"]
	s["typeof"] = s.gg()["typeof"]
	s["unpack"] = s.gg()["unpack"]
	s["type"] = s.gg()["type"]

-- port&save | port_save("____","____")
	port_save("str", "tostring")
	port_save("int", "tostring")
	port_save("exec", "tostring")
	port_save("rint", "math", "random")

--objects
	-- o["_____"] = cloneref(game:GetService("_____"))
		o["w"] = cloneref(game:GetService("Workspace"))
		o["lg"] = cloneref(game:GetService("Lighting"))
		o["p"] = cloneref(game:GetService("Players"))
		o["r"] = cloneref(game:GetService("RunService"))
		o["db"] = cloneref(game:GetService("Debris"))
		o["rs"] = cloneref(game:GetService("ReplicatedStorage"))
		o["rf"] = cloneref(game:GetService("ReplicatedFirst"))
		o["sg"] = cloneref(game:GetService("StarterGui"))
		o["ms"] = cloneref(game:GetService("MaterialService"))
		o["cg"] = cloneref(game:GetService("CoreGui"))
		o["cs"] = cloneref(game:GetService("TextChatService"))
		o["ps"] = cloneref(game:GetService("PhysicsService"))
		o["hs"] = cloneref(game:GetService("HttpService"))
		o["ts"] = cloneref(game:GetService("TeleportService"))
		o["uis"] = cloneref(game:GetService("UserInputService"))
		o["vim"] = cloneref(game:GetService("VirtualInputManager"))

	-- o["_____"] = 
		o["inf"] = 1/0
		o["nan"] = 0/0
		o["mhv3"] = Vector3.new("inf", "inf", "inf")
		o["nv3"] = Vector3.new()

	-- o["_____"] = o._____.
		o["me"] = o.p.LocalPlayer
		o["old_char"] = o.me.Character
		if o.old_char then
			local char = o.old_char
			o["old_hrp"] = char:FindFirstChild("HumanoidRootPart")
			o["old_hum"] = char:FindFirstChild("Humanoid")
			o["old_hd"] = char:FindFirstChild("Head")
			o["old_tr"] = char:FindFirstChild("Torso")
		end
		o["cam"] = o.w.CurrentCamera
		o["m"] = o.me:GetMouse()
		o["name"] = o.me.Name
		o["dname"] = o.me.DisplayName
		o["pg"] = o.me.PlayerGui
		o["muid"] = o.me.UserId
		o["rt"] = o.p.RespawnTime

		local DCSCE = o.rs:FindFirstChild("DefaultChatSystemChatEvents")
		if DCSCE then
			o["saymsg"] = DCSCE:WaitForChild("SayMessageRequest")
			o["getmsg"] = DCSCE:WaitForChild("SayMessageRequest")
		end; DCSCE = nil
	
--kernel
	function k.type(obj)
		local type = s.typeof(obj)
		return (type == "table" and obj["_luaw_"]) or type
	end

	function k.duplicate(num, obj)
		local lt = {}
		for a=1,num do lt[a] = obj end
		return s.unpack(lt)
	end; k.d, k.dup = k.duplicate, k.duplicate

	-- k.md, k.mdup, k.multy_duplicate = k.d(3, function(num, ...)
	-- 	local lt, dlt = {...}, {}
	-- 	for a=1,num do
	-- 		for _,v in lt do
	-- 			dlt[#dlt+1] = v
	-- 		end
	-- 	end; return s.unpack(dlt)
	-- end)

	k.ul, k.unlw, unluaw = k.dup(3, function(...)
		local lt = {...}
		for i,obj in lt do
			if s.typeof(obj) == "table" and obj["_luaw_"] then
				lt[i] = obj[1]
			end
		end; return s.unpack(lt)
	end)
	
	k.l, k.lw, k.luaw = k.dup(3, function(...)
		local lt = {...}
		for i,obj in lt do
			if obj then
				local type = s.typeof(obj)
				local wrap = pr[type]
				wrap[1] = obj
				lt[i] = setmetatable(wrap, mt[type])
			end
		end; return s.unpack(lt)
	end)



--normal
	local o_r_Heartbeat, o_r_RenderStepped = o.r.Heartbeat, o.r.RenderStepped
	local ft1, ft2 = [[return function(num)
		local event = ]],[[
		if not(num) then return event:Wait()
		else local t, tt = tick(), 0
			while tick() < t+num do
				tt = tt + event:Wait()
			end; return tt
		end
	end]]
	n.qw, n.qwait, n.quick_wait = k.dup(3, s.exec(`{ft1}o_r_Heartbeat{ft2}`))
	n.pw, n.pwait, n.physic_wait = k.dup(3, s.exec(`{ft1}o_r_RenderStepped{ft2}`))
	n.tw, n.twait, n.task_wait = k.dup(3, task.wait); ft1,ft2 = nil,nil

	n.random_text, n.rtext, n.rt = k.dup(3, function(length, input)
		if cfg.debug then
			if input == "" then
				warn('random_text: input == ""')
				input = "l"
			end
		end; input = input or "l"
		local output = ""
		if table.find(vdc, input) then
			local lt = {}
			for _,link in input:split("") do
				for _,char in ltls[link] do
					lt[#lt+1] = char
				end
			end; input = lt
		else input = input:split("") end
		local linput = #input
		for a = 1, length or 10 do
			output = output..input[rng(1, linput)]
		end; return output
	end)

	n.chat, n.cht, n.ct = k.dup(3, function(msg)
		if o.cs.ChatVersion == Enum.ChatVersion.TextChatService then
			o.cs.TextChannels.RBXGeneral[1]:SendAsync(k.l(msg):c("os"))
		elseif o.saymsg then
			o.saymsg:FireServer(k.l(msg):c("os"), "All")
		end
	end)

	n.system_chat, n.schat, n.sc = k.dup(3, function(msg)
		o.p:chat(k.l(msg):c("os"))
	end)

	n.bypass_chat, n.bchat, n.bc = k.dup(3, function(msg, num, length)
		if k.ul(msg) == "" then n.schat(k.l("can ")*(num or 10))
		else local can = k.l("can ")*(length or 10)
			for a=1,num or (#msg/10)+1 do
				n.echat(can)
				n.qw(0.3)
				n.chat(msg)
			end
		end
	end)

	n.mouse_ckick, n.mclick, n.mck = k.dup(3, function()
		o.vim:SendMouseButtonEvent(o.m.X, o.m.Y, 0, true, game, 0)
		n.qw(0.01)
		o.vim:SendMouseButtonEvent(o.m.X, o.m.Y, 0, false, game, 0)
	end)

