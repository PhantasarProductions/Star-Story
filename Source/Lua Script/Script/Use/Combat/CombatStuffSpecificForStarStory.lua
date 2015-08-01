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
local f = upper(myfoe.File)
Dbg("Let's kill foe #"..idx.."> "..sval(myfoe.Tag))
inc("%COMBATSTAT.KILLS")
NumAchAward("KILL",CVV("%COMBATSTAT.KILLS"))
Bestiary[f] = (Bestiary[f] or 0) + 1
local maxfactor = 250
local enemylevel = RPGStat.Stat(myfoe.Tag,"Level")
local herotag,herolevel,gainexp
-- Hero experience
for i=0,5 do
    herotag = RPGStat.PartyTag(i)
    if herotag and herotag~="" then
       herolevel = RPGStat.Stat(herotag,"Level")
       gainexp = math.floor((enemylevel/herolevel)*maxfactor)
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

function RunVictory()
ywscale = ywscale or 0
ywtimer = ywtimer or 150
local cosdeg = (360-ywscale)
local cosres = math.cos(cosdeg/9); if cosdeg<=0 then cosres=1 end
local genscale = math.ceil((ywscale/360)*100)
Image.ScalePC(genscale,genscale*cosres)
Image.LoadNew("YOUWIN","GFX/Combat/YouWin.png"); Image.HotCenter("YOUWIN")
Image.Show("YOUWIN",400,150)
Image.ScalePC(100,100)
if ywscale<360 then 
   ywscale = ywscale + 2
   else
   ywtimer = ywtimer - 1
   if ywtimer<=0 then 
      PullMusic()
      inc('%COMBATSTAT.VICTORIES')
      NumAchAward("VICTORY",CVV("%COMBATSTAT.VICTORIES"))
      LAURA.Flow(CombatData.RETURNFLOW or "FIELD") 
      end
   end
end
