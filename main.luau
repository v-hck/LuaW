--!strict
type types = string|number|(...any)->(...any)|Instance|Vector3|CFrame|boolean|{[any]:any}
type types_str = "string"|"number"|"function"|"Instance"|"Vector3"|"CFrame"|"boolean"|"table"
type meta_methods = "__index"|"__newindex"|"__call"|"__add"|"__sub"|"__mul"|
	"__div"|"__mod"|"__pow"|"__unm"|"__eq"|"__lt"|"__le"|"__concat"|
	"__tostring"|"__len"| "__iter"

type luaw<t, ts> = {[number]:t , _type:ts, _method:boolean, _created:number, _last_interaction:number, _cache:{[string]: {[any]: any}}}
type luaws = luaw<types,types_str>
type all = types|luaws

--init env
	local __luaw__
	-- : {
	-- 	funcs: {
	-- 		kernel: {[string]: (...any)->...any},
	-- 		global: {[string]: (...any)->...any},
	-- 		normal: {[string]: (...any)->...any}
	-- 	},
	-- 	objs: {[string]: any},
	-- 	save: {[string]: (...any)->...any},
	-- 	data: {
	-- 		default_props: {[string]: {[string]: any}},
	-- 		func_props: {[string]: {[string]: {props: {[string]: any}, func:(...any)->...any}}},
	-- 		wraps_mods: {[string]: {{props: {[string]: any}, binds: {meta_methods}, start_or_end: boolean, overwrite: boolean, func: (...any)->...any}}},
	-- 		methods: {[string]: {[string]: (...any)->(...any)}},
	-- 		operators: {[string]: {[string]: (...any)->...any}},
	-- 		iters: {[string]: (...any)->...any},
	-- 		wraps: {[string]: {[string|number]: any}},
	-- 		meta: {[string]: {meta_methods}},
	-- 		all_meta: {meta_methods},
	-- 		all_types: {types},
	-- 		cache_reqs: {[string]: {string}},
	-- 		text: {
	-- 			letters: {string},
	-- 			numbers: {string},
	-- 			symbols: {string},
	-- 			valid_combo: {string}
	-- 		}
	-- 	},
	-- 	config: {
	-- 		log: boolean,
	-- 		warn: boolean
	-- 	}
	-- } 
	= {
		funcs = {
			kernel = {},
			global = {},
			normal = {}
		},
		objs = {},
		save = {},
		data = {
			default_props = {},
			func_props = {},
			wraps_mods = {}, -- type = {{vanme = vv}, {binds}, start_or_end, overwrite, func}
			methods = {}, -- name = func
			operators = {}, -- name = func
			iters = {}, -- type = {create_iter_lt_func}
			wraps = {}, -- type = {all_def_vs}
			meta = {}, -- type = {all_meta_funcs}
			all_meta = {},
			all_types = {},
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

-- local __luaw__ = { -- TODO: rewrite root tree
-- 	raw = {
-- 		kernel = {},
-- 		type_sysyem = {
-- 			default_props = {},
-- 			
-- 		}
-- 	}
-- }

	local f = __luaw__.funcs
		local k = f.kernel
		local g = f.global
		local n = f.normal

	local o = __luaw__.objs
	local s = __luaw__.save
		
	local d = __luaw__.data
		local dp = d.default_props
		local fp = d.func_props
		local wm = d.wraps_mods
		local m = d.methods
		local op = d.operators
		local its = d.iters
		local ws = d.wraps
		local mt = d.meta
		local amt = d.all_meta
		local atp = d.all_types
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
	atp = {"string", "number", "function", "Instance", "Vector3", "CFrame", "boolean"}

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

local function port_save(name2:string, ...:string)
	local func = s.gg()
	for _, name in {...} do func = func[name] end
	g[name2] = func
	s[name2] = func
end

-- port&save | port_save("____", "____")
	-- NOTE: ONLY FOR EDIT: idk how to add correct annotation to port_save
		s.str = tostring
		s.int = tostring
		s.exec = tostring
		s.rget = rawget
		s.rset = rawset
		s.un = unpack
		s.tp_ = type
		s.tpf = typeof
		s.pcl = pcall
		s.rvrs = string.reverse
		s.gsub = string.gsub
		s.sub = string.sub
		s.rep = string.rep
		s.tcln = table.clone
		s.tcnc = table.concat
		s.round = math.round
		s.rint = math.random
		s.hash_ = crypt.hash

	port_save("str", "tostring")
	port_save("int", "tostring")
	port_save("exec", "tostring")
	port_save("rget", "rawget")
	port_save("rset", "rawset")
	port_save("un", "unpack")
	port_save("tp_", "type")
	port_save("tpf", "typeof")
	port_save("pcl", "pcall")
	port_save("rvrs", "string", "reverse")
	port_save("gsub", "string", "gsub")
	port_save("sub", "string", "sub")
	port_save("rep", "string", "rep")
	port_save("tcln", "table", "clone")
	port_save("tcnc", "table", "concat")
	port_save("round", "math", "round")
	port_save("rint", "math", "random")
	port_save("hash_", "crypt", "hash")

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
		o["mhv3"] = Vector3.new(o["inf"], o["inf"], o["inf"])
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
		-- o["pg"] = o.me.PlayerGui FIX:  TypeError: Key 'PlayerGui' not found in class 'Player' 
		o["muid"] = o.me.UserId
		o["rt"] = o.p.RespawnTime

		local DCSCE = o.rs:FindFirstChild("DefaultChatSystemChatEvents") :: TextChatService?
		if DCSCE then
			o["saymsg"] = DCSCE:WaitForChild("SayMessageRequest") :: RemoteEvent
			o["getmsg"] = DCSCE:WaitForChild("SayMessageRequest") :: RemoteEvent
			DCSCE = nil
		end

--kernel	
	function k.duplicate<t>(num:number, obj:t):...t
		local lt = {}
		for a=1,num do lt[a] = obj end
		return s.un(lt)
	end; k.d, k.dup = k.duplicate, k.duplicate

	k.h, k.hash = k.d(2, function(...:any):string
		local lt = {...}
		for i,data in lt do
			lt[i] = s.hash_(s.str(data), "md5")
		end; return s.un(lt)
	end)

	k.tp, k.type = k.d(2, function(obj:all):string
		local tp = s.tpf(obj)
		return (tp == "table" and (obj::luaws)._type) or tp
	end)

	-- k.md, k.mdup, k.multy_duplicate = k.d(3, function(num, ...)
	-- 	local lt, dlt = {...}, {}
	-- 	for a=1,num do
	-- 		for _,v in lt do
	-- 			dlt[#dlt+1] = v
	-- 		end
	-- 	end; return s.unpack(dlt)
	-- end)

	k.il, k.islw, k.isluaw = k.d(3, function(obj:all):string|boolean
		return s.tpf(obj) == "table" and (obj::luaws)._type 
	end)

	k.ul, k.unlw, k.unluaw = k.d(3, function(...:all):...any
		local lt = {...}
		for i,obj in lt do
			if k.il(obj) then
				lt[i] = (obj::luaws)[1]
			end
		end; return s.un(lt)
	end)

	k.l, k.lw, k.luaw = k.d(3, function(...:all):...luaws
		local lt = {...}::{any} -- NOTE: lt type must be all
		for i,obj in lt do
			local tp = s.tpf(obj)
			if obj and atp[tp] and not(k.il(obj)) then
				local wrap = ws[tp]
				wrap[1], wrap["_iter"] = obj, its[tp](obj)
				lt[i] = setmetatable(wrap, mt[tp])
			end
		end; return s.un(lt)
	end)

	k.mk, k.make = k.d(2, function()
		local wmf = {{},{}}
		for _,tp in atp do mt[tp], ws[tp] = {}, {} end
		for tp,dp in dp do
			local lt = {} 
			wmf[1][tp], wmf[2][tp] = {}, {}
			for name,dp in dp do lt[name] = dp end
			for _,slt in fp[tp] do for name,v in slt.props do lt[name] = v end end
			for _,slt in wm[tp] do 
				for name,v in slt.props do lt[name] = v end 
				for _,bind in slt.binds do wmf[(slt.start_or_end and 1) or 2][tp][bind] = {t=slt.overwrite, f=slt.func} end
			end; for _,name in cq[tp] do lt[name] = {} end
			ws[tp] = lt
		end
		for tp, m in m do
			local op = op[tp]
			local lt = s.tcln(op)
			for meta,func in lt do
				local smod, emod = wmf[1][tp][meta], wmf[2][tp][meta]
				if smod then 
					if smod.t then lt[meta] = smod.f
					else local mod = smod.f; lt[meta] = function(...) return func(mod(...)) end end
				end; func = lt[meta]; if emod then 
					if emod.t then lt[meta] = emod.f
					else local mod = emod.f; lt[meta] = function(...) return func(mod(...)) end end
				end
			end
			if cfg.log then 
				for meta,func in lt do
					local v:string = s.sub(meta, 2,-1)
					ws[tp][v] = 0
					lt[meta] = function(self:luaws,...) self[v] += 1; return func(s,...) end
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
	n.tw, n.twait, n.task_wait = k.dup(3, task.wait)

	-- n.random_text, n.rtext, n.rt = k.dup(3, function(length, input)
	-- 	if cfg.warn then
	-- 		if input == "" then
	-- 			warn('random_text: input == ""')
	-- 			input = "l"
	-- 		end
	-- 	end; input = input or "l"
	-- 	local output = ""
	-- 	if table.find(vdc, input) then
	-- 		local lt = {}
	-- 		for _,link in input:split("") do
	-- 			for _,char in ltls[link] do
	-- 				lt[#lt+1] = char
	-- 			end
	-- 		end; input = lt
	-- 	else input = input:split("") end -- FIX: rewrite
	-- 	local linput = #input
	-- 	for a = 1, length or 10 do
	-- 		output = output..input[s.rng(1, linput)]
	-- 	end; return output
	-- end)

	n.chat, n.cht, n.ct = k.d(3, function(msg)
		if o.cs.ChatVersion == Enum.ChatVersion.TextChatService then
			o.cs.TextChannels.RBXGeneral:SendAsync(s.str(msg[1])) 
		elseif o.saymsg then
			o.saymsg:FireServer(s.str(msg), "All")
		end
	end)

	n.system_chat, n.schat, n.sc = k.d(3, function(msg:luaws)
		o.p:Chat(s.str(msg[1]))
	end)

	n.bypass_chat, n.bchat, n.bc = k.d(3, function(msg, num, length)
		if msg == "" then n.schat(s.rep("can ", num or 10))
		else local can = k.l("can ")*(length or 10)
			for a=1,num or (#msg/10)+1 do
				n.echat(can)
				n.qw(0.3)
				n.chat(msg)
			end
		end
	end)

	-- n.mouse_ckick, n.mclick, n.mck = k.d(3, function()
	-- 	o.vim:SendMouseButtonEvent(o.m.X, o.m.Y, 0, true, game, 0)
	-- 	n.qw(0.01)
	-- 	o.vim:SendMouseButtonEvent(o.m.X, o.m.Y, 0, false, game, 0)
	-- end)

	n.ifo, n.if_or = k.d(2, function(b, v1, v2)
		if not(v2) then return b or v1
		else return (b and v1) or v2 end
	end)

-- func_props
	-- universal
		local lt:{[string]:{props: {[string]: any}, func:(...any)->...any}} = {}
		lt._age = {props={}, func=function(self) return tick() - self._created end}
		for tp,slt in fp do for name,data in lt do fp[tp][name] = data end end

-- wraps_mods
	-- universal
		local lt:{{props: {[string]: any}, binds: {meta_methods}, start_or_end: boolean, overwrite: boolean, func: (...any)->...any}} = {}
		lt[#lt+1] = {props={_last_interaction=0}, binds=amt, start_or_end=true, overwrite=false, func=function(self,...) self._last_interaction = tick(); return self,... end}
		for tp,slt in wm do for _,data in lt do wm[tp][#wm[tp]+1] = data end end
	
	-- function
		local tp = "function"
		local lt, ccq = wm[tp], cq[tp]
		lt[#lt+1] = {props={_caching = false}, binds={"__call"}, start_or_end=true, overwrite=true, func=function(self,...) 
			local sig = {}
			for _,arg in {...} do sig[_] = s.str(arg) end
			sig = k.h(s.tc(sig))
			local r = self._cache["__call"][sig]
			if r then return s.un(r)
			else
				r = {self[1](((s._method and self[1]) or self),...)}
				self._cache["__call"][sig] = r
				return s.un(r)
			end
		end}; ccq["__call"] = true

-- methods 
	-- universal
		-- local lt = {}
		-- for tp,slt in m do for name,func in lt do m[tp][name] = func end end
	
	-- string
		local tp = "string"
		local lt, ccq = m[tp], cq[tp]
		function lt:run(...)
			local h, c = k.h(self), self._cache["run"]
			local func = c[h]
			if func then return func(...)
			else
				local func = s.exec(self)
				c[h] = func
				return func(...)
			end
		end; ccq[#ccq+1] = "run"

		-- TODO: fastload
	
	-- number
		local tp = "number"
		local lt, cq = m[tp], cq[tp]
		function lt:i(mx, mn) mn = (mn or 0); return mx >= self and self >= mn end

	-- function
		local tp = "function"
		local lt, cq = m[tp], cq[tp]

-- operators
	-- universal
		local lt = {}
		lt.__index = function(self,i)
			local tp = self._type
			local p, m = fp[tp][i], m[tp][i]
			if p then return p.func(self,i)
			elseif m then return m
			else
				local m = k.l(self[1][i])
				m._method = true
				return m
			end
		end 
		lt.__newindex = function(self,i,v) self[1][i] = v end 
		lt.__call = function(self,w,...) return self[1](((self._method and w[1]) or w),...) end
		lt.__iter = function(s) return s.next, s._iter, nil end
		for _,tp in atp do op[tp] = lt end

	-- string
		local tp = "string"
		local lt = op[tp]
		lt.__unm = function(str) return k.l(s.rvrs(str[1])) end
		-- lt.__add = function(str1, str2) return str1..str2 end NOTE: why not concat
		lt.__sub = function(str1, str2)
			local fstr2 = ""
			str2 = s.str(str2)
			for i=1,#str2 do fstr2 = fstr2..`[{s.sub(str2,i)}]` end
			local r,_ = s.gsub(str1[1], k.ul(str2), "")
			return r
		end
		lt.__mul = function(str, num:number):string return k.l(s.rep(str[1], k.ul(num))) end
		lt.__pow = function(str, num:number):string return k.l(s.rep(str[1], k.ul(num) ^ k.ul(#str))) end
		lt.__div = function(str1, str2):number
			local nstr2 = {}
			str2 = k.ul(s.str(str2))
			for i=1,#str2 do nstr2[#nstr2+1] = `[{str2[i]}]` end
			local _,num = s.gsub(str1[1], s.concat(nstr2))
			return k.l(num)
		end
		lt.__concat = function(str1, str2):string return k.l(str1[1]..k.ul(s.str(str2))) end
		lt.__eq = function(str1, str2):boolean return k.l(k.ul(#str1) == k.ul(s.str(str2))) end
		lt.__lt = function(str1, str2):boolean return k.l(k.ul(#str1) < k.ul(s.str(str2))) end
		lt.__le = function(str1, str2):boolean return k.l(k.ul(#str1) <= k.ul(s.str(str2))) end
		lt.__len = function(str):number return k.l(#str[1]) end
		
	-- function
		local tp = "function"
		local lt = op[tp]
		lt.__unm = function(func) return function(...) return s.pcl(func[1],...) end end

	-- table 
		local tp = "table"
		local lt = op[tp]
		local asd = function(lt:{{any}}):{{}} local r = {}; for i,v in lt[1] do r[v] = i end; return k.l(r) end
		lt.__add = function(lt1, lt2) for i,v in lt2 do if typeof(i) == "number" then lt1:i(LuaV(v)) else lt1[i] = LuaV(v) end end return lt1 end
		lt.__sub = function(lt1, lt2) for i,v in lt2 do local fi = lt1:fi(v); if fi ~= 0 then lt1[fi] = nil end end; return lt1 end
		lt.__mul = function(lt, num) local flt = LuaV({}); for a=1,num do flt = flt + lt end; return flt end
		lt.__pow = function(lt, num) for a=1, num do lt = lt + lt end; return lt end
		lt.__div = function(lt, obj) local num = 0; for _,v in lt do if obj == v then num = num + 1 end end; return num end
		lt.__idiv = function(lt, obj) local num = 0; for i,_ in lt do if obj == i then num = num + 1 end end; return num end
		lt.__mod = function(lt, obj) local num = 0; for i,v in lt do if obj == i or obj == v then num = num + 1 end end; return num end
		lt.__eq = function(lt1, lt2) local t = true; for i,v in lt1 do if lt2[i] ~= v then t = false end end; return t end


	-- Instance
		local tp = "Instance"
		local lt = op[tp]
		lt._len = function(self) return #self[1]:GetChildren() end

