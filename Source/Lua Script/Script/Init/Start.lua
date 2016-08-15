--[[
  Start.lua
  Version: 16.08.14
  Copyright (C) 2015, 2016 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================
  zLib license terms:
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]]
function CaptainLovejoyLog()
print("Admiral Lovejoy's opening speech")
local captain = 0
local stars = Image.Load("GFX/INTRO/STARFIELD.PNG")
local sound
local channel = "LovejoyChannel"
local y = 0.5
Done("&SYS.ABLPOWERUPFIXED") -- In a new game everything should be in order from the start (though this will require a test later).
repeat
INP.Grab()
y = y - .05
Image.Cls()
Image.Tile(stars,0,y)
-- @IF $DEBUGBUILD
Image.DText("y = "..y,0,0)
Image.DText("s = "..captain,0,15)
-- @FI
if captain==0 or (Audio.Playing(channel)==0) then
  CSay("Playing captain sound: "..captain)
  captain = captain + 1
   if sound then Audio.Free(sound) end
   if captain<15 then
      sound = Audio.Load("Audio/IntroStory/Lovejoy"..right("000"..captain,4)..".ogg")
      Audio.Play(sound,channel)
      end
   end
Image.Flip()
until captain == 15 or INP.KeyH(KEY_ESCAPE)==1 
if Audio.Playing(channel)==1 then Audio.Stop(channel) end
Image.Free(stars)
end

function ActorsProcess()
while Actors.CountMoving()>0 do
     Image.Cls()
     Maps.Draw()
     Flip()
     end 
for i,k in ipairs({"Wendicka","Crystal","Briggs"}) do
    CSay(i.."> "..k.." is now on spot ("..Actors.PX("Act"..k)..","..Actors.PY("Act"..k)..")")
    end     
end

function ActMoveTo(A,x,y)
CSay("Actor "..A.." is moving to ("..x..","..y..")")
Actors.MoveTo(A,x,y)
end

function ActWalkTo(A,x,y)
CSay("Actor "..A.." is walking to ("..x..","..y..")")
Actors.WalkTo(A,x,y)
end

function BeamUsDownScotty()
local actors = {"Wendicka","Crystal","Briggs"}
local i,v
for i,v in ipairs(actors) do
    Actors.ChoosePic("Act"..v,"TELEPORT")
    Actors.Actor("Act"..v).NotInMotionThen0 = 0
    end
local f
for f=0,99 do
    Image.Cls()
    for i,v in ipairs(actors) do
        -- CSay(i..">Actor "..v.." had frame number "..Actors.Actor("Act"..v).Frame)
        Actors.Actor("Act"..v).Frame = f -- This function goes a bit into the hardcode of Kthura, and best not to use it yourself unless you know the deep background of Kthura.
        -- CSay(i..">Actor "..v.." now has frame number "..Actors.Actor("Act"..v).Frame)
        end
    Maps.Draw()
    --Image.DText("Frame: "..f,0,0) -- Debug line
    Flip()    
    end    
end

function StartIntroSequence()
Image.Cls()
Maps.Load("Intro_Ship_Transporter")
Maps.CamX = 256
Maps.CamY = 32
Actors.Spawn("SpotWendicka","GFX/Actors/Uniform","ActWendicka"); CSay("Wendicka Loaded")
Actors.Spawn("SpotCrystal","GFX/Actors/Uniform","ActCrystal"); CSay("Crystal Loaded")
Actors.Spawn("SpotBriggs","GFX/Actors/Uniform","ActBriggs"); CSay("Briggs Loaded"); CSay("All actors loaded")
Actors.ChoosePic("ActWendicka","WENDICKA.NORTH")
Actors.ChoosePic("ActCrystal","CRYSTAL.NORTH")
Actors.ChoosePic("ActBriggs","BRIGGS.SOUTH")
Maps.Draw()
Image.Flip()
local wenx,weny,wenw = GetCoords("ActWendicka")
local cryx,cryy,cryw = GetCoords("ActCrystal")
local brix,briy,briw = GetCoords("ActBriggs")
-- Maps.DebugBlockMap() -- Debug line
LoadBoxText('SCENONLY/OPENING/START')
SerialBoxText('SCENONLY/OPENING/START',"SCEN_A")
ActMoveTo("ActWendicka",wenx,weny-12)
ActorsProcess()
SerialBoxText('SCENONLY/OPENING/START',"SCEN_B")
ActMoveTo("ActWendicka",wenx,weny)
SerialBoxText('SCENONLY/OPENING/START',"SCEN_C")
ActMoveTo("ActCrystal",cryx,cryy-12)
ActorsProcess()
SerialBoxText('SCENONLY/OPENING/START',"SCEN_D")
ActMoveTo("ActCrystal",cryx,cryy)
SerialBoxText('SCENONLY/OPENING/START',"SCEN_E")
ActMoveTo("ActWendicka",544,245)
ActMoveTo("ActBriggs",544,312); Actors.Actor("ActBriggs").ChosenPic ="BRIGGS.NORTH" 
ActMoveTo("ActCrystal",702,242)
ActorsProcess()
Actors.ChoosePic("ActWendicka","WENDICKA.SOUTH")
Actors.ChoosePic("ActCrystal","CRYSTAL.SOUTH")
Actors.ChoosePic("ActBriggs","BRIGGS.SOUTH")
Image.Cls();
Maps.Draw()
Flip()
BeamUsDownScotty()
-- Maps.Load("Prologue_Yaqirpa")
LoadMap("Prologue_Yaqirpa")
OnlyMapShow("Entrance")
Actors.Spawn("StartWendicka","GFX/Actors/Uniform","ActWendicka"); CSay("Wendicka Loaded")
Actors.Spawn("StartCrystal","GFX/Actors/Uniform","ActCrystal"); CSay("Crystal Loaded")
Actors.Spawn("StartBriggs","GFX/Actors/Uniform","ActBriggs"); CSay("Briggs Loaded"); CSay("All actors loaded")
Actors.ChoosePic("ActWendicka","WENDICKA.NORTH")
Actors.ChoosePic("ActCrystal","CRYSTAL.NORTH")
Actors.ChoosePic("ActBriggs","BRIGGS.NORTH")
Maps.CamX=608
Maps.CamY=1360
Maps.Draw()
Flip()
SerialBoxText('SCENONLY/OPENING/START',"YAQIRPA_WELCOME")
FreeBoxText("SCENONLY/OPENING/START")
Tutorial("To move the Wendicka click to the spot in\nthe building with thef mouse button and she'll\nwalk to it.\n\nDon't worry about obstacles, she'll automatically walk around it")
end 

function NewGame()
print("NewGame")
Console.Write("Setting up a fresh new game",255,180,0)
LoadFlowsScripts(); INP.MouseHide()
LoadBaseGraphics()
Party("UniWendicka","UniCrystal","Briggs")
CaptainLovejoyLog()
StartIntroSequence()
LAURA.Flow("FIELD")
end

--[[ This part has not been used since the New Game+ has now been covered on a differnt way.
function NewGamePlus()
NewGame()
Console.Write("Basic new game has been set up, but now for the New Game+",255,180,0)
end
]]

print("Ready to go?")
