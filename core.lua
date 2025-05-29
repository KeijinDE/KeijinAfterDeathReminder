local function Delay(seconds, callback)
  local elapsed = 0
  local f = CreateFrame("Frame")
  f:SetScript("OnUpdate", function()
    elapsed = elapsed + 0.05
    if elapsed >= seconds then
      f:SetScript("OnUpdate", nil)
      callback()
    end
  end)
end

local function RepeatReminder(times, interval, message)
  local count = 0
  local elapsed = 0
  local f = CreateFrame("Frame")
  f:SetScript("OnUpdate", function()
    elapsed = elapsed + 0.05
    if elapsed >= interval then
      elapsed = 0
      count = count + 1
      DEFAULT_CHAT_FRAME:AddMessage(message, 1, 0.2, 0.2)
      if count >= times then
        f:SetScript("OnUpdate", nil)
      end
    end
  end)
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_UNGHOST")

frame:SetScript("OnEvent", function()
  if KADR_Config and KADR_Config.enabled then
    Delay(3, function()
      RepeatReminder(3, 2, "|cffff4444⚠️ Erinnere dich: Aura, Blessing und Tracking!")
    end)
  end
end)

DEFAULT_CHAT_FRAME:AddMessage("|cff88ff88✅ KeijinAfterDeathReminder ist geladen. Nutze /kadr.", 0.6, 1, 0.6)
