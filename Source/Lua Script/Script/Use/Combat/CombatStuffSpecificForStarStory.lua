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