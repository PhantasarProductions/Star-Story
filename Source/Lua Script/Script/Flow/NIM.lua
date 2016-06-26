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

-- @DEFINE NIM_DEBUG

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

function leftover()
   local num,str
   str = ""
   num = 0
   for row in each(chars) do
       local rn = 0
       for ch in each(row) do
           if not ch.die then rn = rn + 1 end
       end
       str = str .. rn
       num = num + rn
   end
   return num,str
end

function count(row)
  local ret = 0
  assert(chars[row],"There is no row #"..sval(row).." to check")
  for ch in each(chars[row]) do
      if not ch.die then ret = ret + 1 end
  end
  return ret
end

function kill(p)
  ufo.x = ufo.x or -100
  ufo.x = ufo.x + 2
  local i
  if p=='player' then
     Image.Color(0,255,255)
     i = playerinput
  else
     Image.Color(255,0,255)
     i = enemyinput
  end      
  Image.Draw(ufo.img,ufo.x,60)
  local s = #shots.shots
  if ufo.x>=(s+1)*100 and s<i.remove then
     shots.shots[s+1] = { y = 60, x=(s+1)*100, tr=i.row, ti=s+1}
     SFX('audio/sfx/photon.ogg')
  end 
  local gotproj = false
  for sh in each(shots.shots) do
      White()
      Image.Draw(shots.img,sh.x,sh.y)      
      if sh.y>chars[sh.tr][sh.ti].y and sh.y<1000 then 
         chars[sh.tr][sh.ti].die = true
         sh.y=1200 -- Just remove the bullet from sight
      elseif sh.y<1000 then 
        sh.y = sh.y + 1
        gotproj = true
      end
  end  
  local n,s = leftover()
  if ufo.x>900 and (not gotproj) then 
    if n==0 then process = p.."win" 
  	elseif p=='player' then process='enemyai' else process='askplayerrow' end
  end
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
                  killplayer = function() kill('player') end,
                  enemyai = function()
                               local timeout = 10000
                               local n,s = leftover()
                               enemyinput = ({
                                                  ['543'] = { row=3, remove=2},
                                                  ['533'] = { row=1, remove=5},
                                                  ['523'] = { row=1, remove=4},
                                                  ['513'] = { row=1, remove=3},
                                                  ['540'] = { row=1, remove=1},
                                                  ['503'] = { row=1, remove=2},
                                                  
                                                  ['532'] = { row=1, remove=4},
                                                  ['531'] = { row=1, remove=3},
                                                  ['530'] = { row=1, remove=2},
                                                  
                                                  ['523'] = { row=1, remove=4},
                                                  ['522'] = { row=1, remove=5},
                                                  ['521'] = { row=1, remove=2},
                                                  ['520'] = { row=1, remove=3},
                                                  
                                                  ['513'] = { row=1, remove=3},
                                                  ['512'] = { row=1, remove=2},
                                                  ['511'] = { row=1, remove=5},
                                                  ['510'] = { row=1, remove=4},
                                                  
                                                  ['503'] = { row=1, remove=2},
                                                  ['502'] = { row=1, remove=3},
                                                  ['501'] = { row=1, remove=4},
                                                  ['500'] = { row=1, remove=5},
                                                  
                                                  ------------------------------
                                                  
                                                  ['443'] = { row=3, remove=3},
                                                  ['442'] = { row=3, remove=2},
                                                  ['441'] = { row=3, remove=1},
                                                  
                                                  ['433'] = { row=1, remove=4},                                                            
                                                  ['431'] = { row=1, remove=2},
                                                  ['430'] = { row=1, remove=1},
                                                  
                                                  ['423'] = { row=1, remove=3},
                                                  ['422'] = { row=1, remove=4},
                                                  ['421'] = { row=1, remove=2},
                                                  ['420'] = { row=1, remove=2},
                                                  
                                                  ['413'] = { row=1, remove=2},
                                                  ['412'] = { row=1, remove=1},
                                                  ['411'] = { row=1, remove=4},
                                                  ['410'] = { row=1, remove=3},
                                                  
                                                  ['403'] = { row=1, remove=1},
                                                  ['402'] = { row=1, remove=2},
                                                  ['401'] = { row=1, remove=3},
                                                  ['400'] = { row=1, remove=4},

                                                  ------------------------------
                                                  
                                                  ['343'] = { row=2, remove=4},
                                                  ['342'] = { row=2, remove=3},
                                                  ['341'] = { row=2, remove=2},
                                                  ['340'] = { row=2, remove=1},
                                                  
                                                  ['333'] = { row=rand(1,3), remove=3},
                                                  ['332'] = { row=3, remove=2},
                                                  ['331'] = { row=3, remove=1},
                                                  
                                                  ['323'] = { row=2, remove=2},
                                                  ['311'] = { row=1, remove=3},
                                                  ['310'] = { row=1, remove=2},
                                                  
                                                  ['302'] = { row=1, remove=1},
                                                  ['301'] = { row=1, remove=2},
                                                  ['300'] = { row=1, remove=3},

                                                  ------------------------------
                                                  
                                                  ['243'] = { row=2, remove=3},
                                                  ['241'] = { row=2, remove=1},
                                                  ['242'] = { row=2, remove=4},
                                                  ['240'] = { row=2, remove=2},
                                                  
                                                  ['233'] = { row=1, remove=2},
                                                  ['232'] = { row=2, remove=3},
                                                  ['230'] = { row=2, remove=1},
                                                  
                                                  ['223'] = { row=3, remove=3},
                                                  ['222'] = { row=rand(1,3), remove=2},
                                                  ['221'] = { row=3, remove=3},
                                                  
                                                  ['212'] = { row=2, remove=1},
                                                  ['211'] = { row=1, remove=2},
                                                  ['210'] = { row=1, remove=1},
                                                  
                                                  ['203'] = { row=3, remove=1},
                                                  ['201'] = { row=1, remove=1},
                                                  ['200'] = { row=1, remove=2},
                                                  
                                                  ------------------------------
                                                  
                                                  ['143'] = { row=2, remove=2},
                                                  ['142'] = { row=2, remove=1},
                                                  ['141'] = { row=2, remove=4},
                                                  ['140'] = { row=2, remove=3},
                                                  
                                                  ['133'] = { row=1, remove=1},
                                                  ['131'] = { row=2, remove=3},
                                                  ['130'] = { row=2, remove=2},
                                                  
                                                  ['113'] = { row=3, remove=3},
                                                  ['112'] = { row=3, remove=2},
                                                  ['111'] = { row=rand(1,3), remove=1},
                                                   
                                                  ------------------------------
                                                  
                                                  ['043'] = { row=2, remove=1},
                                                  ['042'] = { row=2, remove=2},
                                                  ['041'] = { row=2, remove=3},
                                                  ['040'] = { row=2, remove=4},
                                                  
                                                  ['032'] = { row=2, remove=2},
                                                  ['031'] = { row=2, remove=2},
                                                  ['030'] = { row=2, remove=4},
                                                  
                                                  ['023'] = { row=3, remove=1},
                                                  ['021'] = { row=2, remove=1},
                                                  ['020'] = { row=2, remove=2},
                                                  
                                                  ['013'] = { row=3, remove=2},
                                                  ['012'] = { row=3, remove=1},
                                                  ['010'] = { row=2, remove=1},
                                                  
                                                  ['003'] = { row=3, remove=3},
                                                  ['002'] = { row=3, remove=2},
                                                  ['001'] = { row=3, remove=1}
                                                                                                    
                                                   
                                            })[s] or (function()
                                                       local row,remove
                                                       repeat
                                                          row = rand(1,3)
                                                          timeout=timeout-1
                                                          if timeout<=0 then Sys.Error("NIM-AI-TIMEOUT!") end
                                                       until count(row)>0
                                                       remove = rand(1,count(row))
                                                       return { row=row,remove=remove }
                                                     end)()
                                 process = "enemykill"                    
                               
                            end                  ,
                  enemykill = function() kill('enemy') end,
                  playerwin = function()
                       Sys.Error('You Win') -- True script comes later
                       end,
                  enemywin = function()
                       Sys.Error("I Win") -- True script comes later
                  end     
                                      
             }     
             
function noprocess()
   Sys.Error("I do not understand process name: "..process)
end             

function MAIN_FLOW()
   -- Clear Screen
   Image.Cls()
   -- @IF NIM_DEBUG
   DarkText("Current process: "..sval(process),20,20,0,0,0,180,255)
   -- @FI
   White()
   -- Draw all the characters
   for i,row in ipairs(chars) do
       DarkText(i..":",90,(i*100)+50,1,2,rc[i].r,rc[i].g,rc[i].b)
       White()
       for ch in each(row) do
           Image.SetAlphaPC(ch.alpha)
           DrawImage(pic[ch.sex],(ch.x),ch.y+50)
           if ch.die and ch.alpha>0 then ch.alpha = ch.alpha - 1 end
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
