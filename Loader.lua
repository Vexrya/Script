local Link = game:HttpGet("https://raw.githubusercontent.com/Vexrya/Script/main/Games/"..game.PlaceId..".lua")

if Link then	
   loadstring(Link)()
end
