--[[
**********************************************
  
  Excalibur - Final.lua
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
 
version: 16.07.07
]]

-- @USE /Script/Use/Maps/Gen/Schuif.lua

Names = {
            ['#000'] = 'Secret Hangar',
            ['#001'] = 'Hidden layer',
            ['#003'] = 'Lady of the Lake - Artificial Park'
        }
        
function initkeycards() keycards = {} end     

function HangarEntrance()
   local left  = Maps.Obj.Obj("EntranceLeft")
   local right = Maps.Obj.Obj("EntranceRight")
   left.X = left.X-39
   right.X = right.X+39
   local PLAYER = Actors.Actor("PLAYER")
   local Barrier = Maps.Obj.Obj("BlockStart")
   Barrier.Impassible = 0
   Maps.Remap()
   Actors.MoveToSpot("PLAYER","BeginDungeon")
   repeat
     DrawScreen()
     CSay("Player on Y: "..PLAYER.Y)
     Flip()
   until PLAYER.Y>=365
   for i=39,0,-1 do
       left.X=left.X+1
       right.X=right.X-1
       DrawScreen()
       Flip()
   end  
   if not(Done('&DONE.EXCALIBUR.WENDICKAWELCOMEBACK')) then MapText("WENDICKA_WELCOMEBACK") end
   Barrier.Impassible = 1
   Maps.Remap()
end   

function GALE_OnLoad()
   if not (Done("&DONE.INIT.EXCALIBUR.KEYS")) then initkeycards() end
   MS.LoadNew("PARTY","Script/Subroutines/Party.lua")
   if (CVV("&JOINED.JOHNSON")) then
      Party("Wendicka","Crystal","Yirl","Foxy","Xenobi","Johnson")
      SyncLevel('Johnson')
      MapText("JOHNSON_BACK")
   else
      Party("Wendicka","Crystal","Yirl","Foxy","Xenobi")
   end
   Music("Excalibur/Final.ogg")
   ZA_Enter("EntranceWalkSouth",HangarEntrance)
end
