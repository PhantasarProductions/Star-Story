--[[
**********************************************
  
  Excalibur - Post Game.lua
  (c) Jeroen Broks, 2016, 2017, All Rights Reserved.
  
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
 
version: 17.08.09
]]

function NPC_Doctor()
   SetActive('Wendicka')
   MapText('DOCTOR')
end   

function NPC_Johnson()
  PartyPop('J')
  MapText('JOHNSON')
  Actors.Spawn('NPC_Johnson','gfx/actors/Player','Beam_Johnson',0)
  Maps.Obj.Obj('NPC_Johnson').Visible=0
  Actors.ChoosePic("Beam_Johnson","TELEPORT")
  Actors.Actor("Beam_Johnson").NotInMotionThen0 = 0
  for f=0,99 do
    Image.Cls()
    Actors.Actor("Beam_Johnson").Frame = f 
    Maps.Draw()
    ShowParty()
    --DrawScreen()
    Flip()    
    end
  Actors.Actor("Beam_Johnson").Visible = 0
  MapText('JOHNON_GONE') -- This typo is there in the language file, and fixing it there is gonna be one hell of a job.
  Schedule('MAP','PostCredits')
  MS.Load('CREDITS','Script/Flow/EndCredits.lua')
  LAURA.Flow('CREDITS')
end

function PostCredits()
   -- Sys.Error('Post Credits not available yet')
   LoadMap("Hawk_PostGame")
   SpawnPlayer('Scotty')
end

function GALE_OnLoad()
   Music('Dungeon/Observatorium.ogg')
   ZA_Enter('Win',Award,"WINGAME")
   for ch in each({'Wendicka','Crystal','Foxy','Xenobi','Yirl'}) do 
       local h = RPGChar.Points(ch,'HP')
       h.Have = h.Maximum
   end    
end
