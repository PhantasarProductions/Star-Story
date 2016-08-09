--[[
**********************************************
  
  Phantasar - Ghost House.lua
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
 
version: 16.08.09
]]

-- @USE Phantasar.lua
-- @USE /Script/Use/Maps/Gen/Next.lua

local maxback = 25

function Back()
  local player = Actors.Actor('PLAYER')
  local start = Maps.Obj.Obj('Start')
  local vsolved = CVV('&DONE.PHANTASAR.GHOSTHOUSE.ROOM['..Maps.LayerCodeName..']')
  if vsolved then return end
  player.X = start.X
  player.Y = start.Y
  player.Walking=0
  player.Moving=0
  MapText("BACK."..GetActive())
end

function OpenDoor()
  local tag = '&DONE.PHANTASAR.GHOSTHOUSE.ROOM['..Maps.LayerCodeName..']'
  -- local vsolved = CVV(tag)
  if not Done(tag) then
     SFX("Audio/SFX/MBOX1.ogg")
     MapEXP()
     Maps.Obj.Kill('BlockNext',1)
     Maps.Obj.Kill('Plate2Open',1)
  end
end     

function StopRandomEncounters()
   Var.D('&BLOCK.EMERGENCY.SAVE','TRUE')  -- No more emergency saves. This can only spook things up from here!
   monsters = nil -- No more random encounters ;)
end

function DrawTeleporter()
  local tp = Maps.CObj
  local sx = Maps.CamX
  local sy = Maps.CamY
  tcl = tcl or {255,255,255}
  local cl = tcl
  local cli = rand(1,3)
  local x = tp.X - sx
  local y = tp.Y - sy
  local s  
  --CSay("DrawTeleporter") -- Debug line. May ABSOLUTELY not be present in release!
  for yi = 0,tp.H-1 do
      s = abs(sin((Time.MSecs()/5)+(yi*3)))
      -- --[[
      Image.Color(
                    cl[1]*s,
                    cl[2]*s,
                    cl[3]*s
                 )
      -- ]]           
      Image.Line(x,y+yi,x+tp.W,y+yi)           
      for ci=1,3 do
          if     cli==ci and cl[ci]<255 then cl[ci] = cl[ci] + 1
          elseif cli==ci                then ci = rand(1,3)
          elseif cl[ci]>0               then cl[ci] = cl[ci] - 1 end          
      end    
  end
  --White()
  --Image.DText("sx="..sx.."; sy="..sy.."; x="..x.."; y="..y.."; s="..s,0,30)
end

function Boss()
	oripos = nil
	CleanCombat()
	Var.D("$COMBAT.BACKGROUND","Phan - Dung.png")
	Var.D("$COMBAT.BEGIN","Default")
	Var.D("$COMBAT.FOE1","Boss/LichKing")
	Var.D("$COMBAT.ALTCOORDSFOE1","300,600")
	Var.D("%COMBAT.LVFOE1",MapLevel())
	Var.D("$COMBAT.MUSIC","AltCombat/Phantasar_Boss.ogg")
	StartCombat()	
end

function BackDown()
  Maps.GotoLayer("#001")
  SpawnPlayer('GetBack')
  local deur = Maps.Obj.Obj('DEUR')
  deur.Impassible = 1
  deur.TextureFile = 'GFX/TEXTURES/PHANTASAR/DUNGEON/ARCH2DOOR.PNG'
  Maps.Remap()
end

function MarrilonaAndMyrah()
   if not Done("&DONE.PHANTASAR.GHOSTHOUSE.COMPLETE") then
      PartyPop("MAR")
      MapText("MARRILONA")
      AddPartyPop("NPC_Marrilona")
      AddPartyPop("NPC_Myrah")
      PartyUnPop()
      Award("SCENARIO_PHANTASAR_GHOSTHOUSE")
      Maps.Obj.Kill("NPC_Marrilona",1)
      Maps.Obj.Kill("NPC_Myrah",1)
   end
end


function GALE_OnLoad()
  Music('Dungeon/Tempting Secrets')
  ZA_Enter('Back',Back)
  for i=1,maxback do 
     ZA_Enter(  'Back'..i,Back)
     ZA_Enter("RMBack"..i,Maps.Obj.Kill,'Back'..i) 
     end
  ZA_Enter('BackDown',BackDown)
  ZA_Enter('Plate2Open',OpenDoor)
  ZA_Enter('StopRandomEncounters',StopRandomEncounters)
  ZA_Enter('THE_END',MarrilonaAndMyrah)
  ZA_Enter("Byebye",GoWorld,"Phantasar")
  NPC_SAVE_GREEN = savespot.green
  NPC_SAVE_RED   = savespot.red
  EncounterBack = "Phan - Dung"
  EncounterMusic = "Dungeon/Tempting Secrets"
	AddEnemy("Goblin",20)  
	AddEnemy("PhanUndeadKid_Befindo",30)
	AddEnemy("PhanUndeadKid_Human",30)
	AddEnemy("PhanUndeadKid_Fairy",30)
	AddEnemy("PhanUndeadKid_Phelynx",20)
	AddEnemy("PhanUndeadKid_Elf",30)
	AddEnemy("Imp",26)
	for i=1,#encrange do
	    encrange[i] = math.ceil(encrange[i]/2)
	end 
end

