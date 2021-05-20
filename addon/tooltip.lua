local addon = _G.BrokerWhereAmI
---@class WhereAmITooltip
local tooltip_class = addon.tooltip
local Tourist = addon.tourist
local text = addon.text
---Font definitions
local fonts = addon.fonts

local LibQTip = _G.LibStub('LibQTip-1.0')
local addonName, _ = ...

function tooltip_class:initialize(obj)
    if LibQTip:IsAcquired(addonName) then
        self.tooltip:Clear()
    else
        self.tooltip = LibQTip:Acquire(addonName, 4)

        self.tooltip:SetHeaderFont(fonts.header)
        self.tooltip:SetFont(fonts.text)

        self.tooltip:SmartAnchorTo(obj)

        self.tooltip:SetAutoHideDelay(0.1, obj)
    end
    --_G['WhereAmITooltip'].tooltip = tooltip
    self:add_text()
end

---Clear and update the tooltip
function tooltip_class:update(destination)
    self.tooltip:Clear()
    self:add_text(destination)
end

---add_text
---@param destination string Zone or instance to show walk path to
function tooltip_class:add_text(destination)
    --Title
    local line = self.tooltip:AddLine()
    self.tooltip:SetCell(line, 1, "Broker: Where am I? " .. _G['WhereAmICommon'].version, fonts.title, "CENTER", 0)
    self.tooltip:AddLine(" ")
    --General
    _G['WhereAmITooltip']:general(text.zone)

    --Instances
    _G['WhereAmITooltip']:zone_instances(text.zone.mapId)

    if _G['WhereAmIConfig'].get('show_recommended') then
        _G['WhereAmITooltip']:recommended_zones(destination)
        self.tooltip:AddSeparator()
        -- recommended instances
        _G['WhereAmITooltip']:recommended_instances(destination)
    end

    -- shortcut hints
    self.tooltip:AddLine(" ")
    line = self.tooltip:AddLine()
    self.tooltip:SetCell(line, 1, "|cffeda55fClick|r to open map.", "LEFT", 0)
    line = self.tooltip:AddLine()
    self.tooltip:SetCell(line, 1, "|cffeda55fRight-Click|r to open the options menu.", "LEFT", 0)
    line = self.tooltip:AddLine()
    self.tooltip:SetCell(line, 1, "|cffeda55fShift-Click|r to insert position into chat edit box.", "LEFT", 0)
    if _G['WhereAmIOptions']['show_recommended'] then
        line = self.tooltip:AddLine()
        self.tooltip:SetCell(line, 1, "|cffeda55fClick on recommended item|r to see walk path to it.", "LEFT", 0)
    end
    if _G['WhereAmIOptions']['show_atlas_on_ctrl'] and _G.Atlas_Toggle ~= nil then
        line = self.tooltip:AddLine()
        self.tooltip:SetCell(line, 1, "|cffeda55fControl-Click|r to open Atlas.", "LEFT", 0)
    end

    self.tooltip:Show()
end

function tooltip_class:show_path(zone)
    --@debug@
    print('Show path to', zone)
    --@end-debug@
    if self.selectedPath == zone then
        self.selectedPath = nil
    else
        self.selectedPath = zone
    end
    self:update(self.selectedPath)
end

---Handle click on a recommendation entry
---
---Called static from LibQTip
function tooltip_class.Entry_OnMouseUp(_, info, _)
    --if tooltip_class.selectedPath == info then
    --    tooltip_class.selectedPath = nil
    --else
    --    tooltip_class.selectedPath = info
    --end
    ----addon.obj.OnEnter()
    --tooltip_class:update()
    tooltip_class:show_path(info)
end

