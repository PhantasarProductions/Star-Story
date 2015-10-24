--[[
  AutoUse.lua
  
  version: 15.10.24
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

-- @USEDIR Script/Use/AnyWay




-- This file contains all basic definitions.
-- If any alterations are required, take a look in the General.Lua file

-- This file is pretty general, so I don't expect any references to the story line here
-- But if there are any, they must all be removed before you can use it under the terms of the zlib license.and




function ENDSTAT(ch,stat)
local r = 0
local i,v
for i,v in ipairs( { "BASE_", "UPGRADE_", "POWERUP_", "BUFF_" }) do r = r + RPGStat.Stat(ch,v..stat) end
--CSay(ch.."."..stat.." ==> "..r)
RPGStat.DefStat(ch,"END_"..stat,r)
-- if LAURA.GetFlow()=="COMBAT" then MS.Run("COMBAT","PerformAltStat",ch,stat) end -- This line will adept a stat if there's a status change telling the game to do so.
end

function CALC_Strength(ch)    ENDSTAT(ch,"Strength") end
function CALC_Defense(ch)     ENDSTAT(ch,"Defense") end
function CALC_Will(ch)        ENDSTAT(ch,"Will") end
function CALC_Resistance(ch)  ENDSTAT(ch,"Resistance") end
function CALC_Agility(ch)     ENDSTAT(ch,"Agility") end
function CALC_Accuracy(ch)    ENDSTAT(ch,"Accuracy") end
function CALC_Evasion(ch)     ENDSTAT(ch,"Evasion") end
function CALC_HP(ch)          ENDSTAT(ch,"HP") end
function CALC_AP(ch)          ENDSTAT(ch,"AP") end


--[[ Values
     0 - Fatal
     1 - Very Weak
     2 - Weak
     3 - Standard
     4 - Half
     5 - Immune
     6 - Absorb
]]     
function ELEMRESIST(ch,element)
local ret = 3
RPGStat.DefStat(ch,"ER_"..element,ret)
end


function ER_Fire(ch)         ELEMRESIST(ch,"Fire") end
function ER_Wind(ch)         ELEMRESIST(ch,"Wind") end
function ER_Water(ch)        ELEMRESIST(ch,"Water") end
function ER_Earth(ch)        ELEMRESIST(ch,"Earth") end
function ER_Light(ch)        ELEMRESIST(ch,"Light") end
function ER_Dark(ch)         ELEMRESIST(ch,"Dark") end
function ER_Lightning(ch)    ELEMRESIST(ch,"Lightning") end
function ER_Frost(ch)        ELEMRESIST(ch,"Frost") end


function TRUESTATUSRESIST(ch,status)
local r = 0
local stat = Str.Replace(status,"EQ_TRUE_","")
for i,v in ipairs( { "BASE_", "BUFF_", "EQBF_" }) do 
    r = r + RPGStat.SafeStat(ch,"SR_"..v..stat)
    -- CSay(ch.."."..v..stat.." = "..RPGStat.SafeStat(ch,"SR_"..v..stat).." >> "..r) 
    end
--CSay(ch.."."..stat.." ==> "..r)
if r>100 then r=100 end
RPGStat.DefStat(ch,"SR_TRUE_"..stat,r)
end

function STATUSRESIST(ch,status)
return TRUESTATUSRESIST(ch,Str.Replace(status,"SR_TRUE_",""))
end

function AMMO(ch)
local r = RPGChar.Stat(ch,"AMMO_BASE") + RPGChar.Stat(ch,"AMMO_UPGRADE")
RPGChar.DefStat(ch,'AMMO',r)
return r
end 
