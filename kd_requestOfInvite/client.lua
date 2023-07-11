local Notif = {}
requestOfInvite = {
    lastId = nil,
}


RegisterNetEvent("kd_requestOfInvite:sendMessage")
AddEventHandler("kd_requestOfInvite:sendMessage", function(requestId, message,confirmationtext,canceltext)
  if requestId == nil then return end

  requestOfInvite.lastId = requestId

  confirmationtext = confirmationtext or 'Accept'
  canceltext = canceltext or 'Reject'
  if message then
      NotifColor(message, 2)
      Wait(100)
  end
  NotifKey("~INPUT_MP_TEXT_CHAT_TEAM~", confirmationtext)
  Wait(100)
  NotifKey("~INPUT_REPLAY_ENDPOINT~", canceltext)
  local endTimer = GetGameTimer() + 10000
  local answer = false
  while endTimer > GetGameTimer() do
      Wait(0)
      if IsControlJustReleased(1, 246) then
        answer = true
        break
      end
      if IsControlJustReleased(1, 306) then
        answer = false
        break
      end
  end
  TriggerServerEvent("kd_requestOfInvite:sendResponse", requestId, answer)
  NotifDel()
end)

function NotifColor(txt,color)
    txt=tostring(txt)
	length = string.len(txt)
    local Type = "STRING"
    if length <= 90 then
        Type = "STRING"
    elseif length <= 90 * 2 then
        Type = "THREESTRINGS"
    elseif length <= 90 * 3 then
        Type = "THREESTRINGS"
    end
    SetNotificationTextEntry(Type)
    Citizen.InvokeNative(0x92F0DA1E27DB96DC , color)
    AddTextComponentString(txt)
    local Notification = DrawNotification(false, false)
	table.insert(Notif,Notification)
end

function NotifKey(icon,text)
  SetNotificationTextEntry("STRING")
  table.insert(Notif,Citizen.InvokeNative(0xDD6CB2CCE7C2735C,1,icon,text))
end

function NotifDel()
  for _,v in pairs(Notif) do
    RemoveNotification(v)
  end
  Notif = {}
end