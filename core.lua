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

function TriggerReminder()
  local delay = KADR_Config and KADR_Config.reminderDelay or 3
  local duration = KADR_Config and KADR_Config.frameDuration or 10
  local showChat = KADR_Config and KADR_Config.showChat
  local showFrame = KADR_Config and KADR_Config.showFrame
  local posX = KADR_Config and KADR_Config.frameX or 0
  local posY = KADR_Config and KADR_Config.frameY or 100

  if showChat then
    for i = 1, 3 do
      Delay(delay + (i - 1) * 2, function()
        DEFAULT_CHAT_FRAME:AddMessage("|cffff4444⚠️ Reminder: Aura, Blessing, Tracking!", 1, 0.2, 0.2)
      end)
    end
  end

  if showFrame and KADR_UIReminderFrame then
    KADR_UIReminderFrame:ClearAllPoints()
    KADR_UIReminderFrame:SetPoint("CENTER", UIParent, "CENTER", posX, posY)
    KADR_UIReminderFrame:Show()
    Delay(delay + duration, function()
      KADR_UIReminderFrame:Hide()
    end)
  end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_UNGHOST")
frame:SetScript("OnEvent", function()
  local fallback = KADR_Config and KADR_Config.reminderDelay or 3
  Delay(fallback, function()
    TriggerReminder()
  end)
end)

DEFAULT_CHAT_FRAME:AddMessage("|cff88ff88✅ KeijinAfterDeathReminder v2.0.2b geladen. Nutze /kadr.", 0.6, 1, 0.6)
