--[[
**********************************************
  
  Johnson_Phaser.lua
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
-- @IF IGNORE
SpellAni = {}
-- @FI


function SpellAni.Johnson_Phaser(ActG,ActT,TarG,TarT)
  local ax,ay = FighterCoords(ActG,ActT)
  local tx,ty = FighterCoords(TarG,TarT)
  local gx = (tx-ax)/10
  local gy = (ty-ay)/10
  local x,y=ax,ay
  --Image.LoadNew("PROJECTILE_YIRL_LASER","GFX/Combat/Projectiles/Yirl_Laser.png")
  SFX("Audio/SFX/Photon.ogg")
  repeat
    x = x + gx
    y = y + gy
    --[[DrawScreen()
    White()
    Image.Show("PROJECTILE_YIRL_LASER",x,y)
    Flip()]]
  until x<-50 or x>850 or y<-50 or y>650
  -- I got the data I need now. That routine from Yirl was good for something, eh?
  local sx = ax-16
  local sy = ay-43
  local r = rand(100,255)
  local g = rand(100,255)
  local b = rand(100,255)
  DrawScreen()
  Image.Color(r,g,b)
  Image.Line(sx,sy,x,y)
  Flip()
  Time.Sleep(500)
end


SpellAni.Johnson_PhotonBlade = SpellAni.Johnson_Phaser -- Originally this was meant to be a photon blade, but due to animation issues, I just used a phaser. This line is to prevent conflicts in savegames.
