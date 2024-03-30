ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('bodydrag-server:attach')
AddEventHandler('bodydrag-server:attach', function(Player)
	TriggerClientEvent('bodydrag:attach', Player, source)
end)

RegisterServerEvent('bodydrag-server:deattach')
AddEventHandler('bodydrag-server:deattach', function(Player)
	TriggerClientEvent('bodydrag:deattach', Player, source)
end)