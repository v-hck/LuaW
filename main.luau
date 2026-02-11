--!strict
--!optimize 2
type types_str = "string"|"number"|"function"|"Instance"|"Vector3"|"CFrame"|"table"
type meta_methods = "__index"|"__newindex"|"__call"|"__add"|"__sub"|"__mul"|
	"__div"|"__mod"|"__pow"|"__unm"|"__eq"|"__lt"|"__le"|"__concat"|
	"__tostring"|"__len"| "__iter"


type types_lt<obj> = {["string"]: obj}&{["number"]: obj}&{["function"]: obj}&
	{["Instance"]: obj}&{["Vector3"]: obj}&{["CFrame"]: obj}&{["table"]: obj}

type meta_methods_lt<obj> = {__index: obj}&{__newindex: obj}&{__call: obj}&
	{__add: obj}&{__sub: obj}&{__mul: obj}&{__div: obj}&{__mod: obj}&
	{__pow: obj}&{__unm: obj}&{__eq: obj}&{__lt: obj}&{__le: obj}&
	{__concat: obj}&{__tostring: obj}&{__len: obj}&{__iter: obj}


type luaw<t> = {[number]:t , _type:types_str, _method:boolean, _created:number, _last_interaction:number, _cache:{[string]: {[any]: any}}, _iter: {[any]: any}}
type luaws = luaw<any>

type str = luaw<string>
type int = luaw<number>
type lts = luaw<{[any]: any}>
type bin = luaw<<a...,r...>(a...)->r...>
type ins = luaw<Instance>
type vec3 = luaw<Vector3>
type vec12 = luaw<CFrame>


--init env
	local __luaw__
	-- :{ -- NOTE: annotation for checking the arch correct
	-- 	help: {
	-- 		all_meta: {meta_methods},
	-- 		all_types: {types}
	-- 	},
	-- 	type_sysyem: {
	-- 		help: {
	-- 			cache_reqs: {[string]: {string}},
	-- 			iters: types_lt<(types)->{[any]: any}>
	-- 		},
	-- 		raw: {
	-- 			default_props: types_lt<{[string]: any}>,
	-- 			func_props: types_lt<{[string]: {props: {[string]: any}, func:(...any)->...any}}>,
	-- 			wraps_mods: types_lt<{{props: {[string]: any}, binds: {meta_methods}, start_or_end: boolean, overwrite: boolean, func: (...any)->...any}}>,
	-- 			methods: types_lt<{[string]: (...any)->(...any)}>,
	-- 			operators: types_lt<{[string]: (...any)->...any}>
	-- 		},
	-- 		compiled: {
	-- 			wraps: types_lt<{[string|number]: any}>,
	-- 			meta: types_lt<meta_methods_lt<(luaws, ...any)->...any>>
	-- 		}
	-- 	},
	-- 	funcs: {
	-- 		kernel: {[string]: (...any)->...any},
	-- 		normal: {[string]: (...any)->...any},
	-- 		backups: {[string]: (...any)->...any},
	-- 		orig: {[string]: (...any)->...any}
	-- 	},
	-- 	objects: {
	-- 		roblox: {[string]: Instance},
	-- 		luaw: {[string]: any}
	-- 	},
	-- 	config: {
	-- 		log: boolean,
	-- 		warn: boolean
	-- 	}
	-- } 
	= {
		help = {
			all_meta = {},
			all_types = {}
		},
		type_system = {
			raw = {
				default_props = {},
				func_props = {},
				wraps_mods = {},
				methods = {},
				operators = {},
			},
			compiled = {
				wraps = {},
				meta = {}
			},
			help = {
				cache_reqs = {},
				iters = {}
			}
		},
		funcs = {
			kernel = {},
			normal = {},
			backups = {},
			orig = {}
		},
		objects = {
			roblox = {},
			luaw = {}
		},
		config = {
			log = true,
			warn = true
		}
	}

		local f = __luaw__.funcs
			local k = f.kernel
			local n = f.normal
			local b = f.backups
			local of = f.orig
			local f = nil

		local o = __luaw__.objects
			local ro = o.roblox
			local lo = o.luaw
			local o = nil
			
		local ts = __luaw__.type_sysyem
			local rw = ts.raw
				local dp = rw.default_props
				local fp = rw.func_props
				local wm = rw.wraps_mods
				local m = rw.methods
				local op = rw.operators

			local cd = ts.compiled
				local ws = cd.wraps
				local mt = cd.meta

			local tshp = ts.help
				local cq = tshp.cache_reqs
				local its = tshp.iters

			-- FIX: rng text
			-- local txt = d.text
			-- 	local ltt = txt.letters
			-- 	local nms = txt.numbers
			-- 	local sbl = txt.symbols
			-- 	local vdc = txt.valid_combo
			-- 	local ltls = {l=ltt, n=nms, s=sbl}
		
		local hp = __luaw__.help
			local amt = hp.all_meta
			local atp = hp.all_types
			local hp = nil

		local cfg = __luaw__.config

