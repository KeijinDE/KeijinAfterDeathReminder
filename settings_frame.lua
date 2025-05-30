local f = CreateFrame("Frame", "KADR_SettingsFrame", UIParent)
f:SetWidth(300)
f:SetHeight(240)
f:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
f:SetBackdrop({
  bgFile = "Interface/Tooltips/UI-Tooltip-Background",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true, tileSize = 16, edgeSize = 12,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
f:SetBackdropColor(0, 0, 0, 0.8)
f:Hide()

local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
title:SetPoint("TOP", f, "TOP", 0, -10)
title:SetText("KADR Settings")

local function CreateCheckbox(label, yOffset, configKey)
  local cb = CreateFrame("CheckButton", nil, f)
  cb:SetWidth(20)
  cb:SetHeight(20)
  cb:SetPoint("TOPLEFT", f, "TOPLEFT", 20, yOffset)

  cb:SetNormalTexture("Interface\Buttons\UI-CheckBox-Up")
  cb:SetPushedTexture("Interface\Buttons\UI-CheckBox-Down")
  cb:SetHighlightTexture("Interface\Buttons\UI-CheckBox-Highlight")
  cb:SetCheckedTexture("Interface\Buttons\UI-CheckBox-Check")

  cb:SetChecked(KADR_Config[configKey] == true)
  cb:SetScript("OnClick", function()
    KADR_Config[configKey] = cb:GetChecked()
  end)

  local lbl = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  lbl:SetPoint("LEFT", cb, "RIGHT", 4, 0)
  lbl:SetText(label)
end

CreateCheckbox("Show Chat", -40, "showChat")
CreateCheckbox("Show Frame", -70, "showFrame")

local xLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
xLabel:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -100)
xLabel:SetText("X Position:")

local xInput = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
xInput:SetWidth(50)
xInput:SetHeight(20)
xInput:SetPoint("LEFT", xLabel, "RIGHT", 10, 0)
xInput:SetAutoFocus(false)
xInput:SetText(tostring(KADR_Config.frameX or 0))

local yLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
yLabel:SetPoint("TOPLEFT", f, "TOPLEFT", 20, -130)
yLabel:SetText("Y Position:")

local yInput = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
yInput:SetWidth(50)
yInput:SetHeight(20)
yInput:SetPoint("LEFT", yLabel, "RIGHT", 10, 0)
yInput:SetAutoFocus(false)
yInput:SetText(tostring(KADR_Config.frameY or 0))

local saveXY = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
saveXY:SetWidth(100)
saveXY:SetHeight(20)
saveXY:SetPoint("TOP", f, "TOP", 0, -160)
saveXY:SetText("Save Position")
saveXY:SetScript("OnClick", function()
  local x = tonumber(xInput:GetText())
  local y = tonumber(yInput:GetText())
  if x and y then
    KADR_Config.frameX = x
    KADR_Config.frameY = y
    DEFAULT_CHAT_FRAME:AddMessage("KADR: Position gespeichert ("..x..", "..y..")", 0.5, 1, 0.5)
  else
    DEFAULT_CHAT_FRAME:AddMessage("KADR: Ungültige Eingabe für X/Y", 1, 0.2, 0.2)
  end
end)

local testBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
testBtn:SetWidth(120)
testBtn:SetHeight(20)
testBtn:SetPoint("BOTTOM", f, "BOTTOM", 0, 35)
testBtn:SetText("Test Reminder")
testBtn:SetScript("OnClick", function()
  if KADR_Config.showChat then
    for i = 1, 3 do
      local delay = i * 2
      local chatf = CreateFrame("Frame")
      local elapsed = 0
      chatf:SetScript("OnUpdate", function()
        elapsed = elapsed + 0.05
        if elapsed >= delay then
          chatf:SetScript("OnUpdate", nil)
          DEFAULT_CHAT_FRAME:AddMessage("|cffff4444⚠️ Reminder: Aura, Blessing, Tracking!", 1, 0.2, 0.2)
        end
      end)
    end
  end

  if KADR_Config.showFrame and KADR_UIReminderFrame then
    KADR_UIReminderFrame:ClearAllPoints()
    KADR_UIReminderFrame:SetPoint("CENTER", UIParent, "CENTER", KADR_Config.frameX, KADR_Config.frameY)
    KADR_UIReminderFrame:Show()
    local elapsed = 0
    local t = CreateFrame("Frame")
    t:SetScript("OnUpdate", function()
      elapsed = elapsed + 0.05
      if elapsed >= KADR_Config.frameDuration then
        t:SetScript("OnUpdate", nil)
        KADR_UIReminderFrame:Hide()
      end
    end)
  end
end)

local btn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
btn:SetWidth(120)
btn:SetHeight(20)
btn:SetPoint("BOTTOM", f, "BOTTOM", 0, 10)
btn:SetText("Close")
btn:SetScript("OnClick", function() f:Hide() end)
