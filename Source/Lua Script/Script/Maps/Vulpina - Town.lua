--[[
**********************************************
  
  Vulpina - Town.lua
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
 
version: 16.05.08
]]

function DoneHere()
return CVV("&DONE.VULPINA.ALLTHESHITINTOWNISDONEBYNOW")
end

function CrystalXenobi()
if DoneHere() then return end
Actors.StopWalking("PLAYER")
local text = { [false] = "LUISTERAF_", [true]="BETTERNOT_"}
MapText(text[Done("&DONE.VULPINA.AFGELUISTERD.CRYSTALXENOBI")==true].."CRYSTALXENOBI")
Actors.WalkToSpot("PLAYER","DoNotDisturb")
end

function GoBack()
MapText("PLEASEDONTGO")
Actors.WalkToSpot("PLAYER","TownStart")
end

function NPC_ActivateMidBoss()
MapText("UNLOCK_MIDBOSS")
if not Done("&UNLOCKED.MIDBOSS") then
   ActivateRemotePad('Start','Poloqor - Mid-Boss','Poloqor','Strange Mansion',"#001")
   end
end

function NPC_Foxy()
MapText("FOXY")
Done("&DONE.VULPINA.FOXY")
end


function CLICK_ARRIVAL_StonesForSale()
MapText("STONES4SALE")
GoToStore("STONESELLER")
end

function CLICK_ARRIVAL_Amstella() MapText("AMSTELLA") end

function CLICK_ARRIVAL_Vulpivix()
MapText("VULPIVIX")
if not(Done("&DONE.PHANTASAR.WORLDLOCKS.VULPIVIX")) then
   ActivateRemotePad('Start','Phantasar - Frendor Bushes - Arrival','Phantasar','Frendor Bushes')
   end
end


function NPC_Yirl()
local removal = {"NPC_Yirl","NPC_Foxy","GoBack","Crystal","Xenobi"}
if not(CVV("&DONE.VULPINA.FOXY") and CVV("&DONE.VULPINA.AFGELUISTERD.CRYSTALXENOBI")) then
   MapText("YIRL_NO")
   return
   end
MapText("YIRL_YES")
Var.D('$HAWK.BRIDGE','ToVolcania')
for i in each(removal) do Maps.Obj.Kill(i,1) end
Party("Wendicka","Crystal","Yirl","Foxy","Xenobi")
end   

function GALE_OnLoad()
Music('Town/Vulpina.ogg')
ZA_Enter('Crystal&Xenobi',CrystalXenobi)
ZA_Enter("GoBack",GoBack)
AddClickable("StonesForSale")
AddClickable("Amstella")
if not CVV("&DONE.PHANTASAR.WORLDLOCKS.JIMMY") then Maps.Obj.Kill("Vulpivix") end
end
