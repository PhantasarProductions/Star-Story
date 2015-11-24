--[[
**********************************************
  
  XenobiSpells.lua
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
  
  
 **********************************************
 
version: 15.11.24
]]

--[[ 

    This routine will tell the system when Xenobi got to learn a new spell.and
    Since Xenobi learns new spells simply by levelling up, and since Star Story
    uses a dynamic levelling up system that allows levelling as well inside as
    outside combat I had to place this routine separate from the battle routine
    and into the Party Routine that handles the level ups
    
]]

-- @IF IGNOREME
XCharLvUp = {}   -- Just fooling my outliner, as the game will ignore this line :)
XCharSyncLevel = {}
-- @FI    


XenobiSpells = {
               
               QUICKSTRIKE             = 10,
               HEAL                    = 20,
               RECOVER                 = 44,
               VITALIZE                = 50,
               FROST                   = 30,
               MINDTRICK               = 40,
               BLIZZARD                = 52,
               HURRICANE               = 54,
               ROCK                    = 36,
               QUAKE                   = 60,
               LIGHT                   = 38,
               SOLARIA                 = 70,
               FOCUSENERGY             = 80
               
               }
               
function XenobiLearn(list)
local low,l
local xlv = RPGStat.Stat("Xenobi",'Level')
local xenobilearn=""
CSay("Initiating spells for Xenobi")
for abl,lv in spairs(XenobiSpells) do
    if xlv>=lv and RPGStat.ListHas('Xenobi','ABL',"XENOBI_"..abl)==0 and RPGStat.ListHas('Xenobi','LEARN',"XENOBI_"..abl)==0 then
       l = list or 'LEARN'
       RPGStat.AddList('Xenobi',l,"XENOBI_"..abl)
       CSay(abl.." has been added to Xenobi's "..l)
    elseif (not low) or low>lv then
       low = lv
       xenobilearn = "Xenobi will learn something new at level "..lv
       end
    end
Var.D("$XENOBI.LEARN",xenobilearn)
if RPGStat.CountList("Xenobi","ABL")==14 then Award("ALLABL_XENOBI") end
end


XCharLvUp.Xenobi = XenobiLearn

function XCharSyncLevel.Xenobi() XenobiLearn("ABL") end
