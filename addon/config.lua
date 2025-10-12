local addon = _G.BrokerWhereAmI
if not addon then
    return
end
---@class WhereAmIConfig
local config = addon.config
local AceConfig = _G.LibStub("AceConfig-3.0")
local AceConfigDialog = _G.LibStub("AceConfigDialog-3.0")

---Open config window
function config.ShowConfig()
    _G.Settings.OpenToCategory(addon.name)
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
function config:init()
    AceConfig:RegisterOptionsTable(addon.name, addon.optionsTable, nil)
    self.optionsFrames = {}
    self.optionsFrames.general = AceConfigDialog:AddToBlizOptions(addon.name, nil, nil, "general")

    if _G['WhereAmIOptions'] == nil then
        self.reset()
    end
end

function config.handler_hide_minimap_location(key, value)
    print('show_minimap', key, 'value', value)
    if value then
        print('Hide')
        addon.hideMiniMapZone()
    else
        print('Show')
        addon.showMiniMapZone()
    end
    return key
end

---Get configuration parameter
function config.get(key)
    return _G['WhereAmIOptions'][key]
end

