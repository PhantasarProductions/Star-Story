function Hurt(tg,ti,hp,element)
end


function Attack(ag,ai,act,pdata)
local chactor = FighterTag(ag,ai)
local chtarget = FighterTag(act.TargetGroup,act.TargetIndividual)
local data = pdata or {}
local tg,ti = TargetFromAct(act)
local atkstat = data.atk or "Strength"
local defstat = data.def or "Defense"
local modifier = data.mod or 1
local critical = ({[true]=1,[false]=0})[data.critical==true] -- I have to do it this way, as 'nil' can be a value and would result into a crash.
local element = data.element or "Non-Elemental"
local elementalresistance = ({
                                 [1] = function() return RPGStat.Stat(chtarget,"ER_"..element) end,
                                 [0] = function() return 0 end
                              })[RPGStat.StatExists(chtarget,"ER_"..element)]()
end