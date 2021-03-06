--[[
**********************************************
  
  CombatStuffSpecificForStarStory.lua
  (c) Jeroen Broks, 2015, 2016, All Rights Reserved.
  
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
  
  
 **********************************************
 
version: 16.10.31
]]
-- @IF IGNORE
VicCheck = {}
FlowCheck = {}
-- @FI

-- @UNDEF BUFFDEBUG


function BuffChecks()
 MaxBuffPos = MaxBuffPos or { Hero = ({5000,500, 250})[skill],
                              Foe  = ({ 500,500,5000})[skill]}
 MaxBuffNeg = MaxBuffNeg or { Foe  = ({5000,500, 250})[skill],
                              Hero = ({ 250,500,5000})[skill]}
 MaxBuff = {MaxBuffPos,MaxBuffNeg}
 TimeBuff = TimeBuff or {}
 local inputting = false
 for ft,ftl in spairs(Fighters) do
    for fli,fv in pairs(ftl) do
        inputting = inputting or fv.Gauge==10000
    end
 end
 -- @IF BUFFDEBUG
 local dbg_y = 0
 Image.NoFont()
 -- @FI
 for group,groupdata in pairs(Fighters) do for i,v in ipairs(MaxBuff) do
     if not (v[group]) then CSay("Warning! No data for MaxBuff "..group.."/"..i) end
     TimeBuff[i] = TimeBuff[i] or {}
     TimeBuff[i][group] = (TimeBuff[i][group] or (v[group]+1))
     -- @IF BUFFDEBUG
     Image.DText(group.."/"..i.."> time: "..TimeBuff[i][group].." inp:"..sval(inputting),0,dbg_y)
     dbg_y = dbg_y + 15
     -- @FI
     if not inputting then TimeBuff[i][group] = TimeBuff[i][group] - 1 end
     if TimeBuff[i][group]<=0 then
     	  AlterBuffs = AlterBuffs or {
     	      function(group,ch,stat)
     	        local v = RPGStat.Stat(ch,"BUFF_"..stat)
     	        if v>0 then 
     	           RPGStat.DefStat(ch,"BUFF_"..stat,v-1)
     	           -- @IF BUFFDEBUG
     	           CSay('Char: '..ch.." Stat: "..stat.." buff down 1 point >>> "..RPGStat.Stat(ch,"BUFF_"..stat))
     	           -- @FI 
     	        end
     	      end,
     	      function(group,ch,stat)
     	        local v = RPGStat.Stat(ch,"BUFF_"..stat)
     	        if v<0 then RPGStat.DefStat(ch,"BUFF_"..stat,v+1) end
     	      end
     	   }
     	  for stat in each({"Strength", "Defense", "Will", "Resistance","Agility","Accuracy","Evasion","AP","HP"}) do
     	       for ch,data in pairs(groupdata) do
     	          -- @IF BUFFDEBUG
     	          CSay('Script> AlterBuffs['..i..']("'..group..'", "'..FighterTag(group,ch)..'", "'..stat..'");')
     	          -- @FI
     	          AlterBuffs[i](group,FighterTag(group,ch),stat)
     	      end     
     	  end 
     TimeBuff[i][group] = v[group] -- reset time	  
     end
 end end                  
