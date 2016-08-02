--[[
  EndCredits.lua
  Version: 16.08.02
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
Stars = {}
cdata = {}
function MAIN_FLOW()
      Image.Cls()
      Orion = Orion or Image.Load('GFX/XSpace/Orionnevel.png')
      Image.Draw(Orion,0,0)
      --[[
      -- Init (if needed)
      GoddessInitiated = GoddessInitiated or init()
      -- Control the adds
      for i=2,#Fighters.Foe do
          local foe = Fighters.Foe[i]
          if foe.goddess then
             if foe.goddess.rad > 260 then foe.goddess.rad = foe.goddess.rad - 1
             else foe.goddess.deg = foe.goddess.deg + foe.goddess.dgr end
             foe.x = 300 - (math.sin(foe.goddess.deg)*foe.goddess.rad)
             foe.y = 300 - (math.cos(foe.goddess.deg)*foe.goddess.rad)
          end
      end 
      ]]
      -- Stars
      if Stars[1] and Stars[1].rad > 800 then table.remove(Stars,1) end
      if #Stars<=0 or rand(1,#Stars*10)==1 then -- Lagging less of a problem so MOAR STARS PLEASE!!! 
         Stars [ #Stars + 1 ] = { rad = 0, spd = rand(0,20)/15, deg=rand(0,360) }
      end
      for star in each(Stars) do
          star.rad = star.rad + star.spd
          local x,y = 
               (math.sin(star.deg)*star.rad),
               (math.cos(star.deg)*star.rad)
          White()
          Image.Line(x+400,y+250,x+400,y+250)     
      end
      --[[
      -- Goddess Defeated?
      if RPGStat.Points('FOE_1','HP').Have<=1 then 
         LAURA.Flow('Field')
         Image.Free(Orion) 
      end
      ]]
      local max = nil
      setfont('BoxText')
      for k,d in spairs(cdata) do          
          if d.img then
             Image.Color(d.r or 255,d.g or 255,d.b or 255)
             d.imgtag = d.imgtag or Image.Load(d.img)
             Image.HotCenter(d.imgtag)
             Image.Show(d.imgtag,400,d.y)
          else
             DarkText(d.txt,d.r or 255, d.g or 255, d.b or 255,2,2,400,y)
          end
          d.y = d.y - 1
          max = k      
      end
      if cdata[max].y<=300 then
         Time.Sleep(400)
         for k,d in spairs(cdata) do if d.imgtag then Image.Free(d.imgtag) end end
         Image.Free(Orion)
         MS.Destroy('CREDITS')
         MS.Flow('Field')
      end
      Flip()   
end



function GALE_OnLoad()
  cdata = JINC('Script/JINC/Big/Credits.lua')
  Music('Launcher/Launcher.ogg')
end
