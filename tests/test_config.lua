local lu = require('luaunit')
--loadfile('wow_functions.lua')()
loadfile('wow_frame.lua')()
loadfile('wow_functions.lua')()

-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match
loadfile('../Libs/LibStub/LibStub.lua')()
_G.LibStub:NewLibrary('LibTourist-3.0', 1)

loadfile('build_utils/utils/load_toc.lua')('../Broker_WhereAmI.toc', { 'LibTouristClassic-1.0.lua', 'LibTourist-3.0.lua', 'HereBeDragons-2.0.lua', 'fonts.lua' })

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