local frame = CreateFrame("Frame", "KADR_UIReminderFrame", UIParent)
frame:SetWidth(300)
frame:SetHeight(40)
frame:SetBackdrop({
  bgFile = "Interface/Tooltips/UI-Tooltip-Background",
  edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
  tile = true, tileSize = 16, edgeSize = 12,
  insets = { left = 4, right = 4, top = 4, bottom = 4 }
})
frame:SetBackdropColor(0, 0, 0, 0.7)

local text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
text:SetPoint("CENTER", frame, "CENTER", 0, 0)
text:SetText("⚠ Aura, Blessing, Tracking!")

frame:Hide()
