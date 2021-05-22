--Instances does not have maps in classic
--This table is copied from LibTouristClassic-1.0.lua

local instances = {
    [30] = "Alteric Valley",
    [33] = "Shadowfang Keep",
    [34] = "The Stockade",
    [36] = "The Deadmines",
    [43] = "Wailing Caverns",
    [47] = "Razorfen Kraul",
    [48] = "Blackfathom Deeps",
    [70] = "Uldaman",
    [90] = "Gnomeregan",
    [109] = "The Temple of Atal'Hakkar",
    [129] = "Razorfen Downs",
    [209] = "Zul'Farrak",
    [229] = "Blackrock Spire",
    [230] = "Blackrock Depths",
    [249] = "Onyxia's Lair",
    [329] = "Stratholme",
    [349] = "Maraudon",
    [369] = "Deeprun Tram",
    [389] = "Ragefire Chasm",
    [409] = "Molten Core",
    [429] = "Dire Maul",
    [469] = "Blackwing Lair",
    [489] = "Warsong Gulch",
    [509] = "Ruins of Ahn'Qiraj",
    [529] = "Arathi Basin",
    [531] = "Ahn'Qiraj Temple",
    [533] = "Naxxramas",
    [189] = "Scarlet Monastery", -- 1004 ?
    [289] = "Scholomance", -- 1007 ?
    [309] = "Zul'Gurub"
}

for key, value in pairs(instances) do
    _G['MapInfo'][key] = { Name_lang = value }
end