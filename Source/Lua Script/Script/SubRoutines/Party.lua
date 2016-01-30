--[[
  Party.lua
  Version: 15.11.24
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

-- @USEDIR Script/Use/Sub/Party

statusbar = Image.Load("GFX/Statusbar/StatusBar.png")
portret = {}
levelupanim = {}

needexp = {1750,5000,10000}

XCharLvUp = {}
XCharSyncLevel = {}

function GrabLevel(ch,lv)
local linenumber,line,l
local ls,cs,clv
local lext = 0,t
if lv>=100 then
   t = ""..lv
   lext = left(t,len(t)-2)
   end
CSay("Getting stats for "..ch.." for "..lv.." from series "..lext)   
for linenumber,line in ipairs(jcr6listfile("Data/LvStats/"..ch.."/"..lext)) do
    l = Str.Trim(line)    
    ls = mysplit(l," ")
    if l~="" and ls[1]~="REM" then
       if #ls<2 then CSay("WARNING! Wrongly setup line in char "..ch.." file "..lext.." line #"..linenumber) return end
       cs = mysplit(ls[1],".")
       if ls[1]=="LEVEL" then clv = Sys.Val(ls[2])
       elseif cs[1]=="STAT" and clv==lv then
          RPGChar.DefStat(ch,"BASE_"..cs[2],Sys.Val(ls[2]))
          CSay("Char "..ch.." BASE_"..cs[2].." is now "..Sys.Val(ls[2]))
          end
       end
    end
RPGChar.DefStat(ch,"Level",lv)    
end

function SyncLevel(ch)
GrabLevel(ch,RPGChar.Stat(ch,"Level"))
;(XCharSyncLevel[ch] or function() end)()
end

function InitCharacter(ch)
local ak
CSay("Creating character")
RPGChar.CreateChar(ch)
CSay("Setting default name")
RPGChar.SetName(ch,ch)
CSay("Setting default picture")
RPGChar.SetData(ch,"Pic","GENERAL")
-- Before setting anything else let's first put up the initial data
for i2,v2 in ipairs( { "Strength","Defense","Will","Resistance","Agility","Accuracy","Evasion","HP","AP"}) do
    for i1,v1 in ipairs( { "BASE_", "UPGRADE_", "POWERUP_", "BUFF_", "END_"}) do
        RPGChar.DefStat(ch,v1..v2,0)
        end
    RPGChar.ScriptStat(ch,"END_"..v2,"Script/CharStats/General.lua","CALC_"..v2)    
    end
-- And now default level
RPGChar.DefStat(ch,"Level",1)
-- X pixel modifier on the status bar
RPGChar.SetStat(ch,"PXM",0)
-- Experience
RPGChar.Points(ch,"EXP",1).Maximum = needexp[skill] or 5000
if RPGChar.Points(ch,"EXP",1).Maximum==0 then RPGChar.Points(ch,"EXP",1).Maximum=5000 end -- Dirty code straight from hell, but it will have to do for now.
-- Inventory
for ak=1,InventorySockets do
    RPGChar.SetData(ch,"INVITEM"..ak,"")
    RPGStat.SetStat(ch,"INVAMNT"..ak,0)
    end
-- Ammo if applicable
RPGChar.DefStat(ch,"AMMO_BASE",0)
RPGChar.DefStat(ch,"AMMO_UPGRADE",0)
RPGChar.DefStat(ch,"AMMO",0)    
RPGChar.ScriptStat(ch,"AMMO","Script/CharStats/General.lua","AMMO")    
RPGChar.Points(ch,"AMMO",1).MaxCopy = "AMMO"
RPGChar.Points(ch,"AMMO").Have = RPGChar.Points(ch,"AMMO").Maximum
-- Which spell layout do we need?
RPGChar.SetData(ch,'ABLTYPE',"ABL")
-- Create spell list
RPGChar.CreateList(ch,"ABL")    
RPGChar.CreateList(ch,"ABL_POWERUP")
-- Elemental Resistance
for _,element in ipairs({"Fire","Wind","Water","Earth","Light","Dark","Lightning","Frost"}) do
   CSay("Standard setup element: "..element) 
   RPGChar.DefStat(ch,"ER_"..element,3)
   RPGChar.ScriptStat(ch,"ER_"..element,"Script/CharStats/General.lua","ER_"..element)        
   end
-- Basic values for status resistances
for status in iStatus(true) do
    CSay("Standard setup status: "..status)
    RPGChar.DefStat(ch,"SR_BASE_"..status,0)
    RPGChar.DefStat(ch,"SR_BUFF_"..status,0)
    RPGChar.DefStat(ch,"SR_EQBF_"..status,0)
    RPGChar.DefStat(ch,"SR_TRUE_"..status,0)
    RPGChar.ScriptStat(ch,"SR_TRUE_"..status,"Script/CharStats/General.lua","STATUSRESIST")
    end   
RPGChar.DefStat(ch,"ER_Healing",6)
RPGChar.DefStat(ch,"ER_NonElemental",3)    
-- Scripted stuff
Var.D("$INITCHAR",ch)
jinc("Script/JINC/InitChar/"..ch..".lua")
Console.Write("Loading script character "..ch.." has been completed")
Var.Clear("$INITCHAR")
-- Get the level data
CSay("Grabbing level")
GrabLevel(ch,RPGChar.Stat(ch,"Level"))
-- Points
CSay("Initiating HP and AP")
RPGChar.Points(ch,"HP",1).MaxCopy = "END_HP"
RPGChar.Points(ch,"AP",1).MaxCopy = "END_AP"
RPGChar.Points(ch,"HP").Have = RPGChar.Points(ch,"HP").Maximum
RPGChar.Points(ch,"AP").Have = 0
if skill==1 then RPGChar.Points(ch,"AP").Have = RPGChar.Points(ch,"AP").Maximum end
RPGChar.Points(ch,"AMMO").Have = RPGChar.Points(ch,"AMMO").Maximum 
-- Learnlist
RPGChar.CreateList(ch,"LEARN") -- When this list contains any items (ability names), the first one in the list will be learned the next time the character performs a normal attack. This goes for all characters except Briggs and Crystal.
CSay("Initiated character: "..ch)
end

function Party(...)
RPGChar.NewParty(6)
if #arg>6 then Sys.Error("Party too big "..#arg) end
local ak,v
CSay("Initiating party...")
for ak,v in ipairs(arg) do
    CSay("Position #"..ak..": "..v)
    if RPGChar.CharExists(v)==0 then InitCharacter(v) end
    CSay("Updating party")
    RPGChar.SetParty(ak-1,v) -- Remember for Lua everything starts at 1, but for nearly every other language (including BlitzMax) everything starts at 0.
    CSay("All done... next") 
    end    
end


-- This has been put in the party routine, in order to make it operate fluently with the character screen
function Mini(msg,r,g,b)
SetFont("MiniMessage")
local newm = {msg = msg or "?", r = Sys.Val(r or 255), g = Sys.Val(g or 255), b = Sys.Val(b or 255), y = 490, x = 810 + Image.TextWidth(msg), timer=1000 }
miniarray = miniarray or {}
if #miniarray<50 then table.insert(miniarray,newm) end
end

function ShowGenData()
local function dshow(s) return s.value end
local Show = {
    {
       name  = "Aurinas",
       value = CVVN("%AURINAS")        
    },
    {
       name  = "Credits",
       value = CVVN("%CASH")
    },
    {     
       name  = "Time",
       value = CVVN("%PLAYTIME"),
       show  = function()
               local sec,min,hr
               local ret = ""
               --[[
               sec = CVV("%PLAYTIME")
               while         sec>=60 do sec=sec-60 min=(min or 0)+1 end
               while min and min>=60 do min=min-60 hr =(hr  or 0)+1 end
               ret = sec..'"'
               if min and sec<10 then ret = "0"..ret end
               if min then ret = min.."'"..ret end
               if hr and min and min<10 then ret="0"..ret end
               if hr then ret = hr.."h"..ret end]]
               sec = CVVN("%PLAYTIME.SEC")
               min = CVVN("%PLAYTIME.MIN")
               hr  = CVVN("%PLAYTIME.HR")
               if sec and sec>0 then ret = sec..'"'         if min and sec<10 then ret = "0"..ret end end
               if min and min>0 then ret = min.."'"..ret    if hr  and min<10 then ret = "0"..ret end end
               if  hr and  hr>0 then ret = hr .."h"..ret    end
               return ret
               end 
    }
}
local y = 500
SetFont("MiniMessage")
for s in ieach(Show) do
    -- CSay("Showing: "..s.name)
    if s.value then
       DarkText(s.name..": "..(s.show or dshow)(s),780,y,1,1,255,180,0) -- This is extremly dirty code, but it works.
       y = y - Image.TextHeight(s.name)         
       end
    end
end


function ShowMini()
if not miniarray then return ShowGenData() end
if #miniarray==0 then return ShowGenData() end
local dimmer = 0.5 + (math.abs(math.sin(Time.MSecs()/500))/2)
local i,v
-- Show
SetFont("MiniMessage")
for i,v in ipairs(miniarray) do
    DarkText(v.msg,v.x,v.y,1,1,v.r*dimmer,v.g*dimmer,v.b*dimmer)
    if i<#miniarray and v.x<=790 and v.y>miniarray[i+1].y-15 then v.y=v.y-1 end
    if v.x>790 and (i==1 or miniarray[i-1].y<=v.y-15) then
       v.x = v.x - 2
       if v.x<790 then v.x=790 end
       end
    if v.x<=790 then v.timer = v.timer - 1 end            
    end
-- Remove outdated first rank.
if miniarray[1].timer<=0 or (miniarray[1].x<=790 and #miniarray>20) then table.remove(miniarray,1) end
end

function ShowCharacterPic(ch,pos)
if ch=="" then return end
-- If the portraits are not loaded, then load them respectively (very important when you just loaded a savegame)
local k,i,tag,rec
local picfile,picref
local sx=pos*200
local chd = ch
if left(ch,3)=="Uni" then chd = replace(ch,"Uni","") end
picfile = "GFX/Portret/"..sval(chd).."/"..RPGChar.GetData(ch,"Pic")..".png"
picref = upper(chd).."."..upper(RPGChar.GetData(ch,"Pic"))
if JCR6.Exists(picfile)==0 then CSay("WARNING! Cannot find: "..picfile) end
if Image.Exist(picref)==0 and JCR6.Exists(picfile)==1 then 
   Image.AssignLoad(picref,picfile) 
   portret[picref]=true 
   CSay('Loaded '..picfile..' on '..picref.." (party)") 
elseif Image.Exist(picref)==1 then 
   portret[picref]=true 
   end
if not portret[picref] then
  Image.DText("ERROR: "..ch,sx,500) 
  return 
  end  
-- Show the portaits themselves
Image.Draw(picref,sx-RPGChar.Stat(ch,"PXM"),600-Image.Height(picref))
end

function RecoverChar(ch)
RPGStat.Points(ch,"HP").Have = RPGStat.Points(ch,"HP").Maximum
RPGStat.Points(ch,"AP").Have = RPGStat.Points(ch,"AP").Maximum
end

function LevelUp(ch,pos)
   local lv = RPGStat.Stat(ch,"Level")
   RPGStat.DefStat(ch,"Level",lv+1) 
   GrabLevel(ch,RPGChar.Stat(ch,"Level"));
   RPGStat.Points(ch,"EXP").Have=0
   if RPGStat.Points(ch,"HP").Have>0 then
      ({ 
	  [1] = function() RPGStat.Points(ch,"HP").Have = RPGStat.Points(ch,"HP").Maximum RPGStat.Points(ch,"AP").Have = RPGStat.Points(ch,"AP").Maximum end,
      [2] = function() RPGStat.Points(ch,"HP").Have = RPGStat.Points(ch,"HP").Maximum end,
      [3] = function() end })[skill](ch)
	end
   if RPGStat.Stat(ch,"Level")>=MaxLevel then RGPStat.Points(ch,EXP).Maximum=0 end   
   ;(XCharLvUp[ch] or function() end)()
end   


function ShowStats(ch,pos)
if ch=="" then return end
local col = math.abs(math.sin(Time.MSecs()/1000)*100)
local sx=pos*200
local hp,hpm = RPGChar.Points(ch,"HP").Have,RPGChar.Points(ch,"HP").Maximum
local hpcol = (hp/hpm)*255
local hpbar = (hp/hpm)*100
local ap,apm = RPGChar.Points(ch,"AP").Have,RPGChar.Points(ch,"AP").Maximum
local apbar = (ap/apm)*100
local ep,epm = RPGChar.Points(ch,"EXP").Have,RPGChar.Points(ch,"EXP").Maximum
local epbar 
if epm>0 then epbar = (ep/epm)*100 else epbar = 0 end
local lv = RPGChar.Stat(ch,"Level")
SetFont("StatusBar")
Image.Color(80,80,80)
Image.Rect(sx+95,540,100,2) 
Image.Color(255-hpcol,hpcol,0)
Image.Rect(sx+95,540,hpbar,2) 
DarkText(hp,sx+195,525,1,0,255-hpcol,hpcol,col)
if Image.TextWidth(hp)<100 then DarkText("HP",sx+95,525,1,0,255-hpcol,hpcol,col) end
if apm>0 then -- Only display the AP if the character actually has AP. Crystal and Briggs don't have AP and will never get it either.
   Image.Color(80,80,80)
   Image.Rect(sx+95,565,100,2) 
   Image.Color(0,0,255)
   Image.Rect(sx+95,565,apbar,2) 
   DarkText(ap,sx+195,550,1,0,col,col,255)
   if Image.TextWidth(ap)<100 then DarkText("AP",sx+95,550,1,0,col,col,255) end
   end
if epm>0 then   
   Image.Color(80,80,80)
   Image.Rect(sx+95,590,100,2) 
   Image.Color(255,255,255)
   Image.Rect(sx+95,590,epbar,2) 
   end
DarkText(lv,sx+195,575,1,0)
if Image.TextWidth(lv)<100 then DarkText("LV",sx+95,575,1,0,col+100,col+100,col+100) end   
if epm>0 and ep==epm then 
	LevelUp(ch,pos)
   levelupanim[ch] = { scl=0; tme=150 }
   SFX("Audio/SFX/MBOX2.ogg")
   end
if levelupanim[ch] then
   levelupanim[ch].rot = ((levelupanim[ch].scl/100)*360)-(360+30)
   Image.LoadNew("LEVELUP","GFX/StatusBar/LevelUp.png"); Image.HotCenter("LEVELUP")
   Image.ScalePC(levelupanim[ch].scl,levelupanim[ch].scl)
   Image.Rotate(levelupanim[ch].rot)
   Image.Show("LEVELUP",sx+100,550)
   Image.ScalePC(100,100)
   Image.Rotate(0)
   if levelupanim[ch].scl<100 then levelupanim[ch].scl=levelupanim[ch].scl+1
   elseif levelupanim[ch].tme>0 then levelupanim[ch].tme=levelupanim[ch].tme-1
   else levelupanim[ch]=nil end   
   end   
end

function ShowMiniPic(ch,ppos)
	local tpos = ppos - 3
	if ch=="" then return end
	if not ch then return end
	Image.Color(40,40,40)
	Image.Rect(tpos*40+640,550,30,30)
	White()
	Image.LoadNew("PARTY.CHAR."..ch,"GFX/Combat/GaugeIcons/"..ch..".png")
	Image.HotCenter("PARTY.CHAR."..ch) -- Override initial hotspot settings to make sure this is drawn the way it should (Wendicka's portrait was acting odd before)
	ShowImage("PARTY.CHAR."..ch,(tpos*40)+640+15,550+15)
	-- Marker((tpos*40)+650,550)
end


function ShowParty()
local a,chk
local ep,epm
White()
Image.Show(statusbar,0,500)
-- First show all pictures, the data must be done in a separate loop or the pictures will overlap the data, and the data is more important than the pics.
for ak=0,2 do    
    ShowCharacterPic(RPGChar.PartyTag(ak),ak)
    end    
-- Now the HP, AP and EXP
for ak=0,2 do    
   ShowStats(RPGChar.PartyTag(ak),ak)
   end    
-- And the mini messages (if there are any)
for ak=3,5 do
	ch = RPGChar.PartyTag(ak)
	if ch and ch~="" then		
		ShowMiniPic(ch,ak)
		ep,epm = RPGChar.Points(ch,"EXP").Have,RPGChar.Points(ch,"EXP").Maximum
		if epm>0 and ep==epm then LevelUp(ch,ak) end
	    end
	end	
ShowMini()   
end
