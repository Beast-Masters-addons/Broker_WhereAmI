-- Aliases required for LibStub
_G.debugstack = debug.traceback
_G.strmatch = string.match

function GetAddOnInfo()
    return 'Broker_Where Am I?', 'Broker: Where Am I?'
end

loadfile('../libs/LibStub/LibStub.lua')()
