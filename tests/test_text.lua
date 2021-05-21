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

loadfile('wow-ui-source/SharedXML/Vector2D.lua')()
loadfile('wow-ui-source/SharedXML/Vector3D.lua')()

loadfile('build_utils/data/AreaInfo.lua')()
loadfile('build_utils/data/MapInfo.lua')()

loadfile('build_utils/wow_api/profession_api.lua')()
loadfile('build_utils/wow_api/skills.lua')()
loadfile('build_utils/wow_api/map.lua')()
loadfile('build_utils/wow_api/zone.lua')()

_G['MapInfo'][947] = { MapName_lang = 'Azeroth' }
_G['MapInfo'][1414] = { MapName_lang = 'Kalimdor' }
_G['MapInfo'][1415] = { MapName_lang = 'Eastern Kingdoms' }

loadfile('build_utils/utils/load_toc.lua')('../Broker_WhereAmI.toc', { 'LibTourist-3.0.lua', 'fonts.lua', 'AceGUI-3.0' })

_G['test'] = {}
local test = _G['test']
local addon = _G.BrokerWhereAmI
local inspect = require 'inspect'

function test:test_GetFishingSkillText()
    addon.text:UpdateZoneInfo()
    local fishSkill = addon.text.professions:GetAllSkills()["Fishing"]
    lu.assertEquals(fishSkill[4], 8)
    local minFish = addon.tourist:GetFishingLevel(addon.zoneInfo:current().mapId)
    lu.assertEquals(minFish, 130)
    local expected_text = addon.utils:colorize(minFish, 255, 0, 0)
    lu.assertEquals(addon.text:GetFishingSkillText(), expected_text)
end

function test:test_GetAreaStatus()
    lu.assertTrue(addon.tourist:IsContested(addon.text.mapId))
    lu.assertEquals(addon.text:GetAreaStatus(), addon.utils:colorize('Contested', 255, 178.5, 25.5))
end

os.exit(lu.LuaUnit.run())