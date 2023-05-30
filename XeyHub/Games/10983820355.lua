local Storage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local Player = game:GetService("Players").LocalPlayer
local Hrp = Player.Character:WaitForChild("HumanoidRootPart")

local MarketplaceService = game:GetService("MarketplaceService")
local productInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local gameName = productInfo.Name or "Unknow Game"

local player = game:GetService("Players").LocalPlayer
local playerId = tostring(player.UserId)


getgenv().Settings = {
    AutoFarm = false
}

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/Rafacasari/ArrayField/main/v2.lua'))()


local Window = Rayfield:CreateWindow({
    Name = gameName.." v1 | By Xeyko ",
    LoadingTitle = gameName.." v1 ",
    LoadingSubtitle = "Xeyko",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, 
       FileName = playerId..gameName
    },
    Discord = {
        Enabled = true,
        Invite = "bkQQxHp3mG", -- The Discord invite code, do not include discord.gg/
        RememberJoins = true -- Set this to false to make them join the discord every time they load it up
     }

local Farm = Window:CreateTab("Farm",13041611944)



local GuiTab = Window:CreateTab("Gui", 13041604906)

------ FARM ------
local Section = Farm:CreateSection("Farm")
local map = {"map1","map2","map3","map4"}
local area = {"area_1","area_2","area_3"}

local EnemyDropdown = Farm:CreateDropdown({
	Name = "🗺️ Select Map",
	SectionParent = Section,
	Options = map,
	CurrentOption = "map1",
	Flag = "Map",
	Callback = function(value)
        map = value[1]
    end,
})

local EnemyDropdown = Farm:CreateDropdown({
	Name = "👾Select Area",
	SectionParent = Section,
	Options = area,
	CurrentOption = "area_1",
	Flag = "Area",
	Callback = function(value)
        area = value[1]
    end,
})


Farm:CreateToggle({
    Name = "🗡 Teleport + Attack",
    SectionParent = Section,
    CurrentValue = false,
    Flag = "Attack",
    Callback = function(bool)
        getgenv().Settings.AutoFarm = bool
        if bool and map and area then
            Attack(map, area)
        end
    end,
})

function Attack(map, area)
    spawn(function()
        while getgenv().Settings.AutoFarm do
            local mobs = workspace.MonsterFolder.Model[map][area]:GetChildren()
            for i, v in ipairs(mobs) do
                if v:IsA("Model") and v.Parent.Name == area and v.Parent.Parent.Name == map then
                    repeat
                        wait()
                        Hrp.CFrame = v.HumanoidRootPart.CFrame
                        local healthText = v.HealthBarOfMon.GUI.HealthGUI.HealthNum.Text
                        local healthValue = tonumber(healthText:match("%d+"))
                        local targetName = v.Name
                        Storage.clickAttackHitEvent:FireServer({targetName})
                    until healthValue <= 0 or not getgenv().Settings.AutoFarm
                end
            end
            wait() -- Add a delay before checking for new mobs again
        end
    end)
end



Farm:CreateToggle({
	Name = "Kill Aura",
	SectionParent = Section,
	CurrentValue = false,
	Flag = "Aura",
	Callback = function()end,
})

task.spawn(function()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local KillRadius = 300
	while task.wait() do
		if Rayfield.Flags.Aura.CurrentValue == true then
                for _, enemy in ipairs(game:GetService("Workspace").MonsterFolder.Model:GetDescendants()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                        local distance = (enemy.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude
                        if distance <= KillRadius then
                            game:GetService("ReplicatedStorage").clickAttackHitEvent:FireServer({enemy.Name})
                        end
                    end
                end
        end
	end
end)


Farm:CreateToggle({
	Name = "🖱 Auto Click",
	SectionParent = Section,
	CurrentValue = false,
	Flag = "Click",
	Callback = function()end,
})
task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Click.CurrentValue == true then
            local ohTable1 = {}

            game:GetService("ReplicatedStorage").clickAttackHitEvent:FireServer(ohTable1)
            
        end
	end
end)


Farm:CreateToggle({
	Name = "🧬 Auto Ascend",
	SectionParent = Section,
	CurrentValue = false,
	Flag = "Ascend",
	Callback = function()end,
})
task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Ascend.CurrentValue == true then          
        Storage.rebirthEvent:FireServer()     
        wait(10)
        end
	end
end)


Farm:CreateToggle({
	Name = "💴 Auto Collect",
	SectionParent = Section,
	CurrentValue = false,
	Flag = "Collect",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Collect.CurrentValue == true  then
			for i,v in pairs(workspace.Drop:GetDescendant()) do
                if v:IsA("Part") then
				v.CFrame = Hrp.CFrame
                end
			end
		end
	end
end)

local Section1 = Farm:CreateSection("Others")
Farm:CreateToggle({
	Name = "🎰 Auto Spin Wheel",
	SectionParent = Section1,
	CurrentValue = false,
	Flag = "SpinWheel",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.SpinWheel.CurrentValue == true  then
			Storage.turntableFun:InvokeServer()
            wait()
		end
	end
end)

Farm:CreateToggle({
	Name = "🎁 Auto Claim Reward",
	SectionParent = Section1,
	CurrentValue = false,
	Flag = "DailyReward",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.DailyReward.CurrentValue == true  then
            local reward = {1,2,3,4,5,6,7,8,9,10,11,12}
			for i,v in ipairs(reward) do 
                Storage.getTimeRewardFun:InvokeServer(v)
            end
            wait(600)
		end
	end
end)

local PlayerSection = Farm:CreateSection("Player",false)
Farm:CreateSlider({
  Name = " WalkSpeed",
  SectionParent = PlayerSection,
  Range = {0, 300},
  Increment = 10,
  Suffix = "WK",
  CurrentValue = 16,
  Flag = "Slider1", 
  Callback = function(Value)
   game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
  end,
})

Farm:CreateSlider({
  Name = " Jump Power",
  SectionParent = PlayerSection,
  Range = {0, 300},
  Increment = 10,
  Suffix = "JP",
  CurrentValue = 10,
  Flag = "Slider2", 
  Callback = function(Value)
   game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
  end,
})





local Button = GuiTab:CreateButton({
    Name = "Rejoin",
    Callback = function()
        game.Players.PlayerRemoving:connect(function(plr)
            if plr == game.Players.LocalPlayer then
            game:GetService('TeleportService'):Teleport(game.PlaceId)
        end
        end)
    end,
 })

local Button = GuiTab:CreateButton({
    Name = "Copy Discord Link",
    Callback = function()
        setclipboard("https://discord.gg/bkQQxHp3mG")
    end,
 })


local Button = GuiTab:CreateButton({
   Name = "Destroy GUI",
   Callback = function()
        Rayfield:Destroy()
   end,
})
