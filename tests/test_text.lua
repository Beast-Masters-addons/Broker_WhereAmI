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

loadfile('../libs/CallbackHandler/CallbackHandler-1.0.lua')()
loadfile('../libs/HereBeDragons-2.0/HereBeDragons-2.0.lua')()
if os.getenv('GAME_VERSION') == 'retail' then
    loadfile('../libs/LibTourist-3.0/LibTourist-3.0.lua')()
else
    loadfile('../libs/LibTouristClassic/LibTouristClassic-1.0.lua')()
end
loadfile('build_utils/utils/load_toc.lua')('../Broker_WhereAmI.toc', { 'LibTouristClassic-1.0.lua', 'LibTourist-3.0.lua', 'fonts.lua', 'AceGUI-3.0' })

_G['test'] = {}
local test = _G['test']
local addon = _G.BrokerWhereAmI

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