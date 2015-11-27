--[[
**********************************************
  
  Physillium - Ji Rubble.lua
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
 
version: 15.11.27
]]


function GALE_OnLoad()
Music("Scenario/Panic Stations.ogg")
end

function PostBoss()
local p = {"Wendicka","Crystal","ExHuRU","Yirl","Foxy"}   
CSay("Congratulations on beating that boss!")
MapText("E_POSTBOSS")
Actors.MoveToSpot("POP_Crystal","PostBossCrystal")
for ch in each(p) do Actors.ChoosePic("POP_"..ch,upper(ch)..".NORTH") end
Actors.ChoosePic("POP_Crystal","CRYSTAL.EAST")
local cury = Maps.CamY
for y = cury,0,-1 do
    Maps.CamY = y
    DrawScreen()
    Flip()
    end
Actors.ChoosePic("POP_Crystal","CRYSTAL.NORTH")
MapText("F_XENOBI")
Maps.Obj.Obj('Ji-Zwaard').TextureFile = "GFX/Actors/SinglePic/Ji/Ji East - Black long hair.png"
MapText("G_XENOBI")
Actors.MoveToSpot("POP_Crystal","XenobiCrystal")    
MapText("H_XENOBI_CRYSTAL")
KickReggie("West","POP_Foxy","Reggie")
MapText("I_YIRL")
Sys.Error("Unfortunately the current script ends here.")
end
