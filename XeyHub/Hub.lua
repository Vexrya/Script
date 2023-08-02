--local Nord = loadstring(game:HttpGetAsync("https://scripts.nord.vip/NordNotifs.lua", true))();
local Link = game:HttpGet("https://raw.githubusercontent.com/Odrexyo/Script/main/XeyHub/Games/"..game.PlaceId..".lua")

if Link then	
  --_G.Config = { ["Theme"] = "Spotify" }
--Nord:Notify("XeyHub ", "Script Loaded Sucessfully ", "success", 7);
	loadstring(Link)()
end
