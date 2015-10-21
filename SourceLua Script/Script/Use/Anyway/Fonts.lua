--[[
  Fonts.lua
  
  version: 15.10.15
  Copyright (C) 2015 Jeroen P. Broks
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
/* 
  Fonts List

  Copyright (C) 2015 Jeroen P. Broks

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

*/



Version: 15.08.26

]]



-----------------------------
-- Definition of all fonts --
-----------------------------


fonts = {

    -- BoxText = {"SuperSoulFighter.ttf",20} -- Font unreadable, but I'll keep this line in case nothing better comes my way
    BoxText = {"Robotica.ttf",20},
    Tutorial = {"Robotica.ttf",10},
    StatusBar = {"Robotica.ttf",15},
    StatusName = {"Robotica.ttf",30},
    StatusStat = {"Robotica.ttf",15},
    AbilityList = {"Robotica.ttf",15},
    AchievementHeader = {"Robotica.ttf",25},
    AchievementDescription = {"Robotica.ttf",15},
    AbilityList = {"Robotica.ttf",15},
    ItemHeader = {"Robotica.ttf",25},
    ItemDescription = {"Robotica.ttf",15},
    SaveName = {"Robotica.ttf",20},
    SaveFiles = {"Robotica.ttf",14},
    MiniMessage = {"Robotica.ttf",10},  -- The routines are in party in order to operate more smoothly with the party screen at the bottom of the screen.
    CombatPlayerInput = {"Robotica.ttf",40},
    CombatMessage = {"Robotica.ttf",35},
	LayerInField = {"Robotica.ttf",12}
	
}


--------------------------------------
-- And the function to set the font --
--------------------------------------
function SetFont(font)
if not fonts[font] then CSay("WARNING! Font "..sval(font).." does not exist in the list!") end
if not fonts[font][1] then CSay("WARNING! Font "..sval(font).." does not refer to a file!") end
Image.Font("Fonts/"..fonts[font][1],fonts[font][2])
end

setfont = SetFont
