local addon = _G.BrokerWhereAmI
if not addon then
    return
end
local ldb = _G.LibStub:GetLibrary("LibDataBroker-1.1")

local icon
if not addon.is_classic then
    icon = "Interface\\Icons\\INV_Misc_Map07.png"
else
    icon = "Interface\\Icons\\inv_misc_map_01"
end

---LibDataBroker object
addon.obj = ldb:NewDataObject(addon.name, {
    type = "data source",
    label = "Where am I?",
    text = "Waiting for movement...",
    icon = icon,
})

---Main update function
function addon:MainUpdate()
    self.obj.text = addon.text:GetLDBText()
end

function addon.show_map()
    if _G.Atlas_Toggle ~= nil and _G.IsControlKeyDown() and addon.config.get('show_atlas_on_ctrl') then
        _G.Atlas_Toggle() -- Defined in Atlas.lua in Atlas addon
    else
        _G.ToggleFrame(_G.WorldMapFrame)
    end
end

function addon.hideMiniMapZone()
    _G.MinimapBorderTop:Hide()
    _G.MinimapZoneTextButton:Hide()
    if _G.MinimapToggleButton then
        _G.MinimapToggleButton:Hide()
    end
end

function addon.showMiniMapZone()
    _G.MinimapBorderTop:Show()
    _G.MinimapZoneTextButton:Show()
    if _G.MinimapToggleButton then
        _G.MinimapToggleButton:Show()
    end
end

-- LDB Event handlers
function addon.obj.OnEnter(self)
    addon.tooltip:initialize(self)
end

function addon.obj.OnClick(_, button)
    addon:MainUpdate()
    if button == "LeftButton" then
        if _G.IsShiftKeyDown() then
            local edit_box = _G.ChatEdit_ChooseBoxForSend()
            _G.ChatEdit_ActivateChat(edit_box)
            edit_box:Insert(addon.text:GetChatText())
        else
            addon.show_map()
        end
    end
    if button == "RightButton" then
        addon.config.ShowConfig()
    end
end

function addon.obj.OnLeave()
end
