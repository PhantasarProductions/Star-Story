--[[
/* 
  Load Foe - Star Story

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



Version: 15.07.27

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
if rng==0 then rng=1 end
RPGChar.DefStat(Foe.Tag,"Level",Foe.Level)
RPGChar.SetName(Foe.Tag,FoeData.Name)
for ckey,cvalue in spairs(FoeData.Stat) do
    sint = math.abs(cvalue[2]-cvalue[1])
    sinc = sint / rng
    --CSay("Compiling stat: "..ckey)
    if Foe.Level<lvmin then 
       ldif = lvmin - Foe.Level
       RPGStats.DefStat(Foe.Tag,"BASE_"..ckey,round(cvalue[1]-(sinc*ldif)))
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
-- Steal and drops
Foe.ItemDrop = {}
Foe.ItemSteal = {}
for ckey,cvalue in ipairs(FoeData.ItemDrop)  do if cvalue.LVL>=Foe.Level then table.insert(Foe.ItemDrop ,cvalue) end end
for ckey,cvalue in ipairs(FoeData.ItemSteal) do if cvalue.LVL>=Foe.Level then table.insert(Foe.ItemSteal,cvalue) end end
-- Load the pictures
Image.AssignLoad("O"..Foe.Tag,"GFX/Foes/"..FoeData.ImageFile)  
Image.Negative("O"..Foe.Tag,"N"..Foe.Tag)  
Image.Hot("O"..Foe.Tag,Image.Width("O"..Foe.Tag)/2,Image.Height("O"..Foe.Tag))
Image.Hot("N"..Foe.Tag,Image.Width("N"..Foe.Tag)/2,Image.Height("N"..Foe.Tag))
end