function tooltip_class:general(zone)
    -- general info
    if zone == nil then
        return
    end
    local tooltip = self.tooltip

    local line = tooltip:AddLine("Zone:")
    tooltip:SetCell(line, 2, zone.zoneText, "LEFT", 3)
    if text.zone.subZoneText ~= nil then
        line = tooltip:AddLine("Subzone:")
        tooltip:SetCell(line, 2, zone.subZoneText, "LEFT", 3)
    end

    local status = text:GetAreaStatus()
    if status then
        line = tooltip:AddLine("Status:")
        tooltip:SetCell(line, 2, status, "LEFT", 3)
    end

    line = tooltip:AddLine("Coordinates:")
    local coords_string = text:GetCoordinateText(2):sub(2, -2)
    tooltip:SetCell(line, 2, coords_string, "LEFT", 3)

    --touristContinentText = Tourist:GetContinent(text.touristZoneText)
    line = tooltip:AddLine("Continent:")
    tooltip:SetCell(line, 2, zone.continent, "LEFT", 3)

    local level = text:GetLevelRangeText()
    if level then
        line = tooltip:AddLine("Level range:")
        tooltip:SetCell(line, 2, level, "LEFT", 3)
    end

    local fishText = text:GetFishingSkillText()
    if fishText ~= nil then
        line = tooltip:AddLine("Fishing:")
        tooltip:SetCell(line, 2, fishText, "LEFT", 3)
    end

    if Tourist['GetBattlePetLevelString'] ~= nil then
        local pet_levels = Tourist:GetBattlePetLevelString(text.zone.mapId)
        if pet_levels then
            line = tooltip:AddLine("Battle Pet levels:")
            tooltip:SetCell(line, 2, pet_levels, "LEFT", 3)
        end
    end
end

-- Show path to recommended zone
function tooltip_class:AddPathTooltip(destination_zone)
    local tooltip = self.tooltip

    tooltip:AddSeparator()
    local line = tooltip:AddLine()
    tooltip:SetCell(line, 1, addon.utils:sprintf("    Walk path from %s to %s:",
            text.zone.touristZoneText, destination_zone), "LEFT", 0)

    local found = false
    --@debug@
    addon.utils:printf('Get path from %s to %s', text.zone.touristZoneText, destination_zone)
    --@end-debug@
    for z in Tourist:IteratePath(text.zone.touristZoneText, destination_zone) do
        found = true
        local zone_string, level_string, continent_string = text:zone_info(z)
        tooltip:AddLine("    " .. zone_string, level_string, continent_string)
    end
    if not found then
        line = tooltip:AddLine()
        tooltip:SetCell(line, 1, "    No path found.", "LEFT", 0)
    end
    tooltip:AddSeparator()
end

function tooltip_class:instance_line(instance)
    local zone_string, level_string = text:zone_info(instance)

    local groupSize = Tourist:GetInstanceGroupSize(instance)
    local groupSize_string
    if groupSize > 0 then
        groupSize_string = addon.utils:sprintf("%d-man", groupSize)
    else
        groupSize_string = ''
    end

    return self.tooltip:AddLine(zone_string, level_string, groupSize_string, Tourist:GetInstanceZone(instance))
end

---Show recommended zones
---@param destination_zone string Zone to show walk path to
function tooltip_class:recommended_zones(destination_zone)
    self.tooltip:AddLine(" ")
    local line = self.tooltip:AddHeader()
    self.tooltip:SetCell(line, 1, "Recommended zones:", "LEFT", 0)

    self.tooltip:AddSeparator()
    for zone in Tourist:IterateRecommendedZones() do
        local zone_string, level_string, continent_string = text:zone_info(zone)
        line = self.tooltip:AddLine(zone_string, level_string, continent_string)
        self.tooltip:SetLineScript(line, "OnMouseUp", self.Entry_OnMouseUp, zone)

        -- show path
        if zone == destination_zone then
            self:AddPathTooltip(zone)
        end
    end
end

---Show recommended instances
---@param destination_instance string Instance to show walk path to
function tooltip_class:recommended_instances(destination_instance)
    local tooltip = self.tooltip
    if Tourist:HasRecommendedInstances() then
        tooltip:AddLine(" ")
        local line = tooltip:AddHeader()
        tooltip:SetCell(line, 1, "Recommended instances:", "LEFT", 0)

        tooltip:AddSeparator()
        for instance in Tourist:IterateRecommendedInstances() do
            line = self:instance_line(instance)
            tooltip:SetLineScript(line, "OnMouseUp", self.Entry_OnMouseUp, instance)

            -- show path
            if instance == destination_instance then
                self:AddPathTooltip(instance)
            end
        end
        tooltip:AddSeparator()
    end
end

function tooltip_class:zone_instances(mapId)
    local tooltip = self.tooltip
    if Tourist:DoesZoneHaveInstances(mapId) then
        tooltip:AddLine(" ")
        local line = tooltip:AddHeader()
        tooltip:SetCell(line, 1, "Instances:", "LEFT", 0)

        tooltip:AddSeparator()
        for instance in Tourist:IterateZoneInstances(mapId) do
            self:instance_line(instance)
        end
        tooltip:AddSeparator()
    end
end