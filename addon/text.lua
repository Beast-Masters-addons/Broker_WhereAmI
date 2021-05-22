local addon = _G.BrokerWhereAmI
---@class WhereAmIText Text utils
local text = addon.text

text.professions = _G['LibProfessions']
text.professions = _G['LibStub']('LibProfessions-0')

text.is_classic = addon.is_classic
text.config = addon.config

local Tourist = addon.tourist

---Create fish skill text
---@return string
function text:GetFishingSkillText()
    if addon.is_classic then
        local minFish = Tourist:GetFishingLevel(self.zone.mapId)
        local fishSkill = self.professions:GetAllSkills()["Fishing"]
        if fishSkill ~= nil then
            local skillRank = fishSkill[4]
            if minFish < skillRank then
                return addon.utils:colorize(minFish, 0, 255, 0)
            elseif minFish == skillRank then
                return addon.utils:colorize(minFish, 255, 255, 0)
            else
                return addon.utils:colorize(minFish, 255, 0, 0)
            end
        end
    else
        Tourist:GetZoneMapID(self.touristZoneText) --LibTourist has no error handling for invalid zones
        if self.zone.mapId ~= nil then
            local skillEnabled
            local skillName, _, _, _ = Tourist:GetFishingSkillInfo(self.zone.mapId)
            if not skillName then
                Tourist:LoadFishingSkills()
                skillName, _, _, skillEnabled = Tourist:GetFishingSkillInfo(self.zone.mapId)
                if skillEnabled == false then
                    return
                end
            end
            return skillName
        end
    end
end

-- Return area status: sanctuary, friendly, contested
function text:GetAreaStatus()
    if (Tourist:IsFriendly(self.mapId)) then
        return addon.utils:colorize('Friendly', 25.5, 255, 25.5)
    elseif (Tourist:IsHostile(self.mapId)) then
        return addon.utils:colorize('Hostile', 255, 25.5, 25.5)
    elseif (Tourist:IsContested(self.mapId)) then
        return addon.utils:colorize('Contested', 255, 178.5, 25.5)
    elseif (Tourist:IsInstance(self.mapId)) then
        return addon.utils:colorize('Instance', 255, 25.5, 25.5)
    elseif addon.is_classic == false then
        local pvpType, _, _ = _G.GetZonePVPInfo()
        if (Tourist:IsSanctuary(self.mapId)) then
            return addon.utils:colorize('Sanctuary', 104.55, 204, 239, 7)
        elseif (addon.is_classic == false and Tourist:IsArena(self.mapId)) then
            return addon.utils:colorize('Arena', 255, 25.5, 25.5)
        elseif (pvpType == "combat") then
            return addon.utils:colorize('Combat', 255, 25.5, 25.5)
        end
    end
    return addon.utils:colorize(_G.UNKNOWN or '?', 255, 255, 0)
end

---Save current zone
function text:UpdateZoneInfo()
    self.zone = addon.zoneInfo:current()

    self.mapId = self.zone.mapId
    self.zoneText = self.zone.zoneText
    self.subZoneText = self.zone.subZoneText

    if not addon.is_classic then
        self.touristZoneText = Tourist:GetUniqueZoneNameForLookup(self.zoneText, self.zone.mapId)
    else
        self.touristZoneText = self.zoneText
    end
end

---GetZoneName
---@param show_main boolean
---@param show_sub boolean
---@return string
function text:GetZoneName(show_main, show_sub)
    if self.zone.touristZoneText == '' then
        show_main = false
    end

    if self.zone.subZoneText == self.zone.touristZoneText or self.zone.subZoneText == nil then
        show_sub = false
    end

    if self.zone.mapId == nil then
        return ''
    end

    -- zone and sub zone
    if show_main then
        if show_sub then
            return addon.utils:sprintf('%s: %s', self.touristZoneText, self.subZoneText)
        else
            return self.touristZoneText
        end
    elseif show_sub then
        return self.subZoneText
    else
        return ''
    end
end

function text:GetLevelRangeText(wrap)
    if self.zone.levelString == nil then
        return
    end
    local level_string = self.zone.levelString

    if wrap == true then
        level_string = addon.utils:sprintf('[%s]', level_string)
    end
    local r, g, b = Tourist:GetLevelColor(self.mapId)
    return addon.utils:colorize(level_string, addon.utils:ColorToRGB(r, g, b))
end

function text:GetCoordinateText(precision)
    if self.mapId == nil then
        return ''
    end
    local mapPosObject = _G['C_Map'].GetPlayerMapPosition(self.mapId, "player")
    if mapPosObject == nil then
        return ''
    end
    local x, y = mapPosObject:GetXY()

    return addon.utils:sprintf("(%." .. precision .. "f, %." .. precision .. "f)", x * 100, y * 100)
end

---Create location text for chat
function text:GetChatText()
    local zone = self:GetZoneName(true, true)
    local coords = self:GetCoordinateText(0)
    return zone .. " " .. coords
end

---Create LDB display text
function text:GetLDBText()
    local show_main = self.config.get('show_main_zone')
    local show_sub = self.config.get('show_sub_zone')
    local show_coords = self.config.get('show_coords')
    local show_level = self.config.get('show_zone_level')
    local precision = self.config.get('cords_decimal_precision')

    local ldb_text = ''
    ldb_text = ldb_text .. self:GetZoneName(show_main, show_sub)

    -- coordinates
    if show_coords then
        ldb_text = ldb_text .. " " .. self:GetCoordinateText(precision)
    end

    if show_level and self.zone.levelString ~= nil then
        local level_string = self:GetLevelRangeText(show_main and show_sub)
        ldb_text = ldb_text .. " " .. level_string
    end

    ldb_text = addon.utils:colorize(ldb_text, self.zone.factionColor)
    return ldb_text
end

--function text:GetLocation(show_main, show_sub, precision, show_levels)
--    if precision == nil then
--        precision = 0
--    end
--
--    if show_levels == nil then
--        show_levels = false
--    end
--end

function text:zone_info(zone)
    local zone_obj = _G['BrokerWhereAmI'].zoneInfo:fromZoneName(zone)
    local zone_string = addon.utils:colorize(zone, zone_obj.factionColor)

    local level_string
    if zone_obj.levelString ~= nil then
        level_string = addon.utils:colorize(zone_obj.levelString, zone_obj.factionColor)
    end

    local continent_string
    if self.zone.continent == zone_obj.continent then
        continent_string = addon.utils:colorize(zone_obj.continent, 'ff00ff00') --green
    else
        continent_string = addon.utils:colorize(zone_obj.continent, 'ffffff00') --yellow
    end

    return zone_string, level_string, continent_string, zone_obj
end