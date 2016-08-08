--[[
  MemoryAnhysbys.lua
  Version: 15.11.22
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

-- Definitions
skill = Sys.Val(Var.C("%SKILL"))


col = {
         {255,  0,  0}, -- 1
         {255,255,  0}, -- 2
         {  0,  0,255}, -- 3
         {255,150,  0}, -- 4
         {180,  0,255}, -- 5
         {  0,255,  0}, -- 6
         {255,  0,  0}, -- 7
         {255,255,  0}, -- 8
         {  0,  0,255}, -- 9
         {255,150,  0}, -- 10
         {180,  0,255}, -- 11
         {  0,255,  0}  -- 12
      }

series = ({
          ['#001'] = { {2,5}, {3,6}, {5,8} },
          ['#003'] = { {3,7}, {4,9}, {6,10} }
           })[Maps.LayerCodeName][skill]
           
rowY = ({{250},{125,375},{125,250,375}})[skill]           
           
sl = series[1]

Tile = Image.Load("GFX/MiniGames/AnhysbysMemory/Tile.png")

-- And the actual game itself
function MakeSeries(serlen)
CSeries = CSeries or {}
if skill==3 then CSeries = {} end
sl = sl or serlen or 1
repeat
CSeries[#CSeries+1]=rand(1,skill*4)
until #CSeries>=sl
ASeries = {}
end         

function DrawPuzzle(light,allowclick)
Image.Cls()
local x,y,clicked
local mx,my=MouseCoords()
for i=1,skill*4 do
    y = math.ceil(i/4)
    x = i - ((y-1)*4)
    White()
    clicked = allowclick and mousehit(1) and mx>(x*125) and mx<(x*125)+100 and my>rowY[y] and my<rowY[y]+100
    if clicked then
       ASeries[#ASeries+1] = i
       SFX('Audio/SFX/Memory/MemEffect.ogg')
       end 
    if clicked or i==light then Image.Color(col[i][1],col[i][2],col[i][3]) end
    Image.Show(Tile,(x*125),rowY[y])
    end
ShowParty()
return clicked
end

function DoeHetEvenVoor()
for light in each(CSeries) do
    DrawPuzzle(); Flip() Time.Sleep(500)
    DrawPuzzle(light); SFX('Audio/SFX/Memory/MemEffect.ogg'); Flip(); Time.Sleep(500)
    DrawPuzzle(); Flip() Time.Sleep(500)
    end
DrawPuzzle(); -- Prevent last tile quickly lighting up again, causing confusion.    
end  

function KillYourself()
LAURA.Flow("FIELD")
Image.Free(Tile)
MS.Destroy("MINIGAME")
end


function CheckPuzzle()
if #ASeries==0 then return end
for i=1,#ASeries do
    if ASeries[i]~=CSeries[i] then
       DarkText("OOPS! That's not right!",400,250,2,2,255,0,0)
       DarkText("Let's try that again!"  ,400,350,2,2,255,0,0)
       Flip()
       Time.Sleep(2500)
       DoeHetEvenVoor()
       ASeries = {}
       return
       end
    end
if #ASeries>=#CSeries then
   sl = sl + 1
   if sl>series[2] then
      -- Sys.Error("Puzzle Solved not yet implemented!")
      SFX("Audio/SFX/MBOX1.ogg")
      MS.Run("MAP","Open_PD")
      KillYourself()
      else
      MakeSeries()
      DoeHetEvenVoor()
      end
   end    
end

function MAIN_FLOW()
local c = DrawPuzzle(false,true)
CheckPuzzle()
ShowMouse()
Flip()
if c then Time.Sleep(500) end
end

function GALE_OnLoad()
MakeSeries(series[1])
DoeHetEvenVoor()
MINI("Repeat the sequence",0,180,255)
end
--[[
function GALE_OnUnload() CSay("Mini-game destroyed")
end]]
