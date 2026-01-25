--init env
	getgenv().__luaw__ = {
		funcs = {
			kenrel = {},
			global = {},
			normal = {}
		},
		objs = {},
		save = {},
		data = {
			default_props = {}, -- type = {def_vs}
			func_props = {}, -- name = {{vanme = vv}, func}
			wraps_mods = {}, -- type = {{vanme = vv}, {binds}, start_or_end, func}
			methods = {}, -- name = func
			operators = {}, -- __name = func
			iters = {} -- type = {create_iter_lt_func}
			wraps = {}, -- type = {all_def_vs}
			meta = {}, -- type = {all_meta_funcs}
			all_meta = {},
			all_types = {},
			universal_props = {}, -- name = v
			cache_reqs = {},
			text = {
				letters = {},
				numbers = {},
				symbols = {},
				valid_combo = {}
			}
		},
		config = {
			log = true,
			warn = true
		}
	}

	local f = __luaw__.funcs
		local k = f.kenrel
		local g = f.global
		local n = f.normal

	local o = __luaw__.objs
	local s = __luaw__.save
		
	local d = __luaw__.data
		local dp = d.default_props
		local fp = d.func_props
		local wm = wraps_mods
		local m = d.methods
		local op = d.operators
		local its = d.iters
		local ws = d.wraps
		local mt = d.meta
		local amt = d.all_meta
		local atp = d.all_types
		local unip = d.universal_props
		local cq = d.cache_reqs
		local txt = d.text
			local ltt = txt.letters
			local nms = txt.numbers
			local sbl = txt.symbols
			local vdc = txt.valid_combo
			local ltls = {l=ltt, n=nms, s=sbl}

	local cfg = __luaw__.config

--fast env set
	amt = {"__index", "__newindex", "__call", "__add", "__sub", "__mul",
	"__div", "__mod", "__pow", "__unm", "__eq", "__lt", "__le", "__concat",
	"__tostring", "__len",  "__iter"}
	atp = {"string", "number", "function", "Instance", "Vector3", "CFrame"}

	for _,tp in atp do dp[tp], fp[tp], wm[tp], ws[tp], mt[tp], cq[tp] = {}, {}, {}, {}, {}, {} end

	dp["Instance"]["_method"] = false


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

-- port&save | port_save("____", "____")
	port_save("str", "tostring")
	port_save("int", "tostring")
	port_save("exec", "tostring")
	port_save("rint", "math", "random")
	port_save("rget", "rawget")
	port_save("rset", "rawset")
	port_save("un", "unpack")
	port_save("tp_", "type")
	port_save("tpf", "typeof")
	port_save("hash_", "crypt", "hash")
	port_save("round", "math", "round")

