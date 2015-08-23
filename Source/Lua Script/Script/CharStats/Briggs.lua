function Briggs_Agility()
local Wen = RPGChar.Stat('UniWendicka','END_Agility')
local Cry = RPGChar.Stat('UniCrystal', 'END_Agility')
local Bri = (Wen+Cry)*.75
RPGChar.DefStat('Briggs','BASE_Agility',Bri)
return Bri
end 