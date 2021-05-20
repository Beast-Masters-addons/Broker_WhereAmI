loadfile('wow_text.lua')()
loadfile('wow_texture.lua')()

_G['SlashCmdList'] = {}

function hooksecurefunc(func)

end

function GetBuildInfo()
    if os.getenv('GAME_VERSION') == 'classic' then
        return "1.13.2", 32600, "Nov 20 2019", 11302
    elseif os.getenv('GAME_VERSION') == 'bcc' then
        return "2.5.1", 38364, "Apr 15 2021", 20501
    else
        return "9.0.1", "36492", "Oct 30 2020", 90001
    end
end

function InterfaceOptions_AddCategory()
    
end