--objects
	-- o["_____"] = cloneref(game:GetService("_____"))
		o["w"] = cloneref(game:GetService("Workspace"))
		o["p"] = cloneref(game:GetService("Players"))
		o["r"] = cloneref(game:GetService("RunService"))
		o["lg"] = cloneref(game:GetService("Lighting"))
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
	function k.duplicate(num, obj)
		local lt = {}
		for a=1,num do lt[a] = obj end
		return s.unpack(lt)
	end; k.d, k.dup = k.duplicate, k.duplicate

	k.h, k.hash = k.d(2, function(...)
		local lt = {...}
		for i,data in lt do
			lt[i] = s.hash_(s.str(data), "md5")
		end; return s.un(lt)
	end)

	k.tp, k.type = k.d(2, function(obj)
		local type = s.tp(obj)
		return (type == "table" and obj["_type"]) or type
	end)

	-- k.md, k.mdup, k.multy_duplicate = k.d(3, function(num, ...)
	-- 	local lt, dlt = {...}, {}
	-- 	for a=1,num do
	-- 		for _,v in lt do
	-- 			dlt[#dlt+1] = v
	-- 		end
	-- 	end; return s.unpack(dlt)
	-- end)

	k.il, k.islw, k.isluaw = k.d(3, function(obj)
		return s.tpf(obj) == "table" and obj._type
	end)

	k.ul, k.unlw, unluaw = k.d(3, function(...)
		local lt = {...}
		for i,obj in lt do
			if k.il(obj) then
				lt[i] = obj[1]
			end
		end; return s.un(lt)
	end)

	k.l, k.lw, k.luaw = k.d(3, function(...)
		local lt = {...}
		for i,obj in lt do
			if obj and not(k.il(obj)) then
				local tp = s.tpf(obj)
				local wrap = pr[tp]
				wrap[1], wrap["_iter"] = obj, its[tp](obj)
				lt[i] = setmetatable(wrap, mt[tp])
			end
		end; return s.un(lt)
	end)

	k.mk, k.make = l.dup(2, function()
		local wmf = {{},{}}
		for _,tp in atp do mt[tp], ws[tp] = {}, {} end
		for tp,dp in dp do
			local lt = {}
			wmf[1][tp], wmf[2][tp] = {}, {}
			for name,dp in dp do lt[name] = dp end
			for name,slt in fp[tp] do for name,v in slt[1] do lt[name] = v end end
			for name,slt in wm[tp] do 
				for name,v in slt[1] do lt[name] = v end 
				for _,bind in slt[2] do wmf[(slt[3] and 1) or 2][tp][bind] = slt[4] end
			end; for _,name in cq[tp] do lt[name] = {} end
			ws[tp] = lt
		end
		for tp, m in m do
			local fp = fp[tp]
			local lt = {__index = function(s,i)
				local p, m = fp[i], m[i]
				if p then return p[2](w,i)
				elseif m then return m
				else
					local m = k.l(s[1][i])
					m._method = true
					return m
				end
			end, __newindex = function(s,i,v)
				s[1][i] = v
			end, __call = function(s,w,...)
				return s[1](((s._method and w[1]) or w),...)
			end, __iter = function(s) return s.next, s._iter, nil end}
			for name,o in op[i] do lt[name] = o end
			for meta,func in lt do
				local smod, emod = wmf[1][tp][meta], wmf[2][tp][meta]
				if smod then lt[meta] = function(...) return func(smod(...)) end end
				func = lt[meta]
				if emod then lt[meta] = function(...) return emod(func(...)) end end
			end
			if cfg.log then 
				for meta,func in lt do
					local v = meta:sub(2,-1)
					ws[tp][v] = 0
					lt[meta] = function(s,...) s[v] += 1; return func(s,...) end
				end
			end
			mt[tp] = lt
		end
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
		if cfg.warn then
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

	n.chat, n.cht, n.ct = k.d(3, function(msg)
		if o.cs.ChatVersion == Enum.ChatVersion.TextChatService then
			o.cs.TextChannels.RBXGeneral[1]:SendAsync(s.str(msg)[1])
		elseif o.saymsg then
			o.saymsg:FireServer(s.str(msg)[1], "All")
		end
	end)

	n.system_chat, n.schat, n.sc = k.d(3, function(msg)
		o.p:chat(s.s.str(msg)[1])
	end)

	n.bypass_chat, n.bchat, n.bc = k.d(3, function(msg, num, length)
		if msg == "" then n.schat(k.l("can ")*(num or 10))
		else local can = k.l("can ")*(length or 10)
			for a=1,num or (#msg/10)+1 do
				n.echat(can)
				n.qw(0.3)
				n.chat(msg)
			end
		end
	end)

	n.mouse_ckick, n.mclick, n.mck = k.d(3, function()
		o.vim:SendMouseButtonEvent(o.m.X, o.m.Y, 0, true, game, 0)
		n.qw(0.01)
		o.vim:SendMouseButtonEvent(o.m.X, o.m.Y, 0, false, game, 0)
	end)

	n.ifo, n.if_or = k.d(2, function(b, v1, v2)
		if not(v2) then return b or v1
		else return (b and v1) or v2
	end)

-- func_props
	-- universal
		local lt = {}
		lt._age = {{}, function(w) return tick()-w._created end}
		for tp,slt in fp do for name,data in lt do fp[tp][name] = data end end

-- wraps_mods
	-- universal
		local lt = {}
		lt[#lt+1] = {{_last_interaction=0}, amt, true, function(w,...) w._last_interaction = tick(); return w,... end}
		for tp,slt in wm do for _,data in lt do wm[tp][#wm[tp]+1] = data end end
	
	-- function TODO: time of all acts
	
-- methods 
	-- universal
		-- local lt = {}
		-- for tp,slt in m do for name,func in lt do m[tp][name] = func end end
	
	-- string
		local tp = "string"
		local lt, cq = m[tp], cq[tp]
			function lt:run(...)
				local h, c = k.h(self), self._cache["run"]
				local func = c[h]
				if func then return func(...)
				else
					local func = s.exec(self)
					c[h] = func
					return func(...)
				end
			end; cq[#cq+1] = "run"

			-- TODO: fastload
	
	-- number
		local tp = "number"
		local lt, cq = m[tp], cq[tp]
			function lt:in(mx, mn) mn = (mn or 0); return mx >= self and self >= mn end

	-- function
		local tp = "function"
		local lt, cq = m[tp], cq[tp]

-- operators
	-- universal TODO: move wrom mk
	-- string TODO: -str == str:reverse()
	-- function TODO: -func == s.pcl(func)
	-- table TODO: -table == {v=i}
