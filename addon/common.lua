---@class BrokerWhereAmI
_G['BrokerWhereAmI'] = {
    version = '@project-version@',
    name = ...,
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
_G['BrokerWhereAmI'].is_classic = _G['BrokerWhereAmI'].utils:IsWoWClassic()

if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
    _G['BrokerWhereAmI'].tourist = _G.LibStub("LibTouristClassicEra")
elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    _G['BrokerWhereAmI'].tourist = _G.LibStub("LibTouristClassic-1.0")
elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE then
    _G['BrokerWhereAmI'].tourist = _G.LibStub("LibTourist-3.0")
end