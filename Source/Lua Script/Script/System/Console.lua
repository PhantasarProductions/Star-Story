--[[
/* 
  Console Commands

  Copyright (C) 2015 Jeroen P. Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
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

*/



Version: 15.08.01

]]
-- @USEDIR Script/Use/AnyWay
--[[
  
  
      These are the debug commands you can use in the debug version.
      If you use such a script yourself, please note
      
      - All functions must be declared as function XXX() and not as XXX=function
      - All functions that the console must be able to call must be in ALL CAPS
      
 ]]
 
function TEST(...)
local a,i
for i,a in ipairs(arg) do CSay(i..">"..a) end
end

function SHOWBLOCKMAP()
Maps.DebugBlockMap()
end

function FUCK()
CSay("AAAAAH! HE SAID THE F-WORD!!!!")
end

function SHIT()
CSay("In case you didn't notice... I'm a PC not a WC!")
end

function TUT()
MS.Run("FLIP","TutorialConsole")
end

function PARTY()
local r,g,ak
for ak=0,5 do
    r = (ak/6)*255
    g = 255-r    
    Console.Write(ak.."> "..RPGChar.PartyTag(ak),r,g,0)
    end
end

function CHARPOINTS(...)
local p = arg
local ak
if not arg then Console.Write("NO INPUT",255,0,0)return end
if #arg==0 then
   p = {}
   for ak=0,5 do 
       if RPGChar.PartyTag(ak)~="" then p[ak+1]=RPGChar.PartyTag(ak) end
       end
   end 
local ch,i,r,g
for i=1,#p do
    r = (i/#p)*255
    g = 255-r    
    Console.Write(i.."> "..RPGChar.PartyTag(i),r,g,0)
    Console.Write("   = HP:  "..RPGChar.Points(p[i], "HP").Have.." of "..RPGChar.Points(p[i], "HP").Maximum,r,g,0)
    Console.Write("   = AP:  "..RPGChar.Points(p[i], "AP").Have.." of "..RPGChar.Points(p[i], "AP").Maximum,r,g,0)
    Console.Write("   = EXP: "..RPGChar.Points(p[i],"EXP").Have.." of "..RPGChar.Points(p[i],"EXP").Maximum,r,g,0)
    Console.Write("")
    end
end 


function AWARD(tag)
Award(tag)
end

function SAVE(file)
if (not file) or file=="" then return CSay("? Cannot save when you don't gimme a filename") end
LAURA.Save(file)
end

function MOUSE()
local x,y = MouseCoords()
CSay("("..x..","..y..")")
end

function CLICKABLES()
MS.LN_Run("FIELD","Script/Flow/Field.lua","ListClickables")
end

function TB_SETUP()
local setup = {
     {"i","Please answer the next questions"},
     {"i","Leaving it blank will keep the answer we already got"},
     {"i","Typing '<nil>' will destroy this field"},
     {"%COMBAT.MINLVL","Minimum level:"},
     {"%COMBAT.MAXLVL","Maximum level:"},
     {"$COMBAT.BACKGROUND","Background arena:"},
     {"$COMBAT.MUSIC","Music:","Combat/REGULARCOMBAT.OGG"},    
   }
local i,q,r,g,a
local b=0
for i=1,9 do table.insert(setup,{"$COMBAT.FOE"..i,"Foe #"..i..":"}) end
table.insert(setup,{"i","Right, that should do it. TB_BATTLE will start it up"})
TBSetup = TBSetup or {}
for i,q in ipairs(setup) do
    r = 255 * (i/#setup)
    g = 255 - r
    if q[1]=="i" then
       Console.Write(q[2],r,g,b)
    else
       TBSetup[q[1]] = TBSetup[q[1]] or q[3] 
       Console.Write(q[2].."   ["..sval(TBSetup[q[1]]).."]",r,g,0)
       a = LAURA.ConsoleInput()
       if a=="" then
          -- Do nothing
       elseif lower(a)=="<nil>" then
          TBSetup[q[1]] = nil
       else
          TBSetup[q[1]] = a
          end
       end       
    end   
end

function TB_SHOWSETUP()
local a = mysplit(serialize("TBSetup",TBSetup),"\n")
local i,l
for i,l in ipairs(a) do
    CSay(l)
    end
end

function TB_RUN()
local k,v
local pdel = "%COMBAT.FOE"
for k,v in spairs(TBSetup) do
    if left(k,len(pdel))==pdel then
       TBSetup[k]=nil
       CSay("Remove faulty field:"..k)
       else
       CSay("Define: "..k.." > "..v)
       Var.D(k,v)
       end
    end
CSay("Let combat commence!")
StartCombat() 
end

function VARS()
local k,v
for k,v in IVARS() do
    if left(k,1)~="<" then CSay(k.." = "..sval(v)) end
    end
end

function VAR2TABLETEST(tb)
local a = mysplit(serialize("*table*",Var2Table(tb)),"\n")
local i,l
for i,l in ipairs(a) do
    CSay(l)
    end
end

function KILL(variable)
Var.Clear(variable)
end

function GETHOT(tag)
if Image.Loaded(tag)==0 then Console.Write("? That image is not loaded",255,0,0); return end
CSay(Image.ReturnHot(tag))
end

function RELOADCHAR(ch)
if JCR6.Exists("Script/JINC/InitChar/"..ch..".lua")==0 then Console.Write("? ERROR: Character not found in JCR6 charlist!") end
MS.Run("PARTY","InitCharacter",ch)
end

function ISTATUS()
local a = {false,true}
local ak,al,s
for _,ak in ipairs(a) do 
    CSay("Unindexed Test - Stars = "..sval(ak))
    for s in iStatus(ak) do CSay(" * "..sval(s)) end
    end 
for _,ak in ipairs(a) do 
    CSay("Indexed Test - Stars = "..sval(ak))
for al,s in iStatus(ak,true) do CSay(sval(al)..". "..sval(s)) end
    end 
end

function DIR()
local f
local hue = 0
for f in iJCR6Dir() do
    hue = hue + 1
    if hue>=344 then hue=0 end
    Image.ColorHSV(hue,255,255)
    Console.Write(f,Image.CurrentRed,Image.CurrentGreen,Image.CurrentBlue)
    end
end

function PIA()
if MS.ContainsScript("COMBAT")==0 then Console.Write("? ERROR ? Combat script not loaded!",255,0,0) return end
MS.Run("COMBAT","DebugPIA")
end

function SCRIPTOBJECT(k,i)
local c = Maps.ObjectList.Start(k)
if c==0 then CSay("Everything's empty") end
local l
local s = Maps.ObjectList.ToScript(i or -1)
print ( s )
for l in each(mysplit(s),"\n") do CSay(l) end
end
