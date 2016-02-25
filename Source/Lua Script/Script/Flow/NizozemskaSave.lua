--[[
  NizozemskaSave.lua
  Version: 16.02.25
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


function CLS()
SCR = CreateField(80,25,{ch=32,inv=false})
cursor = {x=0,y=0}
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
    [2]= function() cursor.x=dx+1; cursor.y=dy; if cursor.x>80  then cursor.x=1; cursor.y=dy+1 end;  if cursor.y>25 then cursor.y=1 end end})[mcurs]()    
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
local ccol = { [false]=0,[true]=255}
Image.Scale(1,2)
for x,y in FieldEnum(1,1,80,25) do
    inv = SCR[x][y].inv
    if mouse and mx==x and my==y then inv = not inv end
    Image.Draw(FONT[inv],40+(x*9),5+(y*18),SCR[x][y].ch) 
    end
Image.Scale(1,1)
local ms = Time.MSecs()
if ms~=oms then cursor.show = not cursor.show; oms = ms end
if cursor.show then 
   Image.Color(0,ccol[SCR[cursor.x][cursor.y].inv],0)
   Image.Rect((cursor.x*9)+40,(cursor.y*18)+5+7,9,2)
   end
DarkText(serialize('Cursor',cursor),0,0) -- debug   
end


    

function GALE_OnLoad()
local function LA(n) return Image.LoadAnim('GFX/PC Font/Font'..n..".png",9,9,0,256) end
FONT = { [true] = LA(1), [false]=LA(0) }
CLS()
MyFlow = 'BIOS'
end


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
                  
                  end      


}

function MAIN_FLOW()
Image.Cls()
Image.Color(0,20,0)
Image.Rect(0,0,800,600)
Image.Color(0,200,0)
MyFlowArray[MyFlow]()
Draw()
ShowParty()
Flip()
end
