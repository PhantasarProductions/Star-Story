--[[
**********************************************
  
  Johnson.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
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
 
version: 16.07.14
]]
-- Getting Skill
skill = Sys.Val(Var.C('%SKILL'))



;({function()
   InventorySockets = 100         -- Max sockets
   InventorySocketRow = 10        -- Max number of sockets per row
   InventoryMaxStack = 25         -- Max number of items that may be stacked on a socket
   InventoryMaxVaultStack = 500   -- Max number of items that may be stacked on a vault socket (where each (unique) item just has one socket)
   end, function()
   InventorySockets = 50
   InventorySocketRow = 10   
   InventoryMaxStack = 10
   InventoryMaxVaultStack = 250
   end, function()
   InventorySockets = 25
   InventorySocketRow = 5
   InventoryMaxStack = 1
   InventoryMaxVaultStack = 100
   end})[skill]()    

-- Functions
function prefixed(s,p) return Str.Prefixed(s,p)==1 end

-- Johnson taking over and linking to ExHuRU with his level and his upgrades and permanent powerups.

stats = {"Strength", "Defense", "Will", "Resistance","Agility","Accuracy","Evasion","HP"}

linking = {"Level"}

for _,s in ipairs(stats) do linking[#linking+1] = "UPGRADE_"..s  linking[#linking+1]="POWERUP_"..s end

for _,s in ipairs({'ER_Dark','ER_Earth','ER_Fire','ER_Frost','ER_Healing','ER_Light','ER_Lightning',"ER_Water","ER_Wind"}) do 
   linking[#linking+1] = s 
   ermod = Str.Replace(s,"ER_","ER_MODIFIER_")
   RPGStat.NewStat('ExHuRU',ermod,0) 
   linking[#linking+1] = ermod 
   end

for _,s in ipairs({'Block','Buff','Damned','Death','Debuff','Disease','Paralysis','Poison','Will'}) do linking[#linking+1] = "SR_BUFF_"..s linking[#linking+1] = "SR_EQBF_"..s end

for _,s in ipairs(linking) do RPGStat.LinkStat("ExHuRU","Johnson",s) end


-- Inventory link up
for i=1,InventorySockets do 
    RPGStat.LinkStat('ExHuRU','Johnson','INVAMNT'..i)
    RPGStat.LinkData('ExHuRU','Johnson','INVITEM'..i)
    end


-- Johnson most also take over and link to ExHuRU's Experience points

RPGStat.LinkPoints("ExHuRU","Johnson","EXP")

-- And the ability and learn list must be copied
RPGStat.LinkList("ExHuRU","Johnson","ABL")
RPGStat.LinkList("ExHuRU","Johnson","ABL_POWERUP")
RPGStat.LinkList("ExHuRU","Johnson","LEARN")




-- And the status resistances of Johnson

RPGStat.DefStat("Johnson","SR_BASE_Poison",99/skill)
RPGStat.DefStat("Johnson","SR_BASE_Paralysis",72/skill)
RPGStat.DefStat("Johnson","SR_BASE_Disease",78/skill)
RPGStat.DefStat("Johnson","SR_BASE_Will",60/skill)
RPGStat.DefStat("Johnson","SR_BASE_Block",27/skill)
RPGStat.DefStat("Johnson","SR_BASE_Death",100/skill)
RPGStat.DefStat("Johnson","SR_BASE_Damned",100)

RPGStat.SetData("Johnson","ShootSpellAni","Johnson_Phasar") -- Johnson_PhotonBlade
RPGChar.DefStat("Johnson","AMMO_BASE",12)

RPGChar.DefStat("Johnson","PXM",45)
