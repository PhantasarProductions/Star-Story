--[[
  AutoUse.lua
  
  version: 15.09.22
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
-- @USEDIR Script/Use/Anyway

ROOM_ME = Maps.CodeName

ThisIsAMapScript = true

-- Load the map scenario if available
function InitMapText()
MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
MS.Run("BOXTEXT","RemoveData","MAP")
-- Well, we MUST avoid "if"s, eh? Well, let me show you what kind of dirty code that can create.
local maptextfile = "Languages/"..Var.C("$LANG").."/Scenario/MAPS/"..Maps.CodeName
local letsgo = { 
  [0] = function() Console.Write("WARNING! No maptext found for map "..Maps.CodeName,255,180,0); Console.Write(">> "..maptextfile,0,180,255) end,
  [1] = function() MS.Run("BOXTEXT","LoadData","MAPS/"..Maps.CodeName..";MAP"); Console.Write("MapText for "..Maps.CodeName.." loaded",0,255,180) end }
local f = letsgo[JCR6.Exists(maptextfile)]
f()
-- Well, you gotta agree this could been done in a more efficient way :P
-- Oh yeah, Lua does accept 0 for an array index, it's rather that ipairs doesn't pick that up, but we didn't need ipairs anyway here :P   
-- I could not yet use the functions from BoxTextLinker, as they are not loaded on the moment this function is called, for the other functions, it doesn't matter.
end; InitMapText()

function MapText(tag,mapaltMS)
SerialBoxText("MAP",tag,mapaltMS or "FIELD")
end


-- The Zone Action routines
ZA = { Enter = {}, Leave = {}, Flow = {} }
ZAChkEnter = {}
ZAChkLeave = {}

function ZA_SetAction(Z,A,F)
table.insert(ZA[A],{Z = Z, F = F})
end

function ZA_Enter(Z,F)
ZA_SetAction(Z,"Enter",F)
end

function ZA_Leave(Z,F)
ZA_SetAction(Z,"Leave",F)
end

function ZA_Flow(Z,F)
ZA_SetAction(Z,"Flow",F)
end

function ZA_Run(Z,A)
local F
for f in ipairs(ZA[Z][A]) do f() end
end

function ZA_CheckEnter(actor)
local b
local ZK,ZZ 
for ZK,ZZ in pairs(ZA.Enter) do
    if ROOM_ME==Maps.CodeName then
       b = Maps.ActorInZone(actor,ZZ.Z)==1
       if (not ZAChkEnter[ZZ.Z]) and b then ZZ.F() end
       ZAChkEnter[ZZ.Z] = b
       end 
    end
end

function ZA_CheckLeave(actor)
local b
local ZK,ZZ 
for ZK,ZZ in pairs(ZA.Leave) do
    b = Maps.ActorInZone(actor,ZZ.Z)==1
    if ZAChkLeave[ZZ.Z] and (not b) then ZZ.F() end
    ZAChkLeave[ZZ.Z] = b 
    end
end

function ZA_CheckFlow(actor)
local b
local ZK,ZZ 
for ZK,ZZ in pairs(ZA.Flow) do
    b = Maps.ActorInZone(actor,ZZ.Z)==1
    if b then ZZ.F() end
    end
end

function ResetClickables()
MS.LN_Run("FIELD","Script/Flow/Field.lua","ResetClickables")
end; ResetClickables() -- Yeah, it must always be executed when a new map is loaded, and this way, that will always happen :)

function RemoveClickable(c)
MS.Run("FIELD","RemoveClickable",c)
end

function AddClickable(c)
MS.Run("FIELD","AddClickable",c)
end

function DrawScreen()
MS.Run("FIELD","DrawScreen")
end

function NPC_MapText()
TurnPlayer("North")
MapText(upper(Var.C("$NPC_MAPTEXT")))
end

function CharMapText(Tag)
local a = GetActive()
local t = upper (Tag.."."..a)
MapText(t)
end

function RecoverParty(dontresetap)
local ak,ch,hp,ap,arm
for ak=0,5 do
    ch = RPGChar.PartyTag(ak)
    if ch~="" then
       hp = RPGChar.Points(ch,"HP")
       ap = RPGChar.Points(ch,"AP")
       if skill>=2 and (not dontresetap) then ap.Have=0 end
       hp.Have = hp.Maximum
       end
    if ch=="Crystal" and (not dontresetap) then -- Reload all ARMS
       for arm in each(mysplit(RPGChar.PointsFields('Crystal'))) do
           if prefixed(arm,"ARM.AMMO") then RPGChar.Points(ch,arm).Have = RPGChar.Points(ch,arm).Maximum end
           end
       end   
    end
end

function RecoveryPad()
end
