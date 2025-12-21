local GetAddOnInfo = _G.GetAddOnInfo or (_G.C_AddOns and _G.C_AddOns.GetAddOnInfo)
local _, addonTitle = GetAddOnInfo(...)
---@class BrokerWhereAmI_ace
local ace_addon = _G.LibStub("AceAddon-3.0"):NewAddon("Broker_WhereAmI")

---@class BrokerWhereAmI
local addon = {
    version = '@project-version@',
    name = addonTitle,
    ---@type WhereAmIFonts
    fonts = {},
    ---@type WhereAmIZoneInfo
    zoneInfo = {},
    ---@type WhereAmIConfig
    config = {},
    ---@type WhereAmIOptionsTable
    optionsTable = {},
    ---@type WhereAmIEvents
    events = {},
    ---@type WhereAmITooltip
    tooltip = {},
}
addon.is_classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_MAINLINE
addon.wow_major = math.floor(tonumber(select(4, _G.GetBuildInfo()) / 10000))
ace_addon.wow_major = math.floor(tonumber(select(4, _G.GetBuildInfo()) / 10000))
---AceLocale instance
ace_addon.locale = _G.LibStub("AceLocale-3.0"):GetLocale("Broker_WhereAmI")
---@type string
---Addon display name from toc
ace_addon.title = addonTitle

if addon.wow_major <= 2 then
    addon.tourist = _G.LibStub("LibTouristClassicEra")
elseif addon.wow_major == 3 then
    addon.tourist = _G.LibStub("LibTourist-3.0")
elseif addon.wow_major < 11 then
    addon.tourist = _G.LibStub("LibTouristClassic-1.0")
elseif addon.wow_major >= 11 then
    addon.tourist = _G.LibStub("LibTourist-3.0")
else
    error('Unknown game version')
end

_G['BrokerWhereAmI'] = addon