local frame = {}

function CreateFrame()
    return frame
end

function frame:SetScript(callable)
    self.script = callable
end

function frame:GetScript()
    return self.script
end

function frame:Hide()

end

function frame:Show()

end

function frame:RegisterEvent(event)

end

function frame:SetPoint()

end

function frame:SetSize()

end

function frame:SetText(text)
    self.text = text
end

function frame:EnableMouse()

end

function frame:SetFrameStrata(strata)
    self.strata = strata
end

function frame:SetFrameLevel(level)
    self.level = level
end

function frame:SetBackdrop()

end

function frame:CreateFontString()
    return _G.WowText
end

function frame:SetNormalFontObject(GameFontNormal)

end

function frame:SetHighlightFontObject(GameFontHighlight)

end

---@return WowTexture
function frame:CreateTexture()
    return _G.WowTexture
end

function frame:SetNormalTexture(texture)
    ---@type WowTexture
    self.normalTexture = texture
end

---@return WowTexture
function frame:GetNormalTexture()
    --return self.normalTexture
    return _G.WowTexture
end

function frame:SetPushedTexture(texture)

end

---@return WowTexture
function frame:GetPushedTexture()
    --return self.normalTexture
    return _G.WowTexture
end

function frame:SetHighlightTexture(texture)

end

---@return WowTexture
function frame:GetHighlightTexture()
    --return self.HighlightTexture
    return _G.WowTexture
end

function frame:ClearAllPoints()

end