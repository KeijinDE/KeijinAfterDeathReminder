SLASH_KADR1 = "/kadr"

SlashCmdList["KADR"] = function(msg)
  msg = string.lower(msg)

  if msg == "toggle" then
    KADR_Config.enabled = not KADR_Config.enabled
    DEFAULT_CHAT_FRAME:AddMessage("KADR: "..(KADR_Config.enabled and "aktiviert" or "deaktiviert"))

  elseif msg == "debug" then
    DEFAULT_CHAT_FRAME:AddMessage("KADR: Debug-Test gestartet...")
    for i = 1, 3 do
      local f = CreateFrame("Frame")
      local elapsed = 0
      f:SetScript("OnUpdate", function()
        elapsed = elapsed + 0.05
        if elapsed >= i * 2 then
          f:SetScript("OnUpdate", nil)
          DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00[Debug] Reminder "..i, 1, 1, 0)
        end
      end)
    end

  elseif msg == "config" then
    if KADR_SettingsFrame then
      KADR_SettingsFrame:Show()
    end

  elseif msg == "simulate" then
    DEFAULT_CHAT_FRAME:AddMessage("KADR: Simuliere Wiederbelebung...", 1, 1, 0)
    if TriggerReminder then
      TriggerReminder()
    else
      DEFAULT_CHAT_FRAME:AddMessage("TriggerReminder() nicht gefunden!", 1, 0, 0)
    end

  else
    DEFAULT_CHAT_FRAME:AddMessage("KADR-Befehle: /kadr toggle | /kadr debug | /kadr config | /kadr simulate")
  end
end
