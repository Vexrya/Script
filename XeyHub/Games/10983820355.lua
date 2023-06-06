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
})

local Farm = Window:CreateTab("Main", 13647047527)

local ShopTab  = Window:CreateTab("Shop", 13647046359)

local PlayerTab = Window:CreateTab("Player", 13647016222)

local GuiTab = Window:CreateTab("Settings", 13646973142) 

------ FARM ------
local FarmSection = Farm:CreateSection("Farm")


local map = {"map1","map2","map3","map4","map5","map6"}
local area = {"area_1","area_2","area_3"}

local EnemyDropdown = Farm:CreateDropdown({
	Name = "🗺️ Select Map",
	SectionParent = FarmSection,
	Options = map,
	CurrentOption = "map1",
	Flag = "Map",
	Callback = function(value)
        map = value[1]
    end,
})

local EnemyDropdown = Farm:CreateDropdown({
	Name = "👾Select Area",
	SectionParent = FarmSection,
	Options = area,
	CurrentOption = "area_1",
	Flag = "Area",
	Callback = function(value)
        area = value[1]
    end,
})


Farm:CreateToggle({
    Name = "🗡 Teleport + Attack",
    SectionParent = FarmSection,
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
        local folder = workspace.MonsterFolder.Model[map][area]
        
        folder.ChildAdded:Connect(function(child)
            if child:IsA("Model") and child.Parent.Name == area and child.Parent.Parent.Name == map then
                spawn(function()
                    while getgenv().Settings.AutoFarm do
                        repeat
                            wait()
                            Hrp.CFrame = child.HumanoidRootPart.CFrame
                            local healthText = child.HealthBarOfMon.GUI.HealthGUI.HealthNum.Text
                            local healthValue = tonumber(healthText:match("%d+"))
                            local targetName = child.Name
                            Storage.clickAttackHitEvent:FireServer({targetName})
                            healthText = child.HealthBarOfMon.GUI.HealthGUI.HealthNum.Text
                            healthValue = tonumber(healthText:match("%d+"))
                        until healthValue <= 0 or not getgenv().Settings.AutoFarm
                    end
                end)
            end
        end)
        
        folder.ChildRemoved:Connect(function(child)
            -- Code à exécuter lorsque l'ennemi disparaît de la zone
        end)
    end)
end


local KillSection = Farm:CreateSection("Kill Aura")

getgenv().Killaura = false
local KillRadius = 30

Farm:CreateSlider({
    Name = "Kill Aura Radius",
    SectionParent = KillSection,
    Range = {0, 1000},
    Increment = 10,
    Suffix = "Radius",
    CurrentValue = KillRadius,
    Flag = "Slider1",
    Callback = function(Value)
        KillRadius = Value
    end,
})

Farm:CreateToggle({
    Name = "Kill Aura",
    SectionParent = KillSection,
    CurrentValue = false,
    Flag = "Aura",
    Callback = function(bool)
        getgenv().Killaura = bool
    end,
})

task.spawn(function()
    while task.wait() do
        if getgenv().Killaura == true then
            local mobFolder = game:GetService("Workspace").MonsterFolder.Model
            while true do  -- Utiliser une boucle continue pour vérifier en permanence les nouveaux mobs
                for _, enemy in ipairs(mobFolder:GetDescendants()) do
                    if enemy:IsA("Model") and enemy:FindFirstChild("HumanoidRootPart") then
                        local distance = (enemy.HumanoidRootPart.Position - Hrp.Position).Magnitude
                        if distance <= KillRadius then
                            repeat
                                wait()
                                local healthText = enemy.HealthBarOfMon.GUI.HealthGUI.HealthNum.Text
                                local healthValue = tonumber(healthText:match("%d+"))
                                if healthValue <= 0 then
                                    break  -- Passer au mob suivant si la santé est inférieure ou égale à zéro
                                end
                                game:GetService("ReplicatedStorage").clickAttackHitEvent:FireServer({enemy.Name})
                                healthText = enemy.HealthBarOfMon.GUI.HealthGUI.HealthNum.Text
                                healthValue = tonumber(healthText:match("%d+"))
                            until healthValue <= 0 or not getgenv().Killaura
                        end
                    end
                end
                task.wait()  -- Attendre avant de vérifier à nouveau les mobs
            end
        end
    end
end)

local OthersSection = Farm:CreateSection("Others")

Farm:CreateToggle({
	Name = "🖱 Auto Click",
	SectionParent = OthersSection,
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
	SectionParent = OthersSection,
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
	Name = "💴 Auto Collect Coin",
	SectionParent = OthersSection,
	CurrentValue = false,
	Flag = "Collect",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Collect.CurrentValue == true  then
			for i,v in pairs(workspace.Drop.other.Folder:GetChildren()) do
				v.CFrame = Hrp.CFrame
			end
		end
	end
end)


Farm:CreateToggle({
	Name = " Auto Collect Sword",
	SectionParent = OthersSection,
	CurrentValue = false,
	Flag = "Collect",
	Callback = function()end,
})

task.spawn(function()
	while task.wait() do
		if Rayfield.Flags.Collect.CurrentValue == true  then
			for i,v in pairs(workspace.Drop.sword.touchPart:GetDescendants()) do
                if v:IsA("Part") and v.Name == "touchPart" then 
				v.CFrame = Hrp.CFrame
                end
			end
		end
	end
end)

local MiscSection = Farm:CreateSection("Misc")

Farm:CreateToggle({
	Name = "🎰 Auto Spin Wheel",
	SectionParent = MiscSection,
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
	SectionParent = MiscSection,
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

local PlayerSection = PlayerTab:CreateSection("Player",false)
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

local HatchSection = ShopTab:CreateSection("Hatch",false)
getgenv().AutoHatch = false
local Box = {
    "Box1",
    "Box2",
    "Box3",
    "Box4",
    "Box5",
    "Box6",
    "Box7",
    "Robux1",
    "Robux2",
    "Robux3",
    "Robux4",
    "Robux5",
    "Robux6",
    "Robux7";
}


ShopTab:CreateDropdown({
	Name = "Select Egg",
	SectionParent = HatchSection,
	Options = Box,
	CurrentOption = "Box1",
	Flag = "Box",
	Callback = function(value)
        Box = value[1]
    end,
})

ShopTab:CreateToggle({
    Name = "Auto Hatch",
    SectionParent = HatchSection,
    CurrentValue = false,
    Flag = "Hatch",
    Callback = function(bool)
        getgenv().AutoHatch = bool
        if bool and Box then 
            Hatch(Box)
        end
    end,
})

function Hatch(Box)
    spawn(function()
        while getgenv().AutoHatch == true do
                game:GetService("ReplicatedStorage").summonPetFun:InvokeServer(Box)
            wait()
        end
    end)
end
task.spawn(function(Box)
	while task.wait() do
		if getgenv().AutoHatch == true then
            game:GetService("ReplicatedStorage").summonPetFun:InvokeServer(Box)
        end
	end
end)



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
