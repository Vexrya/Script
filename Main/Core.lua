-- CREDIT: Alyssa
local StartLoadTime = tick()

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local Player = Players.LocalPlayer

local PlaceName: string = getgenv().PlaceName or game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local getgenv: () -> ({[string]: any}) = getfenv().getgenv

local getexecutorname = getfenv().getexecutorname
local identifyexecutor: () -> (string) = getfenv().identifyexecutor
local request = getfenv().request
local getconnections: (RBXScriptSignal) -> ({RBXScriptConnection}) = getfenv().getconnections
local queue_on_teleport: (Code: string) -> () = getfenv().queue_on_teleport
local setfpscap: (FPS: number) -> () = getfenv().setfpscap
local isrbxactive: () -> (boolean) = getfenv().isrbxactive
local setclipboard: (Text: string) -> () = getfenv().setclipboard
local firesignal: (RBXScriptSignal) -> () = getfenv().firesignal


local ScriptVersion = getgenv().ScriptVersion

getgenv().gethui = function()
	return game:GetService("CoreGui")
end

getgenv().FrostByteConnections = getgenv().FrostByteConnections or {}


local function HandleConnection(Connection: RBXScriptConnection, Name: string)
	if getgenv().FrostByteConnections[Name] then
		getgenv().FrostByteConnections[Name]:Disconnect()
	end

	getgenv().FrostByteConnections[Name] = Connection
end

getgenv().HandleConnection = HandleConnection

