--[[
/* 
  Level Caps

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



Version: 15.04.16

]]
function GetBaseLevelsAndCaps()
local llevelcaps = { 
    { 250, 500, 1000, 5000, 10000 }, -- Easy Mode
    { 200, 400, 750,  4500, 7500, 10000}, -- Medium Mode
    { 150, 300, 500,  3000, 5000, 6000, 10000} -- Hard Mode
    }
local lbaselevels = {
      { 0 }, -- Easy Mode
      { 2 }, -- Medium Mode
      { 5 }  -- Hard Mode
    } 
if skill==0 then skill=2 end    
skill = skill or 2
MaxLevel = llevelcaps[skill or 2][ngpcount] or 10000    
end 


GetBaseLevelsAndCaps()
