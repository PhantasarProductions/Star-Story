--[[
  NIM.lua
  Version: 16.06.26
  Copyright (C) 2016 Jeroen Petrus Broks
  
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

NIM = { 5,4,3 }
chars = {}

function PRINT(A)
  Console.Write(A,0,180,255)
end



for n,row in ipairs(NIM) do
    chars[n] = {}
    for i = 1,row do
        chars[n][#chars[n]+1] = {x=i*100,y=n*100,sex=Math.Rand(1,2), alpha=100}
        PRINT("Created char on row: #"..n)
    end
end        

pic = {
         Image.Load('GFX/Actors/SinglePic/Random/AlienGuy.png'),
         Image.Load('GFX/Actors/SinglePic/Random/AlienGirl.png')
      }
      
for _,p in ipairs(pic) do Image.HotCenter(p) end      

ufo = {}
ufo.img = Image.Load("GFX/Special/UFO.png")
Image.HotCenter(ufo.img)

shots = {
           img = Image.Load("GFX/Special/Projectile.png"),
           shots = {}
        }
Image.HotCenter(shots.img)        
      
rc = {
        {r=255,g=  0,b  =0},
        {r=255,g=255,b=255},
        {r=  0,g=  0,b=255}
     }      


function kill(p)
  ufo.x = ufo.x or -100
  ufo.x = ufo.x + 1
  if p=='player' then
     Image.Color(0,255,255)
  else
     Image.Color(255,0,255)
  end      
  Image.Draw(ufo.img,ufo.x,60)
end

     
funprocess = {

                  askplayerrow = function()
                                    playerinput = {}
                                    DarkText("Which row?",400,450,2,2,0,180,255)
                                    if INP.KeyH(KEY_1)==1 or INP.KeyH(KEY_NUM1)==1 then playerinput.row=1 end
                                    if INP.KeyH(KEY_2)==1 or INP.KeyH(KEY_NUM2)==1 then playerinput.row=2 end
                                    if INP.KeyH(KEY_3)==1 or INP.KeyH(KEY_NUM3)==1 then playerinput.row=3 end
                                    if playerinput.row then process='askplayerremove' end
                                 end,
                  askplayerremove = function()
                                       DarkText("Row #"..playerinput.row..": How many do you want to remove?",400,450,2,2,180,0,255) 
                                       if INP.KeyH(KEY_1)==1 or INP.KeyH(KEY_NUM1)==1 then playerinput.remove=1 end
                                       if INP.KeyH(KEY_2)==1 or INP.KeyH(KEY_NUM2)==1 then playerinput.remove=2 end
                                       if INP.KeyH(KEY_3)==1 or INP.KeyH(KEY_NUM3)==1 then playerinput.remove=3 end
                                       if INP.KeyH(KEY_4)==1 or INP.KeyH(KEY_NUM4)==1 then playerinput.remove=4 end
                                       if INP.KeyH(KEY_5)==1 or INP.KeyH(KEY_NUM5)==1 then playerinput.remove=5 end
                                       if INP.KeyH(KEY_ESCAPE)==1 then process='askplayerrow' end
                                       if playerinput.remove and playerinput.remove<=#chars[playerinput.row] then process='killplayer' ufo.x=-100 end
                                    end,
                  killplayer = function() kill('player') end                  
             }     
             
function noprocess()
   Sys.Error("I do not understand process name: "..process)
end             

function MAIN_FLOW()
   -- Clear Screen
   Image.Cls()
   White()
   -- Draw all the characters
   for i,row in ipairs(chars) do
       DarkText(i..":",90,(i*100)+50,1,2,rc[i].r,rc[i].g,rc[i].b)
       White()
       for ch in each(row) do
           Image.SetAlphaPC(ch.alpha)
           DrawImage(pic[ch.sex],ch.x,ch.y)
       end
       Image.SetAlphaPC(100)
   end
   -- Process
   process = process or 'askplayerrow';
   (funprocess[process] or noprocess)()
   -- Party
   ShowParty()
   -- Flip
   Flip()
end


function GALE_OnLoad()
   Music("BlockShooter/Overworld.ogg")
end        
