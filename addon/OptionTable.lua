local addon = _G.BrokerWhereAmI
if not addon then
    return
end
local ace_addon = _G.LibStub("AceAddon-3.0"):GetAddon("Broker_WhereAmI")

---@type WhereAmIConfig
local config = ace_addon:GetModule("WhereAmIConfig")
---@class WhereAmIOptionsTable Options table for AceConfig
local options = ace_addon:NewModule("WhereAmIOptionsTable")

options.optionsTable = {
    type = "group",
    name = addon.name,
    args = {
        general = {
            order = 1,
            type = "group",
            name = "General Settings",
            cmdInline = true,
            get = function(info)
                local key = info[#info]
                return _G['WhereAmIOptions'][key]
            end,
            set = function(info, value)
                local key = info[#info]
                _G['WhereAmIOptions'][key] = value
                addon:MainUpdate()
            end,
            args = {
                confdesc = {
                    order = 1,
                    type = "description",
                    name = "LDB plugin that shows recommended zones and zone info.",
                },
                separator1 = {
                    order = 2,
                    type = "header",
                    name = "Display Options",
                },
                show_main_zone = {
                    order = 3,
                    type = "toggle",
                    width = "full",
                    name = "Show main zone name",
                    desc = "Toggle to show the main zone name.",
                },
                show_sub_zone = {
                    order = 4,
                    type = "toggle",
                    width = "full",
                    name = "Show sub zone name",
                    desc = "Toggle to show the sub zone name.",
                },
                show_coords = {
                    order = 5,
                    type = 'toggle',
                    name = "Show coordinates",
                    desc = "Toggle to show coordinates.",
                },
                cords_decimal_precision = {
                    order = 6,
                    type = "range",
                    name = "Coordinates decimal precision",
                    desc = "Set the number of visible decimals.",
                    min = 0, max = 2, step = 1,
                    disabled = function()
                        return not addon.config.get('show_coords')
                    end,
                },
                show_zone_level = {
                    order = 7,
                    type = 'toggle',
                    width = "full",
                    name = "Show zone level",
                    desc = "Toggle to show the zone level.",
                },
                hide_minimap_location = {
                    order = 8,
                    type = 'toggle',
                    width = "full",
                    name = "Hide location above minimap.",
                    desc = "Toggle to show the text displayed above the minimap.",
                    set = config.handler_hide_minimap_location
                },
                separator2 = {
                    order = 10,
                    type = "header",
                    name = "Tooltip Options",
                },
                show_recommended = {
                    order = 11,
                    type = 'toggle',
                    width = "full",
                    name = "Show recommended zones/instances",
                    desc = "Toggle to show the recommended zones/instances.",
                },
                show_atlas_on_ctrl = {
                    order = 12,
                    type = 'toggle',
                    width = "full",
                    name = "Show Atlas on Control+Click",
                    desc = "Toggle to show Atlas instead of default map when Control Clicking.",
                    hidden = function()
                        return _G['Atlas'] == nil
                    end
                },
                show_map_id = {
                    order = 13,
                    type = 'toggle',
                    width = "full",
                    name = "Show UiMapID",
                    desc = "Toggle to show the UiMapID.",
                },
            }
        }
    }
}