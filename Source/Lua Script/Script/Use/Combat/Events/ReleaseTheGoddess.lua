--[[
**********************************************
  
  ReleaseTheGoddess.lua
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
 
version: 16.02.12
]]
-- @IF IGNORE
VicCheck = {}
DefeatCheck = {}
-- @FI


function DefeatCheck.ReleaseTheGoddess()
if RPGChar.Points("Wendicka","HP").Have>1 then return end -- Only respond once Wendicka is in critical condition
BoxTextBack = "MAP"
DrawScreen(true)
Image.GrabScreen("TMP_COMBATSCREEN")
RPGStat.Points("Wendicka","HP").Minimum = 0
RPGStat.Points("FOE_1","HP").Minimum = 0
NewMessage('Be released, goddess of evil')
for i=1,3 do SpellAni.Mjolnir('Hero',1,'Hero',1) end
MapText("RELEASE_A","MAP")
for i=1,3 do SpellAni.Mjolnir('Hero',1,'Hero',1) end
MapText("RELEASE_B","MAP")
Image.Load("GFX/SPECIAL/GODDESS.png","GODDESS"); Image.HotCenter("GODDESS")
local alpha = 0
local alphadir = .03
local scale = 0
repeat
Image.Color(0,rand(100,180),rand(180,255))
Image.Draw("TMP_COMBATSCREEN",0,0)
for i=0,300 do
    Image.Color(0,rand(100,180),rand(180,255))
    Image.Line(400,300,  0,rand(0,600))
    Image.Line(400,300,800,rand(0,600))
    Image.Line(400,300,rand(0,800),  0)
    Image.Line(400,300,rand(0,800),600)
    end
Image.Scale(scale,scale)    
Image.SetAlpha(alpha)
Image.Draw("GODDESS",400,300)
scale=scale+.005
alpha=alpha+alphadir
if alpha>=1 then alphadir=-.02 end
Image.Scale(1,1)
Image.SetAlpha(1)
Flip()
until alpha<=0
Image.Free('GODDESS')
local g,b=180,255
repeat
if g>0 then g=g-.5 end
if b>0 then b=b-.7 end
Image.Cls()
Image.Color(0,g,b)
Image.Draw("TMP_COMBATSCREEN")
Flip()
if g<10 then StopMusic() end
until g<=0 and b<=0 
DestroyPushedMusic()
Image.Cls()
Image.GrabScreen("TMP_COMBATSCREEN")
MapText("RELEASE_C","MAP")
Image.Free("TMP_COMBATSCREEN")
Done("&GODDESS.RELEASED") -- From this moment on Wendicka no longer heals on thunder attacks and will no longer die instantly when touched by water. That is, unless she's wearing gems that still make this happen.
Done("&NOHAWKMUSIC") -- Make sure the transition to the Hawk goes the way it should
Var.Clear("&TRANSPORTERBLOCK")
LoadMap("Hawk","Bridge")
MS.Run("MAP","AfterVolcania")
end
