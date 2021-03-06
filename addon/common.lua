_G['WhereAmICommon'] = {}
local common = _G['WhereAmICommon']
common.version = '@project-version@'

common.utils = _G['BMUtils']
common.utils = _G.LibStub("BM-utils-1")

common.is_classic = common.utils:IsWoWClassic()
if not common.is_classic then
    common.tourist = _G.LibStub("LibTourist-3.0")
else
    common.tourist = _G.LibStub("LibTouristClassic-1.0")
end