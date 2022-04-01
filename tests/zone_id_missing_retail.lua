--Entries in this table is copied from LibTourist-3.0.lua

local instances = {
    [2046] = "Zereth Mortis",
    [2047] = "Sepulcher of the First Ones",
    [2048] = "Sepulcher of the First Ones",
    [2049] = "Sepulcher of the First Ones",
    [2050] = "Sepulcher of the First Ones",
    [2051] = "Sepulcher of the First Ones",
    [2052] = "Sepulcher of the First Ones",
    [2055] = "Sepulcher of the First Ones",
    [2061] = "Sepulcher of the First Ones",
}

for key, value in pairs(instances) do
    _G['MapInfo'][key] = { Name_lang = value }
end