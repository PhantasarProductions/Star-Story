--[[
/**********************************************
  
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
  
  
 **********************************************/
 



Version: 15.07.20

]]
--[[
Sys.Error("Wendicka not yet ready")

local f = loadstring(JCR6.LoadString("Script/JINC/InitChar/Share/Wendicka.lua")); f()
]]
local ignoreprefixes = {"AMMO"}
local ignorefullnames = {"Pic","PXM"}

local procedure = { 
    Stat   = { F = RPGStat.StatFields,   L = RPGStat.LinkStat   },
    Data   = { F = RPGStat.DataFields,   L = RPGStat.LinkData   },
    Points = { F = RPGStat.PointsFields, L = RPGStat.LinkPoints }
    }

local i,v
local k,d
local ii,iv
local fields
local ok
for k,d in pairs(procedure) do
    fields = mysplit(d.F("UniWendicka"),";")
    for i,v in ipairs(fields) do
        ok = true
        for ii,iv in ipairs(ignoreprefixes)  do ok = ok and (not prefixed(v,iv)) end    
        for ii,iv in ipairs(ignorefullnames) do ok = ok and v~=iv end
        if ok then
           CSay("UniWendicka - Wendicka: Linking "..k..": "..v)
           d.L("UniWendicka","Wendicka",v)
           end
        end   
    end


RPGChar.SetData("Wendicka","Pic","GENERAL")
RPGChar.DefStat("Wendicka","PXM",52)
