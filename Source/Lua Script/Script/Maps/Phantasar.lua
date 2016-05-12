--[[
  Phantasar.lua
  Version: 16.05.12
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

--[[
           
           This file contains all sorts of stuff unique to the Phantasar world
           missions. Have fun with them ;=P
           
]]

-- @DEFINE PHANTASAR_DEBUG


-- Phantasar text
MS.Run("BOXTEXT","LoadData","GENERAL/PHANTASAR;PHANTASAR");

-- Dungeon title
function DungTitleFadeOut()
	local d = dungtitles[1]; if not d then return end
	d.alpha = d.alpha - 1
	if d.alpha>=100 then d.alpha=100 table.remove(dungtitles,1) end
end


function DungTitleWait()
	local d = dungtitles[1]; if not d then return end
  d.time = d.time - 1
  if d.time<=0 then d.stage = DungTitleFadeOut end
  -- @IF PHANTASAR_DEBUG
  Image.NoFont()
  Image.DText("Time remaining: "..d.time,0,0)
  -- @FI
end	

function DungTitleFadeIn()
	local d = dungtitles[1]; if not d then return end
	d.alpha = d.alpha + 1
	if d.alpha>=100 then d.alpha=100 d.stage=DungTitleWait end
end



function DungTitle(title)
	dungtitles = dungtitles or {}
	dungtitles[#dungtitles+1] = {
         text = title or Maps.GetData('Title'),
         stage = DungTitleFadeIn,
         alpha = 0,
         time = 500
    }
end


function DungTitleShow()
	if dungtitles and #dungtitles>0 then
	    local d = dungtitles[1];
	    setfont("PhantasarDungTitle")
	    Image.SetAlphaPC(d.alpha)
	    DarkText(d.text,400,300,2,2)
	    Image.SetAlpha(1)
	    d.stage()
	end
end
	          

DungTitle() -- Can be called safely since no calls to outside functions are done.


-- random encounters
encrange = {640,580,320}

function AddEnemy(enemy,rate)
  monsters = monsters or {}
  for i=1,(rate or 1) do
      monsters[#monsters+1]=enemy
  end
end

function CheckEncounter()
if not monsters then return end
local player = Actors.Actor('PLAYER')
oripos = oripos or {x = player.x, y=player.y}
if player.Walking==0 then return end -- Only have random encounters if the player is walking
local travelled = math.floor(Distance(player.x,player.y,oripos.x,oripos.y))
if rand(0,travelled)<encrange[skill] then return end
-- No more reasons to back out! 
-- GREAT! Then let's start the show!
if not Done("&DONE.PHANTASAR.RANDOMENCOUNTER."..upper(ActivePlayer)) then SerialBoxText("PHANTASAR","RAND."..upper(ActivePlayer),"BOXTEXT.KTHURA") end
CleanCombat()
Var.D("$COMBAT.BACKGROUND",(EncounterBack or "Bos-Spar")..".png")
Var.D("$COMBAT.MUSIC",EncounterMusic or 'AltCombat/X-Ray.ogg') -- Death Predator was the codename until the actual boss name was decided
Var.D("$COMBAT.BEGIN","Default")
local num = ({
                rand(1,3),
                (function() 
                   if rand(1,10)==1 then return 6 else return 3 end
                 end  
                 )(),
                (function() 
                   if rand(1,20)<5 then return 6 elseif rand(1,20)==20 then return 9 else return 3 end
                 end  
                 )(),
             })[skill]
local pt = ngpcount or 1
if pt>99 then pt=99 end
local dt = "PT "..right(" "..pt,2).." Level Range"
while Maps.GetData(dt)=="" do
      pt = pt - 1      
      dt = "PT "..right(" "..pt,2).." Level Range"
      if pt<=0 then return("No foe levels set, ignoring foe request!") end
      end 
local lvrange = mysplit(Maps.GetData(dt),"-")
if #lvrange<2 then GALE_Error("Level range for playthrough #"..pt.." not properly set up!") end
for i,v in ipairs(lvrange) do lvrange[i] = Sys.Val(v) end
if lvrange[2]<lvrange[1] then GALE_Error("Negative level range for playthrough #"..pt) end             
for i=1,num do             
    Var.D("$COMBAT.FOE"..i,monsters[rand(1,#monsters)])
	  Var.D("%COMBAT.LVFOE"..i,rand(lvrange[1],lvrange[2]))
end	  
-- Var.D("$COMBAT.VICTORYCHECK","Phantasar") -- Needed if I want the Dyrt victory tune played, but that is not yet certain.
-- Sys.Error("Random Encounters not yet scripted!")
StartCombat() 
end
    



-- flow
function PhantasarFlow()
	-- Dung Titles
	DungTitleShow()
end

MAP_FLOW = MAP_FLOW or PhantasarFlow
