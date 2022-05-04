-- sv_bat_shop.lua

ESX = nil 

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent("batop:achat")
AddEventHandler("batop:achat", function(name, label, price) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getMoney() >= price then
	    xPlayer.removeMoney(price)
    	xPlayer.addInventoryItem(name, 1) 
        TriggerClientEvent('esx:showNotification', source, "Vous avez bien acheté ~b~1x "..label.."~s~ pour ~g~"..price.."$~s~ !")
     else 
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez ~r~d'argent sur vous !")    
    end
end)