--fast env set
	amt = {"__index", "__newindex", "__call", "__add", "__sub", "__mul",
	"__div", "__mod", "__pow", "__unm", "__eq", "__lt", "__le", "__concat",
	"__tostring", "__len",  "__iter"}
	atp = {"string", "number", "function", "Instance", "Vector3", "CFrame", "boolean"}

	local atp_lt = {}
	for _,tp in atp do atp_lt[tp] = {} end
	for i,_ in rw do rw[i] = table.clone(atp_lt) end
	for i,_ in cd do cd[i] = table.clone(atp_lt) end
	for i,_ in tshp do tshp[i] = table.clone(atp_lt) end
	local atp_lt = nil

	dp["Instance"]["_method"] = false

	local function collect_orig(lt)
		for _,obj in lt do
			local tp = typeof(obj)
			if tp == "function" then
				of[obj] = true
			elseif tp == "table" then
				collect_orig(obj)
			end
		end
	end; collect_orig(getgenv())
	local collect_orig = nil

	-- FIX: rng text
	-- for a=65, 90 do ltt[#ltt+1] = string.char(a) end
	-- for a=97, 122 do ltt[#ltt+1] = string.char(a) end
	-- for a=48, 57 do nms[#nms+1] = string.char(a) end
	-- for a=32, 47 do sbl[#sbl+1] = string.char(a) end
	-- for a=58, 64 do sbl[#sbl+1] = string.char(a) end
	-- for a=91, 96 do sbl[#sbl+1] = string.char(a) end
	-- for a=123, 126 do sbl[#sbl+1] = string.char(a) end
	-- vdc = {"l", "n", "s", "ln", "ns", "sl", "lns", "ls", "nl", "sn", "snl"}

	b["gg"] = getgenv

	local function port_save(name2:string, ...:string)
		local obj = b.gg()
		for _, name in {...} do obj = obj[name] end
		b[name2] = obj
	end

-- port&save | port_save("____", "____")
	-- NOTE: ONLY FOR EDIT: idk how to add correct annotation to port_save
		b.str = tostring
		b.int = tonumber
		b.exec = loadstring
		b.rget = rawget
		b.rset = rawset
		b.un = unpack
		b.tp_ = type
		b.tpf = typeof
		b.pcl = pcall
		b.rvrs = string.reverse
		b.gsub = string.gsub
		b.sub = string.sub
		b.rep = string.rep
		b.tcln = table.clone
		b.tcnc = table.concat
		b.round = math.round
		b.rint = math.random
		b.hash_ = crypt.hash

	port_save("str", "tostring")
	port_save("int", "tonumber")
	port_save("exec", "loadstring")
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
	-- luaw
		-- TODO: rng text here
	-- roblox
		-- o["_____"] = cloneref(game:GetService("_____"))
			ro["w"] = cloneref(game:GetService("Workspace"))
			ro["p"] = cloneref(game:GetService("Players"))
			ro["r"] = cloneref(game:GetService("RunService"))
			ro["lg"] = cloneref(game:GetService("Lighting"))
			ro["db"] = cloneref(game:GetService("Debris"))
			ro["rs"] = cloneref(game:GetService("ReplicatedStorage"))
			ro["rf"] = cloneref(game:GetService("ReplicatedFirst"))
			ro["sg"] = cloneref(game:GetService("StarterGui"))
			ro["ms"] = cloneref(game:GetService("MaterialService"))
			ro["cg"] = cloneref(game:GetService("CoreGui"))
			ro["cs"] = cloneref(game:GetService("TextChatService"))
			ro["ps"] = cloneref(game:GetService("PhysicsService"))
			ro["hs"] = cloneref(game:GetService("HttpService"))
			ro["ts"] = cloneref(game:GetService("TeleportService"))
			ro["uis"] = cloneref(game:GetService("UserInputService"))
			ro["vim"] = cloneref(game:GetService("VirtualInputManager"))

		-- o["_____"] = 
			ro["inf"] = 1/0
			ro["nan"] = 0/0
			ro["mhv3"] = Vector3.new(ro.inf, ro.inf, ro.inf)
			ro["nv3"] = Vector3.new()

		-- o["_____"] = o._____.
			ro["me"] = ro.p.LocalPlayer
			ro["old_char"] = ro.me.Character
			if ro.old_char then
				local char = ro.old_char
				ro["old_hrp"] = char:FindFirstChild("HumanoidRootPart")
				ro["old_hum"] = char:FindFirstChild("Humanoid")
				ro["old_hd"] = char:FindFirstChild("Head")
				ro["old_tr"] = char:FindFirstChild("Torso")
			end
			ro["cam"] = ro.w.CurrentCamera
			ro["m"] = ro.me:GetMouse()
			ro["name"] = ro.me.Name
			ro["dname"] = ro.me.DisplayName
			-- o["pg"] = o.me.PlayerGui FIX:  TypeError: Key 'PlayerGui' not found in class 'Player' 
			ro["muid"] = ro.me.UserId
			ro["rt"] = ro.p.RespawnTime

			local DCSCE = ro.rs:FindFirstChild("DefaultChatSystemChatEvents") :: TextChatService?
			if DCSCE then
				ro["saymsg"] = DCSCE:WaitForChild("SayMessageRequest") :: RemoteEvent
				ro["getmsg"] = DCSCE:WaitForChild("SayMessageRequest") :: RemoteEvent
				DCSCE = nil
			end

--kernel	
	function k.duplicate<t>(num:number, obj:t):...t
		local lt = {}
		for a=1,num do lt[a] = obj end
		return b.un(lt)
	end; k.d, k.dup = k.duplicate, k.duplicate

	k.tp, k.type = k.d(2, function(obj:any):string
		local tp = b.tpf(obj)
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

	k.il, k.islw, k.isluaw = k.d(3, function(obj:any):string|false
		return (b.tpf(obj) == "table" and (obj::luaws)._type) or false 
	end)

	k.ul, k.unlw, k.unluaw = k.d(3, function(...:any):...any
		local lt = {...}
		for i,obj in lt do
			if k.il(obj) then
				lt[i] = (obj::luaws)[1]
			end
		end; return b.un(lt)
	end)

	k.l, k.lw, k.luaw = k.d(3, function<T>(...:T):...luaw<T>
		local lt = {...}::{any}
		for i,obj in lt do
			local tp = b.tpf(obj)
			if obj and atp[tp] and not(k.il(obj)) then
				local wrap = ws[tp]
				wrap[1], wrap["_iter"] = obj, its[tp](obj)
				lt[i] = setmetatable(wrap, mt[tp])
			end
		end; return b.un(lt)
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
			local lt = b.tcln(op)
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
					local v:string = b.sub(meta, 2,-1)
					ws[tp][v] = 0
					lt[meta] = function(self:luaws,...) self[v] += 1; return func(b,...) end
				end
			end
			mt[tp] = lt
		end
	end)

	function k.str(...:any):...str
		local lt = {...}
		for i,obj in lt do lt[i] = k.l(b.str(obj)) end
		return b.un(lt)
	end

	k.h, k.hash = k.d(2, function(...:any):str
		local lt, r = {...}, ""
		for i,data in lt do
			r = b.hash_(r .. k.ul(k.str(data)), "md5")
		end; return k.l(r)
	end)

	-- to any
		function k.int(...:any):...int
			local lt = {...}
			for i,v in lt do 
				if k.il(v) then lt[i] = v:__tonumber()
				else lt[i] = k.l(b.int(v)) end
			end; return b.un(lt)
		end

		function k.lst(...:any):...lst
			local lt = {...}
			for i,v in lt do 
				if k.il(v) then lt[i] = v:__totable()
				else lt[i] = k.l(b.int(v)) end
			end; return b.un(lt)
		end

--normal
	local o_r_Heartbeat, o_r_RenderStepped = ro.r.Heartbeat, ro.r.RenderStepped
	local ft1, ft2 = [[return function(num)
		local event = ]],[[
		num = k.ul(num)
		if not(num) then return event:Wait()
		else local t, tt = tick(), 0
			while tick() < t+num do
				tt = tt + event:Wait()
			end; return k.l(tt)
		end
	end]]

	n.qw, n.qwait, n.quick_wait = k.dup(3, b.exec(`{ft1}o_r_Heartbeat{ft2}`)::(num:number?)->(int)) 
	n.pw, n.pwait, n.physic_wait = k.dup(3, b.exec(`{ft1}o_r_RenderStepped{ft2}`)::(num:number?)->(int))
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

	n.chat, n.cht, n.ct = k.d(3, function(msg:any)
		if ro.cs.ChatVersion == Enum.ChatVersion.TextChatService then
			ro.cs.TextChannels.RBXGeneral:SendAsync(k.ul(k.str(msg)))
		elseif ro.saymsg then
			ro.saymsg:FireServer(k.ul(k.str(msg)), "All")
		end
	end)

	n.system_chat, n.schat, n.sc = k.d(3, function(msg:any)
		ro.p:Chat(k.ul(k.str(msg)))
	end)

	n.bypass_chat, n.bchat, n.bc = k.d(3, function(msg:any, num:any, length:any)
		num, length = k.ul(k.int(num, length))
		local can = b.rep("can ", num or 10)
		if msg == "" then n.schat(can)
		else
			for a=1,num or (#msg/10)+1 do
				n.schat(can)
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

	n.ifo, n.if_or = k.d(2, function(b:any, v1:any, v2:any):any
		if not(v2) then return b or v1
		else return (b and v1) or v2 end
	end)

-- func_props
	-- universal
		local lt:{[string]:{props: {[string]: any}, func:(...any)->...any}} = {}
		lt._age = {props={}, func=function(self:luaws) return tick() - self._created end}
		for tp,slt in fp do for name,data in lt do fp[tp][name] = data end end

-- wraps_mods
	-- universal
		local lt:{{props: {[string]: any}, binds: {meta_methods}, start_or_end: boolean, overwrite: boolean, func: (...any)->...any}} = {}
		lt[#lt+1] = {props={_last_interaction=0}, binds=amt, start_or_end=true, overwrite=false, func=function(self:luaws,...:any):(luaws,...any) self._last_interaction = tick(); return self,... end}
		for tp,slt in wm do for _,data in lt do wm[tp][#wm[tp]+1] = data end end
	
	-- function
		local tp = "function"
		local lt, ccq = wm[tp], cq[tp]
		lt[#lt+1] = {props={_caching = false}, binds={"__call"}, start_or_end=true, overwrite=true, func=function(self:luaws,...:any):...any 
			local sig = k.h(...)
			local r = self._cache.__call[sig]
			if r then return b.un(r)
			else
				r = {self[1](((b._method and self[1]) or self),...)}
				self._cache["__call"][sig] = r
				return b.un(r)
			end
		end}; ccq["__call"] = true

-- methods 
	-- universal
		-- local lt = {}
		-- for tp,slt in m do for name,func in lt do m[tp][name] = func end end
	
	-- string
		local tp = "string"
		local lt, ccq = m[tp], cq[tp]
		function lt:run(self:str,...:any):...any
			local h, c = k.h(self), self._cache["run"]
			local func = c[h]
			if func then return func(...)
			else
				local func = b.exec(self)
				c[h] = func
				return func(...)
			end
		end; ccq[#ccq+1] = "run"

		-- TODO: fastload
	
	-- number
		local tp = "number"
		local lt, cq = m[tp], cq[tp]
		function lt:r(mx:any, mn:any):boolean 
			local nn = self[1]
			mx, mn = k.int(mx)[1], k.int(mn)[1]
			mn = (mn or 0)
			return mx >= nn and nn >= mn 
		end

	-- function
		-- local tp = "function"
		-- local lt, cq = m[tp], cq[tp]

-- operators
	-- universal
		local lt = {}
		lt.__index = function(self:luaws,i:any):any
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
		lt.__newindex = function(self:luaws,i:any,v:any) self[1][i] = v end 
		lt.__call = function(self:luaws,w:luaws,...):...any return self[1](((self._method and w[1]) or w), ((of[self[1]] and k.ul(...)) or ...)) end
		lt.__iter = function(self:luaws) return b.nxt, self._iter, nil end
		for _,tp in atp do op[tp] = lt end

	-- string
		local tp = "string"
		local lt = op[tp]
		lt.__unm = function(self:str):str return k.l(b.rvrs(self[1])) end
		-- lt.__add = function(str1, str2) return str1..str2 end -- TODO: pls give me idea
		lt.__sub = function(self:str, str_arg:any):str
			local fstr = ""
			str_arg = k.ul(k.str(str_arg))
			for i=1,#str_arg do fstr = fstr..`[{b.sub(str_arg,i)}]` end
			local r,_ = b.gsub(self[1], str_arg, "")
			return k.l(r)
		end
		lt.__mul = function(self:str, num:any):str return k.l(b.rep(self[1], k.ul(k.int(num)))) end
		lt.__pow = function(self:str, num:any):self return k.l(b.rep(self[1], k.ul(k.int(num)) ^ k.ul(#self))) end
		lt.__div = function(self:str, str_arg:any):int
			local nstr = {}
			str_arg = k.ul(k.str(str_arg))
			for i=1,#str_arg do nstr[#nstr+1] = `[{str_arg[i]}]` end
			local _,num = b.gsub(self[1], b.tcnc(nstr), "")
			return k.l(num)
		end
		lt.__concat = function(self:str, str_arg:any):str return k.l(self[1]..k.ul(k.str(str_arg))) end
		lt.__eq = function(self:str, str_arg:any):boolean return self[1] == k.ul(k.str(str_arg)) end
		lt.__lt = function(self:str, str_arg:any):boolean return self[1] < k.ul(k.str(str_arg)) end
		lt.__le = function(self:str, str_arg:any):boolean return self[1] <= k.ul(k.str(str_arg)) end
		lt.__len = function(self:str):int return k.l(#self[1]) end
		
	-- function
		local tp = "function"
		local lt = op[tp]
		lt.__unm = function(self) return k.l(function(...) return b.pcl(self[1],...) end) end

	-- table 
		local tp = "table"
		local lt = op[tp]
		lt.__add = function(self:lt, lt_arg:any) 
			for i,v in lt_arg do 
				if typeof(i) == "number" then self:i(LuaV(v)) 
				else self[i] = LuaV(v) 
				end 
			end; return self 
		end
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

