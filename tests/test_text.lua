local lu = require('luaunit')

-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match

loadfile('common.lua')()
loadfile('build_utils/wow_api/text.lua')()
loadfile('build_utils/wow_api/texture.lua')()

loadfile('build_utils/wow_api/constants.lua')()
loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/wow_api/mixin.lua')()
loadfile('build_utils/wow_api/Color.lua')()
loadfile('build_utils/wow_api/pvp.lua')()

loadfile('wow-ui-source/Interface/AddOns/Blizzard_SharedXML/Vector2D.lua')()
loadfile('wow-ui-source/Interface/AddOns/Blizzard_SharedXML/Vector3D.lua')()

loadfile('build_utils/wow_api/profession_api_classic.lua')()
loadfile('build_utils/wow_api/profession_api_retail.lua')()

loadfile('build_utils/wow_api/skills.lua')()
loadfile('build_utils/wow_api/map.lua')()
loadfile('build_utils/wow_api/zone.lua')()

local game = os.getenv('GAME_VERSION')
loadfile(('data/%s/AreaInfo.lua'):format(game))()
loadfile(('data/%s/MapInfo.lua'):format(game))()

if os.getenv('GAME_VERSION') == 'retail' then
    loadfile('zone_id_missing_retail.lua')()
else
    if os.getenv('GAME_VERSION') == 'classic' then
        loadfile('zone_id_vanilla.lua')()
    elseif os.getenv('GAME_VERSION') == 'cata' then
        loadfile('zone_id_tbc.lua')()
    end
    loadfile('instance_id.lua')()
end

loadfile('build_utils/utils/load_toc.lua')('../resolved.toc', { 'fonts.lua', 'AceGUI-3.0' })

_G['test'] = {}
local test = _G['test']
local addon = _G.BrokerWhereAmI
---@type BMUtilsText
local text_utils = _G.LibStub('BMUtilsText')
local ace_addon = _G.LibStub("AceAddon-3.0"):GetAddon("Broker_WhereAmI")
---@type WhereAmIText
local text = ace_addon:GetModule("WhereAmIText")
---@type WhereAmIConfig
local config = ace_addon:GetModule("WhereAmIConfig")

function _G.GetZoneText()
    if addon.wow_major < 4 then
        return 'Stranglethorn Vale'
    else
        return 'The Cape of Stranglethorn'
    end
end

function test:setUp()
    text:UpdateZoneInfo()
end

function test:test_GetFishingSkillText()
    if addon.is_classic then
        ---@type LibProfessionsCommon
        local professions = _G.LibStub('LibProfessions-0')
        local fishSkill = professions:GetAllSkills()["Fishing"]
        lu.assertEquals(fishSkill[4], 8)
        local minFish = addon.tourist:GetFishingLevel(addon.zoneInfo:current().mapId)

        lu.assertEquals(minFish, 130)
        lu.assertEquals(text:GetFishingSkillText(), "|cffff0000130-225|r")
    else
        lu.assertEquals(text:GetFishingSkillText(), 'Classic Fishing')
    end
end

function test:test_GetAreaStatus()
    lu.assertTrue(addon.tourist:IsContested(text.zone.mapId))
    lu.assertEquals(text:GetAreaStatus(), text_utils.colorize('Contested', 255, 178.5, 25.5))
end

function test:test_GetZoneName()
    if addon.wow_major < 4 then
        lu.assertEquals(text:GetZoneName(true, true), 'Stranglethorn Vale')
    else
        lu.assertEquals(text:GetZoneName(true, true), 'The Cape of Stranglethorn')
    end
end

function test:test_GetLevelRangeText()
    if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
        lu.assertEquals(text:GetLevelRangeText(), text_utils.colorize('30-45', 0xff, 0xc3, 0x00))
    elseif addon.wow_major < 4 then
        lu.assertEquals(text:GetLevelRangeText(), text_utils.colorize('25-55', 0xff, 0xcc, 0x00))
    elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE then
        lu.assertEquals(text:GetLevelRangeText(), text_utils.colorize('30 (10-30)', 0x7f, 0x7f, 0x7f))
    end
end

function test:test_GetCoordinateText()
    lu.assertEquals(text:GetCoordinateText(0), '(55, 55)')
    lu.assertEquals(text:GetCoordinateText(1), '(54.8, 54.9)')
    lu.assertEquals(text:GetCoordinateText(2), '(54.77, 54.86)')
end

function test:test_GetChatText()
    if addon.wow_major < 4 then
        lu.assertEquals(text:GetChatText(), 'Stranglethorn Vale (55, 55)')
    else
        lu.assertEquals(text:GetChatText(), 'The Cape of Stranglethorn (55, 55)')
    end
end

function test:test_GetLDBText()
    config:OnInitialize()
    config:OnEnable()
    local ldb_text = text:GetLDBText()
    if _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC then
        lu.assertEquals(ldb_text, '|cffffff00Stranglethorn Vale (55, 55) |cffffc300[30-45]|r|r')
    elseif addon.wow_major < 4 then
        lu.assertEquals(ldb_text, '|cffffff00Stranglethorn Vale (55, 55) |cffffcc00[25-55]|r|r')
    elseif _G.WOW_PROJECT_ID == _G.WOW_PROJECT_MAINLINE then
        lu.assertEquals(ldb_text, '|cffffff00The Cape of Stranglethorn (55, 55) |cff7f7f7f[30 (10-30)]|r|r')
    end
end

os.exit(lu.LuaUnit.run())