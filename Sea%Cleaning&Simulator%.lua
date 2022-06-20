getgenv().autosell = false
getgenv().autoegg = false
getgenv().autoUp = false
getgenv().buyboat = false



function doSell()
    spawn(function()
        while autosell == true do          
            game:GetService("ReplicatedStorage").Packages.Knit.Services.TrashService.RF.Sell:InvokeServer()
            wait()
        end
    end)
end




function OpenEgg(eggname)
    spawn(function()
        while autoegg == true do          
            game:GetService("ReplicatedStorage").Packages.Knit.Services.EggService.RF.Open:InvokeServer(eggname,true)
            wait()
        end
    end)
end


function equipboat(boatname)
    spawn(function()
        game:GetService("ReplicatedStorage").Packages.Knit.Services.BoatService.RF.Equip:InvokeServer(boatname)   
    end)
end



function upgradeBoat()
    spawn(function()
        while autoUp == true do          
            game:GetService("ReplicatedStorage").Packages.Knit.Services.BoatService.RF.Upgrade:InvokeServer()
            wait()
        end
    end)
end



function buyboat(boatname)
    spawn(function()                
        game:GetService("ReplicatedStorage").Packages.Knit.Services.BoatService.RF.Buy:InvokeServer(boatname)          
    end)
end






local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3')))()

local w = library:CreateWindow("Sea Cleaning Simulator") 

local b = w:CreateFolder("Farming") 

local c = w:CreateFolder("Pet")

local d = w:CreateFolder("Misc")


b:Toggle("Auto Sell(in current area)",function(bool)
    getgenv().autosell = bool
    if bool then 
    doSell();
    end
end)

b:Toggle("Auto Upgrade(equipped boat)",function(bool)
    getgenv().autoUp = bool
    if bool then 
    upgradeBoat();
    end
end)



local selectedBoat;
b:Dropdown("Select Boat",{"Dinghy","Life Savor","Dinghy","Tug Bug","Mini Ahoy","Pink Fiery","Orange Stern","Powered Pincher","Wooden Trawler","Trash Eater","Purple Motor-goat","Nautical Lime","Trash Eater 2.0","Seaway Taxi","Mark Rotor"},true,function(value) 
    selectedBoat = value;
end)   


b:Button("Buy Boat",function()
    buyboat(selectedBoat)
end)

b:Button("Equip Boat",function()
    equipboat(selectedBoat)
end)

local selectedEgg;
c:Dropdown("Select Egg",{"Zone1 Normal Egg","Zone1 Eco Egg","Zone2 Normal Egg","Zone2 Eco Egg","Zone3 Normal Egg","Zone3 Eco Egg","Zone4 Normal Egg","Zone4 Eco Egg","Zone5 Normal Egg","Zone5 Eco Egg","VIP Egg","Great Reset Egg","Robux Egg","Mark Rotor"},true,function(value) 
    selectedEgg = value;
end)   

c:Toggle("Auto Open",function(bool)
    getgenv().autoegg = bool
    if bool and selectedEgg then
    OpenEgg(selectedEgg);
    end
end)

d:DestroyGui()

