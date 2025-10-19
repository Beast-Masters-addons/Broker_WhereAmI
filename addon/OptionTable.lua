local addon = _G.BrokerWhereAmI
if not addon then
    return
end
---@type BrokerWhereAmI_ace
local ace_addon = _G.LibStub("AceAddon-3.0"):GetAddon("Broker_WhereAmI")
local L = ace_addon.locale

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
            name = _G.SETTINGS,
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
                    name = L["A LDB plugin that shows where you are and where you should go"],
                },
                separator1 = {
                    order = 2,
                    type = "header",
                    name = _G.DISPLAY,
                },
                show_main_zone = {
                    order = 3,
                    type = "toggle",
                    width = "full",
                    name = L["Show main zone name"],
                    desc = L["Enable to show the main zone name"],
                },
                show_sub_zone = {
                    order = 4,
                    type = "toggle",
                    width = "full",
                    name = L["Show sub zone name"],
                    desc = L["Enable to show the sub zone name"],
                },
                show_coords = {
                    order = 5,
                    type = 'toggle',
                    name = L["Show coordinates"],
                    desc = L["Enable to show coordinates"],
                },
                cords_decimal_precision = {
                    order = 6,
                    type = "range",
                    name = L["Coordinates decimal precision"],
                    desc = L["Set the number of visible decimals"],
                    min = 0, max = 2, step = 1,
                    disabled = function()
                        return not addon.config.get('show_coords')
                    end,
                },
                show_zone_level = {
                    order = 7,
                    type = 'toggle',
                    width = "full",
                    name = L["Show zone level"],
                    desc = L["Enable to show the zone level"],
                },
                hide_minimap_location = {
                    order = 8,
                    type = 'toggle',
                    width = "full",
                    name = L["Hide location above minimap."],
                    desc = L["Enable to show the text displayed above the minimap"],
                    set = config.handler_hide_minimap_location
                },
                separator2 = {
                    order = 10,
                    type = "header",
                    name = L["Tooltip"],
                },
                show_recommended = {
                    order = 11,
                    type = 'toggle',
                    width = "full",
                    name = L["Show recommended zones/instances"],
                    desc = L["Enable to show the recommended zones/instances"],
                },
                show_atlas_on_ctrl = {
                    order = 12,
                    type = 'toggle',
                    width = "full",
                    name = L["Show Atlas on Ctrl+Click"],
                    desc = L["Enable to show Atlas instead of default map when Control Clicking"],
                    hidden = function()
                        return _G['Atlas'] == nil
                    end
                },
                show_map_id = {
                    order = 13,
                    type = 'toggle',
                    width = "full",
                    name = L["Show UiMapID"],
                    desc = L["Enable to show UiMapID in tooltip"],
                },
            }
        }
    }
}