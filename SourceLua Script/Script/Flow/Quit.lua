--[[
  Quit.lua
  Version: 16.06.02
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

function InitItems()
-- @IF ALLOW_QUITSAVE
QuitMenuItems = {

     { Display = "Save",
       Help = "This will allow you to save the game at this spot\nPlease note that this savegame will be deleted once you load it\nYou find this game under user \"System\" as \"Quit Game\".",
       Action = function()
                LAURA.Flow("FIELD") -- Needed otherwise the savegame will contain the wrong FLOW data.
                Image.Cls()
                setfont("SaveName")
                Red()
                Image.DText("Saving",400,300,2,2)
                Flip()
                LAURA.Save("System/Quit Game",1)
                LAURA.KillSaveGame("System/Emergency")
                Sys.Bye()
                end,
       Disabled = CVV('&BLOCK.EMERGENCY.SAVE')          
      },
     { Display = "Don't Save",
       Help    = "Don't save, just quit the game immediately",
       Action  = Sys.Bye
       },
     { Display = "Cancel",
       Help    = "Don't quit and go back to the game",
       Action = function() LAURA.Flow("FIELD") MS.Destroy("QUIT") end
       }
   }
-- @ELSE   
QuitMenuItems = {

     { Display = "Quit",
       Help    = "Quit the game. Unsaved progress will be lost!",
       Action  = Sys.Bye
       },
     { Display = "Cancel",
       Help    = "Don't quit and go back to the game",
       Action = function() LAURA.Flow("FIELD") MS.Destroy("QUIT") end
       }
   }
-- @FI   
end

function GALE_OnLoad()
InitItems()
--[[
for item in each(QuitMenuItems) do
    CSay('-- Quit item --')
	  for k,v in pairs(item) do
	     CSay(k.." = "..sval(v))
	     end
	  end
--]]	     
end

function MAIN_FLOW()
local x = 400
local y = 300
local selection,item
local mx,my = MouseCoords()
local th
White()
Image.Cls()
SetFont("CombatPlayerInput")
for item in each(QuitMenuItems) do
    th = Image.TextHeight(item.Display)
    if my>y-(th/2) and my<y+(th/2) then
    	 if item.Disabled then
    	 	  Image.Color(80,80,80)
    	 	  selection=nil
    	 else	    	 
         selection = item       
         Image.Color(0,255,255)
         end
    else
    	 if item.Disabled then
    	 	  Image.Color(60,60,60)
    	 else	    	 
          Image.Color(0,180,255)
          end
       end
    Image.DText(item.Display,x,y,2,2)
    y = y + Image.TextHeight(item.Display)           
    end
SetFont("MiniMessage")
y = 10    
if selection then
   if INP.MouseH(1)==1 then selection.Action() end
   White()
   for l in each(mysplit(selection.Help,"\n")) do
       Image.DText(l,x,y,2,2)
       y = y + Image.TextHeight(l)
       end
   end    
ShowParty()
ShowMouse()
Flip()
if INP.Terminate==1 then
   MINI("Weren't you already trying to quit?",255,0,0)
   MINI("Please answer the question above and we can quit quite nicely",255,0,0)
   MINI("Please don't be hasty!",255,0,0)
   end 
end
