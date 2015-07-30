--[[
/*
	
	
	
	
	
	(c) , , All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
*/


Version: 15.07.30

]]
ActionFuncs = {}

function ActionFuncs.Error(g,i,act)
Sys.Error("Unknown Action Tag: "..sval(act.Act))
end

function ActionFuncs.SHT(ag,ai,act)
local ch = FighterTag(ag,ai) --RPGChar.PartyTag(ag,ai)
if RPGChar.Points(ch,"AMMO",1).Have<=0 then return MINI(RPGChar.Name(ch).." cannot shoot! Out of ammo!") end
local tg,ti = TargetFromAct(act)
CSay(sval(ag).."["..sval(ai).."]: "..sval(ch).." shoots")
-- Animate character 
--[[ Comes later ]]
-- SpellAni for the projectile
RPGChar.NewData(ch,"ShootSpellAni","PhotonGun") -- If not properly set, we'll assume the photon gun animation is required. 
SpellAni[RPGChar.GetData(ch,"ShootSpellAni")](ag,ai,tg,ti)
-- Perform Attack
Attack(ag,ai,act)
-- Remove one bullet
RPGChar.Points(ch,"AMMO").Have = RPGChar.Points(ch,"AMMO",1).Have - 1
end

function ActionFuncs.RLD(ag,ai,act)
end 
