--[[
**********************************************
  
  Nizozemska - Space Port.lua
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
 
version: 16.02.24
]]


-- @USE /Script/Use/Maps/Gen/Schuif.lua

function SchuifSetup()
InitSchuif( 'InLinks'  ,-40,0)
InitSchuif( 'InRechts' , 40,0)
InitSchuif('UitLinks'  ,-40,0)
InitSchuif('UitRechts' , 40,0)
end

function IngangSluiten()
Maps.Obj.Obj("DoorBlock").Impassible=1
Maps.Remap()
SetSchuif({'InRechts','InLinks'},"Dicht")
end

function IngangOpenen()
Maps.Obj.Obj("DoorBlock").Impassible=0
Maps.Remap()
SetSchuif({'InRechts','InLinks'},"Open")
end


function UitgangOpenen()
Maps.Obj.Obj("DoorBlock").Impassible=0
Maps.Remap()
SetSchuif({'UitRechts','UitLinks'},"Open")
end

function dWait(cyc)
for i=1,cyc do DoSchuif() DrawScreen() Flip() end
end

function SueWalking(tox,toy)
local ctx = tox or Maps.CamX
local cty = toy or Maps.CamY
if Maps.CamX<ctx then Maps.CamX = Maps.CamX + 1 end
if Maps.CamX>ctx then Maps.CamX = Maps.CamX - 1 end
if Maps.CamY<cty then Maps.CamY = Maps.CamY + 1 end
if Maps.CamY>cty then Maps.CamY = Maps.CamY - 1 end
DrawScreen()
Flip()
end

function MeetSue()
-- Spawn Sue (happens outside of the cam view, so no prob here)
Actors.Spawn('Point_Sue','GFX/Actors/Sue','ActSue')
Actors.ChoosePic("ActSue","SUE.EAST")
PartyPop("Sue","South")
dWait(40)
local Wendicka = Actors.Actor("POP_Wendicka")
local Sue     = Actors.Actor("ActSue")
MapText('SUE_A')
repeat
Maps.CamY = Maps.CamY + 1
DrawScreen()
Flip()
until Maps.CamY>=215
Actors.ChoosePic("ActSue","SUE.NORTH")
MapText('SUE_B')
Actors.ChoosePic("ActSue","SUE.WEST")
Actors.MoveTo('ActSue',Wendicka.X,Sue.Y)
repeat SueWalking() until Sue.X<=Wendicka.X
Actors.ChoosePic("ActSue","SUE.NORTH")
MapText('SUE_C')
Actors.MoveTo('ActSue',Wendicka.X,Wendicka.Y+10)
repeat SueWalking(Maps.CamX,64) until Sue.Y<=Wendicka.Y+25
Actors.MoveTo('ActSue',Wendicka.X,Wendicka.Y+25)
MapText("SUE_D")
Actors.Spawn('Spawn Rolf','GFX/Actors/Player','ActRolf')
Actors.ChoosePic("ActRolf","ROLF.NORTH")
Actors.WalkToSpot("ActRolf","Rolf_WalkTo")
MapText("SUE_E")
Party("Wendicka","Crystal","Yirl","Foxy","Xenobi","Rolf")
Actors.ChoosePic("ActRolf","ROLF.SOUTH")
Actors.ChoosePic("ActSue","SUE.SOUTH")
for act in each({"POP_Wendicka","POP_Crystal","POP_Yirl","POP_Foxy","POP_Xenobi","ActRolf","ActSue"}) do
    Actors.WalkToSpot(act,"Start")
    end
for alpha = 0,100,.2 do
    DrawScreen()
    Image.SetAlphaPC(alpha)
    Black()
    Image.Rect(0,0,800,600)
    Image.SetAlphaPC(100)
    Flip()   
    end
Image.Cls()    
LoadMap("Nizozemska - Groenhart Bos",'Bos')
SpawnPlayer('Einde') -- Sounds illogical, but this is because of the alternate worldmap routine.    
PartyPop('E','North')
Actors.ChoosePic("POP_Rolf","ROLF.SOUTH")
for y=0,6400,32 do
    Maps.CamX=0
    Maps.CamY=y
    DrawScreen()
    Image.SetAlpha(1-(y/6400))
    Black()
    Image.Rect(0,0,800,600)
    Image.SetAlphaPC(100)
    Flip()
    end
for i=65,68 do
    MapText('WELCOME_'..string.char(i))
    KickReggie('West',"POP_Foxy","POP_Reggie")
    end
AddPartyPop("POP_Sue")
AddPartyPop("POP_Reggie")
Maps.PermaWrite("for _,act in ipairs({'POP_Reggie','POP_Sue'}) do Maps.Obj.Kill(act) end") -- Why the easy way, if there's the hard way :-P
PartyUnPop()           
-- Sys.Error("End of script. I'll continue later.")
end

function InZone()
IngangOpenen()
dWait(40)
Actors.MoveToSpot("PLAYER","WelcomeToNizozemska",1)
dWait(40)
IngangSluiten()
if not Done("&DONE.NIZOZEMSKA.SUE") then MeetSue() end
end


function GALE_OnLoad()
Music("Nizozemska/SpacePort.ogg")
MS.Run("FIELD","SetScrollBoundaries","16;64;16;489")
SchuifSetup()
ZA_Enter("InZone",InZone)
end
