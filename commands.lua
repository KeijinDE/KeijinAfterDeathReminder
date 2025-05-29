SLASH_KADR1 = "/kadr"

SlashCmdList["KADR"] = function(msg)
  msg = string.lower(msg)

  local function RepeatReminder(times, interval, message)
    local count = 0
    local elapsed = 0
    local f = CreateFrame("Frame")
    f:SetScript("OnUpdate", function()
      elapsed = elapsed + 0.05
      if elapsed >= interval then
        elapsed = 0
        count = count + 1
        DEFAULT_CHAT_FRAME:AddMessage(message, 1, 0.6, 0)
        if count >= times then
          f:SetScript("OnUpdate", nil)
        end
      end
    end)
  end

  if msg == "toggle" then
    KADR_Config.enabled = not KADR_Config.enabled
    local status = KADR_Config.enabled and "aktiviert" or "deaktiviert"
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00KeijinAfterDeathReminder: "..status..".", 1, 1, 0)

  elseif msg == "debug" then
    RepeatReminder(3, 2, "|cffffcc00[Debug] ⚠️ Aura, Blessing und Tracking prüfen!")

  else
    DEFAULT_CHAT_FRAME:AddMessage("|cffffff00Verfügbar: /kadr toggle, /kadr debug", 1, 1, 0)
  end
end
