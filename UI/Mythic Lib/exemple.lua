local MythicLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Vexrya/Script/main/UI/Mythic%20Lib/source.lua"))()

local Window = MythicLib:MakeWindow({
    Title = "Trust",
    SubTitle = "by Jean Paul Gautier",
    UISize = 
})

local Tab1 = Window.MakeTab("Tab", {
    Name = "Tab 1", -- Tab name"
    Icon = "rbxassetid://17250523838", -- Tab icon (optional)
})

local Test = Tab1.AddParagraph("Paragraph", {
    Title = "Something",
    Text = "o mami"
})

local Test = Tab1.AddButton("Button", {
    Name = "Tab 1",
    Description = "A Button",
    Callback = function()
        print(1)
    end
})

local test = Tab1.AddDropdown("Dropdown", {
    Name = "1v1",
    Options = {"Nahh", "i'd win"},
    Default = "Mob",
    Callback = function(T)
        print(T)
    end
})

local test = Tab1.AddSlider("Slider", {
    Name = "slider",
    Desc = "a slider",
    Min = 1,
    Max = 10,
    Increase = 1,
    Default = 5,
    Callback = function(T)
        print(T)
    end
})

local test = Tab1.AddTextBox("TextBox", {
    Name = "slider",
    Desc = "a slider",
    Default = "TextBox",
    PlaceholderText = "a textbox",
    ClearText = true,
    Callback = function(T)
        print(T)
    end
})

local test = Tab1.AddDiscordInvite("DiscordInvite", {
    Title = "Discord Link",
    Desc = "Join Discord pls",
    Logo = "Me",
    Invite = ""
})
