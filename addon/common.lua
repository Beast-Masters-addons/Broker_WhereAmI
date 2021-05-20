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

if not _G['BrokerWhereAmI'].is_classic then
    _G['BrokerWhereAmI'].tourist = _G.LibStub("LibTourist-3.0")
else
    _G['BrokerWhereAmI'].tourist = _G.LibStub("LibTouristClassic-1.0")
end