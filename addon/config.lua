local addon = _G.BrokerWhereAmI
---@class WhereAmIConfig
local config = addon.config
local addonName, _ = ...
local AceConfig = _G.LibStub("AceConfig-3.0")
local AceConfigDialog = _G.LibStub("AceConfigDialog-3.0")

---Open config window
function config:ShowConfig()
    -- call twice to workaround a bug in Blizzard's function
    _G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
    _G.InterfaceOptionsFrame_OpenToCategory(self.optionsFrames.general)
end

function config.reset()
    _G['WhereAmIOptions'] = {
        show_main_zone = true,
        show_sub_zone = true,
        show_coords = true,
        cords_decimal_precision = 0,
        show_zone_level = true,
        show_minimap = false,
        show_recommended = true,
        show_atlas_on_ctrl = false,
    }
end

---Initialize options panel and configuration parameters
---
---Called at event ADDON_LOADED
function config:init()
    AceConfig:RegisterOptionsTable(addon.name, addon.optionsTable, nil)
    self.optionsFrames = {}
    self.optionsFrames.general = AceConfigDialog:AddToBlizOptions(addon.name, nil, nil, "general")

    if _G['WhereAmIOptions'] == nil then
        self.reset()
    end
end

function config.option_set(info, value)
    local key = info[#info]
    --print("The " .. info[#info] .. " was set to: " .. tostring(value))
    _G['WhereAmIOptions'][key] = value
    addon:MainUpdate()
end

---Get configuration parameter
function config.get(key)
    return _G['WhereAmIOptions'][key]
end

function config.option_get(info)
    local key = info[#info]
    --print("Get " .. info[#info])
    return _G['WhereAmIOptions'][key]
end

