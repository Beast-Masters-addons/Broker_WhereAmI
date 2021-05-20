local addon = _G.BrokerWhereAmI
---@class WhereAmIFonts Static font definitions
local fonts = addon.fonts

---Title Font, 14
fonts.title = _G.CreateFont("titleFont")
fonts.title:SetTextColor(1, 0.823529, 0, 1)
fonts.title:SetFont(_G.GameTooltipText:GetFont(), 14)

---Header Font, 12
fonts.header = _G.CreateFont("headerFont")
fonts.header:SetTextColor(0.92, 0.64, 0.37, 1)
fonts.header:SetFont(_G.GameTooltipHeaderText:GetFont(), 13)

---Regular Font, 12
fonts.text = _G.CreateFont("textFont")
fonts.text:SetTextColor(1, 0.823529, 0, 1)
fonts.text:SetFont(_G.GameTooltipText:GetFont(), 12)
