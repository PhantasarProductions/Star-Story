--[[
  BlockShooter.lua
  
  version: 16.02.19
  Copyright (C) 2016 Jeroen P. Broks
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

debug = false

iflow = "start"
logoalpha = -1

MSecs = Time.MSecs

function dbg(a)
if dbg then 
   SetFont('LayerInField')
   DarkText(a,5,dbgy,0,0,rand(0,255),rand(0,255),rand(0,255))
   dbgy=dbgy+15
   end
end   

function Logo(alpha)
Image.LoadNew("BLOCKSHOOT_LOGO","GFX/APP/BLOCKSHOOTER/Logo.png")
Image.HotCenter("BLOCKSHOOT_LOGO")
Image.SetAlphaPC(alpha or 100)
Image.Draw("BLOCKSHOOT_LOGO",400,100)
Image.SetAlphaPC(100)
end

function ShowBlock()
Image.LoadNew("BLOCKSHOOT_BLOCK","GFX/APP/BLOCKSHOOTER/BLOCK.png")
Image.SetAlphaPC((math.sin(MSecs()/500)*25)+75)
Image.Color(0,180,255)
Image.Draw("BLOCKSHOOT_BLOCK",100+(data.blockpos*16),50)
Image.SetAlphaPC(100)
end


rflow = {


           start = function() 
                   if logoalpha<100 then logoalpha = logoalpha + .5 end
                   White()
                   Logo(logoalpha)                   
                   if logoalpha<75 then return end
                   SetFont('BoxText')
                   Image.Color(0,180,255)
                   Image.DText("Coded by: Kakkerlakje",400,280,2,2) -- "Kakkerlakje" was the very first internet nick I ever used. Only for a few days, though. It means "Little Cockroach" in Dutch.
                   Image.DText("Released under the FLUE License",400,300,2,2) -- Disclaimer: This is NOT a real license! It's a JOKE!!!!! A J.O.K.E.!!!!!! (Yeah, it's a pun to an existing license).
                   Image.DText("Copyshite 3000 by Kakkerlakje",400,330,2,2) -- Another JOKE, since this mini game is just copyrighted by me, as stated above in the license block!
                   if logoalpha<95 then return end
                   Image.Color(255,180,0)
                   Image.DText("Do you want instructions ? (Y/N)",400,400,2,2)
                   if INP.KeyH(KEY_Y)==1 then iflow = 'explain' end
                   if INP.KeyH(KEY_N)==1 then iflow = 'game' end
                   end,
                   
           explain = function()
                     White()
                     Logo()
                     SetFont('BoxText')
                     Image.Color(0,180,255)
                     Image.DText("In this game you shoot blocks being 16x16 pixels.",100,250)
                     Image.DText("You just have to enter the number of positions the",100,270)
                     Image.DText("block is away from the left and the cannon will move",100,290)
                     Image.DText("to that position and shoot. You may do this 10 times.",100,310)
                     Image.DText("Then we will see how many hits you had.",100,330)
                     Image.DText("Even a kid can do it!",100,350)
                     Image.Color(255,180,0)
                     Image.DText("Hit spacebar to continue . . .",120,400)
                     if INP.KeyH(KEY_SPACE)==1 then iflow = 'game' end
                     end,        

           game = function()
                  data = data or { shot = 1, hits = 0, misses = 0, cycle = 'NewBlock', cd=150 }
                  ;((  -- Yeah, this is how you can use a switch()/case statement in Lua. Looks complicated, eh?
                  {
                  
                       NewBlock = function()
                                  data.blockpos = rand(0,36)
                                  data.cycle = 'EnterPos'
                                  data.cd = 150
                                  end,
                                  
                       EnterPos = function()
                                  ShowBlock()
                                  dbg("Psst... the block is on number "..data.blockpos)
                                  data.typenum = data.typenum or ""
                                  data.valunum = Sys.Val(data.typenum)
                                  SetFont('BoxText')
                                  q = "Please enter cannon position: "
                                  ix = ix or Image.TextWidth(q)
                                  Image.Color(180,0,255)
                                  Image.DText("Turn: "..data.shot.."; Hits: "..data.hits.."; Misses: "..data.misses,100,410)
                                  Image.Color(255,180,0)
                                  Image.DText(q,100,430)
                                  if data.valunum<=36 then
                                     Image.Color(180,255,0)
                                     if data.typenum~="" and INP.KeyH(KEY_ENTER)==1 then data.cycle = 'Shoot'; data.bullet = {} SFX("Audio/SFX/Crystal ARM.ogg") end
                                  else
                                     Image.Color(255,0,0)
                                     Image.DText("Value too high. Maximum value is 36!",100,450)
                                     end
                                  Image.DText(data.typenum.."<",100+ix,430)
                                  if len(data.typenum)<2 then for i=48,57 do 
                                     if INP.KeyH(i)==1 then data.typenum = data.typenum .. string.char(i) end
                                     end end
                                  if INP.KeyH(8)==1 and len(data.typenum)>0 then data.typenum = left(data.typenum,len(data.typenum)-1) end   
                                  end,     
                       Shoot    = function()
                                  dbg("cd = "..data.cd)
                                  data.bullet.x = (data.bullet.x or ((data.valunum * 16)+100))
                                  data.bullet.y = (data.bullet.y or 600)-2                                  
                                  data.bullet.f = (data.bullet.f or 0)+1
                                  if data.bullet.f>3 then data.bullet.f=1 end
                                  if not data.bullet.hit then ShowBlock() end
                                  Image.LoadNew("BLOCKSHOOTER_BULLET_FRAME"..data.bullet.f,"GFX/App/Blockshooter/Bullet_"..data.bullet.f..".png",1)
                                  Image.Color(255,180,0)
                                  Image.Draw("BLOCKSHOOTER_BULLET_FRAME"..data.bullet.f,data.bullet.x,data.bullet.y) 
                                  if data.valunum == data.blockpos and data.bullet.y<=50 and (not data.bullet.hit) then
                                  	 data.bullet.hit = true
                                  	 data.hits = data.hits + 1
                                  	 data.bullet.y = -100
                                  elseif data.bullet.y<=0 and (not data.bullet.miss) and (not data.bullet.hit) then
                                     data.misses = data.misses + 1
                                     data.bullet.miss = true	 
                                  	 end
                                  if data.bullet.miss then 
                                     Image.Color(255,0,0)
                                     Image.DText("Miss!",400,300)
                                  elseif data.bullet.hit then
                                     Image.Color(180,255,0)
                                     Image.DText("Hit!",400,300)
                                     end
                                  if data.bullet.miss or data.bullet.hit then data.cd = data.cd - 1 end
                                  if data.cd<0 then 
                                     data.shot = data.shot + 1
                                     if data.shot>10 then iflow = 'endgame' else data.cycle = 'NewBlock' data.typenum = nil end
                                     end
                                  end             
                     
                  }
                  )[data.cycle] or function() Sys.Error("Unknown Blockshooter cycle: "..data.cycle) end)()
                  end,
                  
           endgame = function()
                     Image.Color(180,0,255)
                     Image.DText("Game Over",400,100,2,0)
                     Image.Color(0,180,255)
                     Image.DText("Hits:",200,200)
                     Image.DText("Misses:",200,250)
                     Image.Color(180,255,0)
                     Image.DText(data.hits,500,200,1,0)
                     Image.Color(255,0,0)
                     Image.DText(data.misses,500,250,1,0)
                     Image.Color(255,180,0)
                     Image.DText("Play again ? (Y/N)",400,400,2,2)
                     if data.hits==10 and (not Done("&AWARDTROPHY")) then Award("ZZ_BLOCKSHOOTER_PERFECT") end
                     if INP.KeyH(KEY_Y)==1 then data=nil; iflow='game' end
                     if INP.KeyH(KEY_N)==1 then iflow = 'end' end                                          
                     end,       
           ["end"] = function()
                     LAURA.Flow("TERMINAL")
                     MS.Run('MAP',"HawkMusic")
                     MS.Destroy('BLOCKSHOOTER') -- Remove me from the RAM after the current cycle is done!
                     end       

        }
        
function MAIN_FLOW()
dbgy=0
-- Start
White()
Image.Cls()
Image.Show('MenuBack',0,0)
SetFont('BoxText')
-- Run
rflow[iflow]()
-- Party
ShowParty()
-- Flip
Flip()
if INP.KeyH(KEY_ESCAPE)==1 then iflow = 'end' end
end        
        
function GALE_OnLoad()
Music("BlockShooter/Overworld.ogg")
end        
