local StarterGui = game:GetService("StarterGui")

local Link = game:HttpGet("https://raw.githubusercontent.com/Odrexyo/Script/main/XeyHub/Games/"..game.PlaceId..".lua")

if Link then	
  StarterGui:SetCore("SendNotification", {
		Title = "XeyHub X Notification",
		Text = "Welcome. Loading script.",
		Duration = 10
	})
	loadstring(Link)()
end
