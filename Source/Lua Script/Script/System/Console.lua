--[[
  Console.lua
  Version: 16.09.12
  Copyright (C) 2015, 2016 Jeroen Petrus Broks
  
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
-- @USEDIR Script/Use/AnyWay
--[[
  
  
      These are the debug commands you can use in the debug version.
      If you use such a script yourself, please note
      
      - All functions must be declared as function XXX() and not as XXX=function
      - All functions that the console must be able to call must be in ALL CAPS
      
 ]]
 
function NIM()
	MS.Load("NIM","Script/Flow/Nim.lua")
	LAURA.Flow("NIM")
end 
 
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

function NEWPARTY(a,b,c,d,e,f)
Party(a,b,c,d,e,f)
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
    Console.Write(i.."> "..RPGChar.PartyTag(i-1),r,g,0)
    Console.Write("   = HP:  "..RPGChar.Points(p[i], "HP").Have.." of "..RPGChar.Points(p[i], "HP").Maximum,r,g,0)
    Console.Write("   = AP:  "..RPGChar.Points(p[i], "AP").Have.." of "..RPGChar.Points(p[i], "AP").Maximum,r,g,0)
    Console.Write("   = EXP: "..RPGChar.Points(p[i],"EXP").Have.." of "..RPGChar.Points(p[i],"EXP").Maximum,r,g,0)
    Console.Write("")
    end
end 

function CHARLIST()
local list = mysplit(RPGStat.CharList(),";")
for ch in each(list) do
    CSay(ch)
    end
CSay("Number of characters: "..#list)    
end

function SETCHARPOINTS(ch,points,newhave) -- This works on both enemies as heroes providing you know their CODENAME (not the screen name).
if RPGStat.CharExists(ch)==0 then return CSay("? That character does not exist! Try CharList to see what we have!") end
if RPGStat.PointsExists(ch,points)==0 then return CSay("? That character does not have those points, so I cannot modify them") end
RPGStat.Points(ch,points).Have = newhave
end


function KILLCH(ch)
SETCHARPOINTS(ch,"HP",0)
end


function AWARD(tag)
Award(tag)
end

function SAVE(file)
if LAURA.GetFlow()~="FIELD" then return CWrite("? You can only save in the field!",255,0,180) end
if (not file) or file=="" then
    GotoSave()
    CWrite("Leaving the console now will pop-up the save screen",0,180,255) 
    return 
    end
local myfile=file
local dir = mysplit(file,"/")
if #dir==1 then myfile = "Debug/"..myfile; dir = mysplit(myfile,"/") end 
if #dir~=2 then return CWrite("? I cannot save that file. Only one directory please!",255,0,0) end
LAURA.Save(myfile)
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
local s = replace( Maps.ObjectList.ToScript(i or -1) , "\t","      ")
print ( s )
for l in each(mysplit(s,"\n")) do CSay(l) end
end

function RESETFOES()
MS.Run("FIELD","SetUpFoes")
CSay("= Foes are reset")
end

function RESETTREASURE()
MS.Run("FIELD","SetUpTreasure")
CSay("= Treasures are reset")
end

function RESETMAP()
RESETFOES()
RESETTREASURE()
CSay("= Map is reset")
end

function ACTORS()
local obj
local R = rand(1,255)
local G = rand(1,255)
local B = rand(1,255)
for obj in KthuraEach() do
    if obj.Kind=="Actor" then
       R = R + rand(-1,1)
       G = G + rand(-1,1)
       B = B + rand(-1,1)
       if R<0 then R=0 elseif R>255 then R=255 end
       if G<0 then G=0 elseif G>255 then G=255 end
       if B<0 then B=0 elseif B>255 then B=255 end
       CWrite("Actor '"..obj.Tag.."' located on  ("..obj.X..","..obj.Y..")",R,G,B)
       end
     end
end     

function EXITSPOTS()
local obj
local R = rand(1,255)
local G = rand(1,255)
local B = rand(1,255)
for obj in KthuraEach() do
    if obj.Kind=="Exit" or obj.Kind=="Entrance" then
       R = R + rand(-1,1)
       G = G + rand(-1,1)
       B = B + rand(-1,1)
       if R<0 then R=0 elseif R>255 then R=255 end
       if G<0 then G=0 elseif G>255 then G=255 end
       if B<0 then B=0 elseif B>255 then B=255 end
       CWrite("Exit Spot '"..obj.Tag.."' located on  ("..obj.X..","..obj.Y..")",R,G,B)
       end
     end
end     

function FOELIST()
-- MS.RUN("FIELD","FoeList")
MS.Run("FIELD","FoeOverview")
end

function LISTFOES() 
FOELIST() end

function FALLDOWN()
FX.FallDown("PARTY","ShowParty")
end

function LISTSCHEDULED()
MS.Run("FIELD","ListScheduled")
end

function GOD()
Toggle("&CHEAT.GOD")
CSay("God mode is now: "..Var.C("&CHEAT.GOD"))
end

function JACK()
Toggle("&CHEAT.JACK")
CSay("Jack the Ripper mode is now: "..Var.C("&CHEAT.JACK"))
end

function MERLIN()
Toggle("&CHEAT.MERLIN")
CSay("Merlin mode is now: "..Var.C("&CHEAT.MERLIN"))
end

function RAMBO()
Toggle("&CHEAT.RAMBO")
CSay("Rambo mode is now: "..Var.C("&CHEAT.RAMBO"))
end

function COMBATMESSAGE(...)
if LAURA.GetFlow()~="COMBAT" then return CWrite("? This command only works in combat flow mode") end
MS.Run("COMBAT","NewMessage",join(arg,";"))
end

function GAMEOVER()
MS.Load("GAMEOVER","Script/Flow/GameOver.Lua")
LAURA.Flow("GAMEOVER")
end 

function CHARLIST()
local r,g,b
local ch
for ch in each(mysplit(RPGChar.CharList(),";")) do
    r = 180
    g = 255
    b = 0
    if prefixed(ch,"FOE") then r=255; g=0; b=0 end
    CWrite(ch,r,g,b)
    end
end

function CHARSTAT(gch,gstat)
CSay("CHARSTAT("..sval(gch)..","..sval(gstat)..");")
local chlist = gch or RPGChar.CharList()
CSay("Working with charlist: "..sval(chlist))
-- if trim(gch)=="" then chlist = RPGChar.Charlist() end 
chlist = mysplit( chlist, ";" ) 
CSay("Charlist succesfully split")
local statlist 
local ch,stat
for ch in each(chlist) do 
    CSay("- Char: "..ch) 
    statlist = mysplit(gstat or RPGChar.StatFields(ch) or "", ";")
    for stat in each(statlist) do
        CSay("  = "..stat..": "..RPGChar.Stat(ch,stat))
        end
    end

end

function CRASH(err)
Sys.Error(err or "Fabricated Error")
end

function MAPOBJECTS(kind)
local cnt = 0
local o
for o in KthuraEach(kind) do
    CSay(o.IDNUM.."> "..o.Kind.."; "..o.Tag.."; ("..o.X..","..o.Y.."); "..({[0]="Invisible",[1]="Visible"})[o.Visible].."; "..o.Labels)
    cnt = cnt + 1
    end
CSay(  cnt.." objects found")    
end

function UNLABELLED(kind)
local cnt = 0
local o
for o in KthuraEach(kind) do
    if o.Labels=="" then 
       CSay(o.IDNUM.."> "..o.Kind.."; "..o.Tag.."; ("..o.X..","..o.Y.."); "..({[0]="Invisible",[1]="Visible"})[o.Visible]..";") 
       cnt = cnt + 1
       end
    end
CSay(  cnt.." objects found")    
end 

function LEVELUP(...)
local chrs = arg
local ch
local i
if #chrs==0 or chrs[1]=="" then
   chrs = {} 
   for i=0,5 do
       ch = RPGChar.PartyTag(i)
       if ch~="" then table.insert(chrs,ch) end
       end
   end
for ch in each(chrs) do
    CSay("Level up: "..ch)
    RPGChar.Points(ch,"EXP").Have = 9999999
    end
end        


function PLAYERPICS()
if Maps.Obj.Exists("PLAYER")==0 then
   CWrite("Sorry, no player existent (or at least not the normal tagged actor for it)",255,0,0)
   CWrite("(This error is normal if this routine is called from the Yaqirpa",255,180,0)
   return
   end
local l
for l in each(mysplit(Actors.Actor("PLAYER").HavePics(),";")) do
    CWrite( l , rand(0,255), rand(0,255), rand(0,255))
    end
end

function ALLHP()
local foeid
for foeid in ICHARS() do
    CSay("Character: "..foeid.." has "..RPGChar.Points(foeid,"HP").Have.."/"..RPGChar.Points(foeid,"HP").Maximum.." HP") 
    end
end

function GIVESTATUS(ch,Status)
if LAURA.GetFlow()~="COMBAT" then CWrite("? This command only works in combat mode!",255,0,0) return end
if RPGChar.CharExists(ch)==0 then CWrite("? Character '"..sval(ch).."' does not exist!",255,0,0) return end
if RPGChar.ListHas(ch,'STATUSCHANGE',Status)==1 then CWrite("? That item is already there",255,0,0) return end
RPGChar.AddList(ch,'STATUSCHANGE',Status)
if RPGChar.ListHas(ch,'STATUSCHANGE',Status)==1 then CSay("Adding status succesful") else CSay("Adding status failed") end
end



function iStatusChange(ch) -- A quick iterator for status changes. Copied from the combat routine.
local i=-1
return function()
       i = i + 1
       if i<RPGStat.CountList(ch,"STATUSCHANGE") then return RPGStat.ListItem(ch,"STATUSCHANGE",i+1) end
       return nil
       end
end


function GETSTATUS(char)
if LAURA.GetFlow()~="COMBAT" then CWrite("? This command only works in combat mode!",255,0,0) return end
local chl
if (not char) or char=="" then
    chl = {}
    for foeid in ICHARS() do
        chl[#chl+1]=foeid
        end
else        
		chl = mysplit(char,";")
    end    
for ch in each(chl) do
    if RPGChar.CharExists(ch)==0 then CWrite("? Character '"..sval(ch).."' does not exist!",255,0,0) return end
    CSay("- "..ch)    
    for st in iStatusChange(ch) do
        CSay("  = "..st)
        end
    end
end

function MANGAUGE(ch,value)
if LAURA.GetFlow()~="COMBAT" then CWrite("? This command only works in combat mode!",255,0,0) return end
MS.Run("COMBAT","ManGauge",ch..";"..value)
end


function FOXYALL()
Toggle("&CHEAT.FOXYALL")
CSay("FOXYALL is now "..Var.C('&CHEAT.FOXYALL'))
if CVV('&CHEAT.FOXYALL') then CSay("Perform one move with Foxy in battle and very likely all her moves will end up in her learning list") end
end

function LOOKBUTDONTTOUCH()
MS.Run("FIELD","ToggleLookButDontTouch")
end

function SHOWBUFF(ch,stat,onlywhengotvalue)
   if RPGChar.CharExists(ch)==0 then CWrite("? Character '"..sval(ch).."' does not exist!",255,0,0) return end
   local v=RPGStat.Stat(ch,"BUFF_"..stat)
   if v~=0 or (not onlywhengotvalue) then
      Console.Write("= "..stat.." buffed with "..v.." points",0,180,255)
   end 
   return v~=0
end

function BUFFS()
 local got,ch
 for i=0,5 do
    got=false
    ch = RPGStat.PartyTag(i)
    if ch~="" then
       for stat in each({"Strength", "Defense", "Will", "Resistance","Agility","Accuracy","Evasion"}) do
           Console.Write("Character: "..ch,180,100,0)
           got = SHOWBUFF(ch,stat,true) or got
       end
       if not got then Console.Write("No buffs found") end
    end   
 end
end 

function SETBUFF(ch,stat,value)
  -- if LAURA.GetFlow()~="COMBAT" then CWrite("? This command only works in combat mode!",255,0,0) return end
  if RPGChar.CharExists(ch)==0 then CWrite("? Character '"..sval(ch).."' does not exist!",255,0,0) return end
  RPGStat.DefStat(ch,"BUFF_"..stat,value)
end  

function MAPEVENT(func)
  MS.Run("MAP",func)
end   
