--[[
**********************************************
  
  Goddess in Space.lua
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
 
version: 16.11.03
]]
-- @IF IGNORE
AltBackGrounds = {}
-- @FI


GoddessSpace = {
                   Stars = {},
                   
                   AllCharStat = function ()
                       local chars = {'Wendicka','Crystal','Yirl','Foxy','Xenobi','Johnson'}
                       local stats = {'Strength','Defense','Will','Resistance','Agility','Accuracy','HP'} -- 'Evasion', (I don't want the party to miss all the time. For a final boss, that is not really a suitable option.
                       local chi = 1
                       local sti = 0
                       return function ()
                                 sti = sti + 1
                                 if not stats[sti] then 
                                    chi = chi + 1
                                    sti = 1
                                    if not chars[chi] then return nil,nil end
                                 end
                              CSay('AllCharStat Returning   '..chars[chi]..","..stats[sti])
                              return chars[chi],stats[sti]   
                              end 
                   end,
                   
                   init = function ()
                       -- Initial add coordinates
                       for i=2,#Fighters.Foe do
                           local foe = Fighters.Foe[i]
                           local tag = foe.Tag
                           foe.goddess = {
                                            rad = 300+(i*({100,75,50})[skill]),
                                            dgr = ({.01,-.01})[rand(1,2)],
                                            deg = 0 
                                         }
                           RPGChar.Points(tag,"HP").Minimum = RPGChar.Points(tag,"HP").Maximum -- Now all adds are invincible.              
                       end
                       
                       -- Calculate the Goddess' statistics
                       local totalstat = {}
                       for ch,stat in GoddessSpace.AllCharStat() do
                           totalstat[stat] = (totalstat[stat] or skill) + RPGChar.Stat(ch,'END_'..stat)
                       end
                       for key,value in pairs(totalstat) do
                           local modifier = 6 
                           if skill==3 then modifier=5 end -- Goddess slightly stronger in the Hard Mode, yes.
                           if key=='HP' then modifier=({1,.25,.75})[skill] end -- HP should be handled differently
                           RPGStat.DefStat('FOE_1',"BASE_"..key,value/modifier)
                           local HP = RPGStat.Points('FOE_1','HP')
                           HP.Maximum = RPGStat.Stat('FOE_1',"BASE_HP")
                           HP.Minimum = 1 -- Special Script should ignite in the Godess' case.
                           HP.Have = HP.Maximum
                       end
                       return true
                   end
}


--CSay('BHDAB Script present')
function AltBackGrounds.GoddessSpace()
      Image.Cls()
      GoddessSpace.Orion = GoddessSpace.Orion or Image.Load('GFX/XSpace/Orionnevel.png')
      Image.Draw(GoddessSpace.Orion,0,0)
      -- Init (if needed)
      GoddessInitiated = GoddessInitiated or GoddessSpace.init()
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
      -- Stars
      if GoddessSpace.Stars[1] and GoddessSpace.Stars[1].rad > 800 then table.remove(GoddessSpace.Stars,1) end
      if #GoddessSpace.Stars<=0 or rand(1,#GoddessSpace.Stars*100)==1 then 
         GoddessSpace.Stars [ #GoddessSpace.Stars + 1 ] = { rad = 0, spd = rand(0,20)/15, deg=rand(0,360) }
      end
      for star in each(GoddessSpace.Stars) do
          star.rad = star.rad + star.spd
          local x,y = 
               (math.sin(star.deg)*star.rad),
               (math.cos(star.deg)*star.rad)
          White()
          Image.Line(x+400,y+250,x+400,y+250)     
      end
      -- Goddess Defeated?
      if RPGStat.Points('FOE_1','HP').Have<=1 then 
         LAURA.Flow('FIELD')
         Image.Free(GoddessSpace.Orion) 
      end
end

-- @IF IGNORE
return AltBackGrounds
-- @FI
