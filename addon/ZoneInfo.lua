local addon = _G.BrokerWhereAmI
if not addon then
    return
end
---@class WhereAmIZoneInfo
local Zone = addon.zoneInfo

local is_classic = addon.is_classic
local Tourist = addon.tourist
local utils = addon.utils

---Get information about the current Zone
---@return WhereAmIZoneInfo
function Zone:current()
    local o = self:construct()
    return o
end

function Zone:fromZoneName(zone)
    local mapId = Tourist:GetZoneMapID(zone)
    return self:construct(mapId)
end

function Zone:construct(mapId)
    local o = {}
    if mapId == nil then
        o.mapId = _G['C_Map'].GetBestMapForUnit("player")
    else
        o.mapId = mapId
    end

    if mapId == nil then
        o.zoneText = _G.GetZoneText()
    else
        local mapInfo = _G.C_Map.GetMapInfo(o.mapId)
        if mapInfo ~= nil then
            o.zoneText = mapInfo['name']
        else
            --@debug@
            --addon.utils:printf('No info found for UiMapID %d', mapId)
            error(('No info found for UiMapID "%d"'):format(mapId))
            --@end-debug@
        end
    end

    if o.zoneText == '' then
        o.zoneText = nil
    end

    if mapId == nil then
        o.subZoneText = _G.GetSubZoneText()
        if o.subZoneText == '' then
            o.subZoneText = nil
        end
    end

    o.continent = Tourist:GetContinent(o.mapId)

    if not is_classic then
        o.touristZoneText = Tourist:GetUniqueZoneNameForLookup(o.zoneText, o.mapId)
    else
        o.touristZoneText = o.zoneText
    end

    o.levelString = Tourist:GetLevelString(o.mapId)
    if o.levelString == '' or o.levelString == '0' then
        o.levelString = nil
    end

    o.factionColor = utils:GenerateHexColor(utils:ColorToRGB(Tourist:GetFactionColor(o.mapId)))

    --local low, high = Tourist:GetLevel(zone)
    --local r1, g1, b1 = Tourist:GetFactionColor(zone)
    --local r2, g2, b2 = Tourist:GetLevelColor(zone)
    --local zContinent = Tourist:GetContinent(zone)

    self.info = o

    setmetatable(o, self)
    self.__index = self
    return o
end

function Zone:fishing()
    return Tourist:GetFishingSkillInfo(self.mapId)
end