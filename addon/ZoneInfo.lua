_G['ZoneInfo'] = {}
local Zone = _G['ZoneInfo']

local is_classic = _G['WhereAmICommon'].is_classic
local Tourist = _G['WhereAmICommon'].tourist
local utils = _G['WhereAmICommon'].utils

---Get information about the current Zone
---@return ZoneInfo
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
    o.zoneText = _G.GetRealZoneText(mapId)

    if o.zoneText == '' then
        o.zoneText = nil
    end

    o.subZoneText = _G.GetSubZoneText(mapId)
    if o.subZoneText == '' then
        o.subZoneText = nil
    end

    if mapId == nil then
        o.mapId = _G['C_Map'].GetBestMapForUnit("player")
    else
        o.mapId = mapId
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