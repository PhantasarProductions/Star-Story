--[[
/**********************************************
  
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.

  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************/
 



Version: 15.08.01

]]
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

function GiveItem(ch,item,vault)
-- Let's find a spot first to place the item in
   local spot = nil
   local ak
   local putinvault
   -- First we're gonna look for a socket having the same item, but with enough space to carry another
   for ak=1,InventorySockets do
       if item==RPGChar.Data(pchar,"INVITEM"..ak) and RPGChar.Stat(pchar,"INVAMNT"..ak)<InventoryMaxStack then spot = spot or ak end
       end
   -- Now we'll do the same for an empty socket if no filled socket matched our requiments before    
   for ak=1,InventorySockets do
       if RPGChar.Stat(pchar,"INVAMNT"..ak)==0 then spot = spot or ak end
       end
-- If we got no socket reaching the required conditions, we must either reject the item or throw it into the vault (if the latter is allowed for this item)
if not spot then
   if not vault then return end -- If the item cannot be thrown into the vault, let's just ignore the item and we won't even talk about it any more
   putinvault = PutInVault(item)
   if not putinvault then return end -- and if the item also could not be placed in the vault, let's ignore it anway and also not even talk about it any more.    
   RPGChar.IncStat(pchar,"INVAMNT"..ak)     
   end       
-- Right oh, if the script is still being processed it means the item was accepted one way or another. Let's report that to the player.
   
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
local gip = rand(1,3) -- Who will get the item
local gpc = {25,12,4}
local gii
if Fighter.Hero[gip] and Fighter.Hero[gip].Tag~="" and Fighter.Hero[gip].Tag~="Briggs" and RPGStat.Points(Fighter.Hero[gip].Tag,"HP").Have>0 and rand(1,100)>gpc[skill] and #myfoe.ItemDrop>0 then
   gii = rand(1,#myfoe)
   GiveItem(Fighter.Hero[gip].Tag,myfoe.ItemDrop.ITM,myfoe.ItemDrop.VLT)
   end
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