end FlowCheck[#FlowCheck+1] = BuffChecks

function UpPoint(i,amount)
if not Fighters.Hero[i] then return end
local f = FighterTag("Hero",i)
if RPGStat.Points(f,"HP").Have==0 then return end -- Don't deal with the deadif RPGStat.Points(f)
RPGStat.Points(f,"AP").Inc(amount or 1)
local ak
for ak=3,5 do
    f = RPGStat.PartyTag(ak)
    if f~="" then RPGStat.Points(f,"AP").Inc(amount or 1) end
    if f=="Crystal" then RPGStat.Points(f,"HP").Inc((amount or 1)*(6/skill)*((ngpcount*10)/(skill+1))) end
    end
end


function GameSpecificPerformAction(ft,i,fv)
if ft=="Hero" and rand(0,skill)==1 then UpPoint(i) end
local ak
local plus = 0
local maxp = 9 / skill
local lv = ({75,50,25})[skill]
local ch
for ak=1,3 do
    plus = 1
    if ft=="Hero" and rand(0,(skill*skill)+2)==1 then plus = plus + 1 end
    ch = FighterTag("Hero",ak)
    if ch and ch~="" then
        plus = plus + math.floor(RPGChar.Stat(ch,"Level")/lv) 
        if plus>maxp then plus=maxp end        
        UpPoint(ak,plus)
        end 
    end    
end

function GameSpecificAfterPerformAction(ft,i,fv)
	local ch
	if ft=="Hero" then
		ch = RPGChar.PartyTag(i-1);
		(XCharAfterAction[ch] or function() CSay(ch.." doesn't have an 'afteraction' function") end)()
	end
end


function GiveItem(ch,item,vault)
-- DrawScreen()
-- DarkText("Configuring Data",400,300,2,2,255,255,255)
-- Flip()
-- Let's find a spot first to place the item in
   local spot = nil
   local ak
   local putinvault
   if left ( item,4 )~="ITM_" then return CSay("WARNING! "..item.." may not be an item, or at least not one I can process!") end
   -- First we're gonna look for a socket having the same item, but with enough space to carry another
   for ak=1,InventorySockets do
       -- CSay("Spot: "..ak.."; have: "..RPGChar.Stat(ch,"INVAMNT"..ak).." max: "..InventoryMaxStack) -- debug
       if (not spot) and item=="ITM_"..RPGChar.Data(ch,"INVITEM"..ak) and RPGChar.Stat(ch,"INVAMNT"..ak)<InventoryMaxStack then spot = spot or ak end
       --CSay("Spot: "..ak.."; have: "..RPGChar.Stat(ch,"INVAMNT"..ak).." max: "..InventoryMaxStack.." spot: "..sval(spot)) -- debug
       end
   -- Now we'll do the same for an empty socket if no filled socket matched our requiments before    
   for ak=1,InventorySockets do
       if (not spot) and RPGChar.Stat(ch,"INVAMNT"..ak)==0 then spot = spot or ak end
       end
-- If we got no socket reaching the required conditions, we must either reject the item or throw it into the vault (if the latter is allowed for this item)
if not spot then
   if not vault then return end -- If the item cannot be thrown into the vault, let's just ignore the item and we won't even talk about it any more
   -- putinvault = item.PutInVault --PutInVault(item)
   if not putinvault then return end -- and if the item also could not be placed in the vault, let's ignore it anyway and also not even talk about it any more.
   inc("%VAULT."..item)    
else
   RPGChar.SetData(ch,"INVITEM"..spot,right(item,len(item)-4))
   RPGChar.IncStat(ch,"INVAMNT"..spot)        
   end       
-- Right oh, if the script is still being processed it means the item was accepted one way or another. Let's report that to the player.
CSay(ch.." receives "..item)
MINI(RPGChar.GetName(ch).." received: "..ItemName(item),0,180,255)
if not spot then 
   MINI("however "..heshe[ch].." could not carry that any more since "..hisher[ch].." inventory is full",255,180,180)
   if putinvault then MINI("so the item has been put in the vault in stead") end
   end   
if not Done("&TUT.ITEMSINBATTLE") then Tutorial("Occasionally when an enemy dies\nit may drop an item which a random character will pick up\nHowever only if he or she has room in his or her inventory for that item\n\n\nIf an item is vital and the character who finds it cannot pick it up it will be dropped\nin the vault in stead. This will however ONLY\nhappen with VITAL items and not common items!") end
EquipEffect(ch)   
end


function KillFoe(idx,myfoe)
local maxlvmargin = {10000,10,5}
local f = upper(myfoe.File)
Dbg("Let's kill foe #"..idx.."> "..sval(myfoe.Tag))
inc("%COMBATSTAT.KILLS")
NumAchAward("KILL",CVV("%COMBATSTAT.KILLS"))
Bestiary[f] = (Bestiary[f] or 0) + 1
local maxfactor = 350
local enemylevel = RPGStat.Stat(myfoe.Tag,"Level")
local herotag,herolevel,gainexp
local allowexpbonus,bonus
-- Hero experience
for i=0,5 do
    herotag = RPGStat.PartyTag(i)
    if herotag and herotag~="" then
       herolevel = RPGStat.Stat(herotag,"Level")
       gainexp = math.floor((enemylevel/herolevel)*maxfactor)
       allowexpbonus = rand(1,10000)>(herolevel/2)*skill
       bonus = rand(1,math.ceil(ngpcount/(2*skill)))
       if bonus<1 then bonus = 1 end
       if bonus>100 then bonus=100 end
       if allowexpbonus then gainexp = gainexp * bonus end
	   if skill==3 and ngpcount>rand(5,10) then gainexp = gainexp - (Bestiary[f]-1) end -- In the hard mode you will gain less experience for enemies you've met before. From cycle 5 there is a possibility this no longer counts. In cycle 10 it's definite. Getting to level 10,000 must still be TECHNICALLY possible.
	   if gainexp<0 or ((herolevel-enemylevel)>maxlvmargin[skill] and ngpcount<=rand(5,skill*5)) then gainexp=0 end
       if RPGStat.Points(herotag,"HP").Have==0 then
          ({
           function() end,
           function() gainexp = gainexp / 2 end,
           function() gainexp = 0 end})[skill]()          
          end
       RPGStat.Points(herotag,"EXP").Inc(gainexp)
       end
    end
-- Get an Aurina?
herolevel = AVGLevel("Hero")
if rand(0,enemylevel)>rand(0,herolevel*skill) and (not myfoe.Shilders) then
   inc("%AURINAS")
   MINI("You found an Aurina")
   if not Done("&TUT.AURINA") then Tutorial("If you are lucky an enemy will drop an Aurina.\nThey are very important.\nSome businessmen throughout the universe will pay you money for them.") end
elseif myfoe.Shilders and rand(1,(skill*skill)+1) then
	 local getshilders = math.ceil(myfoe.Shilders / rand(1,skill*skill))
	 inc('%SHILDERS',getshilders)
	 MINI("You found "..getshilders.." shilders")   
   end
-- Item Drop
local gip = rand(1,3) -- Who will get the item
local gpc = {25,12,4}
local gii
if (not myfoe.StolenFrom) and Fighters.Hero[gip] and Fighters.Hero[gip].Tag~="" and Fighters.Hero[gip].Tag~="Briggs" and RPGStat.Points(Fighters.Hero[gip].Tag,"HP").Have>0 and rand(1,100)<gpc[skill] and #myfoe.ItemDrop>0 then
   gii = rand(1,#myfoe.ItemDrop)
   -- DBGSerialize(myfoe)
   GiveItem(Fighters.Hero[gip].Tag,myfoe.ItemDrop[gii].ITM,myfoe.ItemDrop[gii].VLT)
   end
-- Count enemies for characters who gain something by that (front row only, he he)
local ch
for ak=0,2 do
    ch = RPGChar.PartyTag(ak)
    if XCharKill[ch] then XCharKill[ch]() end   
    end
-- Remove the enemy from memory           
Fighters.Foe[idx] = nil
if RPGChar.CharExists(myfoe.Tag)==1 then RPGStat.DelChar(myfoe.Tag) else CSay("!! WARNING !! Tried to destroy non-existent foe: "..myfoe.Tag) end
-- Optimize time gauge
InitGaugeSpeed()
end

function VicCheck.YaqirpaBrain()
local f 
if not BrainTag then
   for f in each(Fighters.Foe) do
       BrainTag = f.Tag 
       BrainFoe = f
       CSay("BrainTag = "..BrainTag)
       end
   end
RPGChar.Points(BrainTag,"HP").Minimum = 1 -- Now we cannot accidentally kill the boss, as this would spook the script up a little.
if BrainFoe.x<300 then BrainFoe.x=BrainFoe.x+2 end
if BrainFoe.y<400 then BrainFoe.y=BrainFoe.y+2 end
if RPGChar.Points(BrainTag,"HP").Have==1 then
   GrantExperienceOnLevel(20)
   DrawScreen()
   GrantEventExperience(6)
   DrawScreen()
   -- DelEnemies()
   LAURA.Flow("FIELD")
   end   
end


function VicCheck.Flirmouse_King()
local subjects = ({2,4,8})[skill]
local r
if not InitFlirmouse_King then
   r = rand(2,subjects+1)
   CSay("The king with subject #"..r)
   RPGStat.LinkStat(Fighters.Foe[r].Tag,Fighters.Foe[1].Tag,"END_HP")
   RPGStat.LinkPoints(Fighters.Foe[r].Tag,Fighters.Foe[1].Tag,"HP") -- If the chosen subject dies, so will the king.
   RPGStat.DefStat(Fighters.Foe[1].Tag,"Non-Elemental",5)
   RPGStat.SetData(Fighters.Foe[1].Tag,"IMMUNE","YES")
   InitFlirmouse_King = true
   end
if not Fighters.Foe[1] then -- If the chosen subject and the king are gone, the other subjects will die too.
   for i=1,9 do
       if Fighters.Foe[i] and RPGStat.Points(Fighters.Foe[i].Tag,"HP").Have>0 then
          CharReport("Foe",i,"DEATH!",{255,0,0})
          RPGChar.Points(Fighters.Foe[i].Tag,"HP").Have=0
          end
       end        
   end       
return DefaultVictory()      
end


function BuffNerf()
for i = 0,5 do
    local ch = RPGStat.PartyTag(i)
    if ch and ch~="" then   
     for ss in each({'Strength','Defense','Will','Resistance','Accuracy','Evasion',"Agility"}) do
        local s = "BUFF_"..ss;   
        ({
           function()
             if RPGStat.Stat(ch,s)<0 then  RPGStat.DefStat(ch,s,0) end
           end ,
           function ()
             RPGStat.DefStat(ch,s,math.ceil(RPGStat.Stat(ch,s)/2))
           end,  
           function()
             if RPGStat.Stat(ch,s)>0 then  RPGStat.DefStat(ch,s,0) end
           end ,
        })[skill]()
     end -- for s   
    end -- if ch  
   end -- for i
end

function RunVictory()
ywscale = ywscale or 0
ywtimer = ywtimer or 150
local cosdeg = (360-ywscale)
local cosres = math.cos(cosdeg/9); if cosdeg<=0 then cosres=1 end
local genscale = math.ceil((ywscale/360)*100)
local i,ch   
Image.ScalePC(genscale,genscale*cosres)
Image.LoadNew("YOUWIN","GFX/Combat/YouWin.png"); Image.HotCenter("YOUWIN")
White()
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
      for i=0,5 do
          ch = RPGChar.PartyTag(i)
          if ch~="" and RPGChar.Points(ch,"HP").Have<=0 then RPGChar.Points(ch,"HP").Have=1 end
          end
      if FlawlessVictory then
         FlawlessStreak = FlawlessStreak + 1
         FlawlessVictories = FlawlessVictories + 1
         NumAchAward("PERFECTVICTORY",FlawlessVictories)
         NumAchAward("PERFECTSTREAK",FlawlessStreak)
         CSay("Flawless: "..FlawlessVictories)
         CSay("Streak:   "..FlawlessStreak)
      else
         FlawlessStreak = 0 
         end
      BuffNerf()   
      LAURA.Flow(CombatData.RETURNFLOW or "FIELD") 
      end
   end
end -- func

DefeatedFunctions = { 
      Default = function()
                MS.Load("GAMEOVER","Script/Flow/GameOver.Lua")
                LAURA.Flow("GAMEOVER")
                end
  }
   

function RunDefeated()
DefeatedFunctions[CombatData.Defeated or 'Default']()
end
