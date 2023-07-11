requestOfInvite = {
  list = {},
  response = {},
  index = 0
}

RegisterServerEvent("kd_requestOfInvite:New")
AddEventHandler("kd_requestOfInvite:New", function(player,message, confirmText,cancelText,cb)
  if type(player) ~= "string" then
    player = tostring(player)
  end

  if player == nil then return end
  if requestOfInvite.list[player] ~= nil then return end

  requestOfInvite.index = requestOfInvite.index + 1
  local requestId = requestOfInvite.index
  if requestId == nil then return end
  requestOfInvite.list[player] = requestId 

  TriggerClientEvent("kd_requestOfInvite:sendMessage", tonumber(player), requestId, message, confirmText,cancelText)

  while requestOfInvite.response[requestId] == nil do
    Wait(50)
  end

  cb(requestOfInvite.response[requestId])
end)

RegisterNetEvent("kd_requestOfInvite:sendResponse")
AddEventHandler("kd_requestOfInvite:sendResponse", function(requestId, response)
    local _src = source
    if requestOfInvite.list[tostring(_src)] == nil or requestOfInvite.list[tostring(_src)] ~= requestId then return end

    requestOfInvite.response[requestId] = response
    requestOfInvite.list[tostring(_src)] = nil
end)
