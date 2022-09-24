local lu = require('luaunit')
loadfile('build_utils/wow_api/constants.lua')()
loadfile('build_utils/wow_api/frame.lua')()
loadfile('build_utils/wow_api/functions.lua')()
loadfile('build_utils/wow_api/text.lua')()
loadfile('build_utils/wow_api/texture.lua')()

-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match
loadfile('../libs/LibStub/LibStub.lua')()
if os.getenv('GAME_VERSION') == 'retail' then
    _G.LibStub:NewLibrary('LibTourist-3.0', 1)
end
if os.getenv('GAME_VERSION') == 'wrath' then
    _G.LibStub:NewLibrary('LibTouristClassic-1.0', 1)
end
if os.getenv('GAME_VERSION') == 'classic' then
    _G.LibStub:NewLibrary('LibTouristClassicEra', 1)
end

loadfile('build_utils/utils/load_toc.lua')('../resolved.toc', { 'LibTouristClassicEra.lua', 'LibTouristClassic-1.0.lua', 'LibTourist-3.0.lua', 'HereBeDragons-2.0.lua', 'fonts.lua' })

_G['test'] = {}
local test = _G['test']
local addon = _G.BrokerWhereAmI

function test:test_reset()
    _G['WhereAmIOptions'] = {}
    lu.assertEquals({}, _G['WhereAmIOptions'])
    addon.config.reset()
    lu.assertEquals(true, _G['WhereAmIOptions'].show_main_zone)
end

function test:test_init()
    addon.config:init()
    lu.assertNotNil(addon.config.optionsFrames.general)
end

os.exit(lu.LuaUnit.run())