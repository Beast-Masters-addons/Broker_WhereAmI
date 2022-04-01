local addon = _G.BrokerWhereAmI
---@class WhereAmIOptionsTable Options table for AceConfig
addon.optionsTable = {
    type = "group",
    name = addon.name,
    args = {
        general = {
            order = 1,
            type = "group",
            name = "General Settings",
            cmdInline = true,
            get = addon.config.option_get,
            set = addon.config.option_set,
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
                --[[				show_minimap = {
                                    order = 8,
                                    type = 'toggle',
                                    width = "full",
                                    name = "Show location above minimap.",
                                    desc = "Toggle to show the text displayed above the minimap.",
                                    get = function()
                                        return profileDB.show_minimap
                                    end,
                                    set = function(key, value)
                                        profileDB.show_minimap = value
                                        addon:UpdateMinimapZoneTextButton()
                                    end,
                                },]]
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