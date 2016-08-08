--[[
 **********************************************
  
  This file is part of a closed-source 
  project by Jeroen Petrus Broks and should
  therefore not be in your pocession without
  his permission which should be obtained 
  PRIOR to obtaining this file.
  
  You may not distribute this file under 
  any circumstances or distribute the 
  binary file it procudes by the use of 
  compiler software without PRIOR written
  permission from Jeroen P. Broks.
  
  If you did obtain this file in any way
  please remove it from your system and 
  notify Jeroen Broks you got it somehow. If
  you have downloaded it from a website 
  please notify the webmaster to remove it
  IMMEDIATELY!
  
  Thank you for your cooperation!
  
  
 **********************************************
Wendicka.lua
(c) 2015 Jeroen Petrus Broks
Version: 15.09.18
]]

function mysplit(inputstr, sep) -- I had to copy this, as loadstring includes do not support the compiler directives of GALE.
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
end

function prefixed(s,p) return Str.Prefixed(s,p)==1 end


local ignoreprefixes = {"AMMO","UPGRADE_"}
local ignorefullnames = {"Pic","PXM"}

local procedure = { 
    Stat   = { F = RPGStat.StatFields,   L = RPGStat.LinkStat   },
    Data   = { F = RPGStat.DataFields,   L = RPGStat.LinkData   },
    Points = { F = RPGStat.PointsFields, L = RPGStat.LinkPoints },
    List   = { F = RPGStat.ListFields,   L = RPGStat.LinkList   }
    }

local i,v
local k,d
local ii,iv
local fields
local ok
for k,d in pairs(procedure) do
    Console.Write("UniWendicka - Wendicka: Linking "..k,180,0,255)    
    fields = mysplit(d.F("UniWendicka"),";")
    for i,v in ipairs(fields) do
        ok = true
        for ii,iv in ipairs(ignoreprefixes)  do ok = ok and (not prefixed(v,iv)) end    
        for ii,iv in ipairs(ignorefullnames) do ok = ok and v~=iv end
        if ok then
           Console.Write("UniWendicka - Wendicka: Linking "..k..": "..v,0,180,255)
           d.L("UniWendicka","Wendicka",v)
           end
        end   
    end


RPGChar.SetData("Wendicka","Pic","GENERAL")
RPGChar.DefStat("Wendicka","PXM",52)