if not firesignal and getconnections then
	firesignal = function(Signal: RBXScriptSignal)
		local Connections = getconnections(Signal)
		Connections[#Connections]:Fire()
	end
end

local UnsupportedName = " (Executor Unsupported)"

getgenv().UnsupportedName = UnsupportedName

local function ApplyUnsupportedName(Name: string, Condition: boolean)
	return Name..if Condition then "" else UnsupportedName
end

getgenv().ApplyUnsupportedName = ApplyUnsupportedName

if queue_on_teleport then
	queue_on_teleport([[
	
	local TeleportService = game:GetService("TeleportService")
local TeleportData = TeleportService:GetLocalPlayerTeleportData()

if not TeleportData then
	return
end

if typeof(TeleportData) == "table" and TeleportData.FrostByteRejoin then
	return
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Vexrya/Script/refs/heads/main/Main/Initiate.lua"))()
	
	]])
end
task.wait(1)

if getgenv().Rayfield then
	getgenv().Rayfield:Destroy()
end

local Success, Rayfield = pcall(function()
	return loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end)

local function SendNotification(Title: string, Text: string, Duration: number?, Button1: string?, Button2: string?, Callback: BindableFunction?)
	StarterGui:SetCore("SendNotification", {
		Title = Title,
		Text = Text,
		Duration = Duration or 10,
		Button1 = Button1,
		Button2 = Button2,
		Callback = Callback
	})
end

if not Success or not Rayfield or not Rayfield.CreateWindow then
	SendNotification("Error while loading Rayfield", "Try re-executing or rejoining.")
	error("Error while loading Rayfield")
	return
end

local Flags: {[string]: {["CurrentValue"]: any, ["CurrentOption"]: {string}}} = Rayfield.Flags

getgenv().Flags = Flags

local function Notify(Title: string, Content: string, Image: string)
	if not Rayfield then
		return
	end

	Rayfield:Notify({
		Title = Title,
		Content = Content,
		Duration = 10,
		Image = Image or "info",
	})
end

getgenv().Notify = Notify

task.spawn(function()
	while task.wait(Random.new():NextNumber(5 * 60, 10 * 60)) do
		Notify("Enjoying this script?", "Join the discord at discord.gg/sS3tDP6FSB", "heart")
	end
end)



local PlaceFileName = getgenv().PlaceFileName

if PlaceFileName then
	task.spawn(function()
		local BindableFunction = Instance.new("BindableFunction")

		local Response = false

		local Button1 = "✅ Yes" 
		local Button2 = "❌ No"

		local File = `https://raw.githubusercontent.com/Vexrya/Script/refs/heads/main/Games/{PlaceFileName}.lua`

		BindableFunction.OnInvoke = function(Button: string)
			Response = true

			if Button == Button1 then
				local OriginalFlags = {}

				for i,v in Flags do
					if typeof(v.CurrentValue) ~= "boolean" then
						continue
					end
					
					OriginalFlags[i] = v.CurrentValue
					v:Set(false)
				end
				
				getgenv().OriginalFlags = OriginalFlags

				loadstring(game:HttpGet(File))()
			end
		end

		while task.wait(60) do
			local Result = game:HttpGet(File)
			
			if not Result then
				continue
			end

			Result = Result:split('getgenv().ScriptVersion = "')[2]
			Result = Result:split('"')[1]

			if Result == ScriptVersion then
				continue
			end
            SendNotification("A new FrostByte version has been detected!", "Would you like to load it?", math.huge, Button1, Button2, BindableFunction)

			break
		end
	end)
end

Window = Rayfield:CreateWindow({
	Name = `Vexrya | {PlaceName} | {ScriptVersion or "Dev Mode"}`,
	Icon = "snowflake",
	LoadingTitle = "❄ Brought to you by Vexrya ❄",
	LoadingSubtitle = PlaceName,
	Theme = "DarkBlue",

	DisableRayfieldPrompts = false,
	DisableBuildWarnings = false,

	ConfigurationSaving = {
		Enabled = true,
		FolderName = "Vex",
		FileName = `{getgenv().PlaceFileName or `DevMode-{game.PlaceId}`}-{Player.Name}`
	},

	Discord = {
		Enabled = true,
		Invite = "Y4byXdAKuA",
		RememberJoins = true
	},
})

getgenv().Window = Window

function CreateUniversalTabs()
	local VirtualUser = game:GetService("VirtualUser")
	local VirtualInputManager = game:GetService("VirtualInputManager")
	local TeleportService = game:GetService("TeleportService")
	local RunService = game:GetService("RunService")
	
	local Tab = Window:CreateTab("Client", "user")
	
	Tab:CreateSection("Discord")

	Tab:CreateButton({
		Name = "❄ • Join Vexrya Discord!",
		Callback = function()
			if request then
				request({
					Url = 'http://127.0.0.1:6463/rpc?v=1',
					Method = 'POST',
					Headers = {
						['Content-Type'] = 'application/json',
						Origin = 'https://discord.com'
					},
					Body = HttpService:JSONEncode({
						cmd = 'INVITE_BROWSER',
						nonce = HttpService:GenerateGUID(false),
						args = {code = 'Y4byXdAKuA'}
					})
				})
			elseif setclipboard then
				setclipboard("https://discord.gg/Y4byXdAKuA")
				Notify("Success!", "Copied Discord Link to Clipboard.")
			end

			Notify("Discord", "https://discord.gg/Y4byXdAKuA")
		end,
	})

	Tab:CreateLabel("https://discord.gg/Y4byXdAKuA", "link")

	Tab:CreateSection("AFK")

	Tab:CreateToggle({
		Name = "🔒 • Anti AFK Disconnection",
		CurrentValue = true,
		Flag = "AntiAFK",
		Callback = function()end,
	})
	
	getgenv().HandleConnection(Player.Idled:Connect(function()
		if not Flags.AntiAFK.CurrentValue then
			return
		end

		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.zero)
		VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.RightMeta, false, game)
		VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.RightMeta, false, game)
	end), "AntiAFK")
	
	Tab:CreateSection("Performance")
	
	Tab:CreateSlider({
		Name = ApplyUnsupportedName("🎮 • Max FPS (0 for Unlimited)", setfpscap),
		Range = {0, 240},
		Increment = 1,
		Suffix = "FPS",
		CurrentValue = 0,
		Flag = "FPS",
		Callback = function(Value)
			setfpscap(Value)
		end,
	})
	
	local PreviousValue
	
	Tab:CreateToggle({
		Name = ApplyUnsupportedName("⬜ • Disable 3D Rendering When Tabbed Out", isrbxactive),
		CurrentValue = false,
		Flag = "Rendering",
		Callback = function(Value)
			while Flags.Rendering.CurrentValue and task.wait() do
				local CurrentValue = isrbxactive()
				
				if PreviousValue == CurrentValue then
					continue
				end
				
				PreviousValue = CurrentValue
				
				RunService:Set3dRenderingEnabled(CurrentValue)
			end
			
			if Value then
				RunService:Set3dRenderingEnabled(true)
			end
		end,
	})
	
	Tab:CreateSection("Properties")
	
	Tab:CreateSlider({
		Name = "💨 • Set WalkSpeed",
		Range = {0, 300},
		Increment = 1,
		Suffix = "Studs/s",
		CurrentValue = game:GetService("StarterPlayer").CharacterWalkSpeed,
		Flag = "FPS",
		Callback = function(Value)
			local Character = Player.Character or Player.CharacterAdded:Wait()
			
			if not Character then
				return
			end
			
			local Humanoid = Character:WaitForChild("Humanoid", 5)
			
			if not Humanoid then
				return
			end
			
			Humanoid.WalkSpeed = Value
		end,
	})
	
	Tab:CreateSection("Safety")
	
	local StaffRoleNames = {
		"mod",
		"dev",
		"admin",
		"owner",
		"founder",
		"manag",
	}
	
	local function IsInGroup(CheckPlayer: Player, GroupId: number)
		local Success, Result = pcall(CheckPlayer.IsInGroup, CheckPlayer, GroupId)
		
		return Success and Result
	end
	
	local function GetRoleInGroup(CheckPlayer: Player, GroupId: number)
		local Success, Result = pcall(CheckPlayer.GetRoleInGroup, CheckPlayer, GroupId)
		
		return if Success then Result else "Guest"
	end
	
	local function GetRankInGroup(CheckPlayer: Player, GroupId: number)
		local Success, Result = pcall(CheckPlayer.GetRankInGroup, CheckPlayer, GroupId)
		
		return if Success then Result else 0
	end
	local function GetStaffRole(CheckPlayer: Player)
		local StaffRole

		if IsInGroup(CheckPlayer, 1200769) then
			StaffRole = "Roblox Admin"
		end

		if game.CreatorType ~= Enum.CreatorType.Group then
			return
		end

		local CreatorId = game.CreatorId

		local Role = GetRoleInGroup(CheckPlayer, CreatorId)

		for _, Name in StaffRoleNames do
			if typeof(Role) == "string" and Role:lower():find(Name) then
				StaffRole = Role
			end
		end

		if GetRankInGroup(CheckPlayer, CreatorId) == 255 then
			StaffRole = "Group Owner"
		end
		
		return StaffRole
	end
	
	local function CheckIfStaff(CheckPlayer: Player)
		if not Flags.StaffJoin.CurrentValue then
			return
		end
		
		local StaffRole = GetStaffRole(CheckPlayer)
		
		if not StaffRole then
			return
		end
		
		Player:Kick(`The player '{CheckPlayer.Name}' was detected to be a staff member, their role is '{StaffRole}'.\n\nIf you believe this is false, contact the dev of FrostByte.`)
	end
	
	Tab:CreateToggle({
		Name = "🚪 • Auto Leave When Staff Joins",
		CurrentValue = false,
		Flag = "StaffJoin",
		Callback = function(Value)
			if not Value then
				return
			end
			
			for _, CheckPlayer in Players:GetPlayers() do
				CheckIfStaff(CheckPlayer)
			end
		end,
	})
	
	HandleConnection(Players.PlayerAdded:Connect(CheckIfStaff), "StaffJoin")
	
	getgenv().Role = GetStaffRole(Player)
	
	Tab:CreateSection("UI")
	
	local CustomThemes = {
		BlackHistoryMonth = {
			TextColor = Color3.fromRGB(),

			Background = Color3.fromRGB(),
			Topbar = Color3.fromRGB(),
			Shadow = Color3.fromRGB(),

			NotificationBackground = Color3.fromRGB(),
			NotificationActionsBackground = Color3.fromRGB(),

			TabBackground = Color3.fromRGB(),
			TabStroke = Color3.fromRGB(),
			TabBackgroundSelected = Color3.fromRGB(),
			TabTextColor = Color3.fromRGB(),
			SelectedTabTextColor = Color3.fromRGB(),

			ElementBackground = Color3.fromRGB(),
			ElementBackgroundHover = Color3.fromRGB(),
			SecondaryElementBackground = Color3.fromRGB(),
			ElementStroke = Color3.fromRGB(),
			SecondaryElementStroke = Color3.fromRGB(),

			SliderBackground = Color3.fromRGB(),
			SliderProgress = Color3.fromRGB(),
			SliderStroke = Color3.fromRGB(),

			ToggleBackground = Color3.fromRGB(),
			ToggleEnabled = Color3.fromRGB(),
			ToggleDisabled = Color3.fromRGB(),
			ToggleEnabledStroke = Color3.fromRGB(),
			ToggleDisabledStroke = Color3.fromRGB(),
			ToggleEnabledOuterStroke = Color3.fromRGB(),
			ToggleDisabledOuterStroke = Color3.fromRGB(),

			DropdownSelected = Color3.fromRGB(),
			DropdownUnselected = Color3.fromRGB(),

			InputBackground = Color3.fromRGB(),
			InputStroke = Color3.fromRGB(),
			PlaceholderColor = Color3.fromRGB()
		},
		Default = "DarkBlue",
		Dark = "Default"
	}
	
	Tab:CreateDropdown({
		Name = "🖼 • Change Theme",
		Options = {"BlackHistoryMonth", "Default", "Dark", "AmberGlow", "Amethyst", "Ocean", "Light", "Bloom", "Green", "Serenity"},
		MultipleOptions = false,
		Flag = "Theme",
		Callback = function(CurrentOption)
			CurrentOption = CurrentOption[1]

			if CurrentOption == "" then
				return
			end
			
			Window.ModifyTheme(CustomThemes[CurrentOption] or CurrentOption)
		end,
	})


	Tab:CreateSection("Development")

	Tab:CreateButton({
		Name = "⚙️ • Rejoin",
		Callback = function()
			TeleportService:Teleport(game.PlaceId, Player, {FrostByteRejoin = true})
		end,
	})
	
	Rayfield:LoadConfiguration()
	
	local OriginalFlags = getgenv().OriginalFlags
	
	if OriginalFlags then
		for i,v in OriginalFlags do
			Flags[i]:Set(v)
		end
	end
	
	Notify("Welcome to Vex?", `Loaded in {math.floor((tick() - StartLoadTime) * 10) / 10}s`, "loader-circle")
	
	local FrostByteStarted = getgenv().FrostByteStarted
	
	if FrostByteStarted then
		FrostByteStarted()
	end
end

getgenv().CreateUniversalTabs = CreateUniversalTabs

if not ScriptVersion or ScriptVersion == "Universal" then
	CreateUniversalTabs()
end
