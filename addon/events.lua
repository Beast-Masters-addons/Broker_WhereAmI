_G['WhereAmIEvents'] = {}
local events = _G['WhereAmIEvents']
--local addon = _G['WhereAmI-@project-version@']
local addon = _G['WhereAmI']
local text = _G['WhereAmIText']
local utils = _G['WhereAmICommon'].utils

local frame = _G.CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, ...)
    if _G['WhereAmIEvents'][event] == nil then
        error(utils:sprintf('No event handler for %s', event))
    end
    events[event](self, ...)
end)

function events:ADDON_LOADED(addonName)
    if addonName == 'Broker_WhereAmI' then
        addon = _G['WhereAmI']
        --text = _G['WhereAmIText']
        --@debug
        utils:printf("%s loaded", addonName)
        --@end-debug
        self:RegisterEvent("ZONE_CHANGED")
        self:RegisterEvent("ZONE_CHANGED_INDOORS")
        self:RegisterEvent("ZONE_CHANGED_NEW_AREA")
        self:RegisterEvent("PLAYER_STARTED_MOVING")
        self:RegisterEvent("PLAYER_STOPPED_MOVING")
        self:RegisterEvent("PLAYER_ENTERING_WORLD")

        _G['WhereAmIConfig']:init()
        --addon:MainUpdate()
    end
end

function events.ZONE_CHANGED()
    text:UpdateZoneInfo()
end

function events.ZONE_CHANGED_INDOORS()
    text:UpdateZoneInfo()
end

function events.ZONE_CHANGED_NEW_AREA()
    text:UpdateZoneInfo()
end

function events.PLAYER_ENTERING_WORLD()
    if _G.GetRealZoneText() ~= nil then
        text:UpdateZoneInfo()
        addon:MainUpdate()
        --@debug
        print('PLAYER_ENTERING_WORLD in zone', _G.GetRealZoneText())
        --@end-debug
    end
end

function events:PLAYER_STARTED_MOVING()
    -- Start update loop
    self.isMoving = true
    if text.zone == nil then
        text:UpdateZoneInfo()
    end

    frame:SetScript("OnUpdate", events.onUpdate)
end

function events:PLAYER_STOPPED_MOVING()
    -- Stop update loop
    self.isMoving = false
    frame:SetScript("OnUpdate", nil)
end

local updateCounter = 0;
local updateFrequency = 1;
function events.onUpdate(_, elapsed)
    updateCounter = updateCounter + elapsed;
    if (updateCounter >= updateFrequency) then
        addon:MainUpdate()
    end
end

