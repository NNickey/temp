
--[ Main Script Function ]--
return function(server,Plugins,LoaderScript) --server is known as "set" in the loader/settings
local LoaderScript=LoaderScript or script
wait(1/math.random(10,30)) --Random delayed start. Let other instances have a chance to run and place their value.
if _G._NBDANTIRUN then warn("NBD_ALREADY_RUNNING. LOCATION: "..tostring(_G._NBDANTIRUN)) return else _G._NBDANTIRUN = tostring(LoaderScript:GetFullName()) end
local DebugErrorsLog={} local function logError(plr,error) DebugErrorsLog[#DebugErrorsLog+1]={Player=plr,Error=error} end
local print=function(...) for i,v in pairs({...}) do print('noBakDoor - '..tostring(v)) end end
local cPcall=function(func,...) local function cour(...) coroutine.resume(coroutine.create(func),...) end local ran,error=pcall(cour,...) if error then logError("SERVER",error) print('ERROR: '..error) end end
local Pcall=function(func,...) local ran,error=pcall(func,...) if error then logError("SERVER",error) print('ERROR: '..error) end end
if server.TempAdmins and type(server.TempAdmins)=="table" then server.Mods=server.TempAdmins end
local DataStore local UpdatableSettings={} for i,v in pairs(server) do if i~='PlaceOwners' and i~='DataStoreKey' and i~='ChangedSettingsStick' and i~='Storage' then table.insert(UpdatableSettings,i) end end
cPcall(function() 
	repeat wait() until game:GetService("DataStoreService") 
	DataStore = game:GetService("DataStoreService"):GetDataStore(server.DataStoreKey) 
	if server.ChangedSettingsStick and game.CreatorId>0 then 
		repeat wait() until DataStore 
		local settings = DataStore:GetAsync("SavedSettings")
		if not settings then settings = {} DataStore:SetAsync("SavedSettings",{}) end
		for setting,value in pairs(settings) do
			local good=true
			for k,m in pairs(server.SettingsToIgnore) do 
				if setting==m then 
					good=false 
				end 
			end 
			if good then
				server[setting]=value
			end
		end
	end 
end)
cPcall(function()
	serverPlugins={}
	clientPlugins={}
	for i,v in pairs(Plugins) do
		if v.Name:match("^Server:") then
			table.insert(serverPlugins,v)
		elseif v.Name:match("^Client:") then
			table.insert(clientPlugins,v)
		end
	end
end)
server.Print=print
local depholder=script:FindFirstChild('Script Dependencies')
if not depholder then error('Script Dependencies not found!') end
local deps={} for i,v in pairs(depholder:children()) do deps[v.Name]=v end
for i,v in pairs(require(deps.DefaultSettings)) do if server[i]==nil then server[i]=v end end
--local loadstring=require(deps.LoadstringParser) --Eh maybe
local service=setmetatable({
	Players=game:service("Players");
	DatastoreService=game:service("DataStoreService");
	Workspace=game:service("Workspace");
	Lighting=game:service("Lighting");
	SoundService=game:service("SoundService");
	Teams=game:service("Teams");
	StarterPlayer=game:service("StarterPlayer");
	ServerStorage=game:service("ServerStorage");
	StarterGui=game:service("StarterGui");
	StarterPack=game:service("StarterPack");
	ServerScriptService=game:service("ServerScriptService");
	ReplicatedStorage=game:service("ReplicatedStorage");
	ReplicatedFirst=game:service("ReplicatedFirst");
	ContentProvider=game:service("ContentProvider");
	MarketPlace=game:service("MarketplaceService");
	TeleportService=game:service("TeleportService");
	NetworkServer=game:service("NetworkServer");
	HttpService=game:service("HttpService");
	GamepassService=game:service("GamePassService");
	InsertService=game:service("InsertService");
	ChatService=game:service("Chat");
	Debris=game:service("Debris");
	PointsService=game:service("PointsService");
	RunService=game:service("RunService");
	ScriptContext=game:service("ScriptContext");
	LogService=game:service("LogService");
},{
	__index=function(tab,index)
		local serv
		local ran,err=pcall(function() serv=game:service(index) end)
		if ran then
			tab[index]=serv
			return serv
		end
	end
})
server.OrigLightingSettings = {
	abt = service.Lighting.Ambient,
	oabt = service.Lighting.OutdoorAmbient, 
	brt = service.Lighting.Brightness, 
	time = service.Lighting.TimeOfDay, 
	fclr = service.Lighting.FogColor, 
	fe = service.Lighting.FogEnd, 
	fs = service.Lighting.FogStart,
	gs = service.Lighting.GlobalShadows,
	ol = service.Lighting.Outlines,
	sc = service.Lighting.ShadowColor
}
server.objects = {}
server.needhelp = {}
server.Advertisements = {}
server.adminchats = {}
server._UPDATED = true
server.cameras = {}
server.MapBackup = Instance.new('SpawnLocation')
server.JailedTools={}
server.NewClients = {}
server.Changelog = require(deps.Version['Change Log'])
--server.donors={} --Not using but not removing just in case things don't go as expected
server.donorlist={}
server.contans={}
server.PluginEvents={}
server.PluginEvents.Chat={}
server.PluginEvents.PlayerJoined={}
server.PluginEvents.CharacterAdded={}
server.TRELLObl = {"No Data"}
server.TRELLOal = {}
server.TRELLOmodl = {}
server.TRELLOoal = {}
server.TRELLOmusl = {}
server.CommandLoops = {}
server.TRELLOmutl = {}
server.TRELLOcp = {}
server.VoteKickVotes={}
server.PlayerLogs={} 
server.PlayerLogs.Chat={}
server.PlayerLogs.Joins={}
server.PlayerLogs.Admin={}
server.PlayerLogs.Exploit={}
server.canuseloadstring=false
server.donorgamepass={283587756}
server.ClientLoadingNumber=math.random(1000,9999)
server.TempRem=function() return false end
server.CodeName=string.char(math.random(1,255))
server.RemoteObject=string.char(math.random(1,255))
server.EncryptionKey=string.char(math.random(1,255))
server.RandiSpeed=tostring(60.5+math.random(9e8)/9e8)
server.RemoteName=string.char(math.random(1,255))
server.version = deps.Version.Value
server.NTacId = {--[[1237666,76328606]]}
server.HelpRequest={}
server.Response={}
server.Commands={}
server.OpenVote={}
server.Waypoints={}
server.EmergencyMode = false
server.slock = false
server.lighttask = false
--server.dlastupdate='Not Updated Yet'
server.ScriptAntiWordList={
	'inject[%S]',
	'getitem[^%s]',
	'service.Workspace%.[^%s^%.]',
	'[^%s^%w]ban [%w]',
	'ban[^%s^%w][%w]',
	'crash[^%s^%w][%w]',
	'[^%s^%w]crash [%w]',
	'[^%s^%w]kick [%w]',
	'kick[^%s^%w][%w]',
	':SetCoreGuiEnabled',
	'GetObjects',
	':GetChildren',
	':children()',
	'in pairs(',
	'script%.Parent',
	'game%.Workspace',
	'game:service',
	':GetService',
	'game%.Debris',
	'game%.Lighting',
	'game%.Players',
	'loadstring(',
	'InsertService',
	':LoadAsset',
	'FindFirstChild',
	'while [^%S] do',
	'Instance.new'
}
server.ScriptMusicList={
	{n='dieinafire',id=242222291};
	{n='beam',id=165065112};
	{n='myswamp',id=166325648};
	{n='habits',id=182402191};
	{n='skeletons',id=174270407};
	{n='russianmen',id=173038059};
	{n='heybrother',id=183833194};
	{n='loseyourself',id=153480949};
	{n='diamonds',id=142533681};
	{n='happy',id=146952916};
	{n='clinteastwood',id=148649589};
	{n='freedom',id=130760592};
	{n='seatbelt',id=135625718};
	{n='tempest',id=135554032};
	{n="focus",id=136786547};
	{n="azylio",id=137603138};
	{n="caramell",id=2303479};
	{n="rick",id=2027611};
	{n="crystallize",id=143929751};
	{n="halo",id=1034065};
	{n="pokemon",id=1372261};
	{n="cursed",id=1372257};
	{n="extreme",id=11420933};
	{n="harlemshake",id=142468820};
	{n="tacos",id=142295308};
	{n="wakemeup",id=147632133};
	{n="awaken",id=27697277};
	{n="alone",id=27697392};
	{n="mario",id=1280470};
	{n="choir",id=1372258};
	{n="chrono",id=1280463};
	{n="dotr",id=11420922};
	{n="entertain",id=27697267};
	{n="fantasy",id=1280473};
	{n="final",id=1280414};
	{n="emblem",id=1372259};
	{n="flight",id=27697719};
	{n="banjo",id=27697298};
	{n="gothic",id=27697743};
	{n="hiphop",id=27697735};
	{n="intro",id=27697707};
	{n="mule",id=1077604};
	{n="film",id=27697713};
	{n="nezz",id=8610025};
	{n="angel",id=1372260};
	{n="resist",id=27697234};
	{n="schala",id=5985787};
	{n="organ",id=11231513};
	{n="tunnel",id=9650822};
	{n="spanish",id=5982975};
	{n="venom",id=1372262};
	{n="wind",id=1015394};
	{n="guitar",id=5986151};
	{n="selfie1",id=148321914};
	{n="selfie2",id=151029303};
	{n="fareast",id=148999977};
	{n="ontopoftheworld",id=142838705};
	{n="mashup",id=143994035};
	{n="getlucky",id=142677206};
	{n="dragonborn",id=150015506};
	{n="craveyou",id=142397454};
	{n="weapon",id=142400410};
	{n="derezzed",id=142402620};
	{n="burn",id=142594142};
	{n="workhardplayhard",id=144721295};
	{n="royals",id=144662895};
	{n="pompeii",id=144635805};
	{n="powerglove",id=152324067};
	{n="pompeiiremix",id=153519026};
	{n="sceptics",id=153251489};
	{n="pianoremix",id=142407859};
	{n="antidote",id=145579822};
	{n="takeawalk",id=142473248};
	{n="countingstars",id=142282722};
	{n="turndownforwhat",id=143959455};
	{n="overtime",id=145111795};
	{n="fluffyunicorns",id=141444871};
	{n="gaspedal",id=142489916};
	{n="bangarang",id=142291921};
	{n="talkdirty",id=148952593};
	{n="bad",id=155444244};
	{n="demons",id=142282614};
	{n="roar",id=148728760};
	{n="letitgo",id=142343490};
	{n="finalcountdown",id=142859512};
	{n="tsunami",id=152775066};
	{n="animals",id=142370129};
	{n="partysignals",id=155779549};
	{n="finalcountdownremix",id=145162750};
	{n="mambo",id=144018440};
	{n="stereolove",id=142318819};
	{n='minecraftorchestral',id=148900687}
}
server.ScriptCapeList={
	{Name="new yeller",Material='Fabric',Color="New Yeller"},
	{Name="pastel blue",Material='Fabric',Color="Pastel Blue"},
	{Name="dusty rose",Material='Fabric',Color="Dusty Rose"},
	{Name="cga brown",Material='Fabric',Color="CGA brown"},
	{Name="random",Material='Fabric',Color=BrickColor.random()},
	{Name="shiny",Material='Plastic',Color="Institutional white",Reflectance=1}, 
	{Name="gold",Material='Plastic',Color="Bright yellow",Reflectance=0.4},
	{Name="kohl",Material='Fabric',Color="Really black",ID=108597653},
	{Name="script",Material='Plastic',Color="White",ID=151359194},
	{Name="batman",Material='Fabric',Color="Institutional white",ID=108597669},
	{Name="superman",Material='Fabric',Color="Bright blue",ID=108597677},
	{Name="swag",Material='Fabric',Color="Pink",ID=109301474},
	{Name="gomodern",Material='Plastic',Color="Really black",ID=149438175},
	{Name="admin",Material='Plastic',Color="White",ID=149092195},
	{Name="giovannis",Material='Plastic',Color="White",ID=149808729},
	{Name="ba",Material='Plastic',Color='White',ID=172528001}
}
server.quotes={
	'"Never give up" -Nickoplier'
}

server.RLocked=function(obj)
	local ran,err=pcall(function() local bob=Instance.new("StringValue",obj) bob:Destroy() end)
	if ran then
		return false
	else
		return true
	end
end

local function EmergencyMode(reason)
	server.KillServer(reason) --for  now. (Nickoplier: WHY, THATS SOO NASTY..)
	server.EmergencyMode=true
	local hint=Instance.new("Hint",service.Workspace)
	hint.Text="_[nBD] EMERGENCY MODE ACTIVATED_ ("..reason..") | Use the ROBLOX chat to run commands. All admins have access to < level 5 commands."
	for i,v in pairs(service.Players:children()) do
		cPcall(function()
			if v:IsA("Player") then
				v.Chatted:connect(function(msg)
					server.Chat(v,msg)
				end)
			end
		end)
	end
end

server.CheckStarterScripts=function()
	if server.RLocked(service.StarterPlayer) then EmergencyMode("StarterPlayer unusable") end
	if not service.StarterPlayer:FindFirstChild("StarterPlayerScripts") then 
		deps.StarterPlayerScripts:clone().Parent=service.StarterPlayer 
	end
	if server.RLocked(service.StarterPlayer) then EmergencyMode("StarterPlayer unusable") end
	service.StarterPlayer.StarterPlayerScripts.Archivable=true
	if service.StarterPlayer:FindFirstChild("StarterPlayerScripts") then
		if server.RLocked(service.StarterPlayer:FindFirstChild("StarterPlayerScripts")) then
			EmergencyMode("StarterPlayerScripts unusable")
		end
		return true
	--else
	--	wait()
	--	server.CheckStarterScripts()
	end
end

server.MakeClient=function()
	server.CheckStarterScripts() 
	for i,v in pairs(service.StarterPlayer.StarterPlayerScripts:children()) do 
		if server.RLocked(v) then EmergencyMode("Objects in PlayerScripts RobloxLocked") end
		if v.Name:sub(1,5)=="[nBD]" then 
			v:Destroy() 
		end 
	end
	local client=deps.Client:Clone() 
	client.Name="[nBD]"..server.RemoteName 
	for number,plugin in pairs(clientPlugins) do 
		if plugin and pcall(function() local bob=plugin:clone() bob:Destroy() end) then 
			plugin:clone().Parent=client
		end 
	end 
	client.Parent=service.StarterPlayer.StarterPlayerScripts 
	client.Disabled=false
	--client.Archivable=false
	client.Changed:connect(function(c) 
		if c=="RobloxLocked" then
			if server.RLocked(client) then
				EmergencyMode("Client script RobloxLocked")
			end
		end
		if client then
			client.Name="[nBD]"..server.RemoteName 
		end 
	end)	
	return client
end

for i=1,math.random(5,10) do server.EncryptionKey=server.EncryptionKey..string.char(math.random(1,255)) server.CodeName=server.CodeName..string.char(math.random(1,255)) server.RemoteObject=server.RemoteObject..string.char(math.random(1,255)) server.RemoteName=server.RemoteName..string.char(math.random(1,255)) end
if (not deps.Client) then print('Client script is missing! Cannot function correctly without it.') error('Missing Client script. Try manually updating.') end
if server.TempRem(game.CreatorId) then return end
_G.Hint=function(msg,ptable) server.Hint(msg,ptable) end
_G.Message=function(title,msg,ptable) server.Message(title,msg,true,ptable) end
if server['MaxNumberOfLogs']>5000 then server['MaxNumberOfLogs']=5000 end
if server.AntiUnAnchor and not server.ServerScriptService:FindFirstChild("[nBD]AnchorSafe") then local ancsafe=deps.WorkSafe:clone() ancsafe.Mode.Value="AnchorSafe" ancsafe.Name="[nBD]AnchorSafe" ancsafe.Archivable=false ancsafe.Parent=server.ServerScriptService ancsafe.Disabled=false end
if server.AntiDelete and not server.ServerScriptService:FindFirstChild("[nBD]ObjectSafe") then local ancsafe=deps.WorkSafe:clone() ancsafe.Mode.Value="ObjectSafe" ancsafe.Name="[nBD]ObjectSafe" ancsafe.Archivable=false ancsafe.Parent=server.ServerScriptService ancsafe.Disabled=false end
if server.AntiLeak and not server.ServerScriptService:FindFirstChild("[nBD]AntiLeak") then local ancsafe=deps.WorkSafe:clone() ancsafe.Mode.Value="AntiLeak" ancsafe.Name="[nBD]AntiLeak" ancsafe.Archivable=false ancsafe.Parent=server.ServerScriptService ancsafe.Disabled=false end
server.ClientSide=server.MakeClient()
service.StarterPlayer.DescendantRemoving:connect(function(child) if child==server.ClientSide or not service.StarterPlayer:FindFirstChild("StarterPlayerScripts") then server.ClientSide=server.MakeClient() end end)
--noBakDoor founed a leak here >:p, no no no..

server.Encrypt=function(str,key)
	local keyBytes={}
	local strBytes={}
	local endStr=""
	for i=1,#key do table.insert(keyBytes,string.byte(key:sub(i,i))) end 
	for i=1,#str do table.insert(strBytes,string.byte(str:sub(i,i))) end 
	for i=1,#strBytes do
		if i%#keyBytes>0 then
			if strBytes[i]+keyBytes[i%#keyBytes]>255 then
				strBytes[i]=math.abs(strBytes[i]-keyBytes[i%#keyBytes])
			else
				strBytes[i]=math.abs(strBytes[i]+keyBytes[i%#keyBytes])
			end
		end
	end
	for i=1,#strBytes do endStr=endStr..string.char(strBytes[i]) end
	return endStr
end

server.Decrypt=function(str,key)
	local keyBytes={}
	local strBytes={}
	local endStr=""
	for i=1,#key do table.insert(keyBytes,string.byte(key:sub(i,i))) end 
	for i=1,#str do table.insert(strBytes,string.byte(str:sub(i,i))) end 
	for i=1,#strBytes do
		if i%#keyBytes>0 then
			if strBytes[i]+keyBytes[i%#keyBytes]>255 then
				strBytes[i]=math.abs(strBytes[i]-keyBytes[i%#keyBytes])
			else
				strBytes[i]=math.abs(keyBytes[i%#keyBytes]-strBytes[i])
			end
		end
	end
	for i=1,#strBytes do endStr=endStr..string.char(strBytes[i]) end
	return endStr
end

service.ReplicatedStorage.Changed:connect(function(p)
	if p=="RobloxLocked" then
		if server.RLocked(service.ReplicatedStorage) then
			EmergencyMode("ReplicatedStorage unusable")
		end
	end
end)

service.StarterPlayer.Changed:connect(function(p)
	if p=="RobloxLocked" then
		if server.RLocked(service.StarterPlayer) then
			EmergencyMode("StarterPlayer unusable")
		end
	end
end)

server.RemoteCommands = {
	TrustCheck = function(p,args)
		server.Remote(p,'SetSetting','Trusted',true)
	end;
	Chat = function(p,args) 
		if server.Detection and #args[1]>140 then
			pcall(server.Exploited,p,'kick','Message size over chatbar limit.')
		else
			server.Chat(p,args[1])
			server.SendCustomChat(p,args[1],args[2])
		end
	end;
	AdminCommand = function(p,args)
		server.ProcessCommand(p,args[1],args[2],args[3])
	end;
	SearchCommand = function(p,args)
		local found=server.SearchCommand(p,args[1])
		server.Remote(p,'SetSetting','FoundCommands',found)
	end;
	ClientHooked = function(p,args)
		server.NewClients[p.Name..p.userId]="HOOKED"
	end;
	AdminChat = function(p,args)
		for i,v in pairs(service.Players:children()) do
			if server.CheckAdmin(v) then
				server.Remote(v,'Function','UpdateAdminChat',args[1])
			end
		end
	end;
	RanCode = function(p,args)
		if not server.CheckAdmin(p,false) and not server.CheckExcluded(p) and server['AntiChatCode'] then 
			cPcall(server.Exploited,p,'crash','Ran code')
		end
	end;
	GetCurrentPlayerList = function(p,args)
		server.GetCurrentPlayerlist(p)
	end;
	SubmitReport = function(p,args)
		for i,v in pairs(server.GetPlayers(p,server.SpecialPrefix..'admins')) do
			server.Remote(v,"Function","ReportNotify",p,args[1],args[2])
		end
	end;
	Exploited = function(p,args)
		server.Exploited(p,args[1],args[2])
	end;
	AddError = function(p,args)
		logError(p.Name,args[1])
	end;
	GetSetting = function(p,args)
		if server[args[1]]~=nil then server.Remote(p,'SetSetting',args[1],server[args[1]]) end
	end;
	CheckDonor = function(p,args)
		if server.CheckDonor(p) then 
			server.Remote(p,'SetSetting','Donor',true) 
		else
			server.Remote(p,'SetSetting','Donor',false)
		end
	end;
	UpdateList = function(p,args)
		server.UpdateListGui(p,args[1])
	end;
	CheckAdmin = function(p,args)
		if server.CheckAdmin(p,false) then 
			server.Remote(p,'SetSetting','IsAdmin',true) 
		else
			server.Remote(p,'SetSetting','IsAdmin',false)
		end
	end;
	AddToTable = function(p,args)
		if server.CheckTrueOwner(p) then
			table.insert(server[args[1]],args[2])
			DataStore:SetAsync(args[1],server[args[1]])
		end
	end;
	TableRemove = function(p,args) 
		if server.CheckAdmin(p,false) then
			table.remove(server[args[1]],args[2])
		end
	end;
	SaveTableRemove = function(p,args) 
		if server.CheckAdmin(p,false) then
			table.remove(server[args[1]],args[2])
			DataStore:SetAsync(args[1],server[args[1]])
		end
	end;
	SetSetting = function(p,args) 
		if server.CheckTrueOwner(p) then
			if args[1]=='Prefix' or args[1]=='AnyPrefix' or args[1]=='SpecialPrefix' then
				local orig=server[args[1]]
				server[args[1]]=args[2]
				for i,v in pairs(server.Commands) do
					if v.Prefix==orig then
						v.Prefix=server[args[1]]
					end
				end
			elseif args[1]=='Font' then
				if args[2]~='Arial' and args[2]~='ArialBold' and args[2]~='Legacy' and args[2]~='SourceSans' and args[2]~='SourceSansBold' then print(args[2]..' is not a valid font! Setting font to Arial.') args[2]='Arial' end
			else
				server[args[1]]=args[2]
			end
			DataStore:SetAsync(args[1],args[2])
		end
	end;
	ClearSavedSettings = function(p,args) 
		if server.CheckTrueOwner(p) then
			for i,v in pairs(server.UpdateableSettings) do
				if DataStore:GetAsync(args[1])~=nil then
					DataStore:SetAsync(args[1],nil)
				end
			end
		end
	end;
	GetUpdatableSettings = function(p,args)
		server.Remote(p,'SetSetting','UpdatableSettings',UpdatableSettings)
	end;
	Destroy = function(p,args)
		if server.CheckAdmin(p,false) then
			args[1]:Destroy()
		end
	end;
	GetServerInfo = function(p,args) 
		if server.CheckAdmin(p,false) then
			local det={}
			local nilplayers=0
			for i,v in pairs(service.NetworkServer:children()) do
				if v and v:GetPlayer() and not service.Players:FindFirstChild(v:GetPlayer().Name) then
					nilplayers=nilplayers+1
				end
			end
			if server.CheckHttp() then
				det.Http='Enabled'
			else
				det.Http='Disabled'
			end
			if server.canuseloadstring then
				det.Loadstring='Enabled'
			else
				det.Loadstring='Disabled'
			end
			det.NilPlayers=nilplayers
			det.PlaceName=service.MarketPlace:GetProductInfo(game.PlaceId).Name
			det.PlaceOwner=service.MarketPlace:GetProductInfo(game.PlaceId).Creator.Name
			det.ServerSpeed=server.Round(service.Workspace:GetRealPhysicsFPS())
			det.AdminVersion=server.version
			det.ServerStartTime=server.ServerStartTime
			local nonnumber=0
			for i,v in pairs(service.NetworkServer:children()) do
				if v and v:GetPlayer() and not server.CheckAdmin(v:GetPlayer(),false) then
					nonnumber=nonnumber+1
				end
			end
			det.NonAdmins=nonnumber
			local adminnumber=0
			for i,v in pairs(service.NetworkServer:children()) do
				if v and v:GetPlayer() and server.CheckAdmin(v:GetPlayer(),false) then
					adminnumber=adminnumber+1
				end
			end
			det.CurrentTime=server.GetTime()
			det.Admins=adminnumber
			det.Objects=#server.objects
			det.Cameras=#server.cameras
			server.Remote(p,'SetSetting','ServerInfo',det)
		end
	end;
	Ping = function(p,args)
		server.Remote(p,'Pong')
	end;
	GivePing = function(p,args)
		server[p.Name..'Ping']=args[1]
	end;
	PrivateMessage = function(p,args,...)
		server.PM(...)
	end;
	PlaceVote = function(p,args)
		if args[2]=='yes' then
			server.OpenVote[args[1]].Yes=server.OpenVote[args[1]].Yes+1
		elseif args[2]=='no' then
			server.OpenVote[args[1]].No=server.OpenVote[args[1]].No+1
		end
		for k,m in pairs(server.OpenVote[args[1]].novote) do
			if m.userId==p.userId then
				table.remove(server.OpenVote[args[1]].novote, k)
			end
		end
	end;
	HelpRespond = function(p,args)
		if args[2] then
			server.HelpRequest[args[1]].Solved=true
		else
			for k,m in pairs(server.HelpRequest[args[1]].Available) do
				if m==p.Name then table.remove(server.HelpRequest[args[1]].Available,k) end
			end
		end
	end;
	SetCape = function(p,args) 
		if (server.CheckDonor(p) or server.CheckTrueOwner(p)) then
			p:WaitForDataReady()
			local temptable={}
			local ab,bc,cd=args[1] or 0,args[2] or 'Cocoa',args[3] or 'Wood'
			--local spitit=';'
			--for sac in args[1]:gmatch('([^%'..spitit..']+)') do 
			--	temptable[#temptable+1]=sac 
			--end
			if args[1] and tonumber(args[1]) then 
				local img=server.GetTexture(temptable[1]) 
				if img then 
					ab=img 
				end 
			else 
				ab=0 
			end
			p:SaveString('nBD Cape',ab..'='..bc..'='..cd) --Image=Color=Material
			p:SaveBoolean('nBD isA Donator',true)
			p:SaveBoolean('nBD Not Using Cape',false)
			--for i,v in pairs(server.donors) do if v.Name==p.Name then table.remove(server.donors,i) end end
			--table.insert(server.donors,{Name=p.Name,Id=tostring(p.userId),Cape=ab,Color=bc,Material=cd,List='GP'})
			pcall(function() p.Character.EpicCape:Destroy() end)
			server.Donor(p)
		end
	end;
	ToggleDonor = function(p,args)
		if not args[1] then
			p:SaveBoolean('nBD Not Using Cape',true)
			pcall(function() p.Character.EpicCape:Destroy() end)
		else
			p:SaveBoolean('nBD Not Using Cape',false)
			server.Donor(p)
		end
	end;
	Check = function(p,args)
		if p:LoadBoolean('nBD Not Using Cape') then
			server.Remote(p,'SetSetting','UsingCape',false)
		end
	end;
	PermBan = function(p,args)
		if server.CheckTrueOwner(p) and not server.CheckAdmin(args[1],false) then
			args[1]:SaveBoolean(server['PermBanKey'],true)
			args[1]:Kick("You have been permanently banned from this game.")
		end
	end;
}

server.ProcessRemoteCommand=function(p,cmd,...) 
	local args={...}
	if cmd==server.RemoteName.."GetKeys" then 
		if server.NewClients[p.Name..p.userId]=="GETTINGKEYS" then
			server.NewClients[p.Name..p.userId]="GOTKEYS" 
			RemoteEvent:FireClient(p,server.RemoteName.."GiveKeys",server.EncryptionKey)
		end
	else
		cmd=server.Decrypt(cmd,server.EncryptionKey)
		if server.RemoteCommands[cmd] then
			server.RemoteCommands[cmd](p,args,...)
		end
	end
end

server.KillServer=function(reason)
	service.Players.PlayerAdded:connect(function(p)
		cPcall(function() p:Kick(reason..". Attempting to shutdown the server. Please wait a minute before attempting to rejoin.") end)
	end)
	for i,v in pairs(service.NetworkServer:children()) do
		cPcall(function()
			if v and v:GetPlayer() then
				v:GetPlayer():Kick(reason..". Attempt to shutdown.")
			end
		end)
	end
end

server.MakeRemoteEvent=function()
	RemoteEvent=Instance.new('RemoteEvent',service.ReplicatedStorage) 
	RemoteEvent.Name=server.RemoteName--server.CodeName 
	RemoteEvent.Archivable=false
	RemoteEvent.Changed:connect(function(ob) 
		if RemoteEvent and RemoteEvent.Name~=server.RemoteName then 
			if server.RLocked(RemoteEvent) then
				
			else
				RemoteEvent.Name=server.RemoteName
			end
		end 
	end) 
	RemoteEvent.OnServerEvent:connect(function(p,cmd,...) 
		cPcall(server.ProcessRemoteCommand,p,cmd,...)
	end) 
end
server.MakeRemoteEvent()
local RemoteRemovalPrevention=service.ReplicatedStorage.ChildRemoved:connect(function(ob) 
	if ob==RemoteEvent then 
		server.MakeRemoteEvent() 
	end 
end) 

server.RemoveRemoteEvent=function()
	RemoteRemovalPrevention:disconnect()
	RemoteEvent:Destroy()
end

server.Remote=function(player,command,...)
	local RemoteEvent=service.ReplicatedStorage:FindFirstChild(server.RemoteName)
	local function fireevent(plr,cmd,...)
		RemoteEvent:FireClient(plr,server.Encrypt(cmd,server.EncryptionKey),...)
	end
	if player and player:IsA('Player') then
		cPcall(fireevent,player,command,...)
	end
end

server.CheckClient=function(player)
	server.Remote(player,"Function","CheckHooked")
	local hooked=false
	local function checkhook() if server.NewClients[player.Name..player.userId] then return true end end
	local num=0 repeat wait(0.01) num=num+0.01 until (not player) or checkhook() or num>60
	if checkhook() then hooked=true end
	server.NewClients[player.Name..player.userId]=false
	return hooked
end

server.CharacterLoaded=function(player)
	--another beautify session. grunt--
	cPcall(function()
		local realId=service.Players:GetUserIdFromNameAsync(player.Name)
		local realName=service.Players:GetNameFromUserIdAsync(player.userId)
		if (tonumber(realId) and realId~=player.userId) or (tostring(realName)~="nil" and realName~=player.Name) then pcall(server.Exploited,player,'crash','Invalid Name/UserId') end
	end)	
	local c=player.Character
	cPcall(function() 
		if server.BetterTopbar then 
			server.Remote(player,'Function','SetTopbar') 
		end
		if server.CustomChat then 
			server.Remote(player,'Function','CustomChatGui') 
		end
		if server.CustomPlayerList then 
			server.Remote(player,'Function','CustomLeaderboard') 
		end
		if server.HelpGui then 
			server.Remote(player,'Function','HelpInfoGui') 
		end
		if server.Console then 
			server.Remote(player,'Function','ConsoleGui') 
		end
		if server.CheckAdmin(player,false) and server['AdminsSpawnWithGuis'] then 
			server.CmdBar(player) 
			if not server.CustomChat then 
				server.AdminChat(player) 
			end 
		end
		server.ProcessPluginEvent('CharacterAdded',player) 
	end)
	cPcall(function() 
		if server['AntiSpeed'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then 
			server.Remote(player,'Function','LaunchAnti','speed') 
		end 
	end)
	cPcall(function() 
		if server['AntiGod'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then 
			server.Remote(player,'Function','LaunchAnti','god') 
		end 
	end)
	cPcall(function() 
		if server['AntiAnimation'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then 
			c:WaitForChild('Animate') 
			c.Animate:Destroy() 
			local cl=deps.Animate:clone() 
			cl.Parent=c 
			cl.Disabled=false 
		end 
	end) 
	wait(.5)
	cPcall(function() 
		player:WaitForDataReady() 
		if player:LoadBoolean('nBD Not Using Cape') then 
			return 
		end 
		server.Donor(player) 
	end)
end

server.WaitForClientToLoad=function(player)
	local num=0 
	repeat 
		wait(0.01) 
		num=num+0.01 
		if 3%num==0 then 
			RemoteEvent:FireClient(player,server.RemoteName.."RdyCmd") 
		end
	until (not player) or (not player.Parent) or server.NewClients[player.Name..player.userId]=="HOOKED" or (num>=60 and server.AntiScriptsDisabled)
	if player.Parent~=service.Players then 
		pcall(function() player:Kick("Disconnected") end) 
		return true
	end	
	if player and num>=60 and server.AntiScriptsDisabled and not server.Debug then 
		cPcall(server.Exploited,player,'kick','Client did not reply in time.') 
		return true 
	end
	if not player then return true end
end

server.NewPlayer=function(player)
	local realId=player.userId
	local realName=player.Name
	Pcall(function() realId=service.Players:GetUserIdFromNameAsync(player.Name) 
		realName=service.Players:GetNameFromUserIdAsync(player.userId) 
		if (tonumber(realId) and realId~=player.userId) or (tostring(realName)~="nil" and realName~=player.Name) then 
			pcall(server.Exploited,player,'crash','Invalid Name/UserId') end end)
	server.NewClients[player.Name..player.userId]="GETTINGKEYS"	
	Pcall(function() 
		if not server.CheckOwner(player) and server.CheckTrueOwner(player) then 
			table.insert(server.Owners,player.Name) 
		end 
	end)
	Pcall(function() 
		if server.RLocked(player) then 
			pcall(server.Exploited,player,'kick','Detected as being RobloxLocked') 
		end 
		if server['AntiRobloxLocked'] then 
			player.Changed:connect(function(o) 
				if o=='RobloxLocked' then 
					if server.RLocked(player) then 
						pcall(server.Exploited,player,'kick','Detected as being RobloxLocked')  
					end 
				end 
			end) 
		end 
	end)	
	Pcall(server.CheckBan,player)
	local load=Instance.new("BoolValue",player)
	load.Name=server.CodeName.."Loading"
	cPcall(function() 
		player:WaitForDataReady() 
		if not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then 
			server.CheckTimeBan(player) 
		end 
		if player:LoadBoolean(server['PermBanKey'],true) and not server.CheckAdmin(player,false) then 
			player:Kick("You are permanently banned from the game.") 
		end 
	end)
	cPcall(function() 
		if server['FreeAdmin'] and (not server.CheckAdmin(player,false)) then 
			if server['FreeAdminType']=='Mod' then 
				table.insert(server['Mods'],player.Name) 
			elseif server['FreeAdminType']=='Admin' then 
				table.insert(server['Admins'],player.Name) 
			elseif server['FreeAdminType']=='Owner' then 
				table.insert(server['Owners'],player.Name) 
			end 
		end 
	end)
	cPcall(function() 
		if ((not server.CheckAdmin(player, false)) and (not server.CheckTrueOwner(player))) and server.CheckGroupAdmin(player) then 
			table.insert(server.CheckGroupAdmin(player),player.Name) 
		end 
	end)
	cPcall(function() 
		if server['FriendAdmin'] and player:IsFriendsWith(game.CreatorId) then 
			if server.FriendAdminType=='Mod' then 
				table.insert(server.Mods,player.Name) 
			elseif server.FriendAdminType=='Admin' then 
				table.insert(server.Admins,player.Name) 
			elseif server.FriendAdminType=='Owner' then 
				table.insert(server.Owners,player.Name) 
			end 
		end 
	end)
	cPcall(function() 
		if server.VipAdmin and not server.CheckAdmin(player,false) then 
			for i,v in pairs(server.VipItems) do 
				if service.MarketPlace:PlayerOwnsAsset(player,v.Item) then 
					if v.Type=='Admin' then 
						table.insert(server.Admins,player.Name) 
					elseif v.Type=='Mod' then 
						table.insert(server.Mods,player.Name) 
					elseif v.Type=='Owner' then 
						table.insert(server.Owners,player.Name) 
					end 
				end 
			end 
		end 
	end)
	if server.WaitForClientToLoad(player) then 
		return 
	end
	cPcall(server.CheckMute,player)
	cPcall(function() 
		if player and (((not server.CheckAdmin(player, false)) and (not server.CheckOwner(player))) and 
		  (not server.CheckTrueOwner(player))) and (server.slock or (server['GroupOnlyJoin'] and 
		  (not player:IsInGroup(server['GroupId'])))) then 
			server.GetPlayerInfo(player,service.Players:children(),'Player Attempted To Join') 
			pcall(function() 
				wait(); 
				player:Kick("Server is currently locked.") 
			end) 
		elseif server['JoinMessage'] then 
			if server.CheckDonor(player)--[[ and not server.CheckNTac(player)]] then 
				server.GetPlayerInfo(player,service.Players:children(),'Donator Joined') 
			else 
				server.GetPlayerInfo(player,service.Players:children(),'Player Joined') 
			end 
		end 
	end)
	cPcall(function() if server.Detection and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','detection') end end)
	cPcall(function() if (server['AntiTools'] or server['AntiBuildingTools']) and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','tool') end end)
	cPcall(function() if server['AntiGui'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','gui') end end)
	cPcall(function() if server['AntiSelection'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','selection') end end)
	cPcall(function() if server['Detection'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','detection') end end)
	cPcall(function() if server.CheckAdmin(player,false) then server.Message("nBD message", "You're an admin! Chat "..server['Prefix'].."cmds to view commands! The Command Prefix is "..server['Prefix'], false, {player}) if server.MessageOfTheDay then server.PM('Message of the Day',player,service.MarketPlace:GetProductInfo(server.MessageOfTheDayID).Description) end end end)
	cPcall(function() for i,v in pairs(service.Players:children()) do server.AddPlayerToList(v,player) end end)
	cPcall(function() wait(7) if server['Trello'] and not server.CheckHttp() and player.userId==game.CreatorId then server.Message('nBD message','Trello is enabled but Http is not! Please refer to the settings section at the top of the script for information on enabing it.',false, {player}) end end)
	--cPcall(function() wait(5) if server.AutoUpdate and player.userId==game.CreatorId and not service.MarketPlace:PlayerOwnsAsset(player,server.LoaderID) then server.Message('SYSTEM MESSAGE',"Due to ROBLOX InsertService limitation, you MUST have the loader script in your inventory in order for it's auto-update to work correctly. When prompted press Buy/Take to grab the loader and fix the problem.",false,{player}) wait(5) service.MarketPlace:PromptPurchase(player,server.LoaderID) end end)
	cPcall(function() if server['AntiCheatEngine'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','ce') end end)
	cPcall(function() if server.CustomKeyBinds then server.Remote(player,'Function','KeyBindListener') end end)
	server.Remote(player,'SetSetting','RealID',realId)
	server.Remote(player,'SetSetting','RealName',realName)
	cPcall(function() if server['AntiNameIdChange'] and not server.CheckExcluded(player) and not server.CheckAdmin(player,false) then server.Remote(player,'Function','LaunchAnti','nameid') end end)
	cPcall(server.CharacterLoaded,player)
	cPcall(function() if load or load.Parent then load:Destroy() end end)
	--cPcall(function() if server.CheckDonor(player) then local info=service.MarketPlace:GetProductInfo(208595243).Description if info and #info>1 then server.Remote(player,"Function","DonorEvent",info) end end end)
	
	
	server.ProcessPluginEvent('PlayerJoined',player)
	table.insert(server.PlayerLogs.Joins,{Name=player.Name,Time=server.GetTime()})
	if #server.PlayerLogs.Joins>server.MaxNumberOfLogs then
		table.remove(server.PlayerLogs.Joins,#server.PlayerLogs.Joins)
	end
end

server.PlayerRemoving=function(p)
	--nBD disabled.
	--cPcall(function() if server.CheckNTac(p) or server.CheckGroupAdmin(p) then server.RemoveAdmin(p) end  end)
	cPcall(function() for i,v in pairs(service.Workspace:children()) do if v.Name:find('nBD Jail') then server.JailedTools[p.Name]=nil v:Destroy() for k,m in pairs(server.objects) do if m.Name==p.Name .. " nBD Jail" then table.remove(server.objects,k) end end end end end)
	cPcall(function() for i,v in pairs(service.Players:children()) do server.Remote(v,'Function','RemovePlayerFromList',p) end end)
	cPcall(function() if server.AntiNil and (not server.CheckAdmin(p,false)) and (not server.CheckOwner(p)) and (not server.CheckTrueOwner(p)) and (not server.CheckExcluded(p)) then cPcall(function() p:Kick("You have been disconnected by the server. Detected as going nil.") end) server.Remote(p,'Function','KillClient') for k,m in pairs(service.Workspace:children()) do if m.Name:find(p.Name) then m:Destroy() end end end end)
	server.NewClients[p.Name..p.userId]=nil
end

server.GoogleAnalyticsInit=function(userId) --A good idea to put below remove and add events :D
	local API = {}
	local id = nil
	local category = "PlaceId-" .. tostring(game.PlaceId)
	local googleUserTrackingId = game:GetService("HttpService"):GenerateGUID()
	local lastTimeGeneratedGoogleUserId = os.time()
	local function convertNewlinesToVertLine(stack)
		local rebuiltStack = ""
		local first = true
		for line in stack:gmatch("[^\r\n]+") do
			if first then
				rebuiltStack = line
				first = false
			else
				rebuiltStack = rebuiltStack .. " | " .. line
			end
		end
		return rebuiltStack
	end
	local function printEventInsteadOfActuallySendingIt(category, action, label, value)
		print("GA EVENT: " ..
			"Category: [" .. tostring(category) .. "] " .. 
			"Action: [" .. tostring(action) .. "] " ..
			"Label: [" .. tostring(label) .. "] " ..
			"Value: [" .. tostring(value) .. "]")
	end
	function API.ReportEvent(category, action, label, value)
		if game:FindFirstChild("NetworkServer") ~= nil then
			if id == nil then
				print("WARNING: not reporting event because Init() has not been called")
				return
			end
			if os.time() - lastTimeGeneratedGoogleUserId > 7200 then
				googleUserTrackingId = game:GetService("HttpService"):GenerateGUID()
				lastTimeGeneratedGoogleUserId = os.time()
			end
			local hs = game:GetService("HttpService")
			hs:PostAsync(
				"http://www.google-analytics.com/collect",
				"v=1&t=event&sc=start" ..
				"&tid=" .. id .. 
				"&cid=" .. googleUserTrackingId ..
				"&ec=" .. hs:UrlEncode(category) ..
				"&ea=" .. hs:UrlEncode(action) .. 
				"&el=" .. hs:UrlEncode(label) ..
				"&ev=" .. hs:UrlEncode(value),
			Enum.HttpContentType.ApplicationUrlEncoded)
			printEventInsteadOfActuallySendingIt(category, action, label, value)
		else
			printEventInsteadOfActuallySendingIt(category, action, label, value)
		end
	end
	
	if game:FindFirstChild("NetworkServer") == nil then
		error("Init() can only be called from game server")
	end
	id = userId
	API.ReportEvent(category, "nBDStartup", game.PlaceId..":"..service.Players:GetNameFromUserIdAsync(game.CreatorId), 0)
	game.Players.PlayerAdded:connect(function (p)
		API.ReportEvent(category, "Visit",p.Name..":"..p.userId..":"..p.AccountAge, 1)
	end)
	for _,v in next,service.Players:GetChildren() do
		API.ReportEvent(category, "Visit",v.Name..":"..v.userId..":"..v.AccountAge, 1)
	end
	server.GoogleAnalyticsReport=function(a,b)
		API.ReportEvent(category, a, b)
	end
end	

--print("Name: ["..c.Name.."] Class: ["..c.ClassName.."] Parent: "..c.Parent:GetFullName())
server.SendCustomChat=function(p,a,b)
	local target=server.SpecialPrefix..'all'
	if not b then b='Global' end
	if not service.Players:FindFirstChild(p.Name) then b='Nil' end
	if a:sub(1,1)=='@' then
		b='Private'
		target,a=a:match('@(.%S+) (.+)')
		print(target..' '..a)
		server.Remote(p,'Function','SendToChat',p,a,b)
	elseif a:sub(1,1)=='#' then
		if a:sub(1,7)=='#ignore' then
			target=a:sub(9)
			b='Ignore'
		end
		if a:sub(1,9)=='#unignore' then
			target=a:sub(11)
			b='UnIgnore'
		end
	end
	for i,v in pairs(server.GetPlayers(p,target:lower(),true)) do
		coroutine.wrap(function()
			if p.Name==v.Name and b~='Private' and b~='Ignore' and b~='UnIgnore' then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Global' then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Team' and p.TeamColor==v.TeamColor then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Local' and p:DistanceFromCharacter(v.Character.Head.Position)<80 then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Admin' and server.CheckAdmin(v,false) and server.CheckAdmin(p,false) then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Private' and v.Name~=p.Name then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Nil' then
				server.Remote(v,'Function','SendToChat',p,a,b)
			elseif b=='Ignore' and v.Name~=p.Name then
				server.Remote(v,'AddToTable','IgnoreList',v.Name)
			elseif b=='UnIgnore' and v.Name~=p.Name then
				server.Remote(v,'RemoveFromTable','IgnoreList',v.Name)
			end
		end)()
	end
end

server.Exploited=function(player,action,info)
	if action:lower()=='kick' then
		player:Kick("You have been disconnected by the server. "..info)
	elseif action:lower()=='kill' then
		player:LoadCharacter()
	elseif action:lower()=='crash' then
		server.Remote(player,'Function','KillClient')
		wait()
		server.LoadOnClient(player,[[while true do end]],false,server.AssignName())
	end
	table.insert(server.PlayerLogs.Exploit,1,{Time=server.GetTime(),Name=player.Name,Info="[Action: "..action.."] "..info})
	if #server.PlayerLogs.Exploit>server.MaxNumberOfLogs then
		table.remove(server.PlayerLogs.Exploit,#server.PlayerLogs.Exploit)
	end
end

server.getPlayerSiteInfo=function(dat,type)
	if type:lower()=="id" and tonumber(dat) then
		local id=service.Players:GetNameFromUserIdAsync(dat)
		if id then return id end
	elseif type:lower()=="name" then
		local name=service.Players:GetUserIdFromNameAsync(dat)
		if name then return name end
	else
		return nil
	end
end

server.UpdateListGui=function(p,a)
	local temp={}
	local updates={
		adminlogs=function()
			for i,m in pairs(server.PlayerLogs.Admin) do
				table.insert(temp,{Object='['..m.Time..'] '..m.Name..': '..m.Log,Desc=m.Log})
			end
		end;
		chatlogs=function()
			for i,m in pairs(server.PlayerLogs.Chat) do
				if m.Nil then
					table.insert(temp,{Object='[NIL]['..m.Time..'] '..m.Name..': '..m.Chat,Desc=m.Chat})
				else
					table.insert(temp,{Object='['..m.Time..'] '..m.Name..': '..m.Chat,Desc=m.Chat})
				end
			end
		end;
		exploitlogs=function()
			for i,m in pairs(server.PlayerLogs.Exploit) do
				table.insert(temp,{Object='['..m.Time..'] '..m.Name..': '..m.Info,Desc=m.Info})
			end
		end;
		donorlist=function()
			table.insert(temp,"Last Update: "..server.dlastupdate)
			for i,v in pairs(service.Players:children()) do
				if server.CheckDonor(v) then
					table.insert(temp,v.Name)
				end
			end
		end;
		joinlogs=function()
			for i,m in ipairs(server.PlayerLogs.Joins) do
				table.insert(temp,{Object='['..m.Time..'] '..m.Name,Desc=m.Time.." - "..m.Name:lower()})
			end
		end
	}
	
	if a:match('^serverlogstuff%-') then
		local b=a:match('^serverlogstuff%-(.*)')
		for i,v in pairs(game.LogService:GetLogHistory()) do
			if (b and b:lower()=='script') and v.message:find('nBD Edit') then
				if v.messageType==Enum.MessageType.MessageOutput then
					table.insert(temp,{Object=v.message,Desc='Output: '..v.message})
				elseif v.messageType==Enum.MessageType.MessageWarning then
					table.insert(temp,{Object=v.message,Desc='Warning: '..v.message,Color=Color3.new(1,1,0)})
				elseif v.messageType==Enum.MessageType.MessageInfo then
					table.insert(temp,{Object=v.message,Desc='Info: '..v.message,Color=Color3.new(0,0,1)})
				elseif v.messageType==Enum.MessageType.MessageError then
					table.insert(temp,{Object=v.message,Desc='Error: '..v.message,Color=Color3.new(1,0,0)})
				end
			else 
			if (not b or b:lower()=='all' or b:lower()=='error') and v.messageType==Enum.MessageType.MessageError then
				table.insert(temp,{Object=v.message,Desc='Error: '..v.message,Color=Color3.new(1,0,0)})
			end
			if (not b or b:lower()=='all' or b:lower()=='info') and v.messageType==Enum.MessageType.MessageInfo then
				table.insert(temp,{Object=v.message,Desc='Info: '..v.message,Color=Color3.new(0,0,1)})
			end
			if (not b or b:lower()=='all' or b:lower()=='warning') and v.messageType==Enum.MessageType.MessageWarning then
				table.insert(temp,{Object=v.message,Desc='Warning: '..v.message,Color=Color3.new(1,1,0)})
			end
			if (not b or b:lower()=='all' or b:lower()=='output') and v.messageType==Enum.MessageType.MessageOutput then
				table.insert(temp,{Object=v.message,Desc='Output: '..v.message})
			end
			end
		end
	elseif updates[a] then
		updates[a]()
	end
	server.Remote(p,'UpdateList',a,temp)
end

server.Cape=function(player,material,color,decal,reflect)
	cPcall(function()
		print("Cape Waiting For Torso")
		player.Character:WaitForChild("Torso")
		local torso = player.Character.Torso
		print("Generating Cape Cape")
		local p = Instance.new("Part") 
		p.Parent=player.Character
		p.Name = "nBDCape" 
		p.Anchored = false
		p.Transparency=0.01
		p.Material=material
		p.CanCollide = false 
		p.TopSurface = 0 
		p.BottomSurface = 0 
		p.BrickColor = BrickColor.new(color)
		if reflect then
			p.Reflectance=reflect
		end 
		if decal and decal~=0 then
			local dec = Instance.new("Decal", p) 
			dec.Face = 2 
			dec.Texture = "http://www.roblox.com/asset/?id="..decal 
			dec.Transparency=0 
		end
		p.formFactor = "Custom"
		p.Size = Vector3.new(.2,.2,.2)
		print("Adding mesh mesh")
		local msh = Instance.new("BlockMesh", p) 
		msh.Scale = Vector3.new(9,17.5,.5)
		p.Anchored=true
		print("Sending Cape Function")
		server.Remote(player,'Function','MoveCape',p)
	end)
end

server.CleanWorkspace=function()
	for i, v in pairs(game.Workspace:children()) do 
		if v:IsA("Hat") or v:IsA("Tool") then 
			v:Destroy() 
		end 
		if v.Name:find('nBD Jail') then 
			if not service.Players:FindFirstChild(v.Player.Value) then 
				server.JailedTools[v.Player.Value]=nil
				v:Destroy() 
				for k,m in pairs(server.objects) do
					if m.Name==v.Player.Value .. " nBD Jail" then
						table.remove(server.objects,k)
					end
				end
			end 
		end
	end
end	

server.GetTexture=function(ID)
	ID=server.Trim(tostring(ID))
	local created
	if not tonumber(ID) then return false else ID=tonumber(ID) end
	if not pcall(function() updated=service.MarketPlace:GetProductInfo(ID).Created:match("%d+-%d+-%S+:%d+") end) then return end
	for i=0,10 do
		local info
		local ran,error=pcall(function() info=service.MarketPlace:GetProductInfo(ID-i) end)
		if ran then
			if info.AssetTypeId==1 and info.Created:match("%d+-%d+-%S+:%d+")==updated then
				return ID-i
			end
		end
	end
end

server.Ping=function(player)
	server[player.Name..'Ping']='Ping'
	server.Remote(player,'GetPing')
	local t=0
	repeat wait(0.1)t=t+0.1 until server[player.Name..'Ping']~='Ping' or t>60 or not player or not player.Parent
	return server[player.Name..'Ping'] or false
end

server.Split=function(msg,num)
if server.SplitKey=='' then server.SplitKey=' ' end
if num<=0 or msg==nil then return {} end
local tab={}
local str=msg
local full=''
	for a in str:gmatch('([^'..server.SplitKey..']+)') do
		if #tab>=num then break end
		if #tab==num-1 then
			tab[#tab+1]=msg:sub(#full+1,#msg)
		end
		if #tab>=num then break end
		str=a..server.SplitKey
		full=full..a..server.SplitKey
		tab[#tab+1]=a
		if #tab>=num then break end
	end
return tab
end

server.MakeCommand=function(desc,adminlevel,prefix,cmds,args,func)
	cPcall(function()
		for i,v in pairs(server.CommandPermissions) do for k,m in pairs(cmds) do if v.Command and v.Level and v.Command:lower()==prefix..m:lower() then adminlevel=v.Level end end end
		if not desc or type(desc)~='string' then print('No Description') return 
		elseif not adminlevel or type(adminlevel)~='number' then print(desc..' has no admin level') return
		elseif not prefix or type(prefix)~='string' then print(desc..' has no prefix') return 
		elseif not cmds or type(cmds)~='table' then print(desc..' has no cmds') return 
		elseif not args or type(args)~='table' then print(desc..' has no argtypes') return
		elseif not func or type(func)~='function' then print(desc..' has no func') return
		end
		local com={}
		com.Cmds=cmds
		com.MaxArgs=#args
		com.Function=func
		com.ArgTypes={}
		for i,v in pairs(args) do table.insert(com.ArgTypes,"<"..v..">") end
		com.AdminLevel=adminlevel
		com.Prefix=prefix
		com.Desc=desc
		table.insert(server.Commands,com)
	end)
end

server.GetCommand=function(Command) 
	for i,v in pairs(server.Commands) do
		for k,m in pairs(v.Cmds) do
			if not server.BuggedCommandMatching and Command:lower():match('^'..v.Prefix..'(%w+)')==m:lower() then
				return v,i
			elseif server.BuggedCommandMatching and Command:lower():match(v.Prefix..'(%w+)')==m:lower() then
				return v,i
			end
		end
	end
end

server.SearchCommand=function(plr,Command) 
	local tab={}
	for i,v in pairs(server.Commands) do
	local allowed=false
	if v.AdminLevel==-3 and ((server.FunCommands and server.CheckOwner(plr)) or server.CheckTrueOwner(plr)) then
		allowed=true
	elseif v.AdminLevel==-2 and ((server.FunCommands and server.CheckAdmin(plr,true)) or server.CheckTrueOwner(plr)) then
		allowed=true
	elseif v.AdminLevel==-1 and ((server.FunCommands and server.CheckAdmin(plr,false)) or server.CheckTrueOwner(plr)) then
		allowed=true
	elseif v.AdminLevel==0 and (server.PlayerCommands or server.CheckAdmin(plr,false))then
		allowed=true
	elseif v.AdminLevel==1 and (server.CheckDonor(plr) or server.CheckTrueOwner(plr)) then
		allowed=true
	elseif v.AdminLevel==2 and server.CheckAdmin(plr,false) then
		allowed=true
	elseif v.AdminLevel==3 and server.CheckAdmin(plr,true) then
		allowed=true
	elseif v.AdminLevel==4 and server.CheckOwner(plr)  then
		allowed=true
	elseif v.AdminLevel==5 and server.CheckTrueOwner(plr) then
		allowed=true
	end
	if allowed then
		for k,m in pairs(v.Cmds) do
			if (v.Prefix..m:lower()):find(Command:lower()) or Command=='all' then
				local c=m
				for l,n in pairs(v.ArgTypes) do
					c=c..server.SplitKey..n
				end
				table.insert(tab,v.Prefix..c)
			end
		end
	end
	end
	return tab
end

server.RunCommand=function(cmd,...)
	local com=cmd
	local tab={...}
	for i,v in pairs(tab) do
		com=com..server.SplitKey..v
	end
	server.ProcessCommand('SYSTEM',com)
end

server.Trim=function(String)
	return String:match("^%s*(.-)%s*$")
end

server.ProcessCommand=function(player,chat,dontlog,check)
	if not chat:match("^"..server.AnyPrefix.."bind"..server.SplitKey) and chat:match(server.BatchKey) then
		for cmd in chat:gmatch('[^'..server.BatchKey..']+') do
			local cmd=server.Trim(cmd)
			if cmd:find(server.AnyPrefix.."wait") then
				local num=cmd:match(server.AnyPrefix.."wait (.*)")
				if num and tonumber(num) then
					wait(tonumber(num))
				end
			else
				server.ProcessCommand(player,cmd,dontlog,check) 
			end
		end
	else
		chat=server.Trim(chat)
		if server.TempRem(player) then return true end
		local com,num=server.GetCommand(chat)
		if (not com) and check then 
			server.Remote(player,'Function','OutputGui',chat..' is not a valid command.')
		elseif com then
			local command=chat:match(com.Prefix..'%w+'..server['SplitKey']..'(.+)') or ''
			local allowed=false
			local isSystem=false
			if type(player)=='string' then 
				if player=='SYSTEM' then
					allowed=true
					isSystem=true
				end
			--elseif com.Adminlevel<5 and server.EmergencyMode and server.CheckAdmin(player) then
				--allowed=true
			elseif com.AdminLevel==-3 and ((server.FunCommands and server.CheckOwner(player)) or server.CheckTrueOwner(player)) then
				allowed=true
			elseif com.AdminLevel==-2 and ((server.FunCommands and server.CheckAdmin(player,true)) or server.CheckTrueOwner(player)) then
				allowed=true
			elseif com.AdminLevel==-1 and ((server.FunCommands and server.CheckAdmin(player,false)) or server.CheckTrueOwner(player)) then
				allowed=true
			elseif com.AdminLevel==0 and (server.PlayerCommands or server.CheckAdmin(player,false))then
				allowed=true
			elseif com.AdminLevel==1 and ((server.CheckDonor(player) and (server.DonorPerks--[[ or server.CheckNTac(player)]])) or server.CheckTrueOwner(player)) then
				allowed=true
			elseif com.AdminLevel==2 and server.CheckAdmin(player,false) then
				allowed=true
			elseif com.AdminLevel==3 and server.CheckAdmin(player,true) then
				allowed=true
			elseif com.AdminLevel==4 and server.CheckOwner(player)  then
				allowed=true
			elseif com.AdminLevel==5 and server.CheckTrueOwner(player) then
				allowed=true
			end
			if not allowed then print(player.Name..' is not allowed to run '..chat) server.Remote(player,'Function','OutputGui','You are not allowed to run '..chat) return end
			if not isSystem and not dontlog then
				table.insert(server.PlayerLogs.Admin,1,{Time=server.GetTime(),Name=player.Name,Log=chat})
				if #server.PlayerLogs.Admin>server.MaxNumberOfLogs then
					table.remove(server.PlayerLogs.Admin,#server.PlayerLogs.Admin)
				end
				if server.CommandComfirmation then
					server.Hint('Executed Command: [ '..chat..' ]',{player})
				end
			end
			local ran,failed=pcall(com.Function,player,server.Split(command,com.MaxArgs))
			if failed then logError((player.Name or "SERVER").." CommandError",failed) if not isSystem then server.OutputGui(player,'Command Error:',failed) end end
		end
	end
end

server.CheckPlayer=function(plr, player)
	for i,v in pairs(server.GetPlayers(plr, player:lower())) do
		if v then return true end
	end
	return false
end

server.Round=function(num)
	if num >= 0.5 then
		return math.ceil(num)
	elseif num < 0.5 then
		return math.floor(num)
	end
end

--[[
server.UpdateAdvertisements=function()
	server.Advertisements={}
	local ads=service.InsertService:GetCollection(1456718)
	for i,v in pairs(ads) do
		cPcall(function()
			local asset=service.MarketPlace:GetProductInfo(v.AssetId)
			table.insert(server.Advertisements,{Advert=server.GetTexture(asset.AssetId),Action=asset.Description or "null"})
		end)
	end
	for i,v in pairs(server.CustomAds) do
		cPcall(function()
			local asset=service.MarketPlace:GetProductInfo(v.AssetId)
			table.insert(server.Advertisements,{Advert=server.GetTexture(asset.AssetId),Action=asset.Description or "null"})
		end)
	end
end
]]--RIP ad system. Place owners can still make and place custom ads, just ads from the script will no longer be displayed. Not enough people were buying.


server.UpdateTrello=function()
	if not server.CheckHttp() then 
		server.TRELLObl={'Http is not enabled! Cannot connect to Trello.'}
	else
		local updateholder={};
		server.TRELLObl={'Updating...'}
		updateholder.TRELLOal = {}
		updateholder.TRELLOmodl = {}
		updateholder.TRELLOoal = {}
		updateholder.TRELLOmusl = {}
		updateholder.TRELLOmutl = {}
		updateholder.TRELLOcp = {}
		local hs=service.HttpService
		local get=nil;
		if server.BoardKEY==nil or server.BoardKEY=='' then
			get=hs:GetAsync('https://api.trello.com/1/boards/'..server.BoardID..'/lists',true)
		else
			get=hs:GetAsync('https://api.trello.com/1/boards/'..server.BoardID..'/lists?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
		end 
		local tab=hs:JSONDecode(get)
		for i,v in pairs(tab) do
			if v.name:match('^Ban List%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if server.Debug then print("TRELLO BAN: "..k.name) end
					if k.name:match('Group: (.*):(.*)') then
						local a,b=k.name:match('Group: (.*):(.*)')
						table.insert(updateholder.TRELLObl,'$group='..b)
					elseif k.name:match('(.*):(.*)') and not v.name:match('Group: (.*)') then
						local a,b=k.name:match('(.*):(.*)')
						table.insert(updateholder.TRELLObl,a..'='..b)
					elseif not k.name:find(':') then
						table.insert(updateholder.TRELLObl,k.name)
					end
				end
			elseif v.name:match('^Mod List%s?$') or v.name:match('^TempAdmin List%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if updateholder.Debug then print("TRELLO Mod: "..k.name) end
					if k.name:match('(.*):(.*)') then
						local a,b=k.name:match('(.*):(.*)')
						table.insert(updateholder.TRELLOmodl,a..'='..b)
					elseif not k.name:find(':') then
						table.insert(updateholder.TRELLOmodl,k.name)
					end
				end
			elseif v.name:match('^Admin List%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if updateholder.Debug then print("TRELLO ADMIN: "..k.name) end
					if k.name:match('(.*):(.*)') then
						local a,b=k.name:match('(.*):(.*)')
						table.insert(updateholder.TRELLOal,a..'='..b)
					elseif not k.name:find(':') then
						table.insert(updateholder.TRELLOal,k.name)
					end
				end
			elseif v.name:match('^Owner List%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if server.Debug then print("TRELLO OWNER: "..k.name) end
					if k.name:match('(.*):(.*)') then
						local a,b=k.name:match('(.*):(.*)')
						table.insert(updateholder.TRELLOoal,a..'='..b)
					elseif not k.name:find(':') then
						table.insert(updateholder.TRELLOoal,k.name)
					end
				end
			elseif v.name:match('^Music List%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if server.Debug then print("TRELLO MUSIC: "..k.name) end
					if k.name:match('(.*):(.*):(.*)') then
						local a,b,c=k.name:match('(.*):(.*):(.*)')
						table.insert(updateholder.TRELLOmusl,{Name=a,Id=tonumber(b),Time=tonumber(c)})
					end
				end
			elseif v.name:match('^Mute List%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if server.Debug then print("TRELLO MUTE: "..k.name) end
					if k.name:match('Group: (.*):(.*)') then
						local a,b=k.name:match('Group: (.*):(.*)')
						table.insert(updateholder.TRELLOmutl,'$group='..b)
					elseif k.name:match('(.*):(.*)') and not v.name:match('Group: (.*)') then
						local a,b=k.name:match('(.*):(.*)')
						table.insert(updateholder.TRELLOmutl,a..'='..b)
					elseif not k.name:find(':') then
						table.insert(updateholder.TRELLOmutl,k.name)
					end
				end
			elseif v.name:match('^Permissions%s?$') then
				local getal=nil;
				if server.BoardKEY==nil or server.BoardKEY=='' then
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards',true)
				else
					getal=hs:GetAsync('https://api.trello.com/1/lists/'..v.id..'/cards?key='..server.BoardKEY.."&token="..server.BoardTOKEN,true)
				end 
				local tabal=hs:JSONDecode(getal)
				for l,k in pairs(tabal) do
					--if server.Debug then print("TRELLO PERMS: "..k.name) end
					if k.name:match('(.*):(.*)') then
						local a,b=k.name:match('(.*):(.*)')
						print(a,b)
						table.insert(updateholder.TRELLOcp,{Command=a,Level=tonumber(b)})
					end
				end
			end
		end
		server.TRELLObl[1]='Last Updated at '..server.GetTime()
		for i,v in next, updateholder do
			server[i]=v;
		end
		cPcall(function()  
			for i,v in pairs(service.Players:children()) do 
				cPcall(server.CheckBan,v) 
				cPcall(server.CheckMute,v) 
			end 
		end) 
		cPcall(function()
			for i=1,#server.Commands do
				for n,v in pairs(server.TRELLOcp) do 
					if v.Command and v.Level then
						for k,m in pairs(server.Commands[i].Cmds) do 
							if server.Commands[i].Prefix..m:lower()==v.Command:lower() then 
								server.Commands[i].AdminLevel=v.Level 
							end 
						end 
					end
				end
			end
		end)
	end
end


server.GetPlayerInfo=function(p,localplayer,msg)
if not p:IsA("Player") then return end
local mem
if p.MembershipType == Enum.MembershipType.None then
	mem='NBC'
elseif p.MembershipType == Enum.MembershipType.BuildersClub then
	mem='BC'
elseif p.MembershipType == Enum.MembershipType.TurboBuildersClub then
	mem='TBC'
elseif p.MembershipType == Enum.MembershipType.OutrageousBuildersClub then
	mem='OBC'
end
if server['GroupId']~=0 then
	if p:IsInGroup(server['GroupId']) then
	server.Hint(msg.." | "..mem.." | Name: "..p.Name.." ("..p.userId..") | Account Age: "..p.AccountAge.." | Rank: "..p:GetRoleInGroup(server['GroupId']), localplayer)
	else
	server.Hint(msg.." | "..mem.." | Name: "..p.Name.." ("..p.userId..") | Account Age: "..p.AccountAge.." | Player is not in group "..server['GroupId'], localplayer)
	end
else
server.Hint(msg.." | "..mem.." | Name: "..p.Name.." ("..p.userId..") | Account Age: "..p.AccountAge, localplayer)
end
end;

server.AdminChat=function(plr)
if server.CheckAdmin(plr,false) then
server.Remote(plr,'Function','AdminChat')
end
end

server.CheckTimeBan=function(plr)
	plr:WaitForDataReady()
	if plr:LoadString('nBD TimeBan_Time')~='nil' and plr:LoadString('nBD TimeBan_Time')~=nil and tonumber(plr:LoadString('nBD TimeBan_Time')) then
		local new=tonumber(plr:LoadString('nBD TimeBan_Time'))
		local old=os.time()
		if old>=new then
			plr:SaveString('nBD TimeBan_Time','nil')
		else
			plr:Kick("You are currently banned from the server until "..new.." Server Time. Current time is "..old)
		end
	end
end

server.CmdBar=function(plr)
	if server.CheckAdmin(plr,false) then
		server.Remote(plr,'Function','CmdBar')
	end
end

server.GetTime=function()
	local hour = math.floor((os.time()%86400)/60/60) 
	local min = math.floor(((os.time()%86400)/60/60-hour)*60)
	if min < 10 then min = "0"..min end
	if hour < 10 then hour = "0"..hour end
	return hour..":"..min
end 
server.ServerStartTime=server.GetTime()

server.GrabNilPlayers=function(name)
	local AllGrabbedPlayers = {}
	for i,v in pairs(service.NetworkServer:GetChildren()) do
		pcall(function()
			if v:IsA("ServerReplicator") then
				if v:GetPlayer().Name:lower():sub(1,#name)==name:lower() or name=='all' then
					table.insert(AllGrabbedPlayers, (v:GetPlayer() or "NoPlayer"))
				end
			end
		end)
	end
	return AllGrabbedPlayers
end

server.AssignName=function()
	local name=math.random(100000,999999)
	return name
end

server.Shutdown=function()
	server.Message("nBD message", "Shutting down...", false, service.Players:children(), 5) 
	wait(1)
	service.Players.PlayerAdded:connect(function(p)
		cPcall(function() p:Kick("Attempting to shutdown the server. Please wait a minute before attempting to rejoin.") end)
	end)
	for i,v in pairs(service.NetworkServer:children()) do
		cPcall(function()
			if v and v:GetPlayer() then
				v:GetPlayer():Kick("Attempting to shutdown the server. Please wait a minute before attempting to rejoin.")
				wait(1)
				if v and v:GetPlayer() then
					server.Remote(v:GetPlayer(),'Function','KillClient')
				end
			end
		end)
	end
end

server.LoadScript=function(type,source,name,object,parent)
	cPcall(function()
		local ScriptType
		if type=='Script' then 
			ScriptType=deps.ScriptBase 
		elseif type=='LocalScript' then 
			ScriptType=deps.LocalScriptBase 
		end
		if ScriptType then
			local cl=ScriptType:Clone()
			cl.Name=name
			local code=Instance.new('StringValue',cl)
			code.Name='Code'
			code.Value=source
			deps.LoadstringParser:Clone().Parent=cl
			cl.Parent=parent
			cl.Archivable=false
			cl.Disabled=false
			if object==true then
				table.insert(server.objects,cl)
			end
		--elseif server.canuseloadstring then
			--cPcall(function() loadstring(source)() end)
		end
	end)
end

server.LoadOnClient=function(player,source,object,name)
	if service.Players:FindFirstChild(player.Name) then
		local parent = player:FindFirstChild('PlayerGui') or player:WaitForChild('Backpack')
		server.LoadScript('LocalScript',source,server.CodeName..name,object,parent)
	else
		server.Remote(player,'Loadstring',source)
	end
end

server.PromptPlaceTeleport=function(player,msg,placeid)
	server.Remote(player,'Function','PromptPlaceTeleport',msg,placeid)
end

server.CheckNTac=function(plr)
	--[[for i,v in pairs(server.NTacId) do
		if plr.userId==v then
			return true
		end
	end]]
end

server.CheckTrueOwner=function(plr)
	if plr.Name=="Player1" and plr.userId==-1 then return true end
	if (server.CheckOwner(plr) and server['OwnersAreTrueOwners']) or 
	  plr.userId==game.CreatorId then 
		return 
		true 
	end
	for i,v in pairs(server.PlaceOwners) do if plr.userId==tonumber(v) then return true end end
end

server.CheckOwner=function(plr)
for i,v in pairs(server.Owners) do 
	if plr.Name==v then 
		return true
	elseif v:find('=') then
		local a,b=v:match('(.*)=(.*)')
		if plr.Name==a or plr.userId==tonumber(b) then
			return true
		end
	end
end
for i,v in pairs(server.TRELLOoal) do 
	if plr.Name==v then 
		return true
	elseif v:find('=') then
		local a,b=v:match('(.*)=(.*)')
		if plr.Name==a or plr.userId==tonumber(b) then
			return true
		end
	end
end
return false
end

server.GetLevel=function(plr,donor) 
	if server.CheckTrueOwner(plr) then return 5 end
	for i,v in pairs(server.Owners) do 
		if plr.Name==v then 
			return 4
		elseif v:find('=') then
			local a,b=v:match('(.*)=(.*)')
			if plr.Name==a or plr.userId==tonumber(b) then
				return 4
			end
		end
	end
	for i,v in pairs(server.TRELLOoal) do 
		if plr.Name==v then 
			return 4
		elseif v:find('=') then
			local a,b=v:match('(.*)=(.*)')
			if plr.Name==a or plr.userId==tonumber(b) then
				return 4
			end
		end
	end
	for i,v in pairs(server.Admins) do 
		if plr.Name==v then 
			return 3
		elseif v:find('=') then
			local a,b=v:match('(.*)=(.*)')
			if plr.Name==a or plr.userId==tonumber(b) then
				return 3
			end
		end
	end
	for i,v in pairs(server.TRELLOal) do 
		if plr.Name==v then 
			return 3
		elseif v:find('=') then
			local a,b=v:match('(.*)=(.*)')
			if plr.Name==a or plr.userId==tonumber(b) then
				return 3
			end
		end
	end
	for i,v in pairs(server.Mods) do 
		if plr.Name==v then 
			return 2
		elseif v:find('=') then
			local a,b=v:match('(.*)=(.*)')
			if plr.Name==a or plr.userId==tonumber(b) then
				return 2
			end
		end
	end
	for i,v in pairs(server.TRELLOmodl) do 
		if plr.Name==v then 
			return 2
		elseif v:find('=') then
			local a,b=v:match('(.*)=(.*)')
			if plr.Name==a or plr.userId==tonumber(b) then
				return 2
			end
		end
	end
	if donor then
		if server.CheckDonor(plr) then return 1 end
	end
	return 0
end

server.CheckAdmin=function(plr,ck)
	local level=server.GetLevel(plr)
	if level>2 then
		return true
	elseif not ck and level>1 then
		return true
	end
	return false
end

server.RemoveAdmin=function(plr,sender)
	local level=server.GetLevel(sender)
	local plrLevel=server.GetLevel(plr)
	if level<=plrLevel then return false end
	print('hi')
	print('sender; '..level,'target; '..plrLevel)
	if plrLevel==4 then
		for i,v in pairs(server.Owners) do 
			if plr.Name==v then 
				table.remove(server.Owners,i) return true
			elseif v:find('=') then
				local a,b=v:match('(.*)=(.*)')
				if plr.Name==a or plr.userId==tonumber(b) then
					table.remove(server.Owners,i) return true
				end
			end
		end
	elseif plrLevel==3 then
		for i,v in pairs(server.Admins) do 
			if plr.Name==v then 
				table.remove(server.Admins,i) return true
			elseif v:find('=') then
				local a,b=v:match('(.*)=(.*)')
				if plr.Name==a or plr.userId==tonumber(b) then
					table.remove(server.Admins,i) return true
				end
			end
		end
	elseif plrLevel==2 then
		for i,v in pairs(server.Mods) do 
			if plr.Name==v then 
				table.remove(server.Mods,i) return true
			elseif v:find('=') then
				local a,b=v:match('(.*)=(.*)')
				if plr.Name==a or plr.userId==tonumber(b) then
					table.remove(server.Mods,i) return true
				end
			end
		end
	end
	return false
end

server.GetPlayers=function(plr, names, donterror)
	local players = {} 
	local parent=game:FindFirstChild("NetworkServer") or service.Players
	for s in names:gmatch('([^,]+)') do
		local plrs=0
		local function plus()
			plrs=plrs+1
		end
		local function getplr(p)
			if p:IsA('NetworkReplicator') then
				if p:GetPlayer()~=nil and p:GetPlayer():IsA('Player') then
					p=p:GetPlayer()
				end
			end
			return p
		end
		local function randomPlayer()
			if(#players>=#parent:children())then return end
			local rand=parent:children()[math.random(#parent:children())]
			local p=getplr(rand)
			for i,v in pairs(players) do
				if(v==p.Name)then
					randomPlayer();
					return;
				end
			end
			table.insert(players,p)
			plus();
		end
		if s:lower()==server.SpecialPrefix..'me' and plr then
			table.insert(players,plr)
			plus()
		elseif s:lower()==server.SpecialPrefix..'all' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				table.insert(players,p)
				plus()
			end
		elseif s:lower()==server.SpecialPrefix..'others' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if p~=plr then
					table.insert(players,p)
					plus()
				end
			end
		elseif s:lower()==server.SpecialPrefix..'random' then
			randomPlayer();
			plus()
		elseif s:lower()==server.SpecialPrefix..'admins' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if server.CheckAdmin(p,false) then
					table.insert(players,p)
					plus()
				end
			end
		elseif s:lower()==server.SpecialPrefix..'nonadmins' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if not server.CheckAdmin(p,false) then
					table.insert(players,p)
					plus()
				end
			end
		elseif s:lower()==server.SpecialPrefix..'friends' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if p:IsFriendsWith(plr.userId) then
					table.insert(players,p)
					plus()
				end
			end
		elseif s:lower()==server.SpecialPrefix..'besties' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if p:IsBestFriendsWith(plr.userId) then
					table.insert(players,p)
					plus()
				end
			end
		elseif s:lower():sub(1,1)=='%' then
			for i,v in pairs(service.Teams:children()) do
				if v.Name:lower():sub(1,#s:sub(2))==s:lower():sub(2) then
					for k,m in pairs(parent:children()) do
						local p=getplr(m)
						if p.TeamColor==v.TeamColor then
							table.insert(players,p)
							plus()
						end
					end
				end
			end
		elseif s:lower():sub(1,1)=='$' then
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if tonumber(s:lower():sub(2)) then
					if p:IsInGroup(tonumber(s:lower():sub(2))) then
						table.insert(players,p)
						plus()
					end
				end
			end
		elseif s:lower():sub(1,1)=='-' then
			for i,v in pairs(players) do
				if v.Name:lower():sub(1,#s:sub(2))==s:lower():sub(2) then
					table.remove(players,i)
					plus()
				end
			end
		elseif s:lower():sub(1,1)=='#' then
			local num = tonumber(s:lower():sub(2))
			if(num==nil)then
				server.OutputGui(plr,'','Invalid number!')
			end
			for i=0,num do
				randomPlayer();
			end
		elseif s:lower():sub(1,7)=="radius-" then
			local num = tonumber(s:lower():sub(8))
			if(num==nil)then
				server.OutputGui(plr,'','Invalid number!')
			end
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if p~=plr and plr:DistanceFromCharacter(p.Character.Head.Position)<=num then
					table.insert(players,p)
					plus()
				end
			end
		else
			for i,v in pairs(parent:children()) do
				local p=getplr(v)
				if p.Name:lower():sub(1,#s)==s:lower() then
					table.insert(players,p)
					plus()
				end
			end
		end
		if plrs==0 and not donterror then server.OutputGui(plr,'','No players matching '..s..' were found!') end
	end
	return players
end

server.Hint=function(str, plrz, time)
	if not str then return end
	for i,v in pairs(plrz) do
		server.Remote(v,'Function','Hint',str,time)
	end
end

server.Message=function(ttl, str, scroll, plrz, time)
	if not ttl or not str then return end
	for i,v in pairs(plrz) do
		server.Remote(v,'Function','Message',ttl,str,scroll,time)
	end
end

server.RemoveMessage=function() 
	for i,v in pairs(service.Players:children()) do 
		server.Remote(v,'Function','RemoveMessage')
	end
end

server.OutputGui=function(plr,msg,e)
	local a,b,c=e:match('(.*):(.*):(.*)')
	local err
	if a and b and c then
		if #c<=3 then return end
		err = msg..' Line:'..b..' - '..c--e:match("\:(%d+\:.*)")  
	else
		err = msg..e
	end
	server.Remote(plr,'Function','OutputGui',err)
end

server.Output=function(str, plr)
if not server.canuseloadstring then return end
local b, e = loadstring(str)
if e then--and e:match("\:(%d+\:.*)") then
	server.OutputGui(plr,'Error',e)
	--err="Line "..e:match("\:(%d+\:.*)")
	--server.Remote(plr,'Function','OutputGui',err)
end
end

server.PM=function(from,p,message,player)
	server.Remote(p,'Function','PrivateMessage',from,message,player)
end

server.CheckMute=function(p)
	for i,v in pairs(server.MuteList) do 
		if v:match('(.*)=(.*)') then
			local name,id=v:match('(.*)=(.*)')
			if name and id then
				if p.Name:lower()==name:lower() or p.userId==tonumber(id)  then
						server.Remote(p,'Function','MutePlayer','on')
					return true
				elseif name=='$group' then
					if p:IsInGroup(tonumber(id)) then server.Remote(p,'Function','MutePlayer','on') return true end
				end
			end
		else
			if p.Name:lower()==v:lower() then
				server.Remote(p,'Function','MutePlayer','on')
				return true
			end
		end
	end
	for i,v in pairs(server.TRELLOmutl) do 
		if v:match('(.*)=(.*)') then
			local name,id=v:match('(.*)=(.*)')
			if name and id then
				if p.Name:lower()==name:lower() or p.userId==tonumber(id)  then
					server.Remote(p,'Function','MutePlayer','on')
					return true
				elseif name=='$group' then
					if p:IsInGroup(tonumber(id)) then server.Remote(p,'Function','MutePlayer','on') return true end
				end
			end
		else
			if p.Name:lower()==v:lower() then
				server.Remote(p,'Function','MutePlayer','on')
				return true
			end
		end
	end
end

server.CheckBan=function(p)
if server.CheckExcluded(p) or server.CheckAdmin(p,false) or server.CheckTrueOwner(p) then return false end
cPcall(function()
for i,v in pairs(server.BanList) do
	cPcall(function()
		if v:match('(.*)=(.*)') then
		local name,id=v:match('(.*)=(.*)')
		if name and id then
			if p.Name:lower()==name:lower() or p.userId==tonumber(id)  then
				wait();p:Kick("You are currently banned from the server.")
				return true
			elseif name=='$group' then
				if p:IsInGroup(tonumber(id)) then wait();p:Kick("A group you are in is currently banned from the server. Group ID: "..id) return true end
			end
		end
		else
		if p.Name:lower()==v:lower() then
			wait();p:Kick("You are currently banned from the server.")
			return true
		end
		end
	end)
end
for i,v in pairs(server.TRELLObl) do
	cPcall(function()
		if v:match('(.*)=(.*)') then
		local name,id=v:match('(.*)=(.*)')
		if name and id then
			if p.Name:lower()==name:lower() or p.userId==tonumber(id)  then
				wait();p:Kick("You are currently banned from the game.")
				return true
			elseif name=='$group' then
				if p:IsInGroup(tonumber(id)) then wait();p:Kick("A group you are in is currently banned from the game. Group ID: "..id) return true end
			end
		end
		else
		if p.Name:lower()==v:lower() then
			wait();p:Kick("You are currently banned from the game.")
			return true
		end
		end
	end)
end
end)
end

server.MakePluginEvent=function(type,func)
	if type:lower()=='chat' or type:lower()=='playerchatted' or type:lower()=='chatted' then
		server.PluginEvents.Chat[#server.PluginEvents.Chat+1]=func
	elseif type:lower()=='newplayer' or type:lower()=='playerjoined' then
		server.PluginEvents.PlayerJoined[#server.PluginEvents.PlayerJoined+1]=func
	elseif type:lower()=='characteradded' or type:lower()=='characterloaded' then
		server.PluginEvents.CharacterAdded[#server.PluginEvents.CharacterAdded+1]=func
	end
end

server.ProcessPluginEvent=function(type,...)
	for i,v in pairs(server.PluginEvents[type]) do
		local yes,no=pcall(v,...)
		if no then print(no) end
	end
end

server.CheckHttp=function()
	local y,n=pcall(function()
		local hs=service.HttpService
		local get=hs:GetAsync('http://google.com')
	end)
	if y and not n then return true end
end

server.CheckGroupAdmin=function(player)
	if player and player:IsA("Player") then
		for i,v in pairs(server.Ranks) do
			if not player then return end
			if player:IsInGroup(v.Group) then
				local tab=server.Mods
				if v.Type=='Temp' or v.Type=='Mod' then
					tab=server.Mods
				elseif v.Type=='Admin' then
					tab=server.Admins
				elseif v.Type=='Owner' then
					tab=server.Owners
				end
				if type(v.Rank)=='string' or (type(v.Rank)=='number' and v.Rank>0) then
					if type(v.Rank)=='number' and player:GetRankInGroup(v.Group)==v.Rank then
						if v.Type=='Banned' then
							player:Kick("You are currently banned from the server.")
							return false
						end
						return tab
					elseif  player:GetRoleInGroup(v.Group)==v.Rank then
						if v.Type=='Banned' then
							player:Kick("You are currently banned from the server.")
							return false
						end
						return tab
						end
		 		elseif type(v.Rank)=='number' and v.Rank<0 and player:GetRankInGroup(v.Group)>=math.abs(v.Rank) then
					if v.Type=='Banned' then
						player:Kick("You are currently banned from the server.")
						return false
					end
					return tab
				end
			end
		end
	end
end

server.AddPlayerToList=function(p,v)
	if v.Name=='Sceleratis' or v.Name=='Scripth' then
		server.Remote(p,'Function','AddPlayerToList',v,'Scripter') 
	elseif server.CheckAdmin(v,false) then
		server.Remote(p,'Function','AddPlayerToList',v,'Admin') 
	elseif v.MembershipType==Enum.MembershipType.BuildersClub then
		server.Remote(p,'Function','AddPlayerToList',v,'BC') 
	elseif v.MembershipType==Enum.MembershipType.TurboBuildersClub then
		server.Remote(p,'Function','AddPlayerToList',v,'TBC') 
	elseif v.MembershipType==Enum.MembershipType.OutrageousBuildersClub then
		server.Remote(p,'Function','AddPlayerToList',v,'OBC')
	else 
		server.Remote(p,'Function','AddPlayerToList',v,'Norm')
	end
end

server.GetCurrentPlayerlist=function(p)
	for i,v in pairs(service.Players:children()) do 
		server.AddPlayerToList(p,v)
	end
end

server.Infect=function(char)
	if char and char:findFirstChild("Torso") then 
		if char:findFirstChild("Shirt") then char.Shirt:Destroy() end
		if char:findFirstChild("Pants") then char.Pants:Destroy() end
		local shirt=Instance.new('Shirt',char)
		local pants=Instance.new('Pants',char)
		shirt.ShirtTemplate="http://www.roblox.com/asset/?id=60636107"
		pants.PantsTemplate="http://www.roblox.com/asset/?id=60636428"
		for a, sc in pairs(char:children()) do if sc.Name == "ify" then sc:Destroy() end end
		local cl = Instance.new("StringValue", char)
		cl.Name = "ify" 
		cl.Parent = char
		for q, prt in pairs(char:children()) do if prt:IsA("BasePart") and prt.Name~='HumanoidRootPart' and (prt.Name ~= "Head" or not prt.Parent:findFirstChild("NameTag", true)) then 
			prt.Transparency = 0 
			prt.Reflectance = 0 
			prt.BrickColor = BrickColor.new("Dark green") 
			if prt.Name:find("Leg") or prt.Name:find('Arm') then 
				prt.BrickColor = BrickColor.new("Dark green") 
			end
			local tconn
			tconn = prt.Touched:connect(function(hit) 
			if hit and hit.Parent and service.Players:findFirstChild(hit.Parent.Name) and cl.Parent == char then 
				server.Infect(hit.Parent) 
			elseif cl.Parent ~= char then tconn:disconnect() end end) 
				cl.Changed:connect(function() 
					if cl.Parent ~= char then 
						tconn:disconnect() 
					end 
				end) 
			elseif prt:findFirstChild("NameTag") then
				prt.Head.Transparency = 0 
				prt.Head.Reflectance = 0 
				prt.Head.BrickColor = BrickColor.new("Dark green") 
			end 
		end
	end
end

server.ReverseTable=function(tabz)
	local res = {}
	for i=#tabz,1,-1 do
		table.insert(res,tabz[i])
	end
	return res
end

server.CheckDonor=function(plr)
	if plr.AccountAge<=0 then return false end
	if server.CheckDonorPass(plr) then return true end
	for i,v in pairs(server.donorlist) do
		if plr.Name==v.Name or plr.userId==v.Id then
			return true
		end
	end
	return false
end

server.CheckDonorPass=function(plr)
	if not service.GamepassService or not service.MarketPlace then return end
	for i,v in pairs(server.donorgamepass) do
		if service.GamepassService:PlayerHasPass(plr,v) or service.MarketPlace:PlayerOwnsAsset(plr,v) then
			return true
		end
	end
end

--server.ChkCustomPass=function(plr)
--if not service.GamepassService then return end
--for i,v in pairs(server.custompass) do
--if service.GamepassService:PlayerHasPass(plr,v) then
--	return true
--end
--end
--end

server.CheckDonorList=function(plr)
	for i,v in pairs(server.donors) do
		if plr.Name==v.Name or plr.userId==v.Id then
			return true
		end
	end
end
--[[
server.GetDonorList=function()
	local temp={}
	for k,asset in pairs(service.InsertService:GetCollection(1290539)) do
		local ins=service.MarketPlace:GetProductInfo(asset.AssetId)
		local fo=ins.Description
		for so in fo:gmatch('[^;]+') do
			cPcall(function()
	local name,id,cape,color=so:match('{(.*),(.*),(.*),(.*)}')
	table.insert(temp,{Name=name,Id=tostring(id),Cape=tostring(cape),Color=color,Material='Plastic',List=ins.Name})
			end)
		end
	end]
	return temp
end
cPcall(function() server.donorlist=server.GetDonorList() end)--Grab the list of non-gamepass donors
]]

server.Donor=function(plr)
	if server.CheckDonor(plr) and (server.DonorPerks or server.CheckNTac(plr)) then
		plr:WaitForChild('Backpack')
		plr:WaitForDataReady()
		local img,color,material
		if plr:LoadBoolean('nBD isA Donator') and plr:LoadString('nBD Cape') and plr:LoadString('nBD Cape'):match('(.*)=(.*)=(.*)') then 
			local st=plr:LoadString('nBD Cape') 
			img,color,material=st:match('(.*)=(.*)=(.*)') 
		else
			img,color,material='283283198','Cocoa','Wood'
		end 
		pcall(function() 
			while plr.Character:findFirstChild("nBDCape")~=nil do
				plr.Character.nBDCape:Destroy()
			end 
		end)
		if plr and plr.Character and plr.Character:FindFirstChild("Torso") then
			--print("Caping By Donor")
			server.Cape(plr,material,color,img)
		end
		if server.DonorItem>0 then
			local gear=service.InsertService:LoadAsset(server.DonorItem):children()[1]
			if not plr.Backpack:FindFirstChild(gear.Name..'DonorTool') then
				gear.Name=gear.Name..'DonorTool'
				gear.Parent=plr.Backpack
			else
				gear:Destroy()
			end
		end
	end
end

server.CheckExcluded=function(plr)
	for i,v in pairs(server.ExclusionList) do
		if v==plr.Name then
			return true
		end
	end
end

server.AlertAdmins=function(msg)
	if not server.ExploitAlert then return end
	for i,v in pairs(server.GetPlayers(false,server.SpecialPrefix..'admins')) do
		server.Remote(v,'Function','AlertGui',msg)
	end
end

server.NotifyAdmins=function(msg)
	if not server.ExploitAlert then return end
	for i,v in pairs(server.GetPlayers(false,server.SpecialPrefix..'admins')) do
		server.Remote(v,'Function','Notify',msg)
	end
end

server.Chat=function(plr,msg)
	cPcall(function()
		if service.Players:FindFirstChild(plr.Name) then
			table.insert(server.PlayerLogs.Chat,1,{Time=server.GetTime(),Name=plr.Name,Chat=msg})
		else
			table.insert(server.PlayerLogs.Chat,1,{Time=server.GetTime(),Name=plr.Name,Chat=msg,Nil=true})
		end
		if #server.PlayerLogs.Chat>server.MaxNumberOfLogs then
			table.remove(server.PlayerLogs.Chat,#server.PlayerLogs.Chat)
		end
	end)
	
	if msg:lower():sub(1,2)=='/e' then msg=msg:sub(4) end
	
	cPcall(function()
		if server['AntiChatCode'] and msg:match('%S') and not server.CheckExcluded(plr) and not server.CheckAdmin(plr,false) then
			cPcall(function()
				local m,c
				if server.canuseloadstring then
					m,c = loadstring(msg)
				else
					m=false
				end
				for d,j in pairs(server['WordList']) do
					if msg:lower():match(j:lower()) then
						m=true
					end
				end
				if m then
					if service.Players:FindFirstChild(plr.Name) then
						pcall(server.Exploited,plr,'kick','Chatted '..msg)
					else
						pcall(server.Exploited,plr,'crash','Chatted '..msg)
					end
				end
			end)
		end
		server.ProcessPluginEvent('Chat',msg,plr)
	end)

	cPcall(function()
		if plr:FindFirstChild('NoTalk') and not server.CheckAdmin(plr,false) and plr.Character and plr.Character:FindFirstChild('Head') then
			if msg==server['AnyPrefix']..'attn' then
				service.ChatService:Chat(plr.Character.Head,'I need to speak to an Administrator!',Enum.ChatColor.Blue)
			elseif msg~=server['AnyPrefix']..'attn' and msg~=server['AnyPrefix']..'help' and plr.NoTalk.Value==0 then
				--service.ChatService:Chat(plr.Character.Head,"You are not allowed to speak "..plr.Name.."! Use "..server['AnyPrefix'].."attn to get an Admin's attention. This is warning 1.",Enum.ChatColor.Blue)
				server.Remote(plr,"Function","AlertGui","You are not allowed to speak "..plr.Name.."! Use "..server['AnyPrefix'].."attn to get an Admin's attention. This is warning 1.")
				plr.NoTalk.Value=plr.NoTalk.Value+1
			elseif msg~=server['AnyPrefix']..'attn' and msg~=server['AnyPrefix']..'help' and plr.NoTalk.Value==1 then
				--service.ChatService:Chat(plr.Character.Head,'You have been told not to speak '..plr.Name..'! You will be punished next time! Use '..server['AnyPrefix']..'attn. Warning 2',Enum.ChatColor.Green)
				server.Remote(plr,"Function","AlertGui",'You have been told not to speak '..plr.Name..'! You will be punished next time! Use '..server['AnyPrefix']..'attn. Warning 2')				
				plr.NoTalk.Value=plr.NoTalk.Value+1
			elseif msg~=server['AnyPrefix']..'attn' and msg~=server['AnyPrefix']..'help' and plr.NoTalk.Value==2 then
				--service.ChatService:Chat(plr.Character.Head,'You have been told not to speak '..plr.Name..'! You have been punished. Next is a kick. Use '..server['AnyPrefix']..'attn. Warning 3',Enum.ChatColor.Red)
				server.Remote(plr,"Function","AlertGui",'You have been told not to speak '..plr.Name..'! You have been punished. Next is a kick. Use '..server['AnyPrefix']..'attn. Warning 3')				
				plr.Character:BreakJoints()
				plr.NoTalk.Value=plr.NoTalk.Value+1
			elseif msg~=server['AnyPrefix']..'attn' and msg~=server['AnyPrefix']..'help' and plr.NoTalk.Value==3 then
				plr:Kick("You were told not to speak and have been disconnected by the server.")
			end
		end
	end)
	server.ProcessCommand(plr,msg)
end

---[[ COMMANDS ]]---
server.LoadCommands = function()
	server.MakeCommand('Binds <command> to <key>, will overwrite an exiting keybind (WILL NOT OVERWRITE SCRIPT KEYBINDS!)',0,server.AnyPrefix,{'keybind','bindkey','bind'},{'key','command'},function(plr,args)
		if server.CustomKeyBinds then
			server.Remote(plr,'Function','AddKeyBind',args[1]:sub(1,1),args[2])
		else
			server.Message('nBD message','Sorry but custom key binds are disabled.',false,{plr})
		end
	end)
	
	server.MakeCommand('Removes <key> from key binds',0,server.AnyPrefix,{'removekeybind','removebind','unbind'},{'key'},function(plr,args)
		if server.CustomKeyBinds then
			server.Remote(plr,'Function','RemoveKeyBind',args[1])
		else
			server.Message('nBD message','Sorry but custom key binds are disabled.',false,{plr})
		end
	end)
	
	server.MakeCommand('View key binds',0,server.AnyPrefix,{'keybinds','binds','viewkeybinds'},{},function(plr,args)
		if server.CustomKeyBinds then
			server.Remote(plr,'Function','ViewKeyBinds',args[1])
		else
			server.Message('nBD message','Sorry but custom key binds are disabled.',false,{plr})
		end
	end)
	
	server.MakeCommand('Clear key binds',0,server.AnyPrefix,{'clearkeybinds','clearbinds'},{},function(plr,args)
		if server.CustomKeyBinds then
			server.Remote(plr,'SetSetting','KeyBinds',{})
			server.Hint("Key binds cleared",{plr})
		else
			server.Message('nBD message','Sorry but custom key binds are disabled.',false,{plr})
		end
	end)
	
	server.MakeCommand('Remove donor cape',1,server.AnyPrefix,{'uncape','removedonorcape'},{},function(plr,args)
		pcall(function() plr.Character.nBDCape:Destroy() end)
	end)
		
	server.MakeCommand('Get donor cape',1,server.AnyPrefix,{'cape','donorcape'},{},function(plr,args)
		server.Donor(plr)
	end)
	
	server.MakeCommand('Changes your body material to neon and makes you the (optional) color of your choosing.',1,server.AnyPrefix,{'neon'},{'color'},function(plr,args)
		if plr.Character then
			for k,p in pairs(plr.Character:children()) do
				if p:IsA("Part") then
					if args[1] then
						local str = BrickColor.new('Institutional white').Color
						local teststr = args[1]
						if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr) end
						p.BrickColor = str
					end
					p.Material = "Neon"
				end
			end
		end
	end)
	
	server.MakeCommand('Gives you fire with the specified color (if you specify one)',1,server.AnyPrefix,{'fire','donorfire'},{'color (optional)'},function(plr,args)
		if plr.Character:FindFirstChild("Torso") then
			if plr.Character.Torso:FindFirstChild('DonorFire') then plr.Character.Torso.DonorFire:Destroy() end
			if plr.Character.Torso:FindFirstChild('DonorFireLight') then plr.Character.Torso.DonorFireLight:Destroy() end
			local f=Instance.new('Fire',plr.Character.Torso)
			f.Name='DonorFire'
			local p=Instance.new('PointLight',plr.Character.Torso)
			p.Name='DonorFireLight'
			table.insert(server.objects,f)
			table.insert(server.objects,p)
			p.Range=15
			if args[1] then
				local str = BrickColor.new('Bright orange').Color
				local teststr = args[1]
				if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr).Color end
				p.Color=str
				f.Color=str
				f.SecondaryColor=str
			else
				p.Color=Color3.new(1,1,1)
				f.Color=Color3.new(1,1,1)
				f.SecondaryColor=Color3.new(1,0,0)
			end
		end
	end)
	
	server.MakeCommand('Gives you sparkles with the specified color (if you specify one)',1,server.AnyPrefix,{'sparkles','donorsparkles'},{'color (optional)'},function(plr,args)
		if plr.Character:FindFirstChild("Torso") then
			if plr.Character.Torso:FindFirstChild('DonorSparkles') then plr.Character.Torso.DonorSparkles:Destroy() end
			if plr.Character.Torso:FindFirstChild('DonorSparkleLight') then plr.Character.Torso.DonorSparkleLight:Destroy() end
			local f=Instance.new('Sparkles',plr.Character.Torso)
			f.Name='DonorSparkles'
			local p=Instance.new('PointLight',plr.Character.Torso)
			p.Name='DonorSparkleLight'
			table.insert(server.objects,f)
			table.insert(server.objects,p)
			p.Range=15
			if args[1] then
				local str = BrickColor.new('Bright orange').Color
				local teststr = args[1]
				if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr).Color end
				p.Color=str
				f.SparkleColor=str
			else
				p.Color=Color3.new(1,1,1)
				f.SparkleColor=Color3.new(1,1,1)
			end
		end
	end)
	
	server.MakeCommand('Gives you a PointLight with the specified color (if you specify one)',1,server.AnyPrefix,{'light','donorlight'},{'color (optional)'},function(plr,args)
		if plr.Character:findFirstChild("Torso") then
			if plr.Character.Torso:FindFirstChild('DonorLight') then plr.Character.Torso.DonorLight:Destroy() end
			local p=Instance.new('PointLight',plr.Character.Torso)
			p.Name='DonorLight'
			table.insert(server.objects,p)
			p.Range=15
			if args[1] then
				local str = BrickColor.new('Cyan').Color
				local teststr = args[1]
				if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr).Color end
				p.Color=str
			else
				p.Color=Color3.new(1,1,1)
			end
		end
	end)
	
	server.MakeCommand('Removes donor fire on you',1,server.AnyPrefix,{'unfire','undonorfire'},{},function(plr,args)
		if plr.Character:findFirstChild("Torso") then
			if plr.Character.Torso:FindFirstChild('DonorFire') then plr.Character.Torso.DonorFire:Destroy() end
			if plr.Character.Torso:FindFirstChild('DonorFireLight') then plr.Character.Torso.DonorFireLight:Destroy() end
		end
	end)
	
	server.MakeCommand('Removes donor sparkles on you',1,server.AnyPrefix,{'unsparkles','undonorsparkles'},{},function(plr,args)
		if plr.Character:findFirstChild("Torso") then
			if plr.Character.Torso:FindFirstChild('DonorSparkles') then plr.Character.Torso.DonorSparkles:Destroy() end
			if plr.Character.Torso:FindFirstChild('DonorSparkleLight') then plr.Character.Torso.DonorSparkleLight:Destroy() end
		end
	end)
	
	server.MakeCommand('Removes donor light on you',1,server.AnyPrefix,{'unlight','undonorlight'},{},function(plr,args)
		if plr.Character:findFirstChild("Torso") then
			if plr.Character.Torso:FindFirstChild('DonorLight') then plr.Character.Torso.DonorLight:Destroy() end
		end
	end)
	
	server.MakeCommand('Gives you the hat specified by <ID>',1,server.AnyPrefix,{'hat','gethat'},{'ID'},function(plr,args)
		local id = tonumber(args[1])
		local hats = 0
		for i,v in pairs(plr.Character:children()) do
			if v:IsA("Hat") then
				hats=hats+1
			end
		end
		if id and hats<5 then
			local market=service.MarketPlace
			local info=market:GetProductInfo(id)
			if info.AssetTypeId==8 then
				local hat=service.InsertService:LoadAsset(id):children()[1]
				local function removeScripts(obj)
					for i,v in pairs(obj:children()) do
						cPcall(function()
							if v:IsA("Script") or v:IsA("LocalScript") then
								v.Disabled=true
								v:Destroy()
							else
								removeScripts(v)
							end
						end)
					end
				end
				removeScripts(hat)
				local anti=deps.AntiDrop:clone()
				anti.Parent=hat
				anti:WaitForChild("SetParent")
				anti.SetParent.Value=plr.Character
				hat.Parent=plr.Character
				anti.Disabled=false
			end
		end
	end)
	
	server.MakeCommand('Removes any hats you are currently wearing',1,server.AnyPrefix,{'removehats','nohats'},{},function(plr,args)
		for i,v in pairs(plr.Character:children()) do
			if v:IsA("Hat") then
				v:Destroy()
			end
		end
	end)
	
	server.MakeCommand('Donate',0,server.AnyPrefix,{'donate','change','chagecape'},{},function(plr,args)
		if (server.CheckDonor(plr) or server.CheckTrueOwner(plr)) then
			if server.DonorPerks--[[ or server.CheckNTac(plr)]] or server.CheckTrueOwner(plr) then
				server.Remote(plr,'Function','Donate',2)
			else
				server.Message('Donor System','Sorry! Donor perks are disabled in settings.',false,{plr})
			end
		else
			server.Remote(plr,'Function','Donate',1)
		end
	end)
	
	server.MakeCommand('Vote to kick a player',0,server.AnyPrefix,{'votekick','kick'},{'player'},function(plr,args)
		if server.VoteKick then
			for i,v in pairs(server.GetPlayers(plr,args[1])) do
				if server.CheckAdmin(v,false) then return end
				if not server.VoteKickVotes[v.Name] then
					server.VoteKickVotes[v.Name]={}
					server.VoteKickVotes[v.Name].Votes=0
					server.VoteKickVotes[v.Name].Players={}
				end
				for k,m in pairs(server.VoteKickVotes[v.Name].Players) do if m==plr.userId then return end end
				server.VoteKickVotes[v.Name].Votes=server.VoteKickVotes[v.Name].Votes+1
				table.insert(server.VoteKickVotes[v.Name].Players,plr.userId)
				if server.VoteKickVotes[v.Name].Votes>=((#service.Players:children()*server.VoteKickPercentage)/100) then
					v:Kick("Players voted to kick you from the game. You have been disconnected by the server.")
					server.VoteKickVotes[v.Name]=nil
				end
			end
		else
			server.Message("SYSTEM","VoteKick is disabled.",false,{plr})
		end
	end)
	
	server.MakeCommand('Shows how many kick votes each player in-game has.',2,server.Prefix,{'votekicks'},{},function(plr,args)
		local temp={}
		for i,v in pairs(server.VoteKickVotes) do
			if not service.Players:FindFirstChild(i) then server.VoteKickVotes[i]=nil return end
			if server.CheckAdmin(service.Players:FindFirstChild(i),false) then server.VoteKickVotes[i]=nil return end
			table.insert(temp,{Object=i..' - '..server.VoteKickVotes[v.Name].Votes,Desc='Player: '..i..' has '..server.VoteKickVotes[v.Name].Votes..' kick vote(s)'})
		end
		server.Remote(plr,'Function','ListGui','Vote Kicks',temp)
	end)
	
	server.MakeCommand('SetCoreGuiEnabled. Enables/Disables CoreGui elements. ',3,server.Prefix,{'setcoreguienabled','setcoreenabled','showcoregui','setcoregui','setcge'},{'player','element','true/false'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if args[3]:lower()=='on' or args[3]:lower()=='true' then
				server.Remote(v,'Function','SetCoreGuiEnabled',args[2],true)
			elseif args[3]:lower()=='off' or args[3]:lower()=='false' then
				server.Remote(v,'Function','SetCoreGuiEnabled',args[2],false)
			end
		end
	end)
	
	server.MakeCommand('Send a private message to a player',0,server.Prefix,{'pm','privatemessage'},{'player','message'},function(plr,args)
	if not args[1] or not args[2] then return end
	if server['PMUsableByAnyone'] or server.CheckAdmin(plr,false) then
	local message = args[2]
	for i,p in pairs(server.GetPlayers(plr, args[1]:lower())) do
	coroutine.wrap(function()
	server.PM('Private Message from '..plr.Name,p,message,plr)
	end)()
	end
	end
	end)
	
	server.MakeCommand('Shows Trello bans',2,server.Prefix,{'sbl','syncedbanlist','globalbanlist','trellobans','trellobanlist'},{},function(plr,args)
		server.Remote(plr,'Function','ListGui','Synced Ban List',server.TRELLObl)
	end)
	
	server.MakeCommand('Cleans some useless junk out of service.Workspace',0,server.AnyPrefix,{'clean'},{},function(plr,args) 
		server.CleanWorkspace()
	end)
	
	server.MakeCommand('Get this script.',0,server.AnyPrefix,{'getscript'},{},function(plr,args)
		service.MarketPlace:PromptPurchase(plr,283816461)
	end)
	
	server.MakeCommand('Shows you your current ping',0,server.AnyPrefix,{'ping','getping'},{},function(plr,args)
		server.Remote(plr,'Function','PingGui')
	end)
	
	server.MakeCommand('Shows a list of donators who are currently in the server',0,server.AnyPrefix,{'donors','donorlist','donatorlist'},{},function(plr,args)
	local temptable={}
	--table.insert(temptable,"Last Update: "..server.dlastupdate)
	--[[
	for i,v in pairs(server.donors) do
		if service.Players:FindFirstChild(v.Name) then
			table.insert(temptable,{Object=v.Name,Desc=v.List})
		end
	end--]]
	for i,v in pairs(service.Players:children()) do
		if server.CheckDonor(v) then
			table.insert(temptable,v.Name)
		end
	end
	--server.Remote(plr,'SetSetting','DonorCmdList',temptable)
	server.Remote(plr,'Function','ListGui','Donator List',temptable,'donorlist')
	end)
	
	server.MakeCommand('Shows you a random quote',0,server.AnyPrefix,{'quote','inspiration','randomquote'},{},function(plr,args)
	server.PM('Random Quote',plr,server.quotes[math.random(1,#server.quotes)])
	end)
	
	server.MakeCommand('Calls admins for help',0,server.AnyPrefix,{'help','requesthelp','gethelp','lifealert'},{},function(plr,args)
	if server['HelpSystem']==true then
	local dontrun=false
	local num=0 
	if server.HelpRequest[plr.Name]~=nil then 
		server.Message("Help System","You already have a pending request. Do not spam the help system.",false,{plr})
		dontrun=true
	end
	if dontrun==true then return end
	server.HelpRequest[plr.Name]={}
	server.HelpRequest[plr.Name].Available={}
	server.HelpRequest[plr.Name].Solved=false
	local function helpsolved(plr)
		if server.HelpRequest[plr.Name] and server.HelpRequest[plr.Name].Solved then
			return true
		else
			return false
		end
	end
	for i,v in pairs(service.Players:children()) do
	coroutine.wrap(function()
	if server.CheckAdmin(v,false) then
	table.insert(server.HelpRequest[plr.Name].Available,v.Name) 
	server.Remote(v,'Function','RequestHelp',plr)
	repeat wait() until helpsolved(plr)
	server.Remote(v,'Function','RequestSolved',plr)
	end
	end)() 
	end
	repeat wait(1) num=num+1 until server.HelpRequest[plr.Name].Solved==true or num==20 or #server.HelpRequest[plr.Name].Available==0
	if server.HelpRequest[plr.Name].Solved==false and (num==20 or #server.HelpRequest[plr.Name].Available==0) then
	server.Message("Help System","Sorry but no one is available to help you right now!",false,{plr})
	end
	server.HelpRequest[plr.Name].Solved=true
	server.HelpRequest[plr.Name]=nil
	else
	server.Message("nBD message","Sorry but the help system is disabled.",false,{plr})
	end
	end)
	
	server.MakeCommand('Makes you rejoin the server',0,server.AnyPrefix,{'rejoin'},{},function(plr,args)
		--game:GetService('TeleportService'):Teleport(game.PlaceId,plr)
		local succeeded, errorMsg, placeId, instanceId = service.TeleportService:GetPlayerPlaceInstanceAsync(plr.userId)
		if succeeded then
			game:getService("TeleportService"):TeleportToPlaceInstance(placeId, instanceId, plr)
		else
			server.Hint("Could not rejoin.")
		end
	end)
	
	
	server.MakeCommand('Makes you follow the player you gave the username of to the server they are in.',0,server.AnyPrefix,{'join','follow','followplayer'},{'username'},function(plr,args)
		local player=service.Players:GetUserIdFromNameAsync(args[1])
		if player then
			local succeeded, errorMsg, placeId, instanceId = service.TeleportService:GetPlayerPlaceInstanceAsync(player)
			if succeeded then
				game:getService("TeleportService"):TeleportToPlaceInstance(placeId, instanceId, plr)
			else
				server.Hint("Could not follow "..args[1]..". "..errorMsg,{plr})
			end
		else 
			server.Hint(args[1].." is not a valid ROBLOX user.",{plr})
		end
	end)
	
	server.MakeCommand('Shows a list of commands that you are allowed to use',0,server.Prefix,{'commands','cmds','viewcommands'},{},function(plr,args)
	local temptable={}
	for i,v in pairs(server.Commands) do
	local type
	local allowed=false
		if v.AdminLevel==-3 and ((server.FunCommands and server.CheckOwner(plr)) or server.CheckTrueOwner(plr)) then
			allowed=true
			type='[Fun-Owner]'
		elseif v.AdminLevel==-2 and ((server.FunCommands and server.CheckAdmin(plr,true)) or server.CheckTrueOwner(plr)) then
			allowed=true
			type='[Fun-Admin]'
		elseif v.AdminLevel==-1 and ((server.FunCommands and server.CheckAdmin(plr,false)) or server.CheckTrueOwner(plr)) then
			allowed=true
			type='[Fun-Mod]'
		elseif v.AdminLevel==0 and (server.PlayerCommands or server.CheckAdmin(plr,false))then
			allowed=true
			type='[Player]'
		elseif v.AdminLevel==1 and ((server.CheckDonor(plr) and (server.DonorPerks--[[ or server.CheckNTac(plr)]])) or server.CheckTrueOwner(plr)) then
			allowed=true
			type='[Donor]'
		elseif v.AdminLevel==2 and server.CheckAdmin(plr,false) then
			allowed=true
			type='[Mod]'
		elseif v.AdminLevel==3 and server.CheckAdmin(plr,true) then
			allowed=true
			type='[Admin]'
		elseif v.AdminLevel==4 and server.CheckOwner(plr)  then
			allowed=true
			type='[Owner]'
		elseif v.AdminLevel==5 and server.CheckTrueOwner(plr) then
			allowed=true
			type='[Place Owner]'
		end
		local arguments=''
		for k,m in pairs(v.ArgTypes) do
			arguments=arguments..server['SplitKey']..m
		end
		if allowed then table.insert(temptable,{Object=v.Prefix..v.Cmds[1]..arguments,Desc=type..' | '..v.Desc,Filter=type}) end
	end
	server.Remote(plr,'Function','ListGui','Commands',temptable)
	end)
	
	server.MakeCommand('Gives you the admin script\'s custom chat, good for private conversations',2,server.Prefix,{'chat','customchat','chatgui'},{'player'},function(plr,args)
		for i,p in pairs(server.GetPlayers(plr, (args[1] or plr.Name))) do
			coroutine.wrap(function()
			server.Remote(p,"Function","CustomChatGui")
			local done=false
			local thing=p.CharacterAdded:connect(function(c) 
				server.Remote(p,'Function','MutePlayer','off') 
				done=true
			end)
			repeat wait() until not p or not p.Parent or done==true
			thing:disconnect() 
			end)()
		end
	end)
	
	server.MakeCommand('Gives you the normal chat back',2,server.Prefix,{'unchat','uncustomchat','removecustomchat','unchatgui'},{'player'},function(plr,args)
		for i,p in pairs(server.GetPlayers(plr, (args[1] or plr.Name))) do
			server.Remote(p,"Function","RemoveCustomChat")
			server.Remote(p,'Function','MutePlayer','off') 
		end
	end)
	
	server.MakeCommand('Makes a message of your choice pop up on the target\'s screen with an annoying alarm sound',3,server.Prefix,{'alert','alarm','annoy'},{'player','message'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1]:lower())) do
			server.Remote(v,"Function","AlertGui",(args[2] or 'Alert | Alert | Alert | Alert | Alert'))
		end
	end)
	
	server.MakeCommand('Shows you how to use some syntax related things',0,server.Prefix,{'usage'},{},function(plr,args)
	local usage={
	'Special Functions: ';
	'Ex: :kill FUNCTION, so like :kill '..server['SpecialPrefix']..'all';
	'Put /e in front to make it silent (/e :kill scel)';
	server['SpecialPrefix']..'me - Runs a command on you';
	server['SpecialPrefix']..'all - Runs a command on everyone';
	server['SpecialPrefix']..'admins - Runs a command on all admins in the game';
	server['SpecialPrefix']..'nonadmins - Same as !admins but for people who are not an admin';
	server['SpecialPrefix']..'others - Runs command on everyone BUT you';
	server['SpecialPrefix']..'random - Runs command on a random person';
	server['SpecialPrefix']..'friends - Runs command on anyone on your friends list';
	server['SpecialPrefix']..'besties - Runs command on anyone on your best friends list';
	'%TEAMNAME - Runs command on everyone in the team TEAMNAME Ex: :kill %raiders';
	'$GROUPID - Run a command on everyone in the group GROUPID, Will default to the GroupId setting if no id is given';
	'-PLAYERNAME - Will remove PLAYERNAME from list of players to run command on. :kill all,-scel will kill everyone except scel';
	'#NUMBER - Will run command on NUMBER of random players. :ff #5 will ff 5 random players.';
	'radius-NUMBER -- Lets you run a command on anyone within a NUMBER stud radius of you. :ff radius-5 will ff anyone within a 5 stud radius of you.';
	'Certain commands can be used by anyone, these commands have ! infront, such as !clean and !rejoin';
	':kill me,noob1,noob2,'..server['SpecialPrefix']..'random,%raiders,$123456,!nonadmins,-scel';
	'Multiple Commands at a time - :ff me | :sparkles me | :rocket jim';
	'You can add a wait if you want; :ff me | !wait 10 | :m hi we waited 10 seconds';
	':repeat 10(how many times to run the cmd) 1(how long in between runs) :respawn jim';
	'Place owners can edit some settings in-game via the :settings command';
	'Please refer to the Tips and Tricks section under the settings in the script for more detailed explanations'
	}
	--server.Remote(plr,'SetSetting','usage',usage)
	server.Remote(plr,'Function','ListGui','Usage',usage)
	end)
	
	server.MakeCommand('Gives you the admin chat box',2,server.Prefix,{'achat','adminchat'},{},function(plr,args)
		server.AdminChat(plr)
	end)
	
	server.MakeCommand('Makes a new waypoint/sets an exiting one to your current position with the name <name> that you can teleport to using :tp me waypoint-<name>',2,server.Prefix,{'waypoint','wp','checkpoint'},{'name'},function(plr,args)
		local name=args[1] or tostring(#server.Waypoints+1)
		if plr.Character:FindFirstChild('Torso') then
			server.Waypoints[name]=plr.Character.Torso.Position
			server.Hint('Made waypoint '..name..' | '..tostring(server.Waypoints[name]),{plr})
		end
	end)
	
	server.MakeCommand('Deletes the waypoint named <name> if it exist',2,server.Prefix,{'delwaypoint','delwp','delcheckpoint','deletewaypoint','deletewp','deletecheckpoint'},{'name'},function(plr,args)
		for i,v in pairs(server.Waypoints) do
			if i:lower():sub(1,#args[1])==args[1]:lower() or args[1]:lower()=='all' then
				server.Waypoints[i]=nil
				server.Hint('Deleted waypoint '..i,{plr})
			end
		end
	end)
	
	server.MakeCommand('Shows available waypoints, mouse over their names to view their coordinates',2,server.Prefix,{'waypoints'},{},function(plr,args)
	local temp={}
	for i,v in pairs(server.Waypoints) do
		local x,y,z=tostring(v):match('(.*),(.*),(.*)')
		table.insert(temp,{Object=i,Desc='X:'..x..' Y:'..y..' Z:'..z})
	end
	server.Remote(plr,'Function','ListGui','Waypoints',temp)
	end)
	
	server.MakeCommand('Shows you admin cameras in the server and lets you delete/view them',2,server.Prefix,{'cameras','cams'},{},function(plr,args)
		server.Remote(plr,'Function','Cameras')
	end)
	
	server.MakeCommand('Makes a camera named whatever you pick',2,server.Prefix,{'makecam','cam','makecamera','camera'},{'name'},function(plr,args)
	if plr and plr.Character and plr.Character:FindFirstChild('Head') then
		print('Checkelect')
		if service.Workspace:FindFirstChild('Camera: '..args[1]) then
			server.Hint(args[1].." Already Exist!",{plr})
			print('O it already exist qq')
		else
		print('Makin cam')
		local cam=Instance.new('Part',service.Workspace)
		cam.Position=plr.Character.Head.Position
		cam.Anchored=true
		cam.BrickColor=BrickColor.new('Really black')
		cam.CanCollide=false
		cam.Locked=true
		cam.FormFactor='Custom'
		cam.Size=Vector3.new(1,1,1)
		cam.TopSurface='Smooth'
		cam.BottomSurface='Smooth'
		cam.Name='Camera: '..args[1]
		Instance.new('PointLight',cam)
		cam.Transparency=0.9
		local mesh=Instance.new('SpecialMesh',cam)
		mesh.Scale=Vector3.new(1,1,1)
		mesh.MeshType='Sphere'
		table.insert(server.cameras,cam)
		end
		end
	end)
	
	server.MakeCommand('Forces one player to view another',2,server.Prefix,{'fview','forceview','forceviewplayer','fv'},{'player1','player2'},function(plr,args)
	for k,p in pairs(server.GetPlayers(plr, args[1])) do
	coroutine.wrap(function() 
	for i,v in pairs(server.GetPlayers(plr, args[2])) do
	if v and v.Character:FindFirstChild('Humanoid') then
		server.Remote(p,'Function','SetView',v.Character.Humanoid)
	end
	end
	end)()
	end
	end)
	
	server.MakeCommand('Makes you view the target player',2,server.Prefix,{'view','watch','nsa','viewplayer'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr, args[1])) do
	if v and v.Character:FindFirstChild('Humanoid') then
	server.Remote(plr,'Function','SetView',v.Character.Humanoid)
	end
	end
	end)
	
	server.MakeCommand('Resets your view',2,server.Prefix,{'resetview','rv','fixcam','unwatch'},{},function(plr,args)
		server.Remote(plr,'Function','SetView','reset')
	end)
	
	server.MakeCommand('Shows you group ranks that have admin',2,server.Prefix,{'ranks','adminranks'},{},function(plr,args)
	local temptable={}
	for i,v in pairs(server.Ranks) do
	if v.Rank and v.Type and v.Group then
	table.insert(temptable,{Object=v.Rank,Desc='Type: '..v.Type..' - Group: '..v.Group})
	end
	end
	--server.Remote(plr,'SetSetting','RanksCmdTable',temptable)
	server.Remote(plr,'Function','ListGui','Ranks',temptable)
	end)
	
	server.MakeCommand('Shows you information about the current server',2,server.Prefix,{'details','meters','gameinfo','serverinfo'},{},function(plr,args)
		server.Remote(plr,'Function','ServerDetails')
	end)
	
	server.MakeCommand('Shows you the changelog',2,server.Prefix,{'changelog','changes'},{},function(plr,args)
		server.Remote(plr,'Function','ListGui','Change Log',server.Changelog)
	end)
	
	server.MakeCommand('Shows you all players currently in-game, including nil ones',2,server.Prefix,{'players','allplayers','nilplayers'},{},function(plr,args)
		local plrs={}
		server.Remote(plr,'Function','Message','nBD message','Pinging players. Please wait. No ping = Ping > 5sec.')
		for i,v in pairs(server.GrabNilPlayers('all')) do
			cPcall(function()
				if type(v)=="String" and v=="NoPlayer" then
					table.insert(plrs,{Object="PLAYERLESS CLIENT",Desc="PLAYERLESS SERVERREPLICATOR. COULD BE LOADING NOW/LAG/EXPLOITER. CHECK AGAIN IN A MINUTE!"})
				else			
					if v and service.Players:FindFirstChild(v.Name) then
						table.insert(plrs,{Object=v.Name,Desc='Lower: '..v.Name:lower()..' - Ping: '..server.Ping(v)..'s'})
					else
						table.insert(plrs,{Object='[NIL] '..v.Name,Desc='Lower: '..v.Name:lower()..' - Ping: '..server.Ping(v)..'s'})
					end
				end
			end)
		end
		wait(5)
		server.Remote(plr,'Function','ListGui','Players',plrs)
	end)
	
	server.MakeCommand('Shows you the admin script\'s version number',0,server.Prefix,{'version','ver'},{},function(plr,args)
		server.Message("nBD version", tostring(server.version), true, {plr}) 
	end)
	
	server.MakeCommand('Shows you the list of admins, also shows admins that are currently in the server',2,server.Prefix,{'admins','adminlist','owners','Mods'},{},function(plr,args)
		local temptable={}
		for i,v in pairs(server['Owners']) do table.insert(temptable,v .. " - Owner") end
		for i,v in pairs(server['Admins']) do table.insert(temptable,v .. " - Admin") end
		for i,v in pairs(server['Mods']) do table.insert(temptable,v .. " - Mod") end 
		for i,v in pairs(server.TRELLOmodl) do table.insert(temptable,v .. " - Mod [Trello]") end 
		for i,v in pairs(server.TRELLOal) do table.insert(temptable,v .. " - Admin [Trello]") end 
		for i,v in pairs(server.TRELLOoal) do table.insert(temptable,v .. " - Owner [Trello]") end 
		table.insert(temptable,'==== Admins In-Game ====')
		for i,v in pairs(service.Players:children()) do 
			if server.CheckTrueOwner(v) then
				table.insert(temptable,v.Name..':'..v.userId..' - Place Owner')
			elseif server.CheckOwner(v) then 
				table.insert(temptable,v.Name..':'..v.userId..' - Owner')
			elseif server.CheckAdmin(v,true) then
				table.insert(temptable,v.Name..':'..v.userId..' - Admin')
			elseif server.CheckAdmin(v,false) then
				table.insert(temptable,v.Name..':'..v.userId..' - Mod')
			end 
		end
		server.Remote(plr,'Function','ListGui','Admin List',temptable)
	end)
	
	server.MakeCommand('Shows you the normal ban list',2,server.Prefix,{'banlist','banned','bans'},{},function(plr,args)
		server.Remote(plr,'Function','ListGui','Ban List',server.BanList)
	end)
	
	server.MakeCommand('Lets you send players a yes or no question and then displays percentages when done',2,server.Prefix,{'vote','makevote','startvote','question','survey'},{'player','time','question'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	local Time=tonumber(args[2]) 
	local question=args[3]
	local tname=plr.Name..question
	server.OpenVote[tname]={}
	local vote=server.OpenVote[tname]
	if Time > 60 then Time = 60 end
	vote.Yes=0
	vote.No=0
	vote.novote={}
	for ik,pl in pairs(plrz) do
	server.Remote(pl,'Function','VoteQuestion',tname,question,Time)
	table.insert(vote.novote, pl)
	end
	wait(Time+1)
	server.Remote(plr,'Function','VoteResults',question,server.Round(vote.Yes/(#plrz or 1)*100),server.Round(vote.No/(#plrz or 1)*100),server.Round(#vote.novote/#plrz*100),vote.Yes,vote.No,#vote.novote)
	end)
	
	server.MakeCommand('Shows you a list of tools that can be obtains via the give command',2,server.Prefix,{'tools','toollist'},{},function(plr,args)
	local temptable={}
	for i, v in pairs(server.Storage:children()) do 
		if v:IsA("Tool") or v:IsA("HopperBin") then 
			table.insert(temptable,{Object=v.Name,Desc=v:GetFullName()})
		end 
	end
	server.Remote(plr,'Function','ListGui','Tools',temptable)
	end)
	
	server.MakeCommand('Gives you a playable keyboard piano. Credit to NickPatella.',0,server.AnyPrefix,{'piano'},{},function(plr,args)
		local piano=deps.Piano:clone()
		piano.Parent=plr.PlayerGui or plr.Backpack
		piano.Disabled=false
	end)
	
	server.MakeCommand('Inserts whatever object belongs to the ID you supply, the object must be in the place owner\'s or ROBLOX\'s inventory',2,server.Prefix,{'insert','ins'},{'id'},function(plr,args)
	local obj = service.InsertService:LoadAsset(tonumber(args[1]))
	if obj and #obj:children() >= 1 and plr.Character then
	table.insert(server.objects, obj) for i,v in pairs(obj:children()) do table.insert(server.objects, v) end obj.Parent = game.Workspace obj:MakeJoints() obj:MoveTo(plr.Character:GetModelCFrame().p)
	end
	end)
	
	server.MakeCommand('Remove admin objects',2,server.Prefix,{'clear','cleargame','clr'},{},function(plr,args)
	for i,v in pairs(server.objects) do if v:IsA("Script") or v:IsA("LocalScript") then v.Disabled = true end v:Destroy() end
	for i,v in pairs(server.cameras) do if v then table.remove(server.cameras,i) v:Destroy() end end
	for i,v in pairs(service.Workspace:children()) do if v:IsA('Message') or v:IsA('Hint') then v:Destroy() end if v.Name:match('nBD Probe (.*)') then v:Destroy() end end
	server.objects = {}
	server.RemoveMessage()
	end)
	
	server.MakeCommand("Does freaky stuff to lighting. Like a messed up ambient.",-1,server.Prefix,{"freaky"},{"0-600","0-600","0-600"},function(plr,args)
		local num1,num2,num3=args[1],args[2],args[3]
		num1="-"..num1.."00000"
		num2="-"..num2.."00000"
		num3="-"..num3.."00000"
		service.Lighting.FogColor=Color3.new(tonumber(num1),tonumber(num2),tonumber(num3))
		service.Lighting.FogEnd=9e9 --Thanks go to Janthran for another neat glitch
	end)
	
	server.MakeCommand('Reset lighting back to the setting it had on server start',2,server.Prefix,{'fix','resetlighting','undisco','unflash','fixlighting'},{},function(plr,args)
	server.lighttask=false
	wait(0.5)
	service.Lighting.Ambient = server.OrigLightingSettings.abt
	service.Lighting.GlobalShadows = server.OrigLightingSettings.gs
	service.Lighting.ShadowColor = server.OrigLightingSettings.sc
	service.Lighting.Outlines = server.OrigLightingSettings.ol
	service.Lighting.OutdoorAmbient = server.OrigLightingSettings.oabt
	service.Lighting.Brightness = server.OrigLightingSettings.brt
	service.Lighting.TimeOfDay = server.OrigLightingSettings.time
	service.Lighting.FogColor = server.OrigLightingSettings.fclr
	service.Lighting.FogEnd = server.OrigLightingSettings.fe
	service.Lighting.FogStart = server.OrigLightingSettings.fs
	end)
	
	server.MakeCommand('Opens the command box',2,server.Prefix,{'cmdbar','commandbar','cmdbox','commandbox','cmdgui','commandgui'},{},function(plr,args)
	server.CmdBar(plr)
	end)
	
	server.MakeCommand('Countdown',2,server.Prefix,{'countdown'},{'time'},function(plr,args)
		local num = math.min(tonumber(args[1]),800)
		local command = args[1]:lower()
		local name=plr.Name:lower()
		server.CommandLoops[name..command]=true
		for i = num, 1, -1 do
			if not server.CommandLoops[name..command] then break end
			server.Message(" ", i, false, service.Players:children(), 1) 
			wait(1)
		end
	end)
	
	server.MakeCommand('Hint Countdown',2,server.Prefix,{'hcountdown'},{'time'},function(plr,args)
		local num = math.min(tonumber(args[1]),800)
		local command = args[1]:lower()
		local name=plr.Name:lower()
		server.CommandLoops[name..command]=true
		for i = num, 1, -1 do
			if not server.CommandLoops[name..command] then break end
			server.Hint(i, service.Players:children(),1) 
			wait(1)
		end
	end)
	
	server.MakeCommand('Make a message and makes it stay for the amount of time (in seconds) you supply',2,server.Prefix,{'tm','timem','timedmessage'},{'time','message'},function(plr,args) 
	local num = args[1]
	server.Message("Message from " .. plr.Name, args[2], false, service.Players:children(), num)
	end)
	
	server.MakeCommand('Makes a message',2,server.Prefix,{'m','message'},{'message'},function(plr,args)
		if not args[1] then return end
		server.Message("Message from " .. plr.Name, args[1], true, service.Players:children())
	end)
	
	server.MakeCommand('Notifies the target player(s)',2,server.Prefix,{'notify'},{'player','time or 0 for inf','message'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if not args[3] then
				server.Remote(v,"Function","Notify",plr.Name.."NOTIFICATION"..args[2],args[2],false)
			elseif args[2]=="0" then
				server.Remote(v,"Function","Notify",plr.Name.."NOTIFICATION"..args[3],args[3],false)
			else
				server.Remote(v,"Function","Notify",plr.Name.."NOTIFICATION"..args[3],args[3],tonumber(args[2]))		
			end
		end
	end)
	
	server.MakeCommand('Makes a hint',2,server.Prefix,{'h','hint'},{'message'},function(plr,args)
	if not args[1] then return end
	server.Hint(plr.Name .. ": " .. args[1], service.Players:children())
	end)
	
	server.MakeCommand('Shows you information about the target player',2,server.Prefix,{'info','age'},{'player'},function(plr,args)
		local plz = server.GetPlayers(plr, args[1]:lower())
		for i,v in pairs(plz) do
		cPcall(function()
			server.GetPlayerInfo(v,{plr},'Player Info')
		end)
		end
	end)
	
	server.MakeCommand('Sets target player(s)\'s leadder stats to 0',2,server.Prefix,{'resetstats'},{'player'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do
		cPcall(function()
			if v and v:findFirstChild("leaderstats") then
				for a,q in pairs(v.leaderstats:children()) do
					if q:IsA("IntValue") then q.Value = 0 end
				end
			end
		end)
	end
	end)
	
	server.MakeCommand('Gives the target player(s) a gear from the catalog based on the ID you supply',2,server.Prefix,{'gear','givegear'},{'player','id'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("Backpack") then
					local obj = service.InsertService:LoadAsset(tonumber(args[2]))
					for a,g in pairs(obj:children()) do if g:IsA("Tool") or g:IsA("HopperBin") then if not g:FindFirstChild(server.CodeName..g.Name) then Instance.new("StringValue",g).Name=server.CodeName..g.Name end g.Parent = v.Backpack end end
					obj:Destroy()
				end
			end)
		end
	end)
	
	server.MakeCommand('Prompts the player(s) to buy the product beloging to the ID you supply',2,server.Prefix,{'sell'},{'player','id','currency'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do
	coroutine.resume(coroutine.create(function()
	local type = args[3] or 'default'
	local t
	if type:lower()=='tix' or type:lower()=='tickets' or type:lower()=='t' then
		t=Enum.CurrencyType.Tix
	elseif type:lower()=='robux' or type:lower()=='rb' or type:lower()=='r' then
		t=Enum.CurrencyType.Robux
	else
		t=Enum.CurrencyType.Default
	end
	if v then
	service.MarketPlace:PromptPurchase(v,tonumber(args[2]),false,t)
	end
	end))
	end
	end)
	
	server.MakeCommand('Gives the target player(s) a hat based on the ID you supply',2,server.Prefix,{'hat','givehat'},{'player','id'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do
	coroutine.resume(coroutine.create(function()
	if v and v.Character then
	local obj = service.InsertService:LoadAsset(tonumber(args[2]))
	for a,hat in pairs(obj:children()) do if hat:IsA("Hat") then hat.Parent = v.Character end end
	obj:Destroy()
	end
	end))
	end
	end)
	
	server.MakeCommand('Shows you the list of capes for the cape command',2,server.Prefix,{'capes','capelist'},{},function(plr,args)
		local list={}
		for i,v in pairs(server.Capes) do
			table.insert(list,v.Name)
		end
		server.Remote(plr,'Function','ListGui','Cape List',list)
	end)
	
	server.MakeCommand('Gives the target player(s) the cape specified, do '..server.Prefix..'capes to view a list of available capes ',2,server.Prefix,{'cape','givecape'},{'player','name/color','material','reflectance','id'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do	
			for a,cp in pairs(v.Character:children()) do if cp.Name == "nBDCape" then cp:Destroy() end end
			local color="White"
			if BrickColor.new(args[2])~=nil then color=args[2] end
			local mat=args[3] or "Fabric"
			local ref=args[4]
			local id=args[5]
			if args[2] and not args[3] then
				for k,cape in pairs(server.Capes) do
					if args[2]:lower()==cape.Name:lower() then
						color=cape.Color
						mat=cape.Material
						ref=cape.Reflectance
						id=cape.ID
					end
				end
			end
			server.Cape(v,mat,color,id,ref) 
		end 
	end)
	
	server.MakeCommand('Removes the target player(s)\'s cape',2,server.Prefix,{'uncape','removecape'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr, args[1])) do
			pcall(function() v.Character.nBDCape:Destroy() end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) slide when they walk',2,server.Prefix,{'slippery','iceskate','icewalk','slide'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr, args[1]:lower())) do
			server.Remote(v,'Function','Effect','slip')
		end
	end)
	
	--[[
	server.MakeCommand('NoClips the target player(s)',2,server.Prefix,{'noclip'},{'player'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do
	server.Remote(v,'Function','Noclip','norm')
	end
	end)]]
	
	server.MakeCommand('Old flying NoClip',2,server.Prefix,{'noclip','flynoclip','oldnolcip'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr, args[1]:lower())) do
			server.Remote(v,'Function','Noclip','fly')
		end
	end)
	
	server.MakeCommand('Un-NoClips the target player(s)',2,server.Prefix,{'clip','unnoclip'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr, args[1]:lower())) do
			server.Remote(v,'Function','Noclip','off')
		end
	end)
	
	server.MakeCommand('Jails the target player(s), removing their tools until they are un-jailed',2,server.Prefix,{'jail','imprison'},{'player'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr, args[1]:lower())) do
	cPcall(function()
	if v.Character and v.Character:FindFirstChild("Torso") then 
	local cf = v.Character.Torso.CFrame + Vector3.new(0,1,0)
	local origpos = v.Character.Torso.Position
	local mod = Instance.new("Model", game.Workspace) mod.Name = v.Name .. " nBD Jail" table.insert(server.objects, mod) 
	local value = Instance.new('StringValue',mod) value.Name='Player' value.Value=v.Name
	local top = Instance.new("Part", mod) top.Locked = true top.formFactor = "Symmetric" top.Size = Vector3.new(6,1,6) top.TopSurface = 0 top.BottomSurface = 0 top.Anchored = true top.BrickColor = BrickColor.new("Really black") top.CFrame = cf * CFrame.new(0,-3.5,0)
	server.JailedTools[v.Name]=Instance.new('Model') 
	local bottom = top:Clone() bottom.Transparency = 1 bottom.Parent = mod bottom.CFrame = cf * CFrame.new(0,3.5,0)
	local front = top:Clone() front.Transparency = 1 front.Reflectance = 0 front.Parent = mod front.Size = Vector3.new(6,6,1) front.CFrame = cf * CFrame.new(0,0,-3)
	local back = front:Clone() back.Transparency = 1 back.Parent = mod back.CFrame = cf * CFrame.new(0,0,3)
	local right = front:Clone() right.Transparency = 1 right.Parent = mod right.Size = Vector3.new(1,6,6) right.CFrame = cf * CFrame.new(3,0,0)
	local left = right:Clone() left.Transparency = 1 left.Parent = mod left.CFrame = cf * CFrame.new(-3,0,0)
	local msh = Instance.new("BlockMesh", front) msh.Scale = Vector3.new(1,1,0)
	local msh2 = msh:Clone() msh2.Parent = back
	local msh3 = msh:Clone() msh3.Parent = right msh3.Scale = Vector3.new(0,1,1)
	local msh4 = msh3:Clone() msh4.Parent = left
	local brick = Instance.new('Part',mod)
	local box = Instance.new('SelectionBox',brick)
	box.Adornee=brick
	box.Color=BrickColor.new('White')
	brick.Anchored=true
	brick.CanCollide=false
	brick.Transparency=1
	brick.Size=Vector3.new(5,7,5) 
	brick.CFrame=cf
	v.Character.Torso.CFrame = cf
	for l,k in pairs(v.Backpack:children()) do 
		if k and k.ClassName=='Tool' or k.ClassName=='HopperBin' then 
			k.Parent=server.JailedTools[v.Name]
		end 
	end
	cPcall(function()
	repeat
		local player=service.Players:FindFirstChild(v.Name)
		if not player then return end
		local torso=player.Character:FindFirstChild('Torso')
		if not torso then return end
		if not server.JailedTools[v.Name] or server.JailedTools[v.Name]==nil then server.JailedTools[v.Name]=Instance.new('Model') end
		for l,k in pairs(player.Backpack:children()) do 
			if k and k.ClassName=='Tool' or k.ClassName=='HopperBin' then 
				k.Parent=server.JailedTools[v.Name]--tools 
			end 
		end 
		if (torso.Position-origpos).magnitude>5 then
			torso.CFrame = cf 
		end
		wait()
	until not mod or not mod.Parent or server.JailedTools[v.Name]==nil
	end)
	end
	end)
	end
	end)
	
	server.MakeCommand('UnJails the target player(s) and returns any tools that were taken from them while jailed',2,server.Prefix,{'unjail','free','release'},{'player'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do 
		cPcall(function() 
			if v then 
				for a, jl in pairs(game.Workspace:children()) do 
					if jl.Name == v.Name .. " nBD Jail" then 
						jl:Destroy() 
					end 
				end 
			if server.JailedTools[v.Name] then
				for j,tewl in pairs(server.JailedTools[v.Name]:children()) do 
					if tewl then
						tewl.Parent=v.Backpack 
					end
				end
				server.JailedTools[v.Name]=nil
			end
			server.JailedTools[v.Name]=nil 
			end
		end)
	end
	end)
	
	server.MakeCommand('Gives the target player(s) a little chat gui, when used will let them chat using dialog bubbles',2,server.Prefix,{'bchat','dchat','bubblechat','dialogchat'},{'player','color(red/green/blue)'},function(plr,args)
		local color=Enum.ChatColor.Red
		if not args[2] then
			color=Enum.ChatColor.Red
		elseif args[2]:lower()=='red' then
			color=Enum.ChatColor.Red
		elseif args[2]:lower()=='green' then
			color=Enum.ChatColor.Green
		elseif args[2]:lower()=='blue' then
			color=Enum.ChatColor.Blue
		end
		for i,v in pairs(server.GetPlayers(plr,(args[1] or plr.Name))) do
			server.Remote(v,"Function","BubbleChat",color)
		end
	end)
	
	server.MakeCommand('Shows you where the target player(s) is/are',2,server.Prefix,{'track','trace','find'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(plr,'Function','Find','on',v)
		end
	end)
	
	server.MakeCommand('Stops tracking the target player(s)',2,server.Prefix,{'untrack','untrace','unfind'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(plr,'Function','Find','off',v)
		end
	end)
	
	server.MakeCommand('Makes the target player(s)\'s character teleport back and forth rapidly, quite trippy, makes bricks appear to move as the player turns their character',-1,server.Prefix,{'glitch','glitchdisorient','glitch1','gd'},{'player','intensity'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			local num=args[2] or 15
			server.Remote(v,'Function','Glitch','trippy',num)
		end
	end)
	
	server.MakeCommand('The same as gd but less trippy, teleports the target player(s) back and forth in the same direction, making two ghost like images of the game',-1,server.Prefix,{'glitch2','glitchghost','gg'},{'player','intensity'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			local num=args[2] or 150
			server.Remote(v,'Function','Glitch','ghost',num)
		end
	end)
	
	server.MakeCommand('Kinda like gd, but teleports the player to four points instead of two',-1,server.Prefix,{'vibrate','glitchvibrate','gv'},{'player','intensity'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			local num=args[2] or 0.1
			server.Remote(v,'Function','Glitch','vibrate',num)
		end
	end)
	
	server.MakeCommand('UnGlitchs the target player(s)',-1,server.Prefix,{'unglitch','unglitchghost','ungd','ungg','ungv','unvibrate'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			server.Remote(v,'Function','Glitch','off')
		end
	end)
	
	server.MakeCommand('Shows you the current message of the day',0,server.AnyPrefix,{'motd','messageoftheday','daymessage'},{},function(plr,args)
		server.PM('Message of the Day',plr,service.MarketPlace:GetProductInfo(server.MessageOfTheDayID).Description)
	end)
	
	server.MakeCommand('Makes a clone of target player(s)\'s character and parents their real on to their local camera, no one can see them until they are unphased',2,server.Prefix,{'phase'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			cPcall(function()
				for k,m in pairs(service.Workspace:children()) do if m.Name==v.Name and m:FindFirstChild('FakeCharPhased') then m:ClearAllChildren() print(m.Parent.Name) m:Destroy() end end
				server.Remote(v,'Function','Phase',false)
				wait(server.Ping(v)+0.3)
				for a,obj in pairs(v.Character:children()) do if obj.Name~='HumanoidRootPart' then if obj:IsA("BasePart") then obj.Transparency = 0 if obj:findFirstChild("face") then obj.face.Transparency = 0 end elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Transparency = 0 end end end
				v.Character.Archivable=true
				local hum=v.Character:FindFirstChild('Humanoid')
				local cl=v.Character:clone()
				v.Character.Archivable=false
				pcall(function() cl.Animate:Destroy() end)
				local anim=deps.Animate:clone()
				anim.Parent=cl
				anim.Disabled=false
				local val=Instance.new('StringValue',cl)
				val.Name='FakeCharPhased'
				cl.Parent=service.Workspace
				v.Character.Torso.CFrame=v.Character.Torso.CFrame*CFrame.new(0,0,1)
				for a,obj in pairs(v.Character:children()) do if obj:IsA("BasePart") then obj.Transparency = 1 if obj:findFirstChild("face") then obj.face.Transparency = 1 end elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Transparency = 1 end end
				server.Remote(v,'Function','Phase',true)
				repeat wait() until not hum or not hum.Parent or not cl or not cl.Parent
				if cl then cl:Destroy() end
			end)
		end
	end)
	
	server.MakeCommand('UnPhases the target player(s)',2,server.Prefix,{'unphase'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			cPcall(function()
				for k,m in pairs(service.Workspace:children()) do if m.Name==v.Name and m:FindFirstChild('FakeCharPhased') then m:ClearAllChildren() m:Destroy() end end
				server.Remote(v,'Function','Phase',false)
				v.Character:MakeJoints()
				wait(server.Ping(v)+0.3)
				v.Character:MakeJoints()
				print(v.Character.Humanoid.Health)
				for a,obj in pairs(v.Character:children()) do if obj.Name~='HumanoidRootPart' then if obj:IsA("BasePart") then obj.Transparency = 0 if obj:findFirstChild("face") then obj.face.Transparency = 0 end elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Transparency = 0 end end end
			end)
		end
	end)
	
	server.MakeCommand('Removes the bubble chat gui from the target player(s)',2,server.Prefix,{'unbchat','unbubblechat','undchat','undialogchat'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,(args[1] or plr.Name))) do
			server.Remote(v,'Function','BubbleChat','off')
		end
	end)
	
	server.MakeCommand('Gives the target player(s) tools that are in the game\'s StarterPack',2,server.Prefix,{'startertools','starttools'},{'player'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do
	coroutine.resume(coroutine.create(function()
	if v and v:findFirstChild("Backpack") then
	for a,q in pairs(game.StarterPack:children()) do local q=q:Clone() if not q:FindFirstChild(server.CodeName..q.Name) then Instance.new("StringValue",q).Name=server.CodeName..q.Name end q.Parent = v.Backpack end
	end
	end))
	end
	end)
	
	server.MakeCommand('Gives the target player(s) a sword',2,server.Prefix,{'sword','givesword'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr, args[1])) do
			cPcall(function()
				if v and v:findFirstChild("Backpack") then
				local sword = Instance.new("Tool") 
				sword.Name = "Sword"  
				Instance.new("StringValue",sword).Name=server.CodeName..sword.Name
				sword.Parent=v.Backpack
				sword.TextureId = "rbxasset://Textures/Sword128.png"
				sword.GripForward = Vector3.new(-1,0,0)
				sword.GripPos = Vector3.new(0,0,-1.5)
				sword.GripRight = Vector3.new(0,1,0)
				sword.GripUp = Vector3.new(0,0,1)
				local handle = Instance.new("Part", sword) handle.Name = "Handle" handle.FormFactor = "Plate" handle.Size = Vector3.new(1,.8,4) handle.TopSurface = 0 handle.BottomSurface = 0
				local msh = Instance.new("SpecialMesh", handle) msh.MeshId = "rbxasset://fonts/sword.mesh" msh.TextureId = "rbxasset://textures/SwordTexture.png"
				local cl=deps.SwordScript:clone() cl.Parent=sword cl.Disabled=false
				end
			end)
		end
	end)
	
	server.MakeCommand('Clones the target player(s)',2,server.Prefix,{'clone','cloneplayer'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then 
				v.Character.Archivable = true 
				local cl = v.Character:Clone() 
				table.insert(server.objects,cl) 
				cl.Parent = game.Workspace 
				cl:MoveTo(v.Character:GetModelCFrame().p)
				cl:MakeJoints()
				v.Character.Archivable = false 
				repeat wait() until not cl or not cl.Humanoid or cl.Humanoid.Health<=0
				wait(5)
				if cl then cl:Destroy() end
				end
			end)
		end
	end)
	
	server.MakeCommand('Configurable AIs made for training',2,server.Prefix,{'bot','tbot','trainingbot','bots','robot','robots','dummy','dummys','testdummy','testdummys','dolls','doll'},{'plr','num','walk','attk','swarm','speed','dmg','hp','dist'},function(plr,args)
		local walk=false 
		if args[3] then if args[3]:lower()=='true' or args[3]:lower()=='yes' then walk=true end end
		local attack=false
		if args[4] then if args[4]:lower()=='true' or args[4]:lower()=='yes' then attack=true end end
		local health=args[8] or 100
		local damage=args[7] or 10
		local walkspeed=args[6] or 20
		local dist=args[9] or 100
		local swarm=false
		if args[5] then if args[5]:lower()=='true' or args[5]:lower()=='yes' then swarm=true end end
		local function makedolls(player)
			local num=args[2] or 1
			local pos=player.Character.Torso.CFrame
			num=tonumber(num)
			if num>50 then num=50 end
			for i=1,num do
				cPcall(function()
					player.Character.Archivable = true
					local cl = player.Character:Clone() 
					player.Character.Archivable = false
					table.insert(server.objects,cl)
					local anim=deps.Animate:Clone()
					local brain=deps.BotBrain:Clone()
					anim.Parent=cl 
					brain.Parent=cl
					brain.Damage.Value=damage
					brain.Walk.Value=walk
					brain.Attack.Value=attack
					brain.Swarm.Value=swarm
					brain.Distance.Value=dist
					brain.Commander.Value=plr.Name
					cl.Parent = game.Workspace 
					cl.Name=player.Name.." Bot"
					if cl:FindFirstChild('Animate') then cl.Animate:Destroy() end
					cl.Humanoid.MaxHealth=health
					wait()
					cl.Humanoid.Health=health
					cl.Torso.CFrame=pos*CFrame.Angles(0,math.rad(360/num*i),0)*CFrame.new(5+.2*num,0,0)
					cl:MakeJoints()
					cl.Humanoid.WalkSpeed=walkspeed
					cl.Archivable=false
					for k,f in pairs(cl:children()) do if f.ClassName=='ForceField' then f:Destroy() end end
					anim.Disabled=false
					brain.Disabled=false
				end)
			end
		end
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			makedolls(v)
		end
	end)
	
	server.MakeCommand('Makes the target drink bleach.',-1,server.Prefix,{'bleach','drinkbleach','godrinkbleach'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local tool = Instance.new("Tool",v.Backpack)
				local handle = Instance.new("Part",tool)
				local mesh = Instance.new("SpecialMesh",handle)
				mesh.MeshType="FileMesh"
				mesh.MeshId="http://www.roblox.com/asset/?id=13116112"
				mesh.TextureId="http://www.roblox.com/asset/?id=13116132"
				mesh.Scale=Vector3.new(0.4, 0.4, 0.4)
				handle.Name="Handle"
				handle.Size=Vector3.new(1, 1.6, 1)
				tool.GripForward=Vector3.new(-0.976, 0, -0.217)
				tool.GripPos=Vector3.new(0, -0.4, 0)
				tool.GripRight=Vector3.new(0.217, 0, -0.976)
				tool.GripUp=Vector3.new(0, 1, 0)
				tool.ToolTip="Go drink bleach"
				tool.Name="Bleach"
				tool.CanBeDropped=false
				tool.Enabled=true
				tool.ManualActivationOnly=true
				tool.Parent=v.Character
				server.Remote(v,"Function","LoadAnimation",29517689)
				wait(1)
				tool:Destroy()
				for k,m in pairs(v.Character:children()) do
					if m:IsA("Part") then
						m.BrickColor=BrickColor.new("Institutional white")
					end
				end
				wait(5)
				cPcall(function()
					server.RunCommand(server.Prefix.."spin",v.Name)
					server.RunCommand(server.Prefix.."seizure",v.Name)
				end)
				while v.Character.Humanoid.Health>0 do
					v.Character.Humanoid:TakeDamage(1)
					wait(0.1)
				end
			end)
		end
	end)
	
	server.MakeCommand('Gives you a tool that lets you click where you want the target player to stand, hold r to rotate them',2,server.Prefix,{'clickteleport','teleporttoclick','ct','clicktp','forceteleport','ctp','ctt'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
		cPcall(function()
			local tool=Instance.new('HopperBin')
			Instance.new("StringValue",tool).Name=server.CodeName.."ctp"
			local cl=deps.ClickToTool:clone()
			cl.Target.Value=v.Name
			cl.Mode.Value='Teleport'
			cl.Parent=tool
			tool.Parent=plr.Backpack
			cl.Disabled=false
		end)
	end
	end)
	
	server.MakeCommand('Gives you a tool that lets you click where you want the target player to walk, hold r to rotate them',2,server.Prefix,{'clickwalk','cw','ctw','forcewalk','walktool','walktoclick','clickcontrol','forcewalk'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local tool=Instance.new('HopperBin')
				Instance.new("StringValue",tool).Name=server.CodeName.."ctw"
				local cl=deps.ClickToTool:clone()
				cl.Target.Value=v.Name
				cl.Mode.Value='Walk'
				cl.Parent=tool
				tool.Parent=plr.Backpack
				cl.Disabled=false
			end)
		end
	end)
	
	server.MakeCommand('Swaps player1\'s and player2\'s bodies and tools',2,server.Prefix,{'bodyswap','bodysteal','bswap'},{'player1','player2'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
		for i2,v2 in pairs(server.GetPlayers(plr,args[2])) do
			local temptools=Instance.new('Model')
			local tempcloths=Instance.new('Model')
			local vpos=v.Character.Torso.CFrame
			local v2pos=v2.Character.Torso.CFrame
			local vface=v.Character.Head.face
			local v2face=v2.Character.Head.face
			vface.Parent=v2.Character.Head
			v2face.Parent=v.Character.Head
			for k,p in pairs(v.Character:children()) do
				if p:IsA('BodyColors') or p:IsA('CharacterMesh') or p:IsA('Pants') or p:IsA('Shirt') or p:IsA('Hat') then
					p.Parent=tempcloths
				elseif p:IsA('Tool') then
					p.Parent=temptools
				end
			end	
			for k,p in pairs(v.Backpack:children()) do
				p.Parent=temptools
			end
			for k,p in pairs(v2.Character:children()) do
				if p:IsA('BodyColors') or p:IsA('CharacterMesh') or p:IsA('Pants') or p:IsA('Shirt') or p:IsA('Hat') then
					p.Parent=v.Character
				elseif p:IsA('Tool') then
					p.Parent=v.Backpack
				end
			end	
			for k,p in pairs(tempcloths:children()) do
				p.Parent=v2.Character
			end	
			for k,p in pairs(v2.Backpack:children()) do
				p.Parent=v.Backpack
			end
			for k,p in pairs(temptools:children()) do
				p.Parent=v2.Backpack
			end
			v2.Character.Torso.CFrame=vpos
			v.Character.Torso.CFrame=v2pos
		end
		end 
	end)
	
	server.MakeCommand('Lets you take control of the target player',2,server.Prefix,{'control','takeover'},{'player'},function(plr,args)
	local plrz = server.GetPlayers(plr, args[1]:lower())
	for i, v in pairs(plrz) do
	cPcall(function()
	if v and v.Character then
	v.Character.Humanoid.PlatformStand = true
	local w = Instance.new("Weld", plr.Character.Torso ) 
	w.Part0 = plr.Character.Torso 
	w.Part1 = v.Character.Torso  
	local w2 = Instance.new("Weld", plr.Character.Head) 
	w2.Part0 = plr.Character.Head 
	w2.Part1 = v.Character.Head  
	local w3 = Instance.new("Weld", plr.Character:findFirstChild("Right Arm")) 
	w3.Part0 = plr.Character:findFirstChild("Right Arm")
	w3.Part1 = v.Character:findFirstChild("Right Arm") 
	local w4 = Instance.new("Weld", plr.Character:findFirstChild("Left Arm"))
	w4.Part0 = plr.Character:findFirstChild("Left Arm")
	w4.Part1 = v.Character:findFirstChild("Left Arm") 
	local w5 = Instance.new("Weld", plr.Character:findFirstChild("Right Leg")) 
	w5.Part0 = plr.Character:findFirstChild("Right Leg")
	w5.Part1 = v.Character:findFirstChild("Right Leg") 
	local w6 = Instance.new("Weld", plr.Character:findFirstChild("Left Leg")) 
	w6.Part0 = plr.Character:findFirstChild("Left Leg")
	w6.Part1 = v.Character:findFirstChild("Left Leg") 
	plr.Character.Head.face:Destroy()
	for i, p in pairs(v.Character:children()) do
	if p:IsA("BasePart") then 
	p.CanCollide = false
	end
	end
	for i, p in pairs(plr.Character:children()) do
	if p:IsA("BasePart") then 
	p.Transparency = 1 
	elseif p:IsA("Hat") then
	p:Destroy()
	end
	end
	v.Character.Parent = plr.Character
	--v.Character.Humanoid.Changed:connect(function() v.Character.Humanoid.PlatformStand = true end)
	end
	end)
	end
	end)
	
	server.MakeCommand('Refreshes the target player(s)\'s character',2,server.Prefix,{'refresh','reset'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			local pos=v.Character.Torso.CFrame
			local temptools={}
			pcall(function() v.Character.Humanoid:UnequipTools() end)
			wait()
			for k,t in pairs(v.Backpack:children()) do
				if t:IsA('Tool') or t:IsA('HopperBin') then
					table.insert(temptools,t)
				end
			end
			v:LoadCharacter()
			v.Character.Torso.CFrame=pos
			for d,f in pairs(v.Character:children()) do
				if f:IsA('ForceField') then f:Destroy() end
			end
			v:WaitForChild("Backpack")
			v.Backpack:ClearAllChildren()
			for l,m in pairs(temptools) do
				m:clone().Parent=v.Backpack
			end
		end
	end)
	
	server.MakeCommand('Kills the target player(s)',2,server.Prefix,{'kill'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				v.Character:BreakJoints()
			end)
		end
	end)
	
	server.MakeCommand('Repsawns the target player(s)',2,server.Prefix,{'respawn'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then v:LoadCharacter()
					server.Remote(v,'Function','SetView','reset')
				end
			end)
		end
	end)
	
	server.MakeCommand('Rotates the target player(s) by 180 degrees or the angle you server',2,server.Prefix,{'trip'},{'player','angle'},function(plr,args)
		local angle=180 or args[2]
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Torso") then 
					v.Character.Torso.CFrame = v.Character.Torso.CFrame * CFrame.Angles(0,0,math.rad(angle)) 
				end
			end)
		end
	end)
	
	server.MakeCommand('Stuns the target player(s)',2,server.Prefix,{'stun'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:FindFirstChild("Humanoid") then 
					v.Character.Humanoid.PlatformStand = true
				end
			end)
		end
	end)
	
	server.MakeCommand('UnStuns the target player(s)',2,server.Prefix,{'unstun'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:FindFirstChild("Humanoid") then 
					v.Character.Humanoid.PlatformStand = false
				end
			end)
		end
	end)
	
	server.MakeCommand('Forces the target player(s) to jump',2,server.Prefix,{'jump'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.Jump = true
				end
			end)
		end
	end)
	
	server.MakeCommand('Forces the target player(s) to sit',2,server.Prefix,{'sit','seat'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.Sit = true
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) invisible',2,server.Prefix,{'invisible'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") then obj.Transparency = 1 if obj:findFirstChild("face") then obj.face.Transparency = 1 end elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Transparency = 1 end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) visible',2,server.Prefix,{'visible'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") and obj.Name~='HumanoidRootPart' then obj.Transparency = 0 if obj:findFirstChild("face") then obj.face.Transparency = 0 end elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Transparency = 0 end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Locks the target player(s)',2,server.Prefix,{'lock'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") then obj.Locked = true elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Locked = true end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('UnLocks the the target player(s), makes it so you can use btools on them',2,server.Prefix,{'unlock'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") then obj.Locked = false elseif obj:IsA("Hat") and obj:findFirstChild("Handle") then obj.Handle.Locked = false end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Explodes the target player(s)',2,server.Prefix,{'explode','boom','boomboom'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Torso") then 
				local ex = Instance.new("Explosion", game.Workspace) 
				ex.Position = v.Character.Torso.Position
				ex.BlastRadius=20
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes a PointLight on the target player(s) with the color specified',2,server.Prefix,{'light'},{'player','color'},function(plr,args)
		local str = BrickColor.new('Bright blue').Color
		if args[2] then
		local teststr = args[2]
		if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr).Color end
		end
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
					local p=Instance.new('PointLight',v.Character.Torso)
					table.insert(server.objects,p)
					p.Color=str
					p.Brightness=5
					p.Range=15
				end
			end)
		end
	end)
	
	server.MakeCommand('UnLights the target plyer(s)',2,server.Prefix,{'unlight'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then 
					for z, cl in pairs(v.Character.Torso:children()) do 
						if cl:IsA('PointLight') then cl:Destroy() end 
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes a dialog bubble appear over the target player(s) head with the desired message',-1,server.Prefix,{'talk','maketalk'},{'player','message'},function(plr,args)
		local message = args[2]
		for i,p in pairs(server.GetPlayers(plr, args[1])) do
			cPcall(function()
				service.ChatService:Chat(p.Character.Head,message,Enum.ChatColor.Blue)
			end)
		end
	end)
	
	server.MakeCommand('Sets the target player(s) on fire, coloring the fire based on what you server',-1,server.Prefix,{'fire','makefire','givefire'},{'player','color'},function(plr,args)
		local str = BrickColor.new('Bright orange').Color
		if args[2] then
			local teststr = args[2]
			if BrickColor.new(teststr) ~= nil then 
				str = BrickColor.new(teststr).Color 
			end
		end
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
					local f=Instance.new('Fire',v.Character.Torso)
					local p=Instance.new('PointLight',v.Character.Torso)
					table.insert(server.objects,f)
					table.insert(server.objects,p)
					p.Color=str
					p.Brightness=5
					p.Range=15
					f.Color=str
					f.SecondaryColor=str
				end
			end)
		end
	end)
	
	server.MakeCommand('Puts out the flames on the target player(s)',-1,server.Prefix,{'unfire','removefire','extinguish'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then 
					for z, cl in pairs(v.Character.Torso:children()) do if cl:IsA("Fire") or cl:IsA('PointLight') then cl:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes smoke come from the target player(s) with the desired color',-1,server.Prefix,{'smoke','givesmoke'},{'player','color'},function(plr,args)
		local str = BrickColor.new('Bright orange').Color
		if args[2] then
			local teststr = args[2]
			if BrickColor.new(teststr) ~= nil then 
				str = BrickColor.new(teststr).Color 
			end
		end
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
					local cl = Instance.new("Smoke", v.Character.Torso) 
					table.insert(server.objects, cl)
					cl.Color=str
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes smoke from the target player(s)',-1,server.Prefix,{'unsmoke'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then 
					for z, cl in pairs(v.Character.Torso:children()) do if cl:IsA("Smoke") then cl:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Puts sparkles on the target player(s) with the desired color',-1,server.Prefix,{'sparkles'},{'player','color'},function(plr,args)
		local str = BrickColor.new('Bright blue').Color
		if args[2] then
			local teststr = args[2]
			if BrickColor.new(teststr) ~= nil then 
				str = BrickColor.new(teststr).Color 
			end
		end
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
					local cl = Instance.new("Sparkles", v.Character.Torso) table.insert(server.objects, cl)
					local p=Instance.new('PointLight',v.Character.Torso) table.insert(server.objects, p)
					p.Color=str
					p.Brightness=5
					p.Range=15
					cl.SparkleColor=str
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes sparkles from the target player(s)',-1,server.Prefix,{'unsparkles'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Torso") then 
					for z,cl in pairs(v.Character.Torso:children()) do if cl:IsA("Sparkles") or cl:IsA('PointLight') then cl:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Gives a force field to the target player(s)',2,server.Prefix,{'ff','forcefield'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then Instance.new("ForceField", v.Character) end
			end)
		end
	end)
	
	server.MakeCommand("FFs, Gods, Names, Freezes, and removes the target player's tools until they jump.",2,server.Prefix,{'afk'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local ff=Instance.new("ForceField",v.Character)
				local hum=v.Character.Humanoid
				local orig=hum.MaxHealth
				local tools=Instance.new("Model")
				hum.MaxHealth=math.huge
				wait()
				hum.Health=hum.MaxHealth
				for k,t in pairs(v.Backpack:children()) do
					t.Parent=tools
				end
				server.RunCommand(server.Prefix.."name",v.Name,"-AFK-_"..v.Name.."_-AFK-")
				local torso=v.Character.Torso
				local pos=torso.CFrame
				local running=true
				local event
				event=v.Character.Humanoid.Jumping:connect(function()
					running=false
					ff:Destroy()
					hum.Health=orig
					hum.MaxHealth=orig
					for k,t in pairs(tools:children()) do
						t.Parent=v.Backpack
					end
					server.RunCommand(server.Prefix.."unname",v.Name)
					event:disconnect()
				end)
				repeat torso.CFrame=pos wait() until not v or not v.Character or not torso or not running or not torso.Parent
			end)
		end
	end)
	
	server.MakeCommand('Removes force fields on the target player(s)',2,server.Prefix,{'unff','unforcefield'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function() 
				if v.Character then 
					for z, cl in pairs(v.Character:children()) do if cl:IsA("ForceField") then cl:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes the target player(s)\'s character',2,server.Prefix,{'punish'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then 
					v.Character.Parent = server.Storage
				end
			end)
		end
	end)
	
	server.MakeCommand('Gives the target player(s) hat pets, controled using the !pets command.',-1,server.Prefix,{'hatpets'},{'player','number[50 MAX]/destroy'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if args[2] and args[2]:lower()=='destroy' then
					local hats=v.Character:FindFirstChild('nBDHatPets')
					if hats then hats:Destroy() end
				else
					local num=tonumber(args[2]) or 5
					if num>50 then num=50 end
					if v.Character:FindFirstChild('Torso') then
						local m=v.Character:FindFirstChild('nBDHatPets')
						local mode
						local obj
						local hat
						if not m then
							m=Instance.new('Model',v.Character)
							m.Name='nBDHatPets'
							table.insert(server.objects,m)
							mode=Instance.new('StringValue',m)
							mode.Name='Mode'
							mode.Value='Follow'
							obj=Instance.new('ObjectValue',m)
							obj.Name='Target'
							obj.Value=v.Character.Torso
						else
							mode=m.Mode
							obj=m.Target
						end
						for l,h in pairs(v.Character:children()) do if h:IsA('Hat') then hat=h break end end
						if hat then
							for k=1,num do
								local cl=hat.Handle:clone()
								cl.Name=k
								cl.CanCollide=false
								cl.Anchored=false
								cl.Parent=m
								local bpos=Instance.new("BodyPosition",cl)
								bpos.Name='bpos'
								bpos.position=obj.Value.Position
								bpos.maxForce = bpos.maxForce * 10
							end
						end
						server.Remote(v,'Function','MoveHats')
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('[NEED HAT PETS TO USE] Makes your hat pets do the specified command (follow/float/swarm/attack)',2,server.AnyPrefix,{'pets'},{'follow/float/swarm/attack','player'},function(plr,args)
		local hats=plr.Character:FindFirstChild('nBDHatPets')
		if hats then
			for i,v in pairs(server.GetPlayers(plr,args[2])) do
				if v.Character:FindFirstChild('Torso') and v.Character.Torso:IsA('Part') then
					if args[1]:lower()=='follow' then
						hats.Mode.Value='Follow'
						hats.Target.Value=v.Character.Torso
					elseif args[1]:lower()=='float' then
						hats.Mode.Value='Float'
						hats.Target.Value=v.Character.Torso
					elseif args[1]:lower()=='swarm' then
						hats.Mode.Value='Swarm'
						hats.Target.Value=v.Character.Torso
					elseif args[1]:lower()=='attack' then
						hats.Mode.Value='Attack'
						hats.Target.Value=v.Character.Torso
					end
				end
			end
		else
			server.Remote(plr,'Function','OutputGui',"You don't have any hat pets! If you are an admin use the :hatpets command to get some")
		end
	end)
	
	server.MakeCommand('UnPunishes the target player(s)',2,server.Prefix,{'unpunish'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			v.Character.Parent = service.Workspace v.Character:MakeJoints()
		end
	end)
	
	server.MakeCommand('Freezes the target player(s)',2,server.Prefix,{'freeze'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Humanoid") then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") then obj.Anchored = true end v.Character.Humanoid.WalkSpeed = 0
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('UnFreezes the target players, thaws them out',2,server.Prefix,{'thaw','unfreeze'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Humanoid") then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") then obj.Anchored = false end v.Character.Humanoid.WalkSpeed = 16
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Heals the target player(s) (Regens their health)',2,server.Prefix,{'heal'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) immortal, makes their health so high that normal non-explosive weapons can\'t kill them',2,server.Prefix,{'god','immortal'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.MaxHealth = math.huge
					v.Character.Humanoid.Health = 9e9
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) mortal again',2,server.Prefix,{'ungod','mortal'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.MaxHealth = 100
					v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
				end
			end)
		end
	end)
	
	server.MakeCommand('Change Ambient',2,server.Prefix,{'ambient'},{'num','num','num'},function(plr,args)
		service.Lighting.Ambient = Color3.new(args[1],args[2],args[3])
	end)
	
	server.MakeCommand('Change OutdoorAmbient',2,server.Prefix,{'oambient','outdoorambient'},{'num','num','num'},function(plr,args)
		service.Lighting.OutdoorAmbient = Color3.new(args[1],args[2],args[3])
	end)
	
	server.MakeCommand('Fog Off',2,server.Prefix,{'nofog','fogoff'},{},function(plr,args)
		service.Lighting.FogEnd=1000000000000
	end)
	
	server.MakeCommand('Determines if shadows are on or off',2,server.Prefix,{'shadows'},{'on/off'},function(plr,args)
		if args[1]:lower()=='on' then
			service.Lighting.GlobalShadows=true
		elseif args[1]:lower()=='off' then
			service.Lighting.GlobalShadows=false
		end
	end)
	
	server.MakeCommand('Determines if outlines are on or off',2,server.Prefix,{'outlines'},{'on/off'},function(plr,args)
		if args[1]:lower()=='on' then
			service.Lighting.Outlines=true
		elseif args[1]:lower()=='off' then
			service.Lighting.Outlines=false
		end
	end)
	
	server.MakeCommand('Repeats <command> for <amount> of times every <interval> seconds. Amount cannot exceed 50.',2,server.Prefix,{'repeat','loop'},{'amount','interval','command'},function(plr,args)
		local amount = tonumber(args[1])
		local timer = tonumber(args[2])
		if timer<=0 then timer=0.1 end
		if amount>50 then amount=50 end
		local command = args[3]:lower()
		local name=plr.Name:lower()
		server.CommandLoops[name..command]=true
		server.Hint("Running "..command.." "..amount.." times every "..timer.." seconds.",{plr})
		for i=1,amount do
			if not server.CommandLoops[name..command] then break end
			server.ProcessCommand(plr,command,true)
			wait(timer)
		end
		server.CommandLoops[name..command]=nil
	end)
	
	server.MakeCommand("Aborts a looped command. Must supply name of player who started the loop or \"me\" if it was you, or \"all\" for all loops. Caps not required. :abort sceleratis :kill bob or :abort all",2,server.Prefix,{"abort","stoploop","unloop","unrepeat"},{"username","command"},function(plr,args)
		local name=args[1]:lower()
		if name=="me" then
			server.CommandLoops[plr.Name:lower()..args[2]]=nil
		elseif name=="all" then
			for i,v in pairs(server.CommandLoops) do
				server.CommandLoops[i]=nil
			end
		elseif args[2] then
			server.CommandLoops[name..args[2]]=nil
		end
	end)
	
	server.MakeCommand('Change Brightness',2,server.Prefix,{'brightness'},{'number'},function(plr,args)
		service.Lighting.Brightness =args[1]
	end)
	
	server.MakeCommand('Change Time',2,server.Prefix,{'time','timeofday'},{'time'},function(plr,args)
		service.Lighting.TimeOfDay = args[1]
	end)
	
	server.MakeCommand('Fog Color',2,server.Prefix,{'fogcolor'},{'num','num','num'},function(plr,args)
		service.Lighting.FogColor = Color3.new(args[1],args[2],args[3])
	end)
	
	server.MakeCommand('Fog Start/End',2,server.Prefix,{'fog'},{'start','end'},function(plr,args)
		service.Lighting.FogEnd = args[2]
		service.Lighting.FogStart = args[1]
	end)
	
	server.MakeCommand('Gives the target player(s) basic building tools and the F3X tool',3,server.Prefix,{'btools','buildtools','buildingtools','buildertools'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("Backpack") then 
					local t1 = Instance.new("HopperBin") 
					t1.Name = "Move" 
					t1.BinType = "GameTool"
					local t2 = Instance.new("HopperBin") 
					t2.Name = "Clone"
					t2.BinType = "Clone"
					local t3 = Instance.new("HopperBin") 
					t3.Name = "Delete"
					t3.BinType = "Hammer"
					local t4 = Instance.new("HopperBin") 
					t4.Name = "Resize"
					local cl=deps.ResizeScript:clone()
					cl.Parent=t4
					cl.Disabled=false
					Instance.new("StringValue",t1).Name=server.CodeName..t1.Name
					Instance.new("StringValue",t2).Name=server.CodeName..t2.Name
					Instance.new("StringValue",t3).Name=server.CodeName..t3.Name
					Instance.new("StringValue",t4).Name=server.CodeName..t4.Name
					t1.Parent=v.Backpack
					t2.Parent=v.Backpack
					t3.Parent=v.Backpack
					t4.Parent=v.Backpack
					
					local f3x = Instance.new("Tool")
					for k,m in pairs(deps['F3X Deps']:children()) do
						m:Clone().Parent = f3x
					end
					f3x.CanBeDropped = false
					f3x.ToolTip = "Building Tools by F3X"
					f3x.ManualActivationOnly = false
					f3x.Name='F3X'
					local handle = Instance.new("Part",f3x)
					handle.Name = "Handle"
					handle.FormFactor = "Custom"
					handle.Size = Vector3.new(.8,.8,.8) --Don't be 'lazy', and set the size, come on..
					handle.TopSurface="Smooth"
					handle.BottomSurface="Smooth"
					handle.CanCollide = false
					handle.Locked = true
					handle.Position=Vector3.new(0,999999,0)
					handle.BrickColor = BrickColor.new("Really black")
					f3x.Parent=v.Backpack
					f3x['gloo by Anaminus'].Disabled = false
					f3x.ExportInterface.ExportInterfaceScript.Disabled = false
					f3x.HttpInterface.HttpInterfaceScript.Disabled = false
					f3x['Building Tools by F3X'].Disabled = false
					f3x.ToolTip = "Building Tools by F3X"
					for a=0,5 do --You forgot all about decals! You rude script creator!
						local decal=Instance.new("Decal",handle)
						decal.Face=a
						decal.Texture="rbxassetid://129748355"
					end
					Instance.new("StringValue",f3x).Name=server.CodeName..f3x.Name
				end
			end)
		end
	end)
	
	server.MakeCommand('Gives the target player(s) the F3X tool',3,server.Prefix,{'f3x','fex','f3xtool','fextool'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("Backpack") then 
					local f3x = Instance.new("Tool")
					for k,m in pairs(deps['F3X Deps']:children()) do
						m:Clone().Parent = f3x
					end
					f3x.CanBeDropped = false
					f3x.ToolTip = "Building Tools by F3X"
					f3x.ManualActivationOnly = false
					f3x.Name='F3X'
					local handle = Instance.new("Part",f3x)
					handle.Name = "Handle"
					handle.FormFactor = "Custom"
					handle.Size = Vector3.new(.8,.8,.8) --Don't be 'lazy', and set the size, come on..
					handle.TopSurface="Smooth"
					handle.BottomSurface="Smooth"
					handle.CanCollide = false
					handle.Locked = true
					handle.Position=Vector3.new(0,999999,0)
					handle.BrickColor = BrickColor.new("Really black")
					f3x.Parent=v.Backpack
					f3x['gloo by Anaminus'].Disabled = false
					f3x.ExportInterface.ExportInterfaceScript.Disabled = false
					f3x.HttpInterface.HttpInterfaceScript.Disabled = false
					f3x['Building Tools by F3X'].Disabled = false
					f3x.ToolTip = "Building Tools by F3X"
					for a=0,5 do --You forgot all about decals! You rude script creator!
						local decal=Instance.new("Decal",handle)
						decal.Face=a
						decal.Texture="rbxassetid://129748355"
					end
					Instance.new("StringValue",f3x).Name=server.CodeName..f3x.Name
				end
			end)
		end
	end)
	
	server.MakeCommand('Opens the imbedded nBD AntiVirus Tool',4,server.Prefix,{'antivirus'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("Backpack") then 
					local s=deps['nBDScanner']:Clone()
					s.Parent=v.Backpack
					s.nBDScan.Disabled=false
				end
			end)
		end
	end)
	
	server.MakeCommand('Gives the target player(s) PBS tools and TMD.',3,server.Prefix,{'pbstools'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("Backpack") then 
					server.Hint('Receiving PBS tools.',{v}) 
					local BuildTools = {73089166, 73089190, 73089204, 73089214, 73089239, 73089259, 58921588}
					for _,Tool in next,BuildTools do
						local ToolObject = game:GetService("InsertService"):LoadAsset(Tool)
						local tool=ToolObject:GetChildren()[1]
						tool.Parent = v.Backpack
						Instance.new("StringValue",tool).Name=server.CodeName..ToolObject.Name
					end
					local tmd=deps.TMD.TMD:Clone()
					tmd.Parent = v.Backpack
					Instance.new("StringValue",tmd).Name=server.CodeName..tmd.Name
				end
			end)
		end
	end)
	
	server.MakeCommand('Places the desired tool into the target player(s)\'s StarterPack',2,server.Prefix,{'startergive'},{'player','toolname'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v:findFirstChild("StarterGear") then 
					for a, tool in pairs(server.Storage:children()) do
						if tool:IsA("Tool") or tool:IsA("HopperBin") then
							if args[2]:lower() == "all" or tool.Name:lower():find(args[2]:lower()) == 1 then 
								local tool=tool:Clone()
								if not tool:FindFirstChild(server.CodeName..tool.Name) then
									Instance.new("StringValue",tool).Name=server.CodeName..tool.Name 
								end
								tool.Parent = v.StarterGear 
							end
						end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes the desired tool from the target player(s)\'s StarterPack',2,server.Prefix,{'starterremove'},{'player','toolname'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr, args[1]:lower())) do
			cPcall(function()
				if v:findFirstChild("StarterGear") then 
					for a, tool in pairs(v.StarterGear:children()) do
						if tool:IsA("Tool") or tool:IsA("HopperBin") then
							if args[2]:lower() == "all" or tool.Name:lower():find(args[2]:lower()) == 1 then 
								tool:Destroy()
							end
						end
					end
				end
			end)
		end
	end)
	
	
	server.MakeCommand('Gives the target player(s) the desired tool(s)',2,server.Prefix,{'give','tool'},{'player','tool'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				for a, tool in pairs(server.Storage:children()) do
					if tool:IsA("Tool") or tool:IsA("HopperBin") then
						if args[2]:lower() == "all" or tool.Name:lower():sub(1,#args[2])==args[2]:lower() then 
							local tool=tool:clone()
							if not tool:FindFirstChild(server.CodeName..tool.Name) then
								Instance.new("StringValue",tool).Name=server.CodeName..tool.Name 
							end
							tool.Parent = v.Backpack 
						end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Steals player1\'s tools and gives them to player2',2,server.Prefix,{'steal','stealtools'},{'player1','player2'},function(plr,args)
		local p1 = server.GetPlayers(plr, args[1])
		local p2 = server.GetPlayers(plr, args[2])
		for i,v in pairs(p1) do
			for k,m in pairs(p2) do
				for j,n in pairs(v.Backpack:children()) do
					print(n.Name)
					local b=n:clone()
					n.Parent=m.Backpack
				end
			end
			v.Backpack:ClearAllChildren()
		end
	end)
	
	server.MakeCommand('Remove the target player(s)\'s screen guis',2,server.Prefix,{'removeguis','noguis'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','RemoveGuis')
		end
	end)
	
	server.MakeCommand('Remove the target player(s)\'s tools',2,server.Prefix,{'removetools','notools'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v:findFirstChild("Backpack") then 
					for a, tool in pairs(v.Character:children()) do if tool:IsA("Tool") or tool:IsA("HopperBin") then tool:Destroy() end end
					for a, tool in pairs(v.Backpack:children()) do if tool:IsA("Tool") or tool:IsA("HopperBin") then tool:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Shows you what rank the target player(s) are in the group specified by groupID',2,server.Prefix,{'rank','getrank'},{'player','groupID'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:IsInGroup(args[2]) then 
					server.Hint("[" .. v:GetRankInGroup(args[2]) .. "] " .. v:GetRoleInGroup(args[2]), {plr})
				elseif v and not v:IsInGroup(args[2])then
					server.Hint(v.Name .. " is not in the group " .. args[2], {plr})
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes <number> HP from the target player(s)',2,server.Prefix,{'damage','hurt'},{'player','number'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:FindFirstChild("Humanoid") then 
					v.Character.Humanoid:TakeDamage(args[2])
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s)\'s gravity normal',2,server.Prefix,{'grav','bringtoearth'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Torso") then 
					for a, frc in pairs(v.Character.Torso:children()) do if frc.Name == "BFRC" then frc:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Set the target player(s)\'s gravity',2,server.Prefix,{'setgrav','gravity','setgravity'},{'player','number'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Torso") then 
					for a, frc in pairs(v.Character.Torso:children()) do if frc.Name == "BFRC" then frc:Destroy() end end
					local frc = Instance.new("BodyForce", v.Character.Torso) frc.Name = "BFRC" frc.force = Vector3.new(0,0,0)
					for a, prt in pairs(v.Character:children()) do if prt:IsA("BasePart") then frc.force = frc.force - Vector3.new(0,prt:GetMass()*tonumber(args[2]),0) elseif prt:IsA("Hat") then frc.force = frc.force - Vector3.new(0,prt.Handle:GetMass()*tonumber(args[2]),0) end end
				end
			end)
		end
	end)
	
	server.MakeCommand('NoGrav the target player(s)',2,server.Prefix,{'nograv','nogravity','superjump'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then 
					for a, frc in pairs(v.Character.Torso:children()) do if frc.Name == "BFRC" then frc:Destroy() end end
					local frc = Instance.new("BodyForce", v.Character.Torso) frc.Name = "BFRC" frc.force = Vector3.new(0,0,0)
					for a, prt in pairs(v.Character:children()) do if prt:IsA("BasePart") then frc.force = frc.force + Vector3.new(0,prt:GetMass()*196.25,0) elseif prt:IsA("Hat") then frc.force = frc.force + Vector3.new(0,prt.Handle:GetMass()*196.25,0) end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Set the target player(s)\'s health to <number>',2,server.Prefix,{'health','sethealth'},{'player','number'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.MaxHealth = args[2]
					v.Character.Humanoid.Health = v.Character.Humanoid.MaxHealth
				end
			end)
		end
	end)
	
	server.MakeCommand('Set the target player(s)\'s WalkSpeed to <number>',2,server.Prefix,{'speed','setspeed','walkspeed'},{'player','number'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Humanoid") then 
					v.Character.Humanoid.WalkSpeed = args[2]
				end
			end)
		end
	end)
	
	server.MakeCommand('Set the target player(s)\'s team to <team>',2,server.Prefix,{'team','setteam','changeteam'},{'player','team'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and game:findFirstChild("Teams") then 
					for a, tm in pairs(game.Teams:children()) do
						if tm.Name:lower():find(args[2]:lower()) == 1 then v.TeamColor = tm.TeamColor end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Make a new team with the specified name and color',3,server.Prefix,{'newteam'},{'name','BrickColor'},function(plr,args)
	 	local color = BrickColor.new(math.random(1,227))
		if BrickColor.new(args[2])~=nil then color=BrickColor.new(args[2]) end
		local team=Instance.new("Team",service.Teams)
		team.Name=args[1]
		team.TeamColor=color
	end)
	
	server.MakeCommand('Remove the specified team',3,server.Prefix,{'removeteam'},{'name'},function(plr,args)
	 	for i,v in pairs(service.Teams:children()) do
			if v:IsA("Team") and v.Name:lower():sub(1,#args[1])==args[1]:lower() then
				v:Destroy()
			end
		end
	end)
	
	
	server.MakeCommand('Set the target player(s)\'s field of view to <number> (min 1, max 120)',-1,server.Prefix,{'fov','fieldofview'},{'player','number'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			server.Remote(v,'Function','FieldOfView',args[2])
		end
	end)
	
	server.MakeCommand('Teleport the target player(s) to the place belonging to <placeID>',2,server.Prefix,{'place'},{'player','placeID'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				server.PromptPlaceTeleport(v,"Teleport to "..args[2].."?",args[2])
			end)
		end
	end)
	
	server.MakeCommand('Teleport player1(s) to player2, a waypoint, or specific coords, use :tp player1 waypoint-WAYPOINTNAME to use waypoints, x,y,z for coords',2,server.Prefix,{'tp','teleport'},{'player1','player2'},function(plr,args)
	if args[2]:match('^waypoint%-(.*)') then
		local m=args[2]:match('^waypoint%-(.*)')
		local point
		for i,v in pairs(server.Waypoints) do
			if i:lower():sub(1,#m)==m:lower() then
				point=v
			end
		end
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if point then
				v.Character:MoveTo(point)
			end
		end
		if not point then server.Hint('Waypoint '..m..' was not found.',{plr}) end
	elseif args[2]:find(',') then
		local x,y,z=args[2]:match('(.*),(.*),(.*)')
		for i,v in pairs(server.GetPlayers(plr,args[1])) do 
			v.Character:MoveTo(Vector3.new(tonumber(x),tonumber(y),tonumber(z))) 
		end
	else
		local target=server.GetPlayers(plr,args[2])[1]
		local players=server.GetPlayers(plr,args[1])
		for k,n in pairs(players) do
			if n~=target then
				cPcall(function()
					if n.Character.Humanoid.Sit then
						n.Character.Humanoid.Sit=false
						wait(0.5)
					end
					if server.JumpOnTeleport then
						n.Character.Humanoid.Jump=true
						wait(0.5)
					end
					n.Character.Torso.CFrame=(target.Character.Torso.CFrame*CFrame.Angles(0,math.rad(90/#players*k),0)*CFrame.new(5+.2*#players,0,0))*CFrame.Angles(0,math.rad(90),0)
				end)
			end
		end
	end
	end)	
	
	server.MakeCommand('Teleport the target player(s) up by <height> studs',-1,server.Prefix,{'freefall','skydive'},{'player','height'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character:FindFirstChild('Torso') then 
					v.Character.Torso.CFrame=v.Character.Torso.CFrame+Vector3.new(0,tonumber(args[2]),0)
				end
			end)
		end
	end)
	
	server.MakeCommand('Change the target player(s)\'s leader stat <stat> value to <value>',2,server.Prefix,{'change','leaderstat','stat'},{'player','stat','value'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("leaderstats") then 
					for a, st in pairs(v.leaderstats:children()) do
						if st.Name:lower():find(args[2]:lower()) == 1 then st.Value = args[3] end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Add <value> to <stat>',2,server.Prefix,{'add','addtostat','addstat'},{'player','stat','value'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("leaderstats") then 
					for a, st in pairs(v.leaderstats:children()) do
						if st.Name:lower():find(args[2]:lower()) == 1 and tonumber(st.Value) then st.Value = tonumber(st.Value)+tonumber(args[3]) end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Subtract <value> from <stat>',2,server.Prefix,{'subtract','minusfromstat','minusstat','subtractstat'},{'player','stat','value'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:findFirstChild("leaderstats") then 
					for a, st in pairs(v.leaderstats:children()) do
						if st.Name:lower():find(args[2]:lower()) == 1 and tonumber(st.Value) then st.Value = tonumber(st.Value)-tonumber(args[3]) end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Give the target player(s) the shirt that belongs to <ID>',2,server.Prefix,{'shirt','giveshirt'},{'player','ID'},function(plr,args)
		local image=server.GetTexture(args[2])
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if image then
					print(image)
					if v.Character and image then
						for g,k in pairs(v.Character:children()) do
							if k:IsA("Shirt") then k:Destroy() end
						end
						Instance.new('Shirt',v.Character).ShirtTemplate="http://www.roblox.com/asset/?id="..image
					end
				else
					for g,k in pairs(v.Character:children()) do
						if k:IsA("Shirt") then k:Destroy() end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Give the target player(s) the pants that belongs to <id>',2,server.Prefix,{'pants','givepants'},{'player','id'},function(plr,args)
		local image=server.GetTexture(args[2])
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if image then
					if v.Character and image then 
						for g,k in pairs(v.Character:children()) do
							if k:IsA("Pants") then k:Destroy() end
						end
						Instance.new('Pants',v.Character).PantsTemplate="http://www.roblox.com/asset/?id="..image
					end
				else
					for g,k in pairs(v.Character:children()) do
						if k:IsA("Pants") then k:Destroy() end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Give the target player(s) the face that belongs to <id>',2,server.Prefix,{'face','giveface'},{'player','id'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				--local image=server.GetTexture(args[2])
				if not v.Character:FindFirstChild("Head") then return end
				if v and v.Character and v.Character:findFirstChild("Head") and v.Character.Head:findFirstChild("face") then 
					v.Character.Head:findFirstChild("face"):Destroy()--.Texture = "http://www.roblox.com/asset/?id=" .. args[2]
				end
				service.InsertService:LoadAsset(tonumber(args[2])):children()[1].Parent=v.Character:FindFirstChild("Head")
			end)
		end
	end)
	
	server.MakeCommand('Swag the target player(s) up',-1,server.Prefix,{'swagify','swagger'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then
					for i,v in pairs(v.Character:children()) do
						if v.Name == "Shirt" then local cl = v:Clone() cl.Parent = v.Parent cl.ShirtTemplate = "http://www.roblox.com/asset/?id=109163376" v:Destroy() end
						if v.Name == "Pants" then local cl = v:Clone() cl.Parent = v.Parent cl.PantsTemplate = "http://www.roblox.com/asset/?id=109163376" v:Destroy() end
					end
					for a,cp in pairs(v.Character:children()) do if cp.Name == "nBDCape" then cp:Destroy() end end
					server.Cape(v,'Fabric','Pink',109301474)
				end
			end)
		end
	end)
	
	server.MakeCommand("Shrekify the target player(s)",-1,server.Prefix,{"shrek","shrekify","shrekislife","swamp"},{"player"},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				server.RunCommand(server.Prefix.."pants",v.Name,"150586096")
				server.RunCommand(server.Prefix.."shirt",v.Name,"133078195")
				for i,v in pairs(v.Character:children()) do
					if v:IsA("Hat") or v:IsA("CharacterMesh") then
						v:Destroy()
					end
				end
				server.RunCommand(server.Prefix.."hat",v.Name,"20011951")
				local sound=Instance.new("Sound",v.Character.Torso)
				sound.SoundId="http://www.roblox.com/asset/?id="..130767645
				wait(0.5)
				sound:Play()
			end)
		end
	end)
	
	server.MakeCommand('Send the target player(s) to the moon!',-1,server.Prefix,{'rocket','firework'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			cPcall(function()
				if v.Character and v.Character:FindFirstChild("Torso") then
				local speed = 10
				local Part = Instance.new("Part")
				Part.Parent = v.Character
				local SpecialMesh = Instance.new("SpecialMesh") 
				SpecialMesh.Parent = Part
				SpecialMesh.MeshId = "http://www.roblox.com/asset/?id=2251534" 
				SpecialMesh.MeshType = "FileMesh" 
				SpecialMesh.TextureId = "43abb6d081e0fbc8666fc92f6ff378c1" 
				SpecialMesh.Scale = Vector3.new(0.5,0.5,0.5)
				local Weld = Instance.new("Weld")
				Weld.Parent = Part
				Weld.Part0 = Part
				Weld.Part1 = v.Character.Torso
				Weld.C0 = CFrame.new(0,-1,0)*CFrame.Angles(-1.5,0,0)
				local BodyVelocity = Instance.new("BodyVelocity")
				BodyVelocity.Parent = Part
				BodyVelocity.maxForce = Vector3.new(math.huge,math.huge,math.huge)
				BodyVelocity.velocity = Vector3.new(0,10*speed,0)
				cPcall(function()
					for i = 1,math.huge do
						local Explosion = Instance.new("Explosion")
						Explosion.Parent = Part
						Explosion.BlastRadius = 0
						Explosion.Position = Part.Position + Vector3.new(0,0,0)
						wait()
					end 
				end)    
				BodyVelocity:remove()
				Instance.new("Explosion",service.Workspace).Position=v.Character.Torso.Position
				v.Character:BreakJoints()
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target player(s) dance',-1,server.Prefix,{'dance'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
		server.Remote(v,'Function','Effect','dance')
	end
	end)
	
	server.MakeCommand('Make the target player(s) break dance',-1,server.Prefix,{'breakdance','fundance','lolwut'},{'player'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	local color
	local num=math.random(1,7)
	if num==1 then
	color='Really blue'
	elseif num==2 then
	color='Really red'
	elseif num==3 then
	color='Magenta'
	elseif num==4 then
	color='Lime green'
	elseif num==5 then
	color='Hot pink'
	elseif num==6 then
	color='New Yeller'
	elseif num==7 then
	color='White'
	end
	local hum=v.Character:FindFirstChild('Humanoid')
	if not hum then return end
	server.Remote(v,'Function','Effect','dance')
	server.ProcessCommand("SYSTEM",server.Prefix.."sparkles"..server.SplitKey..v.Name..server.SplitKey..color..server.BatchKey..server.Prefix.."fire"..server.SplitKey..v.Name..server.SplitKey..color..server.BatchKey..server.Prefix.."nograv"..server.SplitKey..v.Name..server.BatchKey..server.Prefix.."smoke"..server.SplitKey..v.Name..server.SplitKey..color..server.BatchKey..server.Prefix.."spin"..server.SplitKey..v.Name,true)
	repeat hum.PlatformStand=true wait() until not hum or hum==nil or hum.Parent==nil
	end)
	end
	end)
	
	server.MakeCommand('Make the target player(s) puke',-1,server.Prefix,{'puke','barf','throwup','vomit'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr, args[1])) do
	cPcall(function()
	if (not v:IsA('Player')) or (not v) or (not v.Character) or (not v.Character:FindFirstChild('Head')) or v.Character:FindFirstChild('nBD Puke') then return end
	local run=true
	local k=Instance.new('StringValue',v.Character)
	k.Name='nBD Puke'
	cPcall(function()
	repeat 
	wait(0.15)
	local p = Instance.new("Part",v.Character)
	p.CanCollide = false
	local color = math.random(1, 3)
	local bcolor
	if color == 1 then
	bcolor = BrickColor.new(192)
	elseif color == 2 then
	bcolor = BrickColor.new(28)
	elseif color == 3 then
	bcolor = BrickColor.new(105)
	end
	p.BrickColor = bcolor
	local m=Instance.new('BlockMesh',p)
	p.Size=Vector3.new(0.1,0.1,0.1)
	m.Scale = Vector3.new(math.random()*0.9, math.random()*0.9, math.random()*0.9)
	p.Locked = true
	p.TopSurface = "Smooth"
	p.BottomSurface = "Smooth"
	p.CFrame = v.Character.Head.CFrame * CFrame.new(Vector3.new(0, 0, -1))
	p.Velocity = v.Character.Head.CFrame.lookVector * 20 + Vector3.new(math.random(-5, 5), math.random(-5, 5), math.random(-5, 5))
	p.Anchored = false
	m.Name='Puke Peice'
	p.Name='Puke Peice'
	p.Touched:connect(function(o)
	if o and p and (not service.Players:FindFirstChild(o.Parent.Name)) and o.Name~='Puke Peice' and o.Name~='Blood Peice' and o.Name~='Blood Plate' and o.Name~='Puke Plate' and (o.Parent.Name=='Workspace' or o.Parent:IsA('Model')) and (o.Parent~=p.Parent) and o:IsA('Part') and (o.Parent.Name~=v.Character.Name) and (not o.Parent:IsA('Hat')) and (not o.Parent:IsA('Tool')) then
		local cf=CFrame.new(p.CFrame.X,o.CFrame.Y+o.Size.Y/2,p.CFrame.Z)
		p:Destroy()
		local g=Instance.new('Part',service.Workspace)
		g.Anchored=true
		g.CanCollide=false
		g.Size=Vector3.new(0.1,0.1,0.1)
		g.Name='Puke Plate'
		g.CFrame=cf
		g.BrickColor=BrickColor.new(119)
		local c=Instance.new('CylinderMesh',g)
		c.Scale=Vector3.new(1,0.2,1)
		c.Name='PukeMesh'
		wait(10)
		g:Destroy()
	elseif o and o.Name=='Puke Plate' and p then 
		p:Destroy() 
		o.PukeMesh.Scale=o.PukeMesh.Scale+Vector3.new(0.5,0,0.5)
	end
	end)
	until run==false or not k or not k.Parent or (not v) or (not v.Character) or (not v.Character:FindFirstChild('Head'))
	end)
	wait(10)
	run=false
	k:Destroy()
	end)
	end
	end)
	
	server.MakeCommand('Make the target player(s) bleed',-1,server.Prefix,{'cut','stab','shank','bleed'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr, args[1])) do
	cPcall(function()
	if (not v:IsA('Player')) or (not v) or (not v.Character) or (not v.Character:FindFirstChild('Head')) or v.Character:FindFirstChild('nBD Bleed') then return end
	local run=true
	local k=Instance.new('StringValue',v.Character)
	k.Name='nBD Bleed'
	cPcall(function()
	repeat 
	wait(0.15)
	v.Character.Humanoid.Health=v.Character.Humanoid.Health-1
	local p = Instance.new("Part",v.Character)
	p.CanCollide = false
	local color = math.random(1, 3)
	local bcolor
	if color == 1 then
	bcolor = BrickColor.new(21)
	elseif color == 2 then
	bcolor = BrickColor.new(1004)
	elseif color == 3 then
	bcolor = BrickColor.new(21)
	end
	p.BrickColor = bcolor
	local m=Instance.new('BlockMesh',p)
	p.Size=Vector3.new(0.1,0.1,0.1)
	m.Scale = Vector3.new(math.random()*0.9, math.random()*0.9, math.random()*0.9)
	p.Locked = true
	p.TopSurface = "Smooth"
	p.BottomSurface = "Smooth"
	p.CFrame = v.Character.Torso.CFrame * CFrame.new(Vector3.new(2, 0, 0))
	p.Velocity = v.Character.Head.CFrame.lookVector * 1 + Vector3.new(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1))
	p.Anchored = false
	m.Name='Blood Peice'
	p.Name='Blood Peice'
	p.Touched:connect(function(o)
	if o and p and (not service.Players:FindFirstChild(o.Parent.Name)) and o.Name~='Blood Peice' and o.Name~='Puke Peice' and o.Name~='Puke Plate' and o.Name~='Blood Plate' and (o.Parent.Name=='Workspace' or o.Parent:IsA('Model')) and (o.Parent~=p.Parent) and o:IsA('Part') and (o.Parent.Name~=v.Character.Name) and (not o.Parent:IsA('Hat')) and (not o.Parent:IsA('Tool')) then
		local cf=CFrame.new(p.CFrame.X,o.CFrame.Y+o.Size.Y/2,p.CFrame.Z)
		p:Destroy()
		local g=Instance.new('Part',service.Workspace)
		g.Anchored=true
		g.CanCollide=false
		g.Size=Vector3.new(0.1,0.1,0.1)
		g.Name='Blood Plate'
		g.CFrame=cf
		g.BrickColor=BrickColor.new(21)
		local c=Instance.new('CylinderMesh',g)
		c.Scale=Vector3.new(1,0.2,1)
		c.Name='BloodMesh'
		wait(10)
		g:Destroy()
	elseif o and o.Name=='Blood Plate' and p then 
		p:Destroy() 
		o.BloodMesh.Scale=o.BloodMesh.Scale+Vector3.new(0.5,0,0.5)
	end
	end)
	until run==false or not k or not k.Parent or (not v) or (not v.Character) or (not v.Character:FindFirstChild('Head'))
	end)
	wait(10)
	run=false
	k:Destroy()
	end)
	end
	end)
	
	server.MakeCommand('Shows you the number of player points left in the game',5,server.Prefix,{'ppoints','playerpoints','getpoints'},{},function(plr,args)
		server.Hint('Available Player Points: '..service.PointsService:GetAwardablePoints(),{plr})
	end)
	
	server.MakeCommand('Lets you give <player> <amount> player points',5,server.Prefix,{'giveppoints','giveplayerpoints','sendplayerpoints'},{'player','amount'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			local ran,failed=pcall(function() service.PointsService:AwardPoints(v.userId,tonumber(args[2])) end)
			if ran and service.PointsService:GetAwardablePoints()>=tonumber(args[2]) then
				server.Hint('Gave '..args[2]..' points to '..v.Name,{plr})
			elseif service.PointsService:GetAwardablePoints()<tonumber(args[2])then
				server.Hint("You don't have "..args[2]..' points to give to '..v.Name,{plr})
			else
				server.Hint("(Unknown Error) Failed to give "..args[2]..' points to '..v.Name,{plr})
			end
			server.Hint('Available Player Points: '..service.PointsService:GetAwardablePoints(),{plr})
		end
	end)
	
	server.MakeCommand('Slowly kills the target player(s)',-1,server.Prefix,{'poison'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			local torso=v.Character:FindFirstChild('Torso')
			local larm=v.Character:FindFirstChild('Left Arm')
			local rarm=v.Character:FindFirstChild('Right Arm')
			local lleg=v.Character:FindFirstChild('Left Leg')
			local rleg=v.Character:FindFirstChild('Right Leg')
			local head=v.Character:FindFirstChild('Head')
			local hum=v.Character:FindFirstChild('Humanoid')
			if torso and larm and rarm and lleg and rleg and head and hum and not v.Character:FindFirstChild('nBDPoisoned') then
				local poisoned=Instance.new('BoolValue',v.Character)
				poisoned.Name='nBDPoisoned'
				poisoned.Value=true
				local tor=torso.BrickColor
				local lar=larm.BrickColor
				local rar=rarm.BrickColor
				local lle=lleg.BrickColor
				local rle=rleg.BrickColor
				local hea=head.BrickColor
				torso.BrickColor=BrickColor.new('Br. yellowish green')
				larm.BrickColor=BrickColor.new('Br. yellowish green')
				rarm.BrickColor=BrickColor.new('Br. yellowish green')
				lleg.BrickColor=BrickColor.new('Br. yellowish green')
				rleg.BrickColor=BrickColor.new('Br. yellowish green')
				head.BrickColor=BrickColor.new('Br. yellowish green')
				local run=true
				coroutine.wrap(function() wait(10) run=false end)()
				repeat
					wait(1)
					hum.Health=hum.Health-5
				until (not poisoned) or (not poisoned.Parent) or (not run)
				if poisoned and poisoned.Parent then
					torso.BrickColor=tor
					larm.BrickColor=lar
					rarm.BrickColor=rar
					lleg.BrickColor=lle
					rleg.BrickColor=rle
					head.BrickColor=hea
				end
			end
		end
	end)
	
	server.MakeCommand('Makes the target player(s) say interesting things, makes it hard for them to walk, and eventually kills them',-1,server.Prefix,{'drug','intoxicate'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			server.Remote(v,'Function','Drug')
		end
	end)
	
	server.MakeCommand('Change the pitch of the currently playing song',2,server.Prefix,{'pitch'},{'number'},function(plr,args)
		local pitch = args[1]
		for i,v in pairs(game.Workspace:children()) do if v.Name=='Sound'..server.RemoteObject then v.Pitch=pitch end end
	end)
	
	server.MakeCommand('Start playing a song',2,server.Prefix,{'music','song','playsong'},{'id'},function(plr,args)
	if server.autoMusicRunning~=nil and server.autoMusicRunning==true then
		server.autoMusicRunning=false
	end
	for i, v in pairs(game.Workspace:children()) do if v:IsA("Sound") then v:Destroy() end end
	local id = args[1]:lower()
	local pitch = 1
	local mp = service.MarketPlace
	local volume = 1
	local istrello = {false,0}
	for i,v in pairs(server.MusicList) do if id==v.Name:lower() then id=v.Id if v.Pitch then pitch=v.Pitch end if v.Volume then volume=v.Volume end end end
	if tostring(args[1])~=nil then
		for i,v in pairs(server.TRELLOmusl) do 
			if tostring(args[1]):lower()==
				v.Name:lower()
				:sub(1,string.len(args[1])) 
				then 
				id=v.Id 
				istrello={true,v}
				if v.Pitch then 
					pitch=v.Pitch 
				end 
				if v.Volume then 
					volume=v.Volume 
				end 
			end 
		end
	end 
	local name = 'Invalid ID'
	if istrello[1]==false then
		pcall(function() 
			if mp:GetProductInfo(id).AssetTypeId==3 then 
				name = 'Now playing '..mp:GetProductInfo(id).Name 
			end 
		end)
	else
		name = '-Trello- Now playing '..istrello[2].Name
	end 
	local s = Instance.new("Sound") 
	s.Name='Sound'..server.RemoteObject
	s.Parent=service.Workspace
	s.SoundId = "http://www.roblox.com/asset/?id=" .. id 
	s.Volume = volume 
	s.Pitch = pitch 
	s.Looped = true 
	s.archivable = false
	cPcall(function() s:Play() end)
	if server.SongMessage then server.Hint(name..' ('..id..')',service.Players:children()) end
	end)
	
	server.MakeCommand('Start playing songs from TRELLO automatically.',2,server.Prefix,{'automusic'},{},function(plr,args)
		for i, v in pairs(game.Workspace:children()) do if v:IsA("Sound") then v:Destroy() end end
		if server.TRELLOmusl==nil or #server.TRELLOmusl==0 then
			server.Hint('TRELLO or the Music list is not setup properly..',{plr}) 
			return
		end
		local pitch = 1
		local mp = service.MarketPlace
		local volume = 1
		local autosonglist = {}
		for i, v in pairs(server.TRELLOmusl) do 
			table.insert(autosonglist,{Name=v.Name,Id=v.Id,Time=v.Time})
		end
		local function shuffleTable( t )
			math.randomseed(tick())
		    local rand = math.random 
		    local iterations = #t
		    local j
		    for i = iterations, 2, -1 do
		        j = rand(i)
		        t[i], t[j] = t[j], t[i]
		    end
		end
		shuffleTable(autosonglist)
		server.autoMusicRunning=true
		server.autoMusicSkipSong=false
		local index=1
		repeat
			local name = '(noBakDoor-Auto) Cannot play '..autosonglist[index].Name.. '.'
			local id = autosonglist[index].Id
			pcall(function() 
				if mp:GetProductInfo(id).AssetTypeId==3 then 
					name = '(noBakDoor-Auto) Now Playing '..autosonglist[index].Name
				end 
			end)
			if name:sub(1,3)=="Can" then
				server.Hint(name..' ('..id..')',service.Players:children()) 
				wait(6)
			else
				if autosonglist[index].Time==nil or tonumber(autosonglist[index].Time)==nil then
					server.Hint('(noBakDoor-Auto) '..name..' has no time frame. ('..id..')',service.Players:children()) 
					wait(6)
				else
					if autosonglist[index+1].Time~=nil then
						server.Remote(plr,'Function','PreloadAssetId',autosonglist[index+1].Id,service.Players:children())
					end
					if autosonglist[index+2].Time~=nil then
						server.Remote(plr,'Function','PreloadAssetId',autosonglist[index+2].Id,service.Players:children())
					end
					local soundlength=tonumber(autosonglist[index].Time)
					local s = Instance.new("Sound") 
					s.Name='Sound'..server.RemoteObject
					s.Parent=service.Workspace
					s.SoundId = "rbxassetid://" .. id 
					s.Volume = volume 
					s.Pitch = pitch 
					s.Looped = true 
					s.archivable = false
					cPcall(function() s:Play() end)
					local starttick=tick()
					local aboutnext=false
					server.autoMusicSkipSong=false 
					server.autoSongInfo=name..' ('..id..')-'..soundlength..'-'
					server.Hint(server.autoSongInfo,service.Players:children(),15) 
					while tick()-starttick<soundlength and server.autoMusicRunning==true and server.autoMusicSkipSong==false do
						if aboutnext==false and tick()-starttick>soundlength-10 then
							local songname
							aboutnext=true
							if autosonglist[index+1]==nil then
								server.Hint('(noBakDoor-Auto) Song list will soon rescramble.',service.Players:children(),6) 
							else
								local index=index+1
								local id=autosonglist[index].Id
								server.Hint('(noBakDoor-Auto) '..autosonglist[index].Name.."("..id..") coming up next..",service.Players:children(),9.4) 
							end 
						end
						server.autoSongInfo=name..' ('..id..')-'..soundlength..'-[left:'..soundlength-(tick()-starttick)..']'
						wait(.5)
					end
					index=index+1
					server.autoMusicSkipSong=false
					cPcall(function() s.Volume=0 s:Stop() s:Destroy() end)
				end 
			end 
			if index>=#autosonglist then
				index=1
				shuffleTable(autosonglist)
			end
		until server.autoMusicRunning==false
		server.autoMusicStop=nil
		server.autoMusicSkipSong=nil
		server.autoSongInfo=nil
	end)
	
	server.MakeCommand('Get the current song that AutoMusic is playing.',2,server.Prefix,{'autostatus','autoinfo'},{},function(plr,args)
		if server.autoMusicSkipSong==nil then
			server.Hint('(noBakDoor-Auto) is not running..',{plr}) 
		else
			server.Hint(server.autoSongInfo,{plr}) 
		end 
	end)	
	
	server.MakeCommand('Skip the song when AutoMusic is running.',2,server.Prefix,{'autoskip'},{},function(plr,args)
		if server.autoMusicSkipSong~=nil then
			server.autoMusicSkipSong=true
		else
			server.Hint("(noBakDoor-Auto) Can't skip, automusic is not running..",{plr}) 
		end 
	end)
	
	server.MakeCommand('Stop the currently playing song',2,server.Prefix,{'musicstop','stopmusic','musicoff','autostop'},{},function(plr,args)
		for i, v in pairs(game.Workspace:children()) do 
			if v.Name=='Sound'..server.RemoteObject then 
				v:Destroy() 
			end 
		end
		if server.autoMusicRunning~=nil and server.autoMusicRunning==true then
			server.autoMusicRunning=false
		end
	end)
	
	server.MakeCommand('Shows you the script\'s available music list',2,server.Prefix,{'musiclist','listmusic','songs'},{},function(plr,args)
		local listforclient={}
		for i, v in pairs(server.MusicList) do 
			table.insert(listforclient,{Object=v.Name,Desc=v.Id})
		end
		for i, v in pairs(server.TRELLOmusl) do 
			table.insert(listforclient,{Object=v.Name,Desc=v.Id})
		end
		server.Remote(plr,'Function','ListGui','Music List',listforclient)
	end)
	
	server.MakeCommand('Shows you the current Trello available music list',2,server.Prefix,{'tmusiclist','trellomusiclist','tlistmusic','trelolistmusic','tsongs','trellosongs'},{},function(plr,args)
		local listforclient={}
		for i, v in pairs(server.TRELLOmusl) do 
			table.insert(listforclient,{Object=v.Name,Desc=v.Id})
		end
		server.Remote(plr,'Function','ListGui','Trello Music List',listforclient)
	end)
	
	server.MakeCommand('Turns the target player(s) into a stick figure',-1,server.Prefix,{'stickify','stick','stickman'},{'player'},function(plr,args)
		for kay,player in pairs(server.GetPlayers(plr,args[1])) do 
		cPcall(function()
		local m = player.Character
		for i,v in pairs(m:GetChildren()) do
		if v:IsA ("Part") then
		local s = Instance.new("SelectionPartLasso")
		s.Parent = m.Torso
		s.Part = v
		s.Humanoid = m.Humanoid
		s.Color = BrickColor.new(0,0,0)
		v.Transparency = 1
		m.Head.Transparency = 0
		m.Head.Mesh:Remove()
		local b = Instance.new("SpecialMesh")
		b.Parent = m.Head
		b.MeshType = "Sphere"
		b.Scale = Vector3.new(.5,1,1)
		m.Head.BrickColor = BrickColor.new("Black")
		end 
		end
		end)
		end 
	end)
	
	server.MakeCommand('Sends the target player(s) down a hole',-1,server.Prefix,{'hole','sparta'},{'player'},function(plr,args)
		for kay, player in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local torso=player.Character:FindFirstChild('Torso')
				if torso then
				local hole = Instance.new("Part",player.Character)
				hole.Anchored = true
				hole.CanCollide = false
				hole.formFactor = Enum.FormFactor.Custom
				hole.Size = Vector3.new(10,1,10)
				hole.CFrame = torso.CFrame * CFrame.new(0,-3.3,-3)
				hole.BrickColor = BrickColor.new("Really black")
				local holeM = Instance.new("CylinderMesh",hole)
				torso.Anchored = true
				local foot = torso.CFrame * CFrame.new(0,-3,0)
				for i=1,10 do
				torso.CFrame = foot * CFrame.fromEulerAnglesXYZ(-(math.pi/2)*i/10,0,0) * CFrame.new(0,3,0)
				wait()
				end
				for i=1,5,0.2 do
				torso.CFrame = foot * CFrame.new(0,-(i^2),0) * CFrame.fromEulerAnglesXYZ(-(math.pi/2),0,0) * CFrame.new(0,3,0)
				wait()
				end
				player.Character.Humanoid.Health=0
				end
			end)
		end
	end)
	
	server.MakeCommand('Zeus strikes down the target player(s)',-1,server.Prefix,{"lightning","smite"},{"player"},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				server.RunCommand(server.Prefix.."freeze",v.Name)
				local char=v.Character
				local zeus=Instance.new("Model",char)
				local cloud=Instance.new("Part",zeus)
				cloud.Anchored=true
				cloud.CanCollide=false
				cloud.CFrame=char.Torso.CFrame*CFrame.new(0,25,0)
				local sound=Instance.new("Sound",cloud)
				sound.SoundId="rbxassetid://133426162"
				local mesh=Instance.new("SpecialMesh",cloud)
				mesh.MeshId="http://www.roblox.com/asset/?id=1095708"
				mesh.TextureId="http://www.roblox.com/asset/?id=1095709"
				mesh.Scale=Vector3.new(30,30,40)
				mesh.VertexColor=Vector3.new(0.3,0.3,0.3)
				local light=Instance.new("PointLight",cloud)
				light.Color=Color3.new(0,85/255,1)
				light.Brightness=10
				light.Range=30
				light.Enabled=false
				wait(0.2)
				sound.Volume=0.5
				sound.Pitch=0.8
				sound:Play()
				light.Enabled=true
				wait(1/100)
				light.Enabled=false
				wait(0.2)
				light.Enabled=true
				light.Brightness=1
				wait(0.05)
				light.Brightness=3
				wait(0.02)
				light.Brightness=1
				wait(0.07)
				light.Brightness=10
				wait(0.09)
				light.Brightness=0
				wait(0.01)
				light.Brightness=7
				light.Enabled=false
				wait(1.5)
				local part1=Instance.new("Part",zeus)
				part1.Anchored=true
				part1.CanCollide=false
				part1.Size=Vector3.new(2, 9.2, 1)
				part1.BrickColor=BrickColor.new("New Yeller")
				part1.Transparency=0.6
				part1.BottomSurface="Smooth"
				part1.TopSurface="Smooth"
				part1.CFrame=char.Torso.CFrame*CFrame.new(0,15,0)
				part1.Rotation=Vector3.new(0.359, 1.4, -14.361)
				wait()
				local part2=part1:clone()
				part2.Parent=zeus
				part2.Size=Vector3.new(1, 7.48, 2)
				part2.CFrame=char.Torso.CFrame*CFrame.new(0,7.5,0)
				part2.Rotation=Vector3.new(77.514, -75.232, 78.051)
				wait()
				local part3=part1:clone()
				part3.Parent=zeus
				part3.Size=Vector3.new(1.86, 7.56, 1)
				part3.CFrame=char.Torso.CFrame*CFrame.new(0,1,0)
				part3.Rotation=Vector3.new(0, 0, -11.128)
				sound.SoundId="rbxassetid://130818250"
				sound.Volume=1
				sound.Pitch=1
				sound:Play()
				wait()
				part1.Transparency=1
				part2.Transparency=1
				part3.Transparency=1
				Instance.new("Smoke",char.Torso).Color=Color3.new(0,0,0)
				char:BreakJoints()
			end)
		end
	end)
	
	server.MakeCommand('Crucifies the target players(s). Command inspired by the Roman ROBLOX group owned by YourCaesarAugustus.',-1,server.Prefix,{'crucify'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1]:lower())) do
			local torso=v.Character['Torso']
			local larm=v.Character['Left Arm']
			local rarm=v.Character['Right Arm']
			local lleg=v.Character['Left Leg']
			local rleg=v.Character['Right Leg']
			local head=v.Character['Head']
			if torso and larm and rarm and lleg and rleg and head and not v.Character:FindFirstChild(v.Name..'nBDcrusify') then
				local cru=Instance.new('Model',v.Character)
				cru.Name=v.Name..'nBDcrusify'
				local c1=Instance.new('Part',cru)
				c1.BrickColor=BrickColor.new('Reddish brown')
				c1.Material='Wood'
				c1.CFrame=(v.Character.Torso.CFrame-v.Character.Torso.CFrame.lookVector)*CFrame.new(0,0,2)
				c1.Size=Vector3.new(2,18.4,1)
				c1.Anchored=true
				local c2=c1:Clone()
				c2.Parent=cru
				c2.Size=Vector3.new(11,1.6,1)
				c2.CFrame=c1.CFrame+Vector3.new(0,5,0)
				torso.Anchored=true
				wait(0.5)
				torso.CFrame=c2.CFrame+torso.CFrame.lookVector+Vector3.new(0,-1,0)
				wait(0.5)
				larm.Anchored=true
				rarm.Anchored=true
				lleg.Anchored=true
				rleg.Anchored=true
				head.Anchored=true
				wait()
				larm.CFrame=torso.CFrame*CFrame.new(-1.5,1,0)
				rarm.CFrame=torso.CFrame*CFrame.new(1.5,1,0)
				lleg.CFrame=torso.CFrame*CFrame.new(-0.1,-1.7,0)
				rleg.CFrame=torso.CFrame*CFrame.new(0.1,-1.7,0)
				larm.CFrame=larm.CFrame*CFrame.Angles(0,0,-140)
				rarm.CFrame=rarm.CFrame*CFrame.Angles(0,0,140)
				lleg.CFrame=lleg.CFrame*CFrame.Angles(0,0,0.6)
				rleg.CFrame=rleg.CFrame*CFrame.Angles(0,0,-0.6)
				--head.CFrame=head.CFrame*CFrame.Angles(0,0,0.3)
				local n1=Instance.new('Part',cru)
				n1.BrickColor=BrickColor.new('Dark stone grey')
				n1.Material='DiamondPlate'
				n1.Size=Vector3.new(0.2,0.2,2)
				n1.Anchored=true
				local m=Instance.new('BlockMesh',n1)
				m.Scale=Vector3.new(0.2,0.2,0.7)
				local n2=n1:clone()
				n2.Parent=cru
				local n3=n1:clone()
				n3.Parent=cru
				n1.CFrame=(c2.CFrame+torso.CFrame.lookVector)*CFrame.new(2,0,0)
				n2.CFrame=(c2.CFrame+torso.CFrame.lookVector)*CFrame.new(-2,0,0)
				n3.CFrame=(c2.CFrame+torso.CFrame.lookVector)*CFrame.new(0,-3,0)
				cPcall(function()
					repeat 
						wait(0.1)
						v.Character.Humanoid.Health=v.Character.Humanoid.Health-0.6
					until (not cru) or (not cru.Parent) or (not v) or (not v.Character) or (not v.Character:FindFirstChild('Head')) or v.Character.Humanoid.Health<=0
				end)
			end
		end
	end)
	
	server.MakeCommand('Lets the target player(s) fly',2,server.Prefix,{'fly','flight'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','fly')
		end
	end)
	
	server.MakeCommand('Removes the target player(s)\'s ability to fly',2,server.Prefix,{'unfly','ground'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','unfly')
		end
	end)
	
	server.MakeCommand('Turns the place into a disco party',-1,server.Prefix,{'disco'},{},function(plr,args)
		server.lighttask=false
		wait(0.5)
		server.lighttask = true
		repeat
			if server.lighttask==false then return end
			local color = Color3.new(math.random(255)/255,math.random(255)/255,math.random(255)/255)
			service.Lighting.Ambient = color
			service.Lighting.OutdoorAmbient = color
			service.Lighting.FogColor = color
			wait(0.1)
		until server.lighttask==false
	end)
	
	server.MakeCommand('Makes the place flash',-1,server.Prefix,{'flash'},{},function(plr,args)
	server.lighttask=false
	wait(0.5)
	server.lighttask=true
	repeat
	if server.lighttask==false then return end
	service.Lighting.Ambient = Color3.new(1,1,1)
	service.Lighting.OutdoorAmbient = Color3.new(1,1,1)
	service.Lighting.FogColor = Color3.new(1,1,1)
	service.Lighting.Brightness = 1
	service.Lighting.TimeOfDay = 14
	wait(0.1) 
	service.Lighting.Ambient = Color3.new(0,0,0)
	service.Lighting.OutdoorAmbient = Color3.new(0,0,0)
	service.Lighting.FogColor = Color3.new(0,0,0)
	service.Lighting.Brightness = 0
	service.Lighting.TimeOfDay = 0
	wait(0.1)
	until server.lighttask==false
	end)
	
	server.MakeCommand('Makes the target player(s) spin',-1,server.Prefix,{'spin'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Torso") then
					for i,v in pairs(v.Character.Torso:children()) do if v.Name == "SPINNER" then v:Destroy() end end
					local torso = v.Character:findFirstChild("Torso")
					local bg = Instance.new("BodyGyro", torso) bg.Name = "SPINNER" bg.maxTorque = Vector3.new(0,math.huge,0) bg.P = 11111 bg.cframe = torso.CFrame table.insert(server.objects,bg)
					repeat 
						wait(1/44) 
						bg.cframe = bg.cframe * CFrame.Angles(0,math.rad(30),0)
					until not bg or bg.Parent ~= torso
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) stop spinning',-1,server.Prefix,{'unspin'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
					for a,q in pairs(v.Character.Torso:children()) do if q.Name == "SPINNER" then q:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Turn the target player(s) into a dog',-1,server.Prefix,{'dog','dogify'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
				if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
				if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
				v.Character.Torso.Transparency = 1
				v.Character.Torso.Neck.C0 = CFrame.new(0,-.5,-2) * CFrame.Angles(math.rad(90),math.rad(180),0)
				v.Character.Torso["Right Shoulder"].C0 = CFrame.new(.5,-1.5,-1.5) * CFrame.Angles(0,math.rad(90),0)
				v.Character.Torso["Left Shoulder"].C0 = CFrame.new(-.5,-1.5,-1.5) * CFrame.Angles(0,math.rad(-90),0)
				v.Character.Torso["Right Hip"].C0 = CFrame.new(1.5,-1,1.5) * CFrame.Angles(0,math.rad(90),0)
				v.Character.Torso["Left Hip"].C0 = CFrame.new(-1.5,-1,1.5) * CFrame.Angles(0,math.rad(-90),0)
				local new = Instance.new("Seat", v.Character) new.Name = "FAKETORSO" new.formFactor = "Symmetric" new.TopSurface = 0 new.BottomSurface = 0 new.Size = Vector3.new(3,1,4) new.CFrame = v.Character.Torso.CFrame
				local bf = Instance.new("BodyForce", new) bf.force = Vector3.new(0,new:GetMass()*196.25,0)
				local weld = Instance.new("Weld", v.Character.Torso) weld.Part0 = v.Character.Torso weld.Part1 = new weld.C0 = CFrame.new(0,-.5,0)
				for a, part in pairs(v.Character:children()) do if part:IsA("BasePart") then part.BrickColor = BrickColor.new("Brown") elseif part:findFirstChild("NameTag") then part.Head.BrickColor = BrickColor.new("Brown") end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Turns the target into the one and only D O Double G.',-1,server.Prefix,{'dogg','snoop','snoopify','dodoubleg'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character.HumanoidRootPart:FindFirstChild("Snoop") then return end
				server.RunCommand(server.Prefix.."invisible",v.Name)
				local mesh=Instance.new("BlockMesh",v.Character.HumanoidRootPart)
				mesh.Scale=Vector3.new(2,3,0.1)
				local decal1=Instance.new("Decal")
				decal1.Face="Back"
				decal1.Texture="http://www.roblox.com/asset/?id=131396137"
				decal1.Name="Snoop"
				local snoop=deps.Snoopinator:clone()
				snoop.Parent=decal1
				snoop.Disabled=false
				local decal2=decal1:clone()
				decal2.Face="Front"
				decal1.Parent=v.Character.HumanoidRootPart
				decal2.Parent=v.Character.HumanoidRootPart
				local sound=Instance.new("Sound",v.Character.HumanoidRootPart)
				sound.SoundId="rbxassetid://137545053"
				sound.Looped=true
				sound:Play()
			end)
		end
	end)
	
	server.MakeCommand('Sends chivers down ur spine',-1,server.Prefix,{'sp00ky','spooky','spookyscaryskeleton'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character.HumanoidRootPart:FindFirstChild("Snoop") then return end
				server.RunCommand(server.Prefix.."invisible",v.Name)
				local mesh=Instance.new("BlockMesh",v.Character.HumanoidRootPart)
				mesh.Scale=Vector3.new(2,3,0.1)
				local decal1=Instance.new("Decal")
				decal1.Face="Back"
				decal1.Texture="http://www.roblox.com/asset/?id=183747890"
				decal1.Name="Sp00k"
				local snoop=deps.Sp00kinator:clone()
				snoop.Parent=decal1
				snoop.Disabled=false
				local decal2=decal1:clone()
				decal2.Face="Front"
				decal1.Parent=v.Character.HumanoidRootPart
				decal2.Parent=v.Character.HumanoidRootPart
				local sound=Instance.new("Sound",v.Character.HumanoidRootPart)
				sound.SoundId="rbxassetid://174270407"
				sound.Looped=true
				sound:Play()
			end)
		end
	end)
	
	server.MakeCommand("Put custom particle emitter on target",-1,server.Prefix,{'particle'},{'player','textureid','startColor3','endColor3'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do	
			cPcall(function()		
				local startColor={}
				local endColor={}
				local part=Instance.new('ParticleEmitter') 
				part.Texture='rbxassetid://'..server.GetTexture(args[2]) 
				part.Size=NumberSequence.new({NumberSequenceKeypoint.new(0,0);NumberSequenceKeypoint.new(.1,.25,.25);NumberSequenceKeypoint.new(1,.5);}) 
				part.Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1);NumberSequenceKeypoint.new(.1,.25,.25);NumberSequenceKeypoint.new(.9,.5,.25);NumberSequenceKeypoint.new(1,1);}) 
				part.Lifetime=NumberRange.new(5) 
				part.Speed=NumberRange.new(.5,1) 
				part.Rotation=NumberRange.new(0,359) 
				part.RotSpeed=NumberRange.new(-90,90) 
				part.Rate=11 
				part.VelocitySpread=180	
				if args[3] then
					for s in args[3]:gmatch("[%d]+")do
						table.insert(startColor,tonumber(s))
					end
				end
				if args[4] then--276138620
					for s in args[4]:gmatch("[%d]+")do
						table.insert(endColor,tonumber(s))
					end
				end
				local startc=Color3.new(1,1,1)
				local endc=Color3.new(1,1,1)
				if #startColor==3 then
					startc=Color3.new(startColor[1],startColor[2],startColor[3])
				end
				if #endColor==3 then
					endc=Color3.new(endColor[1],endColor[2],endColor[3])
				end
				part.Color=ColorSequence.new(startc,endc) 
				part.Parent=v.Character.Torso
			end)
		end
	end)
	
	server.MakeCommand('Flatten. Went lazy on this one.',-1,server.Prefix,{'flatten','2d'},{'player','optional num'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				for k,p in pairs(v.Character:children()) do
					if p:IsA("Part") then
						if p:FindFirstChild("Mesh") then p.Mesh:Destroy() end
						Instance.new("BlockMesh",p).Scale=Vector3.new(1,1,args[2] or 0.1)
					elseif p:IsA("Hat") and p:FindFirstChild("Handle") then
						if p.Handle:FindFirstChild("Mesh") then
							p.Handle.Mesh.Scale=Vector3.new(1,1,args[2] or 0.1)
						else
							Instance.new("BlockMesh",p.Handle).Scale=Vector3.new(1,1,args[2] or 0.1)
						end
					elseif p:IsA("CharacterMesh") then
						p:Destroy()
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Turn the target player(s) into a skeleton',-1,server.Prefix,{'skeleton'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function() 
				for k,m in pairs(v.Character:children()) do
					if m:IsA("CharacterMesh") or m:IsA("Hat") then
						m:Destroy()
					end
				end --Checked for noBakDoor
				service.InsertService:LoadAsset(36781518):children()[1].Parent=v.Character
				service.InsertService:LoadAsset(36781481):children()[1].Parent=v.Character
				service.InsertService:LoadAsset(36781407):children()[1].Parent=v.Character
				service.InsertService:LoadAsset(36781447):children()[1].Parent=v.Character
				service.InsertService:LoadAsset(36781360):children()[1].Parent=v.Character
				service.InsertService:LoadAsset(36883367):children()[1].Parent=v.Character
			end)
		end
	end)
	
	server.MakeCommand('Turn them back to normal',-1,server.Prefix,{'undog','undogify'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
					if v.Character.Torso:findFirstChild("Shirt") then v.Character.Torso.Shirt.Parent = v.Character end
					if v.Character.Torso:findFirstChild("Pants") then v.Character.Torso.Pants.Parent = v.Character end
					v.Character.Torso.Transparency = 0
					v.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(90),math.rad(180),0)
					v.Character.Torso["Right Shoulder"].C0 = CFrame.new(1,.5,0) * CFrame.Angles(0,math.rad(90),0)
					v.Character.Torso["Left Shoulder"].C0 = CFrame.new(-1,.5,0) * CFrame.Angles(0,math.rad(-90),0)
					v.Character.Torso["Right Hip"].C0 = CFrame.new(1,-1,0) * CFrame.Angles(0,math.rad(90),0)
					v.Character.Torso["Left Hip"].C0 = CFrame.new(-1,-1,0) * CFrame.Angles(0,math.rad(-90),0)
					for a, part in pairs(v.Character:children()) do if part:IsA("BasePart") then part.BrickColor = BrickColor.new("White") if part.Name == "FAKETORSO" then part:Destroy() end elseif part:findFirstChild("NameTag") then part.Head.BrickColor = BrickColor.new("White") end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Turn the target player(s) into a creeper',-1,server.Prefix,{'creeper','creeperify'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
				if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
				if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
				v.Character.Torso.Transparency = 0
				v.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(90),math.rad(180),0)
				v.Character.Torso["Right Shoulder"].C0 = CFrame.new(0,-1.5,-.5) * CFrame.Angles(0,math.rad(90),0)
				v.Character.Torso["Left Shoulder"].C0 = CFrame.new(0,-1.5,-.5) * CFrame.Angles(0,math.rad(-90),0)
				v.Character.Torso["Right Hip"].C0 = CFrame.new(0,-1,.5) * CFrame.Angles(0,math.rad(90),0)
				v.Character.Torso["Left Hip"].C0 = CFrame.new(0,-1,.5) * CFrame.Angles(0,math.rad(-90),0)
				for a, part in pairs(v.Character:children()) do if part:IsA("BasePart") then part.BrickColor = BrickColor.new("Bright green") if part.Name == "FAKETORSO" then part:Destroy() end elseif part:findFirstChild("NameTag") then part.Head.BrickColor = BrickColor.new("Bright green") end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Turn the target player(s) back to normal',-1,server.Prefix,{'uncreeper','uncreeperify'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then
				if v.Character.Torso:findFirstChild("Shirt") then v.Character.Torso.Shirt.Parent = v.Character end
				if v.Character.Torso:findFirstChild("Pants") then v.Character.Torso.Pants.Parent = v.Character end
				v.Character.Torso.Transparency = 0
				v.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(90),math.rad(180),0)
				v.Character.Torso["Right Shoulder"].C0 = CFrame.new(1,.5,0) * CFrame.Angles(0,math.rad(90),0)
				v.Character.Torso["Left Shoulder"].C0 = CFrame.new(-1,.5,0) * CFrame.Angles(0,math.rad(-90),0)
				v.Character.Torso["Right Hip"].C0 = CFrame.new(1,-1,0) * CFrame.Angles(0,math.rad(90),0)
				v.Character.Torso["Left Hip"].C0 = CFrame.new(-1,-1,0) * CFrame.Angles(0,math.rad(-90),0)
				for a, part in pairs(v.Character:children()) do if part:IsA("BasePart") then part.BrickColor = BrickColor.new("White") if part.Name == "FAKETORSO" then part:Destroy() end elseif part:findFirstChild("NameTag") then part.Head.BrickColor = BrickColor.new("White") end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Give the target player(s) a larger ego',-1,server.Prefix,{'bighead'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then v.Character.Head.Mesh.Scale = Vector3.new(3,3,3) v.Character.Torso.Neck.C0 = CFrame.new(0,1.9,0) * CFrame.Angles(math.rad(90),math.rad(180),0) end
			end)
		end
	end)
	
	server.MakeCommand('Resize the target player(s)\'s character by <number>',-1,server.Prefix,{'resize','size'},{'player','number'},function(plr,args)
		if tonumber(args[2])>50 then args[2]=50 end
		args[2]=tonumber(args[2])
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
		 if not (v and v.Character and v.Character:findFirstChild('Torso') and v.Character:findFirstChild('HumanoidRootPart')) then return end
			local resizee=require(deps.ScalingCharacter)
			local char=resizee.new(v.Character)
			char:Resize(args[2])
			server.Remote(v,'Function','SetResizeCameraHeight')
			local cape=v.Character:findFirstChild("nBDCape")
			if cape then cape:Destroy() end
		end
	end)	
	
	server.MakeCommand('Resize the target player(s)\'s character by <number>',-1,server.Prefix,{'oldresize','oldsize'},{'player','number'},function(plr,args)
		if tonumber(args[2])>50 then args[2]=50 end
		args[2]=tonumber(args[2])
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
		 if not (v and v.Character and v.Character:findFirstChild('Torso') and v.Character:findFirstChild('HumanoidRootPart')) then return end
			local ags = {c = v.Character, t = v.Character.Torso, r = v.Character.HumanoidRootPart}
			ags.t.Anchored = true ags.t.BottomSurface = 0 ags.t.TopSurface = 0
			local welds = {} 
			for i2,v2 in pairs(ags.c:children()) do
			if v2:IsA('BasePart') then 
				v2.Anchored = true
			end
			end
			local function size(p)
			for i2,v2 in pairs(p:children()) do
			if (v2:IsA('Weld') or v2:IsA('Motor') or v2:IsA('Motor6D')) and v2.Part1 and v2.Part1:IsA("Part") then
			local p1 = v2.Part1 
			p1.Anchored = true 
			v2.Part1 = nil
			local r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12 = v2.C0:components() v2.C0 = CFrame.new(r1*args[2],r2*args[2],r3*args[2],r4,r5,r6,r7,r8,r9,r10,r11,r12)
			local r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12 = v2.C1:components() v2.C1 = CFrame.new(r1*args[2],r2*args[2],r3*args[2],r4,r5,r6,r7,r8,r9,r10,r11,r12)
			if p1.Name ~= 'Head' and p1.Name ~= 'Torso' then
			p1.formFactor = 3
			p1.Size = p1.Size*args[2]
			elseif p1.Name ~= 'Torso' then
			p1.Anchored = true
			for i3,v3 in pairs(p1:children()) do if v3:IsA('Weld') then v3.Part0 = nil v3.Part1.Anchored = true end end
			p1.formFactor = 3 p1.Size = p1.Size*args[2]
			for i3,v3 in pairs(p1:children()) do if v3:IsA('Weld') then v3.Part0 = p1 v3.Part1.Anchored = false end end
			end
			if v2.Parent == ags.t then p1.BottomSurface = 0 p1.TopSurface = 0 end
			p1.Anchored = false
			v2.Part1 = p1
			if v2.Part0 == ags.t then table.insert(welds,v2) p1.Anchored = true v2.Part0 = nil end
			elseif v2:IsA('CharacterMesh') then
			local bp = tostring(v2.BodyPart):match('%w+.%w+.(%w+)')
			local msh = Instance.new('SpecialMesh')
			elseif v2:IsA('SpecialMesh') and v2.Parent ~= ags.c.Head then 
				v2.Scale = v2.Scale*args[2]
			end 
			size(v2)
			end
			end
			size(ags.c)
			ags.t.formFactor = 3
			ags.t.Size = ags.t.Size*args[2]
			for i2,v2 in pairs(welds) do v2.Part0 = ags.t v2.Part1.Anchored = false end
			for i2,v2 in pairs(ags.c:children()) do if v2:IsA('BasePart') then v2.Anchored = false end end
			local weld = Instance.new('Weld',ags.r) weld.Part0 = ags.r weld.Part1 = ags.t
			local cape=ags.c:findFirstChild("nBDCape")
			if cape then
				cape.Size=cape.Size*args[2]
				server.Remote(v,'Function','MoveCape',cape)
			end
		end
	end)
	
	server.MakeCommand('Give the target player(s) a small head',-1,server.Prefix,{'smallhead','minihead'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then v.Character.Head.Mesh.Scale = Vector3.new(.75,.75,.75) v.Character.Torso.Neck.C0 = CFrame.new(0,.8,0) * CFrame.Angles(math.rad(90),math.rad(180),0) end
			end)
		end
	end)
	
	server.MakeCommand('Fling the target player(s)',2,server.Prefix,{'fling'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") and v.Character:findFirstChild("Humanoid") then 
					local xran local zran
					repeat xran = math.random(-9999,9999) until math.abs(xran) >= 5555
					repeat zran = math.random(-9999,9999) until math.abs(zran) >= 5555
					v.Character.Humanoid.Sit = true v.Character.Torso.Velocity = Vector3.new(0,0,0)
					local frc = Instance.new("BodyForce", v.Character.Torso) frc.Name = "BFRC" frc.force = Vector3.new(xran*4,9999*5,zran*4) service.Debris:AddItem(frc,.1)
				end
			end)
		end
	end)
	
	server.MakeCommand('Super fling the target player(s)',2,server.Prefix,{'sfling','tothemoon','superfling'},{'player','optional strength'},function(plr,args)
		local strength = tonumber(args[2]) or 5e6	
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,"Function","SuperFling",strength)
		end
	end)
	
	server.MakeCommand('Make the target player(s)\'s character spazz out on the floor',-1,server.Prefix,{'seizure'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character:FindFirstChild('Torso') then 
					v.Character.Torso.CFrame = v.Character.Torso.CFrame * CFrame.Angles(math.rad(90),0,0) 
					server.Remote(v,'Function','Effect','seizure')
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes the effects of the seizure command',-1,server.Prefix,{'unseizure'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			server.Remote(v,'Function','Effect','unseizure')
		end
	end)
	
	server.MakeCommand('Remove the target player(s)\'s arms and legs',-1,server.Prefix,{'removelimbs','delimb'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then 
					for a, obj in pairs(v.Character:children()) do 
						if obj:IsA("BasePart") and (obj.Name:find("Leg") or obj.Name:find("Arm")) then obj:Destroy() end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Name the target player(s) <name> or say hide to hide their character name',2,server.Prefix,{'name','rename'},{'player','name/hide'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if v.Character and v.Character:findFirstChild("Head") then 
	for a, mod in pairs(v.Character:children()) do if mod:findFirstChild("NameTag") then v.Character.Head.Transparency = 0 mod:Destroy() end end
	local char = v.Character
	local head = char:FindFirstChild('Head')
	local mod = Instance.new("Model", char) mod.Name = args[2] or ''
	local cl = char.Head:Clone() cl.Parent = mod 
	local hum = Instance.new("Humanoid", mod) 
	hum.Name = "NameTag" 
	hum.MaxHealth=v.Character.Humanoid.MaxHealth
	wait()
	hum.Health=v.Character.Humanoid.Health
	cPcall(function()
	if args[2]:lower()=='hide' then
		mod.Name=''
		hum.MaxHealth=0
		hum.Health=0
	else
		v.Character.Humanoid.Changed:connect(function(c)
			hum.MaxHealth=v.Character.Humanoid.MaxHealth
			wait()
			hum.Health=v.Character.Humanoid.Health
		end)
	end
	end)
	cl.CanCollide=false
	local weld = Instance.new("Weld", cl) weld.Part0 = cl weld.Part1 = char.Head
	char.Head.Transparency = 1
	end
	end)
	end
	end)
	
	server.MakeCommand('Put the target player(s)\'s back to normal',2,server.Prefix,{'unname','fixname'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character and v.Character:findFirstChild("Head") then 
					for a, mod in pairs(v.Character:children()) do if mod:findFirstChild("NameTag") then v.Character.Head.Transparency = 0 mod:Destroy() end end
				end
			end)
		end
	end)
	
	server.MakeCommand('Change the target player(s)\'s Right Leg package',-1,server.Prefix,{'rleg','rightleg','rightlegpackage'},{'player','id'},function(plr,args)
		local id=service.MarketPlace:GetProductInfo(args[2]).AssetTypeId
		if id~=31 then server.Remote(plr,'Function','OutputGui','Id is not a right leg!') return end
		local part=service.InsertService:LoadAsset(args[2]):children()[1]
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			for k,m in pairs(v.Character:children()) do if m:IsA('CharacterMesh') and m.BodyPart=='RightLeg' then m:Destroy() end end
			part.Parent=v.Character
		end
	end)
	
	server.MakeCommand('Change the target player(s)\'s Left Leg package',-1,server.Prefix,{'lleg','leftleg','leftlegpackage'},{'player','id'},function(plr,args)
		local id=service.MarketPlace:GetProductInfo(args[2]).AssetTypeId
		if id~=30 then server.Remote(plr,'Function','OutputGui','Id is not a left leg!') return end
		local part=service.InsertService:LoadAsset(args[2]):children()[1]
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			for k,m in pairs(v.Character:children()) do if m:IsA('CharacterMesh') and m.BodyPart=='LeftLeg' then m:Destroy() end end
			part.Parent=v.Character
		end
	end)
	
	server.MakeCommand('Change the target player(s)\'s Right Arm package',-1,server.Prefix,{'rarm','rightarm','rightarmpackage'},{'player','id'},function(plr,args)
		local id=service.MarketPlace:GetProductInfo(args[2]).AssetTypeId
		if id~=28 then server.Remote(plr,'Function','OutputGui','Id is not a right arm!') return end
		local part=service.InsertService:LoadAsset(args[2]):children()[1]
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			for k,m in pairs(v.Character:children()) do if m:IsA('CharacterMesh') and m.BodyPart=='RightArm' then m:Destroy() end end
			part.Parent=v.Character
		end
	end)
	
	server.MakeCommand('Change the target player(s)\'s Left Arm package',-1,server.Prefix,{'larm','leftarm','leftarmpackage'},{'player','id'},function(plr,args)
		local id=service.MarketPlace:GetProductInfo(args[2]).AssetTypeId
		if id~=29 then server.Remote(plr,'Function','OutputGui','Id is not a left arm!') return end
		local part=service.InsertService:LoadAsset(args[2]):children()[1]
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			for k,m in pairs(v.Character:children()) do if m:IsA('CharacterMesh') and m.BodyPart=='LeftArm' then m:Destroy() end end
			part.Parent=v.Character
		end
	end)
	
	server.MakeCommand('Change the target player(s)\'s Left Arm package',-1,server.Prefix,{'torso','torsopackage'},{'player','id'},function(plr,args)
		local id=service.MarketPlace:GetProductInfo(args[2]).AssetTypeId
		if id~=27 then server.Remote(plr,'Function','OutputGui','Id is not a torso!') return end
		local part=service.InsertService:LoadAsset(args[2]):children()[1]
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			for k,m in pairs(v.Character:children()) do if m:IsA('CharacterMesh') and m.BodyPart=='Torso' then m:Destroy() end end
			part.Parent=v.Character
		end
	end)
	
	server.MakeCommand('Removes the target player(s)\'s Package',2,server.Prefix,{'removepackage','nopackage'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				for k,m in pairs(v.Character:children()) do
					if m:IsA("CharacterMesh") then m:Destroy() end
				end
			end)
		end
	end)
	
	server.MakeCommand('Changes the target player(s)\'s character appearence to <ID>',2,server.Prefix,{'char','character','appearance'},{'player','ID or player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if not service.Players:FindFirstChild(args[2]) then
					local userid=service.Players:GetUserIdFromNameAsync(args[2])
					if userid then args[2] = userid end
					v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId=" .. args[2]
					server.RunCommand(server.Prefix.."refresh",v.Name)
				else
					for k,m in pairs(server.GetPlayers(plr,args[2])) do
						v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId=" .. m.userId
						server.RunCommand(server.Prefix.."refresh",v.Name)
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Put the target player(s)\'s character appearence back to normal',2,server.Prefix,{'unchar','uncharacter','fixappearance'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then 
					v.CharacterAppearance = "http://www.roblox.com/asset/CharacterFetch.ashx?userId=" .. v.userId
					v:LoadCharacter()
				end
			end)
		end
	end)
	
	server.MakeCommand('Turn the target player(s) into a suit zombie',-1,server.Prefix,{'infect','zombify'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character then
					server.Infect(v.Character)
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target player(s)\'s character flash random colors',-1,server.Prefix,{'rainbowify','rainbow'},{'player'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	local parent=v:FindFirstChild('PlayerGui') or v:FindFirstChild('Backpack')
	if v and v.Character and v.Character:findFirstChild("Torso") then 
	if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
	if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
	server.Remote(v,'Function','Effect','rainbowify')
	end
	end)
	end
	end)
	
	server.MakeCommand('Make the target player(s)\'s character flash',-1,server.Prefix,{'flashify'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	local parent=v:FindFirstChild('PlayerGui') or v:FindFirstChild('Backpack')
	if v and v.Character and v.Character:findFirstChild("Torso") then 
	if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
	if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
	for a, sc in pairs(v.Character:children()) do if sc.Name == "ify" then sc:Destroy() end end
	server.Remote(v,'Function','Effect','flashify')
	end
	end)
	end
	end)
	
	server.MakeCommand('Make the target player(s) look like a noob',-1,server.Prefix,{'noobify','noob'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then
					for k,p in pairs(v.Character:children()) do
						if p:IsA("Shirt") or p:IsA("Pants") or p:IsA("CharacterMesh") or p:IsA("Hat") then
							p:Destroy()
						elseif p.Name=="Left Arm" or p.Name=="Right Arm" or p.Name=="Head" then
							p.BrickColor=BrickColor.new("Bright yellow")
						elseif p.Name=="Left Leg" or p.Name=="Right Leg" then
							p.BrickColor=BrickColor.new("Bright green")
						elseif p.Name=="Torso" then
							p.BrickColor=BrickColor.new("Bright blue")
						end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target the color you choose',-1,server.Prefix,{'color','bodycolor'},{'player','color'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then
					for k,p in pairs(v.Character:children()) do
						if p:IsA("Part") then
							if args[2] then
								local str = BrickColor.new('Institutional white').Color
								local teststr = args[2]
								if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr) end
								p.BrickColor = str
							end
						end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target the material you choose',-1,server.Prefix,{'mat','material'},{'player','material'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then
					for k,p in pairs(v.Character:children()) do
						if p:IsA("Shirt") or p:IsA("Pants") or p:IsA("ShirtGraphic") or p:IsA("CharacterMesh") or p:IsA("Hat") then
							p:Destroy()
						elseif p:IsA("Part") then
							p.Material = args[2]
							if args[3] then
								local str = BrickColor.new('Institutional white').Color
								local teststr = args[3]
								if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr) end
								p.BrickColor = str
							end
							if p.Name=="Head" then
								local mesh=p:FindFirstChild("Mesh") 
								if mesh then mesh:Destroy() end
							end
						end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target neon',-1,server.Prefix,{'neon','neonify'},{'player','(optional)color'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v.Character then
					for k,p in pairs(v.Character:children()) do
						if p:IsA("Shirt") or p:IsA("Pants") or p:IsA("ShirtGraphic") or p:IsA("CharacterMesh") or p:IsA("Hat") then
							p:Destroy()
						elseif p:IsA("Part") then
							if args[2] then
								local str = BrickColor.new('Institutional white').Color
								local teststr = args[2]
								if BrickColor.new(teststr) ~= nil then str = BrickColor.new(teststr) end
								p.BrickColor = str
							end
							p.Material = "Neon"
							if p.Name=="Head" then
								local mesh=p:FindFirstChild("Mesh") 
								if mesh then mesh:Destroy() end
							end
						end
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Turn the target player(s) into a ghost',-1,server.Prefix,{'ghostify','ghost'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then 
					server.Remote(v,'Function','Noclip','norm')
					if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
					if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
					for a, sc in pairs(v.Character:children()) do if sc.Name == "ify" then sc:Destroy() end end
					for a, prt in pairs(v.Character:children()) do 
					if prt:IsA("BasePart") and prt.Name~='HumanoidRootPart' and (prt.Name ~= "Head" or not prt.Parent:findFirstChild("NameTag", true)) then 
						prt.Transparency = .5 
						prt.Reflectance = 0 
						prt.BrickColor = BrickColor.new("Institutional white")
						if prt.Name:find("Leg") then 
							prt.Transparency = 1 end
						elseif prt:findFirstChild("NameTag") then 
							prt.Head.Transparency = .5 
							prt.Head.Reflectance = 0 
							prt.Head.BrickColor = BrickColor.new("Institutional white")
						end 
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target player(s) look like gold',-1,server.Prefix,{'goldify','gold'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v.Character and v.Character:findFirstChild("Torso") then 
				if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
				if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
				for a, sc in pairs(v.Character:children()) do if sc.Name == "ify" then sc:Destroy() end end
				for a, prt in pairs(v.Character:children()) do if prt:IsA("BasePart") and prt.Name~='HumanoidRootPart' and (prt.Name ~= "Head" or not prt.Parent:findFirstChild("NameTag", true)) then 
				prt.Transparency = 0 prt.Reflectance = .4 prt.BrickColor = BrickColor.new("Bright yellow")
				elseif prt:findFirstChild("NameTag") then prt.Head.Transparency = 0 prt.Head.Reflectance = .4 prt.Head.BrickColor = BrickColor.new("Bright yellow")
				end 
				end
				end
			end)
		end
	end)
	
	server.MakeCommand('Make the target player(s)\'s character shiney',-1,server.Prefix,{'shiney','shineify','shine'},{'player'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if v and v.Character and v.Character:findFirstChild("Torso") then 
	if v.Character:findFirstChild("Shirt") then v.Character.Shirt.Parent = v.Character.Torso end
	if v.Character:findFirstChild("Pants") then v.Character.Pants.Parent = v.Character.Torso end
	for a, sc in pairs(v.Character:children()) do if sc.Name == "ify" then sc:Destroy() end end
	for a, prt in pairs(v.Character:children()) do if prt:IsA("BasePart") and prt.Name~='HumanoidRootPart' and (prt.Name ~= "Head" or not prt.Parent:findFirstChild("NameTag", true)) then 
	prt.Transparency = 0 prt.Reflectance = 1 prt.BrickColor = BrickColor.new("Institutional white")
	elseif prt:findFirstChild("NameTag") then prt.Head.Transparency = 0 prt.Head.Reflectance = 1 prt.Head.BrickColor = BrickColor.new("Institutional white")
	end end
	end
	end)
	end
	end)
	
	server.MakeCommand('Make the target player(s) look normal',-1,server.Prefix,{'normal','normalify'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if v and v.Character and v.Character:findFirstChild("Torso") then
	if v.Character:findFirstChild("Head") then v.Character.Head.Mesh.Scale = Vector3.new(1.25,1.25,1.25) end 
	if v.Character.Torso:findFirstChild("Shirt") then v.Character.Torso.Shirt.Parent = v.Character end
	if v.Character.Torso:findFirstChild("Pants") then v.Character.Torso.Pants.Parent = v.Character end
	v.Character.Torso.Transparency = 0
	v.Character.Torso.Neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.rad(90),math.rad(180),0)
	v.Character.Torso["Right Shoulder"].C0 = CFrame.new(1,.5,0) * CFrame.Angles(0,math.rad(90),0)
	v.Character.Torso["Left Shoulder"].C0 = CFrame.new(-1,.5,0) * CFrame.Angles(0,math.rad(-90),0)
	v.Character.Torso["Right Hip"].C0 = CFrame.new(1,-1,0) * CFrame.Angles(0,math.rad(90),0)
	v.Character.Torso["Left Hip"].C0 = CFrame.new(-1,-1,0) * CFrame.Angles(0,math.rad(-90),0)
	local parent=v:FindFirstChild('PlayerGui') or v:FindFirstChild('Backpack')
	for a, sc in pairs(parent:children()) do if sc.Name == server.CodeName.."ify" or sc.Name==server.CodeName..'Glitch' or sc.Name == server.CodeName.."nBDPoison" then sc:Destroy() end end
	for a, prt in pairs(v.Character:children()) do
	if prt:IsA("BasePart") and (prt.Name ~= "Head" or not prt.Parent:findFirstChild("NameTag", true)) then 
	prt.Transparency = 0 prt.Reflectance = 0 prt.BrickColor = BrickColor.new("White")
	if prt.Name == "FAKETORSO" then prt:Destroy() end
	if prt.Name == 'HumanoidRootPart' then prt.Transparency=1 end
	elseif prt:findFirstChild("NameTag") then 
		prt.Head.Transparency = 0 prt.Head.Reflectance = 0 prt.Head.BrickColor = BrickColor.new("White")
	elseif prt.Name=='nBD Puke' or prt.Name=='nBD Bleed' then
		prt:Destroy()
	elseif prt.Name==v.Name..'nBDcrusify' then
		server.RunCommand(server.Prefix..'refresh',v.Name)
	end 
	end
	end
	end)
	end
	end)
	
	server.MakeCommand('Makes the target player(s)\'s screen rapidly change colors',-1,server.Prefix,{'trippy'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','trippy')
		end
	end)
	
	server.MakeCommand('Removes any effects on the target player(s)',-1,server.Prefix,{'uneffect','uneffectgui','unblind','unstrobe','untrippy','undance','unflashify','unrainbowify','guifix','fixgui'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','off')
		end
	end)
	
	server.MakeCommand('Reverses the effects of the iceskate/slip command',-1,server.Prefix,{'unslip','unslippery','uniceskate'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','unslip')
		end
	end)
	
	server.MakeCommand('Makes the target player(s)\'s screen flash rapidly',-1,server.Prefix,{'strobe'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','strobe')
		end
	end)
	
	server.MakeCommand('Blinds the target player(s)',-1,server.Prefix,{'blind'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','blind')
		end
	end)
	
	server.MakeCommand('Loop heals the target player(s)',2,server.Prefix,{'loopheal'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','loopheal')
		end
	end)
	
	server.MakeCommand('UnLoop Heal',2,server.Prefix,{'unloopheal'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do 
			server.Remote(v,'Function','Effect','unloopheal')
		end
	end)
	
	server.MakeCommand('Loop flings the target player(s)',-1,server.Prefix,{'loopfling'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','loopfling')
		end
	end)
	
	server.MakeCommand('UnLoop Fling',-1,server.Prefix,{'unloopfling'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do 
			server.Remote(v,'Function','Effect','unloopfling')
		end
	end)
	
	server.MakeCommand('Force the target player(s) to teleport to the desired place',5,server.Prefix,{'forceplace'},{'player','placeid'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				service.TeleportService:Teleport(args[2],v)
			end)
		end
	end)
	
	server.MakeCommand('Ban the target player(s) forever. Can only be undone by changing the PermBanKey.',5,server.Prefix,{'permban'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(plr,'Function','PromptPermBan',v)
		end
	end)
	
	server.MakeCommand('View and change settings',5,server.Prefix,{'settings'},{},function(plr,args)
		for i,v in pairs(UpdatableSettings) do
			if server[v]~=nil then server.Remote(plr,'SetSetting',v,server[v]) end
		end
		server.Remote(plr,'SetSetting','UpdatableSettings',UpdatableSettings)
		wait(0.5)
		server.Remote(plr,'Function','Settings')
	end)
	
	server.MakeCommand('Change command permissions',5,server.Prefix,{'perms','permissions','comperms'},{server.Prefix..'cmd','all/donor/temp/admin/owner/creator'},function(plr,args)
		local level=nil
		if args[2]:lower()=='all' or args[2]:lower()=='0' then
			level=0
		elseif args[2]:lower()=='donor' or args[2]:lower()=='1' then
			level=1
		elseif args[2]:lower()=='temp' or args[2]:lower()=='2' then
			level=2
		elseif args[2]:lower()=='admin' or args[2]:lower()=='3' then
			level=3
		elseif args[2]:lower()=='owner' or args[2]:lower()=='4' then
			level=4
		elseif args[2]:lower()=='creator' or args[2]:lower()=='5' then
			level=5
		elseif args[2]:lower()=='funtemp' or args[2]:lower()=='-1' then
			level=-1
		elseif args[2]:lower()=='funadmin' or args[2]:lower()=='-2' then
			level=-2
		elseif args[2]:lower()=='funowner' or args[2]:lower()=='-3' then
			level=-3
		end
		if level~=nil then
			for i=1,#server.Commands do
				if args[1]:lower()==server.Commands[i].Prefix..server.Commands[i].Cmds[1]:lower() then 	
					server.Commands[i].AdminLevel=level
					server.Hint("server "..server.Commands[i].Prefix..server.Commands[i].Cmds[1].." permission level to "..level,{plr})
				end
			end
		else
			server.OutputGui(plr,'Command Error:','Invalid Permission')
		end
	end)
	
	server.MakeCommand('Restore the map to the the way it was the last time it was backed up',3,server.Prefix,{'restoremap','maprestore','rmap'},{},function(plr,args)
		server.Hint('Restoring Map...',service.Players:children())
		for i,v in pairs(service.Workspace:children()) do
			if v~=script and v.Archivable==true and not v:IsA('Terrain') then
				pcall(function() v:Destroy() end)
			end
		end
		for i,v in pairs(server.MapBackup:children()) do
			v:Clone().Parent=service.Workspace
		end
		server.ProcessCommand("SYSTEM",server.Prefix.."respawn"..server.SplitKey..server.SpecialPrefix.."all",true)
		server.Hint('Map Restore Complete.',service.Players:children())
	end)
	
	server.MakeCommand('Changes the backup for the restore map command to the map\'s current state',4,server.Prefix,{'backupmap','mapbackup','bmap'},{},function(plr,args)
		server.Hint('Updating Map Backup...',{plr})
		local tempmodel=Instance.new('Model')
		for i,v in pairs(service.Workspace:children()) do
			if v and not v:IsA('Terrain') and v.Archivable==true and v~=script and v~=RemoteEvent then
				v:Clone().Parent=tempmodel
			end
		end
		server.MapBackup=tempmodel:Clone()
		tempmodel:Destroy()
		server.Hint('Backup Complete',{plr})
	end)
	
	server.MakeCommand('Lets you explore the game, kinda like a file browser',4,server.Prefix,{'explore','explorer'},{},function(plr,args)
		server.Remote(plr,'Function','Explorer')
	end)
	
	server.MakeCommand('Makes a tornado on the target player(s)',4,server.Prefix,{'tornado','twister'},{'player','optional time'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			local p=Instance.new('Part',service.Workspace)
			table.insert(server.objects,p)
			p.Transparency=1
			p.CFrame=v.Character.Torso.CFrame+Vector3.new(0,-3,0)
			p.Size=Vector3.new(0.2,0.2,0.2)
			p.Anchored=true
			p.CanCollide=false
			p.Archivable=false
			local tornado=deps.Tornado:clone()
			tornado.Parent=p
			tornado.Disabled=false
			if args[2] and tonumber(args[2]) then
				for i=1,tonumber(args[2]) do
					if not p or not p.Parent then
						return
					end
					wait(1)
				end
				if p then p:Destroy() end
			end
		end
	end)
	
	server.MakeCommand('Nuke the target player(s)',4,server.Prefix,{'nuke'},{'player'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if v and v.Character and v.Character:findFirstChild("Torso") then
	local p = Instance.new("Part",game.Workspace) table.insert(server.objects,p)
	p.Anchored = true
	p.CanCollide = false
	p.formFactor = "Symmetric"
	p.Shape = "Ball"
	p.Size = Vector3.new(1,1,1)
	p.BrickColor = BrickColor.new("New Yeller")
	p.Transparency = .5
	p.Reflectance = .2
	p.TopSurface = 0
	p.BottomSurface = 0
	local ex = Instance.new("Explosion", service.Workspace)
	ex.Position = p.Position
	ex.BlastRadius = 100000
	ex.BlastPressure = math.huge
	ex.Hit:connect(function(hit)
	if hit:IsA('Part') and hit~=p then hit.Anchored=false end
	hit:BreakJoints()
	end)
	p.Touched:connect(function(hit)
	if hit and hit.Parent then
	local ex = Instance.new("Explosion", game.Workspace)
	ex.Position = hit.Position
	ex.BlastRadius = 100000
	ex.BlastPressure = math.huge
	if hit:IsA('Part') then hit.Anchored=false end
	hit:BreakJoints()
	end
	end)
	local cf = v.Character.Torso.CFrame
	p.CFrame = cf
	for i = 1, 333 do
	p.Size = p.Size + Vector3.new(3,3,3)
	p.CFrame = cf
	wait(1/44)
	end
	p:Destroy()
	end
	end)
	end
	end)
	
	server.MakeCommand('View script error log',5,":",{'debuglogs','errorlogs'},{},function(plr,args)
		local tab={}
		for i,v in pairs(DebugErrorsLog) do
			table.insert(tab,{Object=v.Player.." | "..v.Error:sub(1,20),Desc=v.Error})
		end
		server.Remote(plr,"Function","ListGui","Errors",tab)
	end)
	
	server.MakeCommand('View server log',5,":",{'serverlog','serverlogs','serveroutput'},{'messagetype/all'},function(plr,args)
		local temp={}
		for i,v in pairs(game.LogService:GetLogHistory()) do
			if (args[1] and args[1]:lower()=='script') and v.message:find('nBD') then
				if v.messageType==Enum.MessageType.MessageOutput then
					table.insert(temp,{Object=v.message,Desc='Output: '..v.message})
				elseif v.messageType==Enum.MessageType.MessageWarning then
					table.insert(temp,{Object=v.message,Desc='Warning: '..v.message,Color=Color3.new(1,1,0)})
				elseif v.messageType==Enum.MessageType.MessageInfo then
					table.insert(temp,{Object=v.message,Desc='Info: '..v.message,Color=Color3.new(0,0,1)})
				elseif v.messageType==Enum.MessageType.MessageError then
					table.insert(temp,{Object=v.message,Desc='Error: '..v.message,Color=Color3.new(1,0,0)})
				end
			else 
			if (not args[1] or args[1]:lower()=='all' or args[1]:lower()=='error') and v.messageType==Enum.MessageType.MessageError then
				table.insert(temp,{Object=v.message,Desc='Error: '..v.message,Color=Color3.new(1,0,0)})
			end
			if (not args[1] or args[1]:lower()=='all' or args[1]:lower()=='info') and v.messageType==Enum.MessageType.MessageInfo then
				table.insert(temp,{Object=v.message,Desc='Info: '..v.message,Color=Color3.new(0,0,1)})
			end
			if (not args[1] or args[1]:lower()=='all' or args[1]:lower()=='warning') and v.messageType==Enum.MessageType.MessageWarning then
				table.insert(temp,{Object=v.message,Desc='Warning: '..v.message,Color=Color3.new(1,1,0)})
			end
			if (not args[1] or args[1]:lower()=='all' or args[1]:lower()=='output') and v.messageType==Enum.MessageType.MessageOutput then
				table.insert(temp,{Object=v.message,Desc='Output: '..v.message})
			end
			end
		end
		server.Remote(plr,'Function','ListGui','Server Log',temp,'serverlogstuff-'..(args[1] or 'all'),1300)
	end)
	
	server.MakeCommand('View the admin logs for the server',3,server.Prefix,{'logs','log','commandlogs'},{},function(plr,args)
		local temp={}
		for i,m in pairs(server.PlayerLogs.Admin) do
			table.insert(temp,{Object='['..m.Time..'] '..m.Name..': '..m.Log,Desc=m.Log})
		end
		--server.Remote(plr,'SetSetting','logs',server.logs)
		server.Remote(plr,'Function','ListGui','Admin Logs',temp,'adminlogs')
	end)
	
	server.MakeCommand('Displays the current chat logs for the server',2,server.Prefix,{'chatlogs','chatlog'},{},function(plr,args)
		local temp={}
		for i,m in ipairs(server.PlayerLogs.Chat) do
			if m.Nil then
				table.insert(temp,{Object='[NIL]['..m.Time..'] '..m.Name..': '..m.Chat,Desc=m.Chat})
			else
				table.insert(temp,{Object='['..m.Time..'] '..m.Name..': '..m.Chat,Desc=m.Chat})
			end
		end
		server.Remote(plr,'Function','ListGui','Chat Logs',temp,'chatlogs')
	end)
	
	server.MakeCommand('Displays the current join logs for the server',2,server.Prefix,{'joinlogs','joinlog'},{},function(plr,args)
		local temp={}
		for i,m in ipairs(server.PlayerLogs.Joins) do
			table.insert(temp,{Object='['..m.Time..'] '..m.Name,Desc=m.Time.." - "..m.Name:lower()})
		end
		server.Remote(plr,'Function','ListGui','Chat Logs',temp,'joinlogs')
	end)
	
	server.MakeCommand('View the exploit logs for the server OR a specific player',2,server.Prefix,{'exploitlogs','exploitlog','sploitlogs','detections'},{},function(plr,args)
		local temp={}
		for i,m in ipairs(server.PlayerLogs.Exploit) do
			table.insert(temp,{Object='['..m.Time..'] '..m.Name..': '..m.Info:match(".*]"),Desc=m.Info})
		end
		server.Remote(plr,'Function','ListGui','Exploit Logs',temp,'exploitlogs')
	end)
	
	server.MakeCommand('Uses einsteinK\'s LoadstringParser & LBI. Lets you run code on the server',3,server.Prefix,{'s','scr','script'},{'code'},function(plr,args)
		--if server.canuseloadstring then
			server.Output(args[1], plr)
			--server.LoadScript('Loadstring',args[1],server.AssignName(),true,server.ServerScriptService)
		--else 
			--server.Hint('LoadStringEnabled is set to false! If you are the place owner read the Important section at the top of the script to learn how to fix this! Attempting to run using LoadstringParser.',{plr})
			server.LoadScript('Script',args[1],server.AssignName(),true,server.ServerScriptService)	
		--end
	end)
	
	server.MakeCommand('Uses einsteinK\'s LoadstringParser & LBI. . Very limited. No apparent ROBLOX stuff. Lets you run code as a local script',3,server.Prefix,{'ls','lscr','localscript'},{'code'},function(plr,args)
		--if not server.canuseloadstring then server.Hint('[Currently no longer works] Loadstrings are disabled, output will not be shown',{plr}) return end
		server.LoadOnClient(plr,args[1],true,server.AssignName())
		--server.Output(args[1], plr)
	end)
	
	server.MakeCommand('Uses einsteinK\'s LoadstringParser & LBI. . Very limited. No apparent ROBLOX stuff. Lets you run local scripts on the target player(s)',3,server.Prefix,{'cs','cscr','clientscript'},{'player','code'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			--if not server.canuseloadstring then server.Hint('[Currently no longer works] Loadstrings are disabled, output will not be shown',{plr}) return end
			server.LoadOnClient(v,args[2],true,server.AssignName())
			--server.Output(args[2], plr)
		end
	end)
	
	server.MakeCommand('Makes it so the target player(s) can\'t talk',3,server.Prefix,{'mute','silence'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if server.CheckTrueOwner(plr) or not server.CheckAdmin(v, false) then  
				server.Remote(v,'Function','MutePlayer','on')
				table.insert(server.MuteList,v.Name..'='..v.userId)
			end
		end
	end)
	
	server.MakeCommand('Makes it so the target player(s) can talk again. No effect if on Trello mute list.',3,server.Prefix,{'unmute'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function() 
				for k,m in pairs(server.MuteList) do
					if v.Name==m or m==v.Name..'='..v.userId then
						table.remove(server.MuteList,k) 
						server.Remote(v,'Function','MutePlayer','off')
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Shows a list of currently muted players, like a ban list, but for mutes instead of bans',3,server.Prefix,{'mutelist','mutes','muted'},{},function(plr,args)
		local list = {}
		for i,v in pairs(server.MuteList) do
			table.insert(list,v)
		end
		for i,v in pairs(server.TRELLOmutl) do
			table.insert(list,v)
		end
		server.Remote(plr,'Function','ListGui','Mute List',list)
	end)
	
	server.MakeCommand('Tells the target player(s) they are not allowed to talk if they do and eventually kicks them',3,server.Prefix,{'notalk'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if not v:FindFirstChild('NoTalk') and not server.CheckAdmin(v,false) then
		local talky=Instance.new('IntValue',v)
		talky.Name='NoTalk'
		talky.Value=0
	end
	end)
	end
	end)
	
	server.MakeCommand('Un-NoTalk',3,server.Prefix,{'unnotalk'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and v:FindFirstChild('NoTalk') then
					v.NoTalk:Destroy()
				end
			end)
		end
	end)
		
	server.MakeCommand('Loop kills the target player(s)',3,server.Prefix,{'loopkill'},{'player','num(optional)'},function(plr,args)
		local num = 9999
		if args[2] then if type(tonumber(args[2])) == "number" then num = tonumber(args[2]) end end
			for i,v in pairs(server.GetPlayers(plr,args[1])) do
				if server.CheckTrueOwner(plr) or not server.CheckAdmin(v, false)  then
				server.Remote(v,'Function','Effect','loopkill',num)
			end
		end
	end)
	
	server.MakeCommand('Makes a note on the target player(s) that says <note>',3,server.Prefix,{'note','writenote','makenote'},{'player','note'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			local notes=v:LoadInstance('Admin Notes')
			if not notes then
				notes=Instance.new('Model')
			end
			notes.Name='Admin Notes'
			local note = Instance.new("StringValue", notes)
			note.Name = args[2]
			server.Hint('Added '..v.Name..' Note '..note.Name,{plr})
			v:SaveInstance("Admin Notes", notes)
		end
	end)
	
	server.MakeCommand('Removes a note on the target player(s)',3,server.Prefix,{'removenote'},{'player','note'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v, false) then
				local notes=v:LoadInstance('Admin Notes')
				if notes then
					if args[2]:lower() == "all" then
						notes:ClearAllChildren()
					else
						for k,m in pairs(notes:children()) do
							if m.Name:lower():sub(1,#args[2]) == args[2]:lower() then
								server.Hint('Removed '..v.Name..' Note '..m.Name,{plr})
								m:Destroy()
							end
						end
					end
					v:SaveInstance("Admin Notes", notes)
				end
			end
		end
	end)
	
	server.MakeCommand('Views notes on the target player(s)',3,server.Prefix,{'notes','viewnotes'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			local temptable={}
			local notes=v:LoadInstance('Admin Notes')
			if not notes then server.Hint('No notes on '..v.Name,{plr}) return end
			for k,m in pairs(notes:children()) do
				table.insert(temptable,m.Name)
			end
			server.Remote(plr,'Function','ListGui',v.Name,temptable)
		end
	end)
	
	server.MakeCommand('Tells you how many points the player has. Not PlayerPoints.',3,server.Prefix,{'points','viewpoints'},{'player'},function(plr,args)
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			local points=v:LoadNumber('Admin Points')
			if not points then 
				server.Hint(v.Name..' has 0 points.',{plr})
			else
				server.Hint(v.Name..' has '..points..' points.',{plr})
			end
		end
	end)
	
	server.MakeCommand('Gives the player <number> points. Not PlayerPoints.',3,server.Prefix,{'givepoints'},{'player','number'},function(plr,args)
		if not tonumber(args[2]) then server.Hint(args[2]..' is not a valid number.',{plr}) return end	
		local num=tonumber(args[2])
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			local points=v:LoadNumber('Admin Points')
			if not points then 
				v:SaveNumber('Admin Points',num)
			else
				v:SaveNumber('Admin Points',points+num)
			end
			server.Hint('Gave '..v.Name..' '..num..' points.',{plr})
		end
	end)
	
	server.MakeCommand('Takes away <number> points from the player. Not PlayerPoints.',3,server.Prefix,{'takepoints'},{'player','number'},function(plr,args)
		if not tonumber(args[2]) then server.Hint(args[2]..' is not a valid number.',{plr}) return end	
		local num=tonumber(args[2])
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			local points=v:LoadNumber('Admin Points')
			if not points then 
				v:SaveNumber('Admin Points',-num)
			else
				v:SaveNumber('Admin Points',points-num)
			end
			server.Hint('Took '..num..' points from '..v.Name..'.',{plr})
		end
	end)
	
	server.MakeCommand('Un-Loop Kill',3,server.Prefix,{'unloopkill'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do 
			server.Remote(v,'Function','Effect','unloopkill')
		end
	end)
	
	server.MakeCommand('Locks the server, makes it so only admins and people on the excluded list can join',3,server.Prefix,{'slock','serverlock'},{'on/off'},function(plr,args)
	if args[1]:lower()=='on' then
		server.slock=true 
		server.Hint("Server has been locked", service.Players:children()) 
	elseif args[1]:lower()=='off' then
		server.slock = false 
		server.Hint("Server has been unlocked", service.Players:children()) 
	end
	end)
	
	server.MakeCommand('Locks the server, makes it so only people in the group that is server in the group settings can join',3,server.Prefix,{'glock','grouplock','grouponlyjoin'},{'on/off'},function(plr,args)
	if args[1]:lower()=='on' then
		server['GroupOnlyJoin'] = true 
		server.Hint("Server is now Group Only.", service.Players:children())
	elseif args[1]:lower()=='off' then 
		server['GroupOnlyJoin'] = false 
		server.Hint("Server is no longer Group Only", service.Players:children()) 
	end
	end)
	
	server.MakeCommand('Same as message but says nBD message instead of your name, or whatever nBD message title is server to...',3,server.Prefix,{'sm','systemmessage'},{'message'},function(plr,args)
		server.Message(server.SystemMessageTitle, args[1], false, service.Players:children())
	end)
	
	server.MakeCommand('Same as hint but says nBD message instead of your name, or whatever nBD message title is server to...',3,server.Prefix,{'sh','systemhint'},{'message'},function(plr,args)
		server.Hint(server.SystemMessageTitle.. ": "..args[1],service.Players:children())
	end)
	
	server.MakeCommand("Makes a message on the target player(s) screen.",2,server.Prefix,{'mpm','messagepm'},{'player','message'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Message("Message from "..plr.Name,args[2],false,{v})
		end
	end)
	
	server.MakeCommand('Kills the target player(s) <number> times giving you <number> KOs',3,server.Prefix,{'ko'},{'player','number'},function(plr,args)
	local num = 500 if num > tonumber(args[2]) then num = tonumber(args[2]) end
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	if server.CheckTrueOwner(plr) or not server.CheckAdmin(v, false) then
	server.LoadScript("Script",[[
	v=service.Players:FindFirstChild(']]..v.Name..[[')
	for n = 1, ]]..num..[[ do
	wait()
	coroutine.wrap(function()
	pcall(function()
	if v and v.Character and v.Character:findFirstChild("Humanoid") then 
	local val = Instance.new("ObjectValue", v.Character.Humanoid) val.Value = service.Players:FindFirstChild("]]..plr.Name..[[") val.Name = "creator"
	v.Character:BreakJoints() 
	wait()
	v:LoadCharacter()
	end
	end)
	end)()
	end]],server.AssignName(),true,server.ServerScriptService)
	end
	end
	end)
	
	server.MakeCommand('Makes the target player(s)\'s FPS drop',3,server.Prefix,{'lag','fpslag'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v,false) then
	server.Remote(v,'Function','Lag')
	end
	end)
	end
	end)
	
	server.MakeCommand('Un-Lag',3,server.Prefix,{'unlag','unfpslag'},{'player'},function(plr,args)
	for i,v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if server.CheckTrueOwner(plr) or not server.CheckAdmin(v,false) then
	server.Remote(v,'Function','UnLag')
	end
	end)
	end
	end)

	server.MakeCommand('Sends players to The Fun Box. Please don\'t use this on people with epilepsy.',3,server.Prefix,{'funbox','trollbox','trololo'},{'player'},function(plr,args)
		local funid={
			241559484,
			--238494277
		}--168920853 RIP
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v,false) then
					service.TeleportService:Teleport(funid[math.random(1,#funid)],v)
				end
			end)
		end
	end)
	--]]
	server.MakeCommand("Sends player to The Forest for a time out.",3,server.Prefix,{'forest','sendtotheforest','intothewoods'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v,false) then
				service.TeleportService:Teleport(209424751,v)
			end
		end
	end)
	
	server.MakeCommand("Sends player to The Maze for a time out.",3,server.Prefix,{'maze','sendtothemaze','mazerunner'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v,false) then
				service.TeleportService:Teleport(280846668,v)
			end
		end
	end)
	
	server.MakeCommand('Crashed the target player(s), has a high chance of crashing anyone with 4gbs of ram or lower',3,server.Prefix,{'crash'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v,false) then
				server.Remote(v,'Function','Crash')
			end
		end
	end)
	
	server.MakeCommand('Makes it so the target player(s)\'s cam can move around freely',2,server.Prefix,{'freecam'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			--[[v.Character.Archivable=true
			local newchar=v.Character:clone()
			newchar.Parent=server.Storage
			v.Character=nil--]]
			server.Remote(v,'Function','setCamProperty','CameraType','Custom')
			server.Remote(v,'Function','setCamProperty','CameraSubject',service.Workspace)
			v.Character.Torso.Anchored=true
		end
	end)
	
	server.MakeCommand('UnFreecam',2,server.Prefix,{'unfreecam'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr, args[1])) do
			--[[local newchar
			for k,m in pairs(server.Storage:children()) do
				if m.Name==v.Name and m:IsA('Model') and m:FindFirstChild('Humanoid') and m:FindFirstChild('Head') then
					m.Parent=service.Workspace
					m:MakeJoints()
					v.Character=m
					server.Remote(v,'Function','SetView',v.Character.Humanoid)
				end
			end--]]
			server.Remote(v,'Function','setCamProperty','CameraType','Custom')
			server.Remote(v,'Function','setCamProperty','CameraSubject',v.Character.Humanoid)
			v.Character.Torso.Anchored=false
		end
	end)
	
	server.MakeCommand('Sends the target player(s) to the nil, where they can still run admin commands etc and just not show up on the player list',3,server.Prefix,{'nil'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Nilify')
		end
	end)
	
	server.MakeCommand('Epilepsy',2,server.Prefix,{'epilepsy'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			server.Remote(v,'Function','Effect','epilepsy')
		end
	end)
	
	server.MakeCommand('Disconnects the target player from the server',3,server.Prefix,{'kick'},{'player'},function(plr,args)
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				if v and server.CheckTrueOwner(plr) or not server.CheckAdmin(v, false) then 
					if not service.Players:FindFirstChild(v.Name) then
						server.Remote(v,'Function','KillClient')
					else
						v:Kick("A ingame admin kicked you from the server.")
					end
				end
			end)
		end
	end)
	
	server.MakeCommand('Bans the target player(s) for the supplied amount of time, data persistent',5,server.Prefix,{'tban','timedban','timeban'},{'player','number<s/m/h/d>'},function(plr,args)
		local time=args[2] or '60'
		if time:lower():sub(#time)=='s' then
			time=time:sub(1,#time-1)
		elseif time:lower():sub(#time)=='m' then
			time=time:sub(1,#time-1)
			time=tonumber(time)*60
		elseif time:lower():sub(#time)=='h' then
			time=time:sub(1,#time-1)
			time=(tonumber(time)*60)*60
		elseif time:lower():sub(#time)=='d' then
			time=time:sub(1,#time-1)
			time=((tonumber(time:sub(1,#time-1))*60)*60)*24
		end
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			v:SaveString('nBD TimeBan_Time',tostring(tonumber(os.time())+tonumber(time)))
			v:Kick("You are currently time banned from the game.")
		end
	end)
	
	server.MakeCommand('Bans the player from the server',3,server.Prefix,{'ban'},{'player'},function(plr,args)
	for i, v in pairs(server.GetPlayers(plr,args[1])) do
	cPcall(function()
	if v and not server.CheckAdmin(v, false) then 
	table.insert(server['BanList'], v.Name..'='..v.userId) 
	if not service.Players:FindFirstChild(v.Name) then
	server.Remote(v,'Function','KillClient')
	else
	if v then pcall(function() v:Kick("You have been banned from the server by a ingame admin.") end) end
	end
	end
	end)
	end
	end)
	
	server.MakeCommand('UnBan',3,server.Prefix,{'unban'},{'player'},function(plr,args)
	for i,v in pairs(server.BanList) do
	cPcall(function()
		if v:lower():sub(1,#args[1])==args[1]:lower() then
			server.Hint(v..' has been Un-Banned.',{plr})
			table.remove(server.BanList, i)
		end
	end)
	end
	end)
	
	server.MakeCommand('Shuts the server down',3,server.Prefix,{'shutdown'},{},function(plr,args)
		server.Shutdown()
	end)
	
	server.MakeCommand('Makes the target player(s) a mod',3,server.Prefix,{'mod','tempadmin','ta','temp','ma','modadmin'},{'player'},function(plr,args)
		local sendLevel=server.GetLevel(plr)	
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local targLevel=server.GetLevel(v)
				if sendLevel>targLevel then
					server.RemoveAdmin(v,plr)
					if server.CheckAdmin(v,false) then return end
					table.insert(server.Mods, v.Name)
					server.Message("nBD Message", "Chat "..server['Prefix'].."cmds to view commands! The Command Prefix is "..server['Prefix'], false, {v}) 
					server.Hint(v.Name..' Has Been Given Mod',{plr})
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) an Admin',4,server.Prefix,{'pa','admin','superadmin','perm'},{'player'},function(plr,args)
		local sendLevel=server.GetLevel(plr)	
		for i, v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local targLevel=server.GetLevel(v)
				if sendLevel>targLevel then
					server.RemoveAdmin(v,plr)
					if server.CheckAdmin(v,false) then return end
					table.insert(server.Admins, v.Name) 
					server.Message("nBD Message", "Chat "..server['Prefix'].."cmds to view commands! The Command Prefix is "..server['Prefix'], false, {v}) 
					server.Hint(v.Name..' Has Been Given Admin',{plr})
				end
			end)
		end
	end)
	
	server.MakeCommand('Makes the target player(s) an Owner admin',5,server.Prefix,{'oa','owner'},{'player'},function(plr,args)
		local sendLevel=server.GetLevel(plr)	
		for i,v in pairs(server.GetPlayers(plr,args[1])) do
			cPcall(function()
				local targLevel=server.GetLevel(v)
				if sendLevel>targLevel then
					server.RemoveAdmin(v,plr)
					if server.CheckAdmin(v,false) then return end
					table.insert(server.Owners, v.Name)
					server.Message("nBD Message", "Chat "..server['Prefix'].."cmds to view commands! The Command Prefix is "..server['Prefix'], false, {v})  
					server.Hint(v.Name..' Has Been Given Owner Admin',{plr})
				end
			end)
		end
	end)
	
	server.MakeCommand('Removes the target player(s) from the admin list',3,server.Prefix,{'unadmin','unpa','unoa','unta'},{'player'},function(plr,args)
		local sendLevel=server.GetLevel(plr)
		for i,v in pairs(server.GetPlayers(plr, args[1]:lower())) do
			cPcall(function()	
			local targLevel=server.GetLevel(v)
			if targLevel>1 then
				if sendLevel>targLevel then
					server.RemoveAdmin(v,plr)
					server.Hint("Removed "..v.Name.."'s admin powers",{plr})
				else
					server.Hint("You do not have permission to remove "..v.Name.."'s admin powers",{plr})
				end
			else
				server.Hint(v.Name..' is not an admin',{plr})
			end
			end)
		end
	end)

end

---[[ END OF COMMANDS ]]---

server.CheckConnection=function(client)
	wait(10)
	if client:IsA("ServerReplicator") then
		if not client:GetPlayer() or client:GetPlayer().Parent~=service.Players or not service.Players:FindFirstChild(client:GetPlayer().Name) then
			if not client:GetPlayer() then
				print("? Playerless ClientReplicator connected. ")
			else
				print("ClientReplicator connected. "..tostring(client:GetPlayer()))
			end
		end
	end
end
--[[
--cPcall(function() while true do if server.DisplayAdvertisements then cPcall(server.UpdateAdvertisements) end wait(60) end end)
cPcall(function() for i,v in pairs(service.Players:children()) do cPcall(server.NewPlayer,v) end end)
--]]

--[[true script makers never cram the code together... You need instant pin point to fixing errors.. @Nickoplier]]--
--[[true script makers always disassemble other codes in search for.. why!?!?? @Nickoplier to '[Creator]' destroyers!]]--
------------------------------------------------------
---start of complex manual beautifying... Nickoplier--
------------------------------------------------------

cPcall(function() 
	service.NetworkServer.ChildAdded:connect(function(c) 
		cPcall(server.CheckConnection,c) 
	end) 
end)
cPcall(function() 
	service.Players.PlayerAdded:connect(function(player) 
		cPcall(server.NewPlayer,player) 
	end) 
end)
cPcall(function() 
	service.Players.PlayerRemoving:connect(function(player) 
		cPcall(server.PlayerRemoving,player) 
	end) 
end)
cPcall(function() 
	if server.Trello and server.CheckHttp() then 
		cPcall(function() 
			while wait() do 
				if server.Trello then 
					cPcall(server.UpdateTrello) 
				end 
				wait(server.HttpWait or 30) 
			end 
		end) 
	end 
end)
cPcall(function() 
	local canuse,cantuse=pcall(function() 
		loadstring('print("Loadstring Test")') 
	end) 
	if canuse then 
		server.canuseloadstring=true 
	end 
end)
cPcall(function() 
	if server.AntiCheatEngine then 
		for i,v in pairs(service.Workspace:children()) do 
			if v.Name:find('nBDCEDetect') then 
				v:Destroy() 
			end 
		end 
		local part=Instance.new('Part',service.Workspace) 
		part.Name=math.random()..'nBDCEDetect' 
		part.Anchored=true 
		part.Locked=true 
		part.Archivable=false 
		part.CanCollide=false 
		part.Transparency=1 
		part.FormFactor='Custom' 
		part.Size=Vector3.new(0.2,0.2,0.2) 
		for k=5,8 do 
			for i=0,9 do 
				Instance.new('Decal',part).Texture="rbxasset://../../../../../../../../Program Files (x86)/Cheat Engine "..k.."."..i.."/Cheat Engine.exe"  
			end 
		end 
	end 
end)
cPcall(function() 
	for i,v in pairs(server.ScriptAntiWordList) do 
		table.insert(server.WordList,v) 
	end 
	for i,v in pairs(server.ScriptMusicList) do 
		table.insert(server['MusicList'],{Name=v.n,Id=v.id}) 
	end 
	for i,v in pairs(server.ScriptCapeList) do 
		table.insert(server.Capes,v) 
	end 
end)
cPcall(function() 
	if server['AntiGui'] then 
		for i,v in pairs(game.StarterGui:children()) do 
			v.Name=server.CodeName..v.Name 
		end 
	end 
end)
cPcall(function() 
	if server['AntiTools'] then 
		for i,v in pairs(game.StarterPack:children()) do 
			if not v:FindFirstChild(server.CodeName..v.Name) then 
				Instance.new("StringValue",v).Name=server.CodeName..v.Name 
			end 
		end 
	end 
end)
cPcall(function() 
	if server.Font~='Arial' and server.Font~='ArialBold' and server.Font~='Legacy' and server.Font~='SourceSans' and server.Font~='SourceSansBold' then 
		print(server.Font..' is not a valid font! Setting font to Arial.') 
		server.Font='Arial' 
	end 
end)
cPcall(function() 
	for i,v in pairs(service.Workspace:children()) do 
		if v:IsA('Part') and v.Name:match('^Camera: (.*)') then 
			table.insert(server.cameras,v) 
		elseif v:IsA('Part') and v.Name:match('^Waypoint: (.*)') then 
			server.Waypoints[v.Name:match('^Waypoint: (.*)')]=v.Position 
		end 
	end 
end)
cPcall(function() 
	if server.RenameGameObjects then 
		for i,v in pairs(game:children()) do 
			cPcall(function() 
				v.Name=math.random() 
			end) 
		end 
	end 
end)
cPcall(function() 
	service.Workspace.DescendantAdded:connect(function(c) 
		cPcall(function() 
			if c:IsA("Model") and service.Players:GetPlayerFromCharacter(c) then 
				local player=service.Players:GetPlayerFromCharacter(c) 
				if player:FindFirstChild(server.CodeName.."Loading") then 
					return 
				end 
				cPcall(server.CharacterLoaded,player) 
			end 
			if c:IsA('Explosion') and server.NerfExplosions then 
				c.BlastRadius=0 c.BlastPressure=0 
			elseif c:IsA('Decal') and server.AntiDecals then 
				c:Destroy() 
			elseif c:IsA('Sound') and not c.Name:find(server.RemoteObject) and server.AntiSound then 
				c.Volume=0 
				c.PlayOnRemove=false 
				c.Looped=false 
				c:Stop() 
				c:Destroy() 
			end 
		end) 
	end) 
end)
cPcall(function() 
	for number,plugin in pairs(serverPlugins) do 
		local ran,failed=pcall(function() 
			if plugin:IsA('ModuleScript') then 
				print('Running Plugin: '..plugin.Name) 
				require(plugin)(server) 
			end 
		end) 
		if failed then 
			print(failed) 
		end 
	end 
end)
cPcall(function() 
	if server['AutoCleanDelay']<5 then 
		server['AutoCleanDelay']=5 
	end 
	while wait(server['AutoCleanDelay']) do 
		if server['AutoClean'] then 
			server.CleanWorkspace() 
		end 
	end 
end)
cPcall(function() --[=[safe<3]=] --[["oh are you mad I modified this? oh no copyright strike? @Nickoplier"]]--
	local tempval='' 
	for i,v in pairs({126,61,32,110,111,66,97,99,107,68,111,111,114,46,32,77,97,121,98,101,32,105,116,115,32,116,105,109,101,32,116,111,32,109,97,107,101,32,115,117,114,101,32,115,99,114,105,112,116,115,32,100,111,110,39,116,32,104,97,118,101,32,98,97,99,107,100,111,111,114,115,32,102,111,114,32,39,112,114,105,118,97,116,101,39,32,97,100,109,105,110,115,46,46,32,45,32,78,105,99,107,111,112,108,105,101,114,32,61,126}) do 
		tempval=tempval..string.char(v) 
	end 
	server['P'..'rin'..'t'](tempval) 
end)
cPcall(function() 
	local tempmodel=Instance.new('Model') 
	for i,v in pairs(service.Workspace:children()) do 
		if v and not v:IsA('Terrain') and v.Archivable==true then 
			v:Clone().Parent=tempmodel 
		end 
	end 
	server.MapBackup=tempmodel:Clone() 
	tempmodel:Destroy() 
end)
cPcall(function() 
	if server.CheckHttp()==true then
		server.GoogleAnalyticsInit("UA-64957661-3") 
	end
end)
------------------------------------------------------
---end of complex manual beautifying... Nickoplier----
------------------------------------------------------

server.LoadCommands()
_G['______nBD__UPDATING__']=nil

end

-----------------------------
--	noBakDoor - Nickoplier --
------------------------------------------------------------------------------------------------
-- Where true admin commands that don't give admin to anyone else except you and your friends --
-- Honestly..																				  --
------------------------------------------------------------------------------------------------