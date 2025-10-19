local addonName = ...
local addon = _G.BrokerWhereAmI
if not addon then
    return
end

---@type BrokerWhereAmI_ace
local ace_addon = _G.LibStub("AceAddon-3.0"):GetAddon("Broker_WhereAmI")

---@class WhereAmIConfig
local config = ace_addon:NewModule("WhereAmIConfig")
addon.config = config

local AceConfig = _G.LibStub("AceConfig-3.0")
local AceConfigDialog = _G.LibStub("AceConfigDialog-3.0")

---Open config window
function config.ShowConfig()
    _G.Settings.OpenToCategory(ace_addon.title)
end

function config.reset()
    _G['WhereAmIOptions'] = {
        show_main_zone = true,
        show_sub_zone = true,
        show_coords = true,
        cords_decimal_precision = 0,
        show_zone_level = true,
        hide_minimap_location = false,
        show_recommended = true,
        show_atlas_on_ctrl = false,
        show_map_id = false,
    }
end

---Initialize options panel and configuration parameters
---
---Called at event ADDON_LOADED
function config:OnInitialize()
    self.optionsFrames = {}
    if _G['WhereAmIOptions'] == nil then
        self.reset()
    end
end

function config:OnEnable()
    ---@type WhereAmIOptionsTable
    local options = ace_addon:GetModule("WhereAmIOptionsTable")
    -- Register the config
    AceConfig:RegisterOptionsTable(ace_addon.title, options.optionsTable, nil)
    self.optionsFrames.general = AceConfigDialog:AddToBlizOptions(ace_addon.title, nil, nil, "general")
end

function config.handler_hide_minimap_location(key, value)
    if value then
        addon.hideMiniMapZone()
    else
        addon.showMiniMapZone()
    end
    return key
end

---Get configuration parameter
function config.get(key)
    return _G['WhereAmIOptions'][key]
end

