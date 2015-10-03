--[[
  CLoadFoe.lua
  Version: 15.10.03
  Copyright (C) 2015 Jeroen Petrus Broks
  
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
function LoadFoe(Foe,Data)
local FoeData
local paths = {"","Reg/","Boss/","Special/"}
local v,file,checkfile
file = nil
for _,path in ipairs(paths) do
    checkfile = "Script/JINC/Foes/"..path..Foe.File..".lua"
    -- CSay("Searching for: "..checkfile)
    if JCR6.Exists(checkfile)==1 then file=checkfile end
    end
if not file then Sys.Error(Foe.File.." not found in any of the allowed directories") end
FoeData = JINC(file)
if not FoeData then Sys.Error("Either no data returned or a faulty foe load script","File,"..file) end
RPGChar.CreateChar(Foe.Tag)
-- Compile the data to get the right stats of the right level
local ckey,cvalue
local lvrange = FoeData.Stat.LevelRange
local lvmin = lvrange[1]
local lvmax = lvrange[2]
local rng = math.abs(lvmax - lvmin)
local sint,sinc,ldif
local i1,v1
local tstat
if rng==0 then rng=1 end
if Foe.Level<1 then Foe.Level=1 end
RPGChar.DefStat(Foe.Tag,"Level",Foe.Level)
RPGChar.SetName(Foe.Tag,FoeData.Name)
for ckey,cvalue in spairs(FoeData.Stat) do
    sint = math.abs(cvalue[2]-cvalue[1])
    sinc = sint / rng
    --CSay("Compiling stat: "..ckey)
    if Foe.Level<lvmin then 
       ldif = lvmin - Foe.Level
       tstat = round(cvalue[1]-(sinc*ldif))
       if tstat<5 then tstat = 5 end
       RPGStats.DefStat(Foe.Tag,"BASE_"..ckey,tstat)
       CSay("Setting BASE_"..ckey.." (neg)")       
    else   
       ldif = Foe.Level - lvmin
       RPGStats.DefStat(Foe.Tag,"BASE_"..ckey,round(cvalue[1]+(sinc*ldif)))
       --CSay("Setting BASE_"..ckey.." (pos)")       
       end       
    for i1,v1 in ipairs( { "UPGRADE_", "POWERUP_", "BUFF_", "END_"}) do
        RPGChar.DefStat(Foe.Tag,v1..ckey,0)
        --CSay("Added Stat: "..v1..ckey)
        end
    RPGChar.ScriptStat(Foe.Tag,"END_"..ckey,"Script/CharStats/General.lua","CALC_"..ckey)    
    end
RPGStat.Points(Foe.Tag,"HP",1).MaxCopy = "END_HP"
RPGStat.Points(Foe.Tag,"HP").Have = RPGStat.Points(Foe.Tag,"HP").Maximum    
-- Elemental resistances
for k,v in spairs(FoeData) do
    if prefixed(k,"EleRes_") then RPGStat.DefStat(Foe.Tag,replace(k,"EleRes_","ER_"),v) end
    end 
-- Steal and drops
Foe.ItemDrop = {}
Foe.ItemSteal = {}
for ckey,cvalue in ipairs(FoeData.ItemDrop)  do if cvalue.LVL<=Foe.Level then table.insert(Foe.ItemDrop ,cvalue) end end
for ckey,cvalue in ipairs(FoeData.ItemSteal) do if cvalue.LVL<=Foe.Level then table.insert(Foe.ItemSteal,cvalue) end end
-- Actions (only needed for the Default AI setting)
Foe.Actions = {}
for cvalue in each(FoeData.Acts) do
    if Foe.Level>=FoeData.ActMinLevel[cvalue] then table.insert(Foe.Actions,cvalue) end -- Only add the move if the level allows it
    end
Foe.AI=FoeData.AI    
-- Load the pictures
Image.AssignLoad("O"..Foe.Tag,"GFX/Combat/Fighters/Foe/"..FoeData.ImageFile)  
Image.Negative("O"..Foe.Tag,"N"..Foe.Tag)  
Image.Hot("O"..Foe.Tag,Image.Width("O"..Foe.Tag)/2,Image.Height("O"..Foe.Tag))
Image.Hot("N"..Foe.Tag,Image.Width("N"..Foe.Tag)/2,Image.Height("N"..Foe.Tag))
end
