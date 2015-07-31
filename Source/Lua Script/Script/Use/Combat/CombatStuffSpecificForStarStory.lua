function UpPoint(i,amount)
if not Fighters.Hero[i] then return end
local f = FighterTag("Hero",i)
RPGStat.Points(f,"AP").Inc(amount or 1)
local ak
for ak=3,5 do
    f = RPGStat.PartyTag(ak)
    if f~="" then RPGStat.Points(f,"AP").Inc(amount or 1) end
    end
end


function GameSpecificPerformAction(ft,i,fv)
if ft=="Hero" and rand(0,skill)==1 then UpPoint(i) end
local ak
for ak=1,3 do UpPoint(ak) end    
end


function KillFoe(idx,myfoe)
local maxfactor = 250
local enemylevel = RPGStat.Stat(myfoe.Tag,"Level")
local herotag,herolevel,gainexp
-- Hero experience
for i=0,5 do
    herotag = RPGStat.PartyTag(i)
    if herotag~="" then
       herolevel = RPGStat.Stat(herotag,"Level")
       gainexp = math.floor((herolevel/enemylevel)*maxfactor)
       RPGStat.Points(herotag,"EXP").Inc(gainexp)
       end
    end
-- Get an Aurina?
herolevel = AVGLevel("Hero")
if rand(0,enemylevel)>rand(0,herolevel*skill) then
   inc("%AURINAS")
   MINI("You found an Aurina")
   if not Done("&TUT.AURINA") then Tutorial("If you are lucky an enemy will drop an Aurina.\nThey are very important.\nSome businessmen throughout the universe will pay you money for them.") end
   end
-- Item Drop
--[[ This comes later ]]--   
-- Remove the enemy from memory           
Fighters.Foe[idx] = nil
RPGStat.DelChar(myfoe.Tag)
end