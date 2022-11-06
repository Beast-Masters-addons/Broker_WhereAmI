local _, addonTitle = _G.GetAddOnInfo(...)
---@class BrokerWhereAmI
local addon = {
    version = '@project-version@',
    name = addonTitle,
    ---@type BMUtils
    utils = _G.LibStub("BM-utils-1"),
    ---@type WhereAmIFonts
    fonts = {},
    ---@type WhereAmIZoneInfo
    zoneInfo = {},
    ---@type WhereAmIConfig
    config = {},
    ---@type WhereAmIOptionsTable
    optionsTable = {},
    ---@type WhereAmIText
    text = {},
    ---@type WhereAmIEvents
    events = {},
    ---@type WhereAmITooltip
    tooltip = {},
}
addon.is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
    addon.tourist = _G.LibStub("LibTouristClassicEra")
elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_WRATH_CLASSIC then
    addon.tourist = _G.LibStub("LibTouristClassic-1.0")
elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE then
    addon.tourist = _G.LibStub("LibTourist-3.0")
else
    error('Unknown game version')
end

_G['BrokerWhereAmI'] = addon