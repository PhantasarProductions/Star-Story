--[[
/* 
  Field

  Copyright (C) 2015 Jeroen P. broks

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

-- @UNDEF EMSAVEDEBUG

cplayer = "PLAYER"
scrolling = true
scrollrange = {}

Icons = {"Achievements","FullScreen","Quit"}
IconImg = {}
IconMnX = 750 - (#Icons*40)
IconBack = Image.Load("GFX/FieldIcons/Back.png") 
IconClicked = nil

IconFunction = 
{
   Achievements = function()
                  MS.LoadNew("ACH","Script/Flow/Achievements.lua") -- Only loads if it wasn't loaded before :)
                  LAURA.Flow("ACH") 
                  end,
   FullScreen = LAURA.ToggleFullScreen,   
   Quit = function() 
          MS.LoadNew("QUIT","Script/Flow/Quit.lua")
          LAURA.Flow("QUIT") 
          end
}
function ShowIcons()
White()
Image.Draw(IconBack,IconMnX,0)
local ak,i
local mx,my = MouseCoords()
local x
Image.Color(0,180,255)
IconClicked = nil
for ak,i in ipairs(Icons) do 
    IconImg[ak] = IconImg[ak] or Image.Load("GFX/FieldIcons/"..i..".png")
    Image.HotCenter(IconImg[ak])
    x=IconMnX+(ak*40)+10
    Image.Draw(IconImg[ak],x,40)
    if my>5 and my<74 and mx>x-16 and mx<x+16 and mousehit(1) then IconClicked = i end
    end    
end

function DrawScreen()
Image.Cls()
Maps.Draw()
MS.Run("MAP","MAP_FLOW")
ShowIcons()
ShowParty()
ShowMouse()
end

function FGoToMenu(chn)
repeat
INP.Grab()
until INP.MouseH(1)==0
GoToMenu(chn)
end

function ResetClickables()
Clickables = {}
end

function ListClickables()
local i,k
if #Clickables==0 then Console.Write("No clickables on this map",255,100,0) end
for i,k in ipairs(Clickables) do CSay(i..">"..k) end
end 

function AddClickable(c)
if tablecontains(Clickables,c) then CSay('Duplicate clickable definiation '..c); return end
table.insert(Clickables,c)
end

function RemoveClickable(c)
local v,i,r
for i,v in ipairs(Clickables) do
    if v==c then r=i end
    end
table.remove(Clickables,r)
end


function CheckClickables()
local i,c
local mx,my = TrueMouseCoords()
local ret
if mousehit(1) then
   for i,c in ipairs(Clickables) do
       -- CSay("Clicked in object: "..c.." ("..mx..","..my..") ==> "..Maps.CoordsInObject(c,mx,my))
       if Maps.CoordsInObject(c,mx,my)==1 then
          Actors.WalkToSpot(cplayer,"SPOT_"..c)
          WalkArrival = "CLICK_ARRIVAL_"..c
          ret=true
          end
       end
   end    
return ret   
end


function Click()
local mx,my = MouseCoords()
local ak
if mousehit(1) then -- Left Mouse button    
   if my>500 then  -- must come prior to checks in the field
      for ak=0,5 do
          if ClickedChar(ak) then FGoToMenu(ak) end
          end
   elseif IconClicked then -- Must come prior to checks in the field
      IconFunction[IconClicked]()       
   elseif CheckClickables() then
     -- Nothing happens here, but this will take any other checks out.       
      else -- If there's nothing else then perform then walk to
      CSay(cplayer.." is going to walk to ("..mx..","..my..")")
      Actors.WalkTo(cplayer,mx+Maps.CamX,my+Maps.CamY)
      WalkArrival = nil
      -- Actors.MoveTo(cplayer,mx+Maps.CamX,my+Maps.CamY)
      end
   end
end

function SetPlayer(P) cplayer=P end

function SetScrolling(set,rsx,rsy,rex,rey)
scrolling = set==true or set=="true" or set=="TRUE" or sval(set)==1
if rsx then scrollrange = {rsx=Sys.Val(rsx),rsy=Sys.Val(rsy),rex=Sys.Val(rex),rey=Sys.Val(rey)} end
end

function DestroyScrollRage() scrollrange={} end

function AutoScroll()
if not scrolling then return end
local px,py = GetCoords(cplayer)
local sx = px - 400
local sy = py - 300
if scrollrange.rsx and sx<scrollrange.rsx then sx=scrollrange.rsx end
if scrollrange.rsy and sx<scrollrange.rsy then sx=scrollrange.rsy end
if scrollrange.rex and sx>scrollrange.rex then sx=scrollrange.rex end
if scrollrange.rey and sx>scrollrange.rey then sx=scrollrange.rey end
Maps.CamX = sx
Maps.CamY = sy
end

function ZoneAction()
MS.Run("MAP","ZA_CheckEnter",cplayer)
MS.Run("MAP","ZA_CheckLeave",cplayer)
MS.Run("MAP","ZA_CheckFlow" ,cplayer)    
end

function WalkArrivalCheck()
if WalkArrival and Actors.Walking(cplayer)==0 then
  -- @SELECT type(WalkArrival)
  -- @CASE "string"
     MS.Run("MAP",WalkArrival)
     CSay("Arrival>MAP>"..WalkArrival) -- Debug line
  -- @CASE "function"
     WalkArrival()
  -- @CASE "table"
     MS_Run(WalkArrival[1],WalkArrival[2],WalkArrival[3])
  -- @DEFAULT
     Sys.Error("Unknown walk arrival type ("..type(WalkArrival)..")")
  -- @ENDSELECT
  WalkArrival = nil
  end      
end

function SetUpFoes()
local ak,num
local obj,foe
local R,G,B
local pt = ngpcount or 1
local lvrange
local minenemies = {1,2,3}
local maxenemies = {3,6,9}
local hilevel,diflevel
local myleveltotal,partymembers,ptag
-- Make sure there are no foes in the field
CSay("Searching for existing foes")
for obj in KthuraEach("Actor") do
    CSay("Checking: "..obj.Kind.." "..obj.Tag.."; Got suffix "..sval(suffixed(obj.Tag,"FoeActor")))
    if suffixed(obj.Tag,"FoeActor") then
       Maps.Obj.Kill(obj.Tag); CSay("Killed foe: "..obj.Tag.." (Obj #"..obj.IDNum..")")
       end 
    end
-- calc level differences
for ak=0,5 do
    ptag = RPGChar.PartyTag(ak)
    if ptag~="" then
       partymembers = (partymembers or 0) + 1
       myleveltotal = (myleveltotal or 0) + RPGChar.Stat(ptag,"Level")
       end
    end
if not partymembers then Sys.Error("Something went wrong when counting the levels here!") end
local mylevel = myleveltotal / partymembers
if pt>99 then pt=99 end
local dt = "PT "..right(" "..pt,2).." Level Range"
while Maps.GetData(dt)=="" do
      pt = pt - 1      
      dt = "PT "..right(" "..pt,2).." Level Range"
      if pt<=0 then return("No foe levels set, ignoring foe request!") end
      end 
lvrange = mysplit(Maps.GetData(dt),"-")
if #lvrange<2 then GALE_Error("Level range for playthrough #"..pt.." not properly set up!") end
for i,v in ipairs(lvrange) do lvrange[i] = Sys.Val(v) end
if lvrange[2]<lvrange[1] then GALE_Error("Negative level range for playthrough #"..pt) end
-- setting up the foes     
FieldFoes = {}
CSay("Resetting Foes")
for obj in KthuraEach() do
    -- CSay("   = Seen: "..obj.IDNum.."; "..obj.Tag.."; "..obj.Kind) -- Debugline
    if prefixed(obj.Kind,"$Enemy") then
       CSay("  = Process: "..obj.IDNum.."; "..obj.Tag.."; "..obj.Kind)
       FieldFoes[obj.Tag] = {  }       
       foe = FieldFoes[obj.Tag]
       foe.Work = right(obj.Kind,3)
       foe.Go = left(foe.Work,2)
       foe.Skill = Sys.Val(right(obj.Work,1))     
       if skill<foe.Skill then
          CWrite("  = Rejected. Not meant for this skill level",255,0,0)
          FieldFoes[obj.Tag] = nil
         else
          foe.Actor = obj.Tag .. " FoeActor"
          foe.Tag = foe.Actor
          CSay("  = Spawning actor")
          Actors.Spawn(obj.Tag,"GFX/FIELD/ENCOUNTER.PNG",foe.Tag,1)
          CSay("  = Configuring actor")
          Maps.Obj.Pick(foe.Tag)
          foe.Enemies = {}
          num = rand(minenemies[skill],maxenemies[skill])
          hilevel = 0
          for ak=1,num do
              foe.Enemies[ak] = 
                {
                    level = rand(lvrange[1],lvrange[2])
                }
              if hilevel<foe.Enemies[ak].level then hilevel=foe.Enemies[ak].level end
              end
          diflevel = hilevel - mylevel
          CSay("  = MyLevel="..mylevel.."; HiLevel="..hilevel.."; DifLevel="..diflevel)    
          if diflevel<-10 then
             R = 0
             G = 255
             B = 0
             foe.radius = 100
             CSay("  = Too Easy")
          elseif diflevel<=0 then
             R = 180
             G = 255
             B = 0
             foe.radius = 250
             CSay("  = Easy")
          elseif diflevel<10 then
             R = 255
             G = 180
             B = 0
             foe.radius = 500
             CSay("  = Hard")
          else
             R = 255
             G = 0
             B = 0
             foe.radius = 1000
             CSay("  = Too Hard")
             end   
          CWrite("  = Adjusting color of object "..Maps.Obj.MyObject.Tag.."  to ("..R..","..G..","..B..")",R,G,B)   
          Maps.Obj.SetColor(R,G,B)
          --foe.obj = nil
          end
       end
    end
end 

-- @IF *DEVELOPMENT
function ToggleFoeRadius()
FoeRadius = not FoeRadius
end
-- @FI

function FoeChase()
end

function FoeActive(foe)
end


function ControlFoes()
local foe
if not FieldFoes then return end
for obj in KthuraEach("Actor") do    
    foe = FieldFoes[replace(obj.Tag," FoeActor","")]
    CSay("We got a foe on  : "..obj.Tag.." >> "..sval(foe~=nil))
    CSay("We got suffix on : "..obj.Tag.." >> "..sval(suffixed(obj.Tag,"FoeActor")))
    if foe and suffixed(obj.Tag,"FoeActor") then
       (({   -- Switch
          HZ = function ()  -- Horizontaal
               if Active(foe) then 
                 FoeChase()
               else
                 if foe.GoEast then Actors.MoveTo(obj.Tag,obj.X+10,obj.Y) else Actors.MoveTo(obj.Tag,obj.X-10,obj.Y) end
                 if obj.X==foe.OldX and obj.Y==foe.OldY then foe.GoEast=not foe.GoEast else f.OldX=obj.X f.OldY=obj.Y end 
                 end 
               end,
          VT = function () -- Verticaal
               if Active(foe) then 
                 FoeChase()
               else
                 if foe.GoSouth then Actors.MoveTo(obj.Tag,obj.X,obj.Y+10) else Actors.MoveTo(obj.Tag,obj.X,obj.Y-10) end
                 if obj.X==foe.OldX and obj.Y==foe.OldY then foe.GoSouth=not foe.GoSouth else f.OldX=obj.X f.OldY=obj.Y end 
                 end 
               end,     
          SS = function() -- Sta Stil!     
               if Active(foe) then 
                 FoeChase()
                 end 
               end,
          AS = function() -- Altijd Stilstaan
               end     
       })[foe.Go] or function() Sys.Error("Unknown go code for foe #"..obj.IdNum,"Tag,"..obj.Tag..";Go,"..foe.Go) end)() 
       end
    end
end

function SetUpTreasure()
end

function LoadMap(map)
Maps.Load(map)
SetUpFoes()
SetUpTreasure()
Var.Clear("$MAP.MAPSHOW.LASTREQUEST")
Var.Clear("$MAP.MAPSHOW.LASTALWAYSSHOW")
end

function Termination()
-- DarkText(INP.Terminate,10,10)
if INP.Terminate>0 then IconFunction.Quit() end
end

function EmergencySave()
local maxtime=600
-- @IF EMSAVEDEBUG
   maxtime = 10
-- @FI
if LAURA.GetFlow()~="FIELD" then return end
if ES_Time~=Time.Time() then
   EM_Second = (EM_Second or -1) + 1
   if EM_Second>=maxtime then
      LAURA.Save("System/Emergency",1)
      EM_Second = nil
      -- @IF EMSAVEDEBUG
      MINI("DEBUG: Time over minutes have passed in the field. Emergency savegame has been saved!")
      -- @FI
      end
   ES_Time = Time.Time()
   end
-- @IF EMSAVEDEBUG
DarkText("Save timer: "..sval(EM_Second),10,10)
-- @FI
end

function MAIN_FLOW()
DrawScreen()
Click()
AutoScroll()
ZoneAction()
WalkArrivalCheck()
Termination()
EmergencySave()
ControlFoes()
Flip()
end
