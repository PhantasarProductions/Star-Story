--[[
  NizozemskaSave.lua
  Version: 16.08.18
  Copyright (C) 2016 Jeroen Petrus Broks
  
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

allowletters = {[32]=true}
for i=48,57 do allowletters[i]=true end
for i=65,90 do allowletters[i]=true end


function Scan()
files = {}
PM = PM or 1
dir = LAURA.GetSaveDir() .. "/" .. LAURA.User()
if Dir.DirExists(dir)==0 then return end
Dir.GetDir(dir)
local ak
for ak=1,Dir.DirLen() do
    table.insert(files,Dir.DirEntry(ak))
    end
Scrolled = false    
end


function CLS()
SCR = CreateField(80,25,{ch=32,inv=false})
cursor = cursor or {}
cursor.x=1
cursor.y=1
maindrawn = false
end

function WriteXY(text,x,y,inv,pcursor)
local dx,dy=x,y
local mcurs = pcursor or 1
for i = 1,len(text) do
    SCR[dx][dy] = {ch = string.byte(text,i), inv=inv==true}
    dx = dx + 1
    if dx>80 then dx=1 dy=dy+1 end
    if dy>25 then dy=1 end
    end
;({ [0]= function() end,
    [1]= function() cursor.x=1; cursor.y=dy+1; if cursor.y>25 then cursor.y=1 end end,
    [2]= function() cursor.x=dx; cursor.y=dy; if cursor.x>80  then cursor.x=1; cursor.y=dy+1 end;  if cursor.y>25 then cursor.y=1 end end})[mcurs]()    
end

function Box(x,y,w,h,inv)
local array = {
  left = {218,179,212},
  right = {183,186,188},
  center = {196,32,205}
}
local iar,iix
for iy=y,(y+h)-1 do
    for ix=x,(x+w)-1 do
        if iy==y then iix=1 elseif iy==(y+h)-1 then iix=3 else iix=2 end
        if ix==x then iar='left' elseif ix==(x+w)-1 then iar='right' else iar='center' end
        SCR[ix][iy] = {ch = array[iar][iix], inv=inv==true}
        end
    end
end

function MC()
local tmx,tmy = MouseCoords()
local rx = math.ceil((tmx/800)*80)
local ry = math.ceil((tmy/600)*25)
if rx==0 then rx=1 end
if ry==0 then ry=1 end
return rx,ry
end

function Draw(mouse)
local mx,my = MC()
local inv
local ccol = { [false]=255,[true]=0}
Image.Scale(1,2)
for x,y in FieldEnum(1,1,80,25) do
    inv = SCR[x][y].inv
    if mouse and mx==x and my==y then inv = not inv end
    Image.Draw(FONT[inv],40+(x*9),5+(y*18),SCR[x][y].ch) 
    end
Image.Scale(1,1)
local ms = math.floor(Time.MSecs() / 32)
if ms~=oms then 
   cursor.show = not cursor.show
   oms = ms 
   -- CSay("BLINK! "..sval(cursor.show))
   end
if cursor.show then 
   if not SCR[cursor.x]           then cursor.x=1 end
   if not SCR[cursor.x][cursor.y] then cursor.y=1 end
   Image.Color(0,ccol[SCR[cursor.x][cursor.y].inv],0)
   Image.Rect((cursor.x*9)+40,(cursor.y*18)+5+16,8,4)
   end
--DarkText(serialize('cursor',cursor).."; ms = "..ms.."; oms = "..oms,0,0) -- debug   
end


function GoodBye()
LAURA.Flow("FIELD")
MS.Destroy("NIZOSAVE")
end

function Save(SaveName)
LAURA.Flow("FIELD")
--Image.Cls()
--setfont("SaveName")
--Red()
CLS()
WriteXY("Saving",40-(len('Saving')/2),12)
Draw()
Flip()
LAURA.Save(LAURA.User().."/"..SaveName)
Mini("The game has been saved",255,180,0)
-- Scrolled=false
end    

function GALE_OnLoad()
local function LA(n) return Image.LoadAnim('GFX/PC Font/Font'..n..".png",9,9,0,256) end
FONT = { [true] = LA(1), [false]=LA(0) }
CLS()
MyFlow = 'BIOS'
Scan()
end


boottext = {

     [100] = {"HR-DOS v6.10.1905",1},
     [101] = {"(c) Nanosoft corporation",2},
     [120] = {"A>prompt $p$g",4},
     [125] = {"A:\\>cd system",5},
     [130] = {"A:\\SYSTEM>cd starstry",6},
     [145] = {"A:\\SYSTEM\\STARSTRY>savegame.exe",7},
     [225] = {"SaveGame - (c) Jeroen Petrus Broks 2016",9},
     [300] = {"END",0}
}

MyFlowArray = {


           BIOS = function()
                  precount = (precount or -1) + 1
                  KBcount = (KBcount or 0)
                  aftcount = (aftcount or 0)
                  CLS()
                  WriteXY('Narcissus Personal Computer System',1,1)
                  WriteXY('Version 6.19.1975',1,2)
                  WriteXY('(c) Narcissus Computing 2975-3000',1,3)
                  if precount<75 then return end
                  WriteXY(KBcount.." KB OK",1,5,false,2)
                  if KBcount<520 then KBcount = KBcount + 8 return else KBcount=520 end
                  aftcount = aftcount + 1
                  if aftcount<25 then return end
                  WriteXY("Booting...",1,7) 
                  if aftcount>75 then MyFlow="Boot" end
                  end,
                  
           Boot = function()
                  CLS()
                  booti = booti or 0
                  booti = booti + 1
                  for i=1,booti do
                      if boottext[i] then
                         if boottext[i][1]=="END" then MyFlow = "EXE"; return end
                         WriteXY(boottext[i][1],1,boottext[i][2])
                         end
                       end
                  end,
                  
           EXE = function()
                 local mx,my = MC()
                 --if not maindrawn then 
                    CLS()
                    maindrawn=true -- 1         2         3         4         5         6
                          -- 123456789012345678901234567890123456789012345678901234567890
                    WriteXY("              ***** ***** Save Game ***** *****             ",10,2,true)
                    Box(10,4,60,3)  -- Text input
                    Box(10,7,60,14) -- file list
                    Box(50,22,10,3); WriteXY("Save",53,23)
                    Box(35,22,10,3); WriteXY("Cancel",37,23)
                 --    end
                 -- Confirm and Cancel
                 if mousehit(1) and my>21 and my<25 then
                    if mx>35 and mx<45 then GoodBye() end
                    if mx>50 and mx<60 and PFILE and PFILE~="" then Save(PFILE) GoodBye() end
                    end
                 -- Scroll
                    if PM>1 then
                       WriteXY(string.char(30),72,7)
                       if mousehit(1) and my==7 then PM=PM-1 end
                       end
                    if files[PM+12] then
                       WriteXY(string.char(31),72,21)
                       if mousehit(1) and my==21 then PM=PM+1 end
                       end
                       
                 -- List   
                 for i=0,11 do
                     WriteXY(files[PM+i],12,8+i) 
                     if mousehit(1) and mx>10 and mx<70 and my==i+8 and files[PM+i] then PFILE = files[PM+i] end
                     end
                 -- Save File (must be last, because that sets the cursor right) ;)
                 PFILE = PFILE or ""
                 --WriteXY("                                                       ",12,5) -- Make sure the field is empty before blitting the name
                 WriteXY(PFILE,12,5,false,2)
                 setfont("SaveName") -- Only needed to check the max name length
                 for i=32,90 do 
                     if keyhit(i) and allowletters[i] and Image.TextWidth(PFILE)<365 then PFILE = PFILE .. string.char(i) end
                     end
                 if keyhit(8) and PFILE~="" then PFILE = left(PFILE,len(PFILE)-1) end    
                 end       
                  


}

function MAIN_FLOW()
Image.Cls()
Image.Color(0,20,0)
Image.Rect(0,0,800,600)
Image.Color(0,200,0)
MyFlowArray[MyFlow]()
Draw(MyFlow=='EXE')
ShowParty()
Flip()
end
