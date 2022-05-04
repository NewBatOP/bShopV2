-- cl_bat_shop.lua


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)      
		Citizen.Wait(5000)
	end
end)


--- CREATION DU MENU ---

local open = false 
local MainMenu = RageUI.CreateMenu('Shop', 'interaction') 
local subMenu = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
local subMenu2 = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
local subMenu3 = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
local subMenu4 = RageUI.CreateSubMenu(MainMenu, "Shop", "interaction")
MainMenu.Display.Header = true 
MainMenu.Closed = function()
  open = true
end

--- OUVERTURE DU MENU ---

function batopshop()
	if open then 
		open = false
		RageUI.Visible(MainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(MainMenu, true)
		CreateThread(function()
		while open do 
		   RageUI.IsVisible(MainMenu,function() 


			RageUI.Button("Nourritures", nil, {RightLabel = "→→"}, true , {
				onSelected = function() 
        end
		}, subMenu)

			RageUI.Button("Boissons", nil, {RightLabel = "→→"}, true , { 
				onSelected = function() 
				end
		}, subMenu2) 

        RageUI.Button("Boissons Alcoolisé", nil, {RightLabel = "→→"}, true , { 
            onSelected = function() 
            end
        }, subMenu3) 

            RageUI.Button("Technologie", nil, {RightLabel = "→→"}, true , { 
                onSelected = function() 
                end   
        }, subMenu4) 



    end) 

       

			RageUI.IsVisible(subMenu,function()

                RageUI.Separator("↓ Liste des Nourritures ↓")

                for k, v in pairs(Config.Categories.Nourriture) do 
               RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
					onSelected = function()
					   TriggerServerEvent('batop:achat',v.name, v.label, v.price)
                    end,
				})
            end
   
        end)
        
        RageUI.IsVisible(subMenu2,function()
            RageUI.Separator("↓ Liste des Boissons ↓")

            for k, v in pairs(Config.Categories.Boissons) do 
                RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
                     onSelected = function()
                        TriggerServerEvent('batop:achat',v.name, v.label, v.price)
	
                    end,
				})
            end	
        end)

        RageUI.IsVisible(subMenu3,function()
            RageUI.Separator("↓ Liste des Alcoolisé ↓")

            for k, v in pairs(Config.Categories.Alcool) do 
                RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
                     onSelected = function()
                        TriggerServerEvent('batop:achat',v.name, v.label, v.price)
	
                    end,
				})
            end	
        end)

        RageUI.IsVisible(subMenu4,function()

            RageUI.Separator("↓ Liste Technologie ↓")

            for k, v in pairs(Config.Categories.Technologie) do 
           RageUI.Button(v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(v.price).."$"}, true , {
                onSelected = function()
                   TriggerServerEvent('batop:achat',v.name, v.label, v.price)
                end,
            })
        end
    end)

		Wait(5)
	end
 end)
end
end 




---- Blips + Position Vendeur ----
Citizen.CreateThread(function()  
    while Config == nil do 
        Wait(5000)
    end 
    for k, v in pairs(Config.bShopV2) do 
        -- Blips
        local blips = AddBlipForCoord(v.pos)
        SetBlipSprite(blips, 59)
        SetBlipColour(blips, 2)
        SetBlipScale(blips, 0.8)
        SetBlipDisplay(blips, 4)
        SetBlipAsShortRange(blips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Supérette")
        EndTextCommandSetBlipName(blips)
    while true do 
        local myCoords = GetEntityCoords(PlayerPedId())
        local nofps = false

        if not openedMenu then 
            for k, v in pairs(Config.bShopV2) do 
                if #(myCoords - v.pos) < 1.0 then 
                    nofps = true
                    Visual.Subtitle("Appuyer sur ~b~[E]~s~ pour parler au ~b~vendeur", 1) 
                    if IsControlJustPressed(0, 38) then 
                        lastPos = GetEntityCoords(PlayerPedId())                 
                        batopshop()
                    end 
                elseif #(myCoords - v.pos) < 5.0 then 
                    nofps = true 
                    DrawMarker(22, v.pos, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 0, 0 , 255, true, true, p19, true)     
                end 
            end 
        end
        if nofps then 
            Wait(1)
        else 
            Wait(1500)
        end 
    end
end)