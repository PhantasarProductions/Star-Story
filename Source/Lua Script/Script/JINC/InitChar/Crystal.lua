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
--Sys.Error("Crystal not yet ready")
local f = loadstring(JCR6.LoadString("Script/JINC/InitChar/Share/Crystal.lua")); f()


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


local ignoreprefixes = {"AMMO","UPGRADE_","BASE_","BUFF_","END_"}
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
    Console.Write("UniCrystal - Crystal: Linking "..k,180,0,255)    
    fields = mysplit(d.F("UniCrystal"),";")
    for i,v in ipairs(fields) do
        ok = true
        for ii,iv in ipairs(ignoreprefixes)  do ok = ok and (not prefixed(v,iv)) end    
        for ii,iv in ipairs(ignorefullnames) do ok = ok and v~=iv end
        if ok then
           Console.Write("UniCrystal - Crystal: Linking "..k..": "..v,0,180,255)
           d.L("UniCrystal","Crystal",v)
           end
        end   
    end


RPGChar.SetData("Crystal","Pic","GENERAL")
RPGChar.DefStat("Crystal","PXM",26)
