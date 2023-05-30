local NotificationLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/lobox920/Notification-Library/main/Library.lua"))()


local Link = game:HttpGet("https://raw.githubusercontent.com/Odrexyo/Script/main/XeyHub/Games/"..game.PlaceId..".lua")

if Link then	
  StarterGui:SetCore("SendNotification", {
		Title = "XeyHub X Notification",
		Text = "Welcome. Loading script.",
		Duration = 10
	})
	loadstring(Link)()
end
