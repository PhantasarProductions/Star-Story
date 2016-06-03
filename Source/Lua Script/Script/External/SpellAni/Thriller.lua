--[[
  Thriller.lua
  Version: 16.06.03
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
stage = 1

zombiepics = {
     "GFX/Combat/Fighters/Foe/Reg/PhanUndeadKid_Befindo.png",
     "GFX/Combat/Fighters/Foe/Reg/PhanUndeadKid_Elf.png",
     "GFX/Combat/Fighters/Foe/Reg/PhanUndeadKid_Fairy.png",
     "GFX/Combat/Fighters/Foe/Reg/PhanUndeadKid_Human.png",
     "GFX/Combat/Fighters/Foe/Reg/PhanUndeadKid_Phelynx.png"
}

zombieimg = {}  -- This is where the image references will actually be stored.

zombiecopy = {} -- The data of the zombie

function createzombie(x,y)
   local ret = { x = x, y = y }
   local imgnum = rand(1,#zombiepics)
   zombieimg[imgnum] = zombieimg[imgnum] or Image.Load(zombiepics[imgnum])
   ret.img = zombieimg[imgnum]
   return ret
end 

function drawzombies()
   White()
   for i,zombie in ipairs(zombiecopy) do       
       Image.Draw(zombie.img,zombie.x,zombie.y)
       CSay('Drawing zombie: '..i.." >> "..zombie.img.." ("..zombie.x..","..zombie.y..")")
   end    
end

stages = {

    function()
       alpha = (alpha or -1) + 1
       MS.Run("COMBAT","DrawScreen")
       Image.SetAlphaPC(alpha)
			 Black()
			 Image.Rect(0,0,800,600)
			 Image.SetAlphaPC(100)
			 if alpha>=100 then stage=2 end       
    end,
    
    function()
      Time.Sleep(50)
      x = (x or 0) + 80
      y = (y or 90)
      if x>=780 then y = y + 90 x=80 end
      if y>=500 then stage = 3 return end
      zombiecopy[#zombiecopy+1] = createzombie(x,y)
      Image.Cls()
      drawzombies()      
    end,
    
    function()
       local michael = Image.Load("GFX/Actors/SinglePic/Phantasar/Michael.png")
       Image.HotCenter(michael)
       Time.Sleep(500)
       zombiecopy[#zombiecopy+1] = { x = 400, y = 550, img = michael }
       Image.Cls()
       drawzombies()
       Flip()
       Time.Sleep(250)
       SFX("Audio/sfx/SpellAni/Evil Laugh.ogg")
       Time.Sleep(1000)
       stage=nil
     end
       


}



function SPELLANI(ag,ai,tg,ti)
repeat
  stages[stage]()
  Flip()
until not stage
stage = 1  
end
