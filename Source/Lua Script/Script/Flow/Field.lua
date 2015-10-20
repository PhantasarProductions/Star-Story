--[[
  Field.lua
  Version: 15.10.20
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

-- @UNDEF EMSAVEDEBUG

cplayer = cplayer or "PLAYER"
activeplayer = activeplayer or RPGChar.PartyTag(0)

scrolling = true
scrollrange = {}

Icons = {"Achievements","FullScreen","Quit"}
IconImg = {}
IconMnX = 750 - (#Icons*40)
IconBack = Image.Load("GFX/FieldIcons/Back.png") 
IconClicked = nil

Scheduled = {}
ScrollBoundaries = ScrollBoundaries or {}

-- This array is used by the party pop routine. If not in use it should always be "nil".
PartyPopArray = nil

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


function SetScrollBoundaries(xmin,ymin,xmax,ymax)
ScrollBoundaries = {}
if xmin and xmin~='nil' then ScrollBoundaries.minx = Sys.Val(xmin) end
if xmax and xmax~='nil' then ScrollBoundaries.maxx = Sys.Val(xmax) end
if ymin and ymin~='nil' then ScrollBoundaries.miny = Sys.Val(ymin) end
if ymax and ymax~='nil' then ScrollBoundaries.maxy = Sys.Val(ymax) end
end



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

function GetActive(external)
if external=='yes' then Var.D('$RET',activeplayer) end
return activeplayer
end

-- Automatically turn the player actor into the right direction
function AutoPlayerWind()
if cplayer~="PLAYER" then return end
local x,y,w = GetCoords("PLAYER")
Actors.ChoosePic("PLAYER",upper(replace(activeplayer,"Uni","")).."."..upper(w))
end

function TurnPlayer(w)
if cplayer~="PLAYER" then return CSay("No PLAYER to turn") end
Actors.ChoosePic("PLAYER",upper(replace(activeplayer,"Uni","")).."."..upper(w))
Actors.Actor("PLAYER").Wind = w
end

function DrawScreen()
local s = math.abs(math.sin(Time.MSecs()/1000))
Image.Cls()
Maps.Draw()
MS.Run("MAP","MAP_FLOW")
AutoPlayerWind()
ShowIcons()
ShowParty()
if Maps.Multi()==1 and prefixed(Maps.LayerCodeName,"#") then 
	setfont('LayerInField')	
	DarkText("Area ",5,5,0,0,(s*155)+100,(s*80)+100,0)
	DarkText(Maps.LayerCodeName,5+Image.TextWidth("Area "),5,0,0,0,(s*80)+100,(s*155)+100)
    end
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
for i,k in ipairs(Clickables) do CSay(serialize("Click #"..i,k)) end
end 

function AddClickable(c)
if tablecontains(Clickables,c) then CSay('Duplicate clickable definiation '..c); return end
CSay(serialize("AddingClickable",c))
table.insert(Clickables,c)
end

function AddClickableScript(c)
  local f,e = loadstring(c)
  if not f then Sys.Error("LoadString Error: "..e) end  
  AddClickable(f())
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
local ret,ARMSpot,obj
if not Clickables then return end
if mousehit(1) then
   for i,c in ipairs(Clickables) do
	   if type(c)=='table' then obj=c.obj else obj=c end
	   --Image.NoFont()
	   --CSay("#"..i.." Click: "..obj.." >> "..Maps.CoordsInObject(obj,mx,my)) -- Debug line!
	    
       --[[
       ({['string'] = function() 
                      end,
         ['table'] = function()
                     end})[type(cd)]()
         ]]                                
       -- CSay("Clicked in object: "..c.." ("..mx..","..my..") ==> "..Maps.CoordsInObject(c,mx,my))
       if Maps.Obj.Exists(obj) and Maps.CoordsInObject(obj,mx,my)==1 then
          if type(c)=='table' then
			CSay("Request from table")  
            if c.spot then Actors.WalkToSpot(cplayer,c.spot) CSay("Walking To Spot: "..c.spot) end
            if c.coords then Acotrs.WalkTo(cplayer,c.coods.x,c.coords.y) end
            WalkArrival = c.arrival   ; CSay("Execute: "..WalkArrival)   
			WalkArrivalArg = c.arrivalarg		
			ret = true
          elseif prefixed(c,"NPC_MT_") then
            Actors.WalkTo(cplayer,Maps.Obj.Obj(c).X,Maps.Obj.Obj(c).Y+32)
            WalkArrival = "NPC_MapText"
			WalkArrivalArg = nil
            Var.D("$NPC_MAPTEXT",c)
            ret=true
          elseif prefixed(c,"NPC_") then
            if c=="NPC_MapText" then Sys.Error("Illegal NPC tag!") end
            Actors.WalkTo(cplayer,Maps.Obj.Obj(c).X,Maps.Obj.Obj(c).Y+32)
            WalkArrival = c
			WalkArrivalArg = nil
            ret=true            
          elseif prefixed(c,"ARMCHST") then -- This block until the next "else" statement is specifically for Star Story.
              ARMSpot = replace(c,"ARMCHST","ARMSPOT")
              Actors.WalkToSpot(cplayer,ARMSpot)
              WalkArrival = "GRANT_ARM"
			  WalkArrivalArg = nil  
              Var.D("$ARMSPOT",ARMSpot)
              CSay("Gimme that ARM at "..Maps.Obj.Obj(ARMSpot).x..","..Maps.Obj.Obj(ARMSpot).y)
              CSay(" = Arrival call: "..WalkArrival)
              CSay(" = ARMSpot:      "..ARMSpot)
              ret = true
		  else
			if Maps.Obj.Exists("SPOT_"..c)==1 then
				Actors.WalkToSpot(cplayer,"SPOT_"..c)
			else
				Actors.WalkToSpot(cplayer,c)
			end			
            WalkArrival = "CLICK_ARRIVAL_"..c
            ret=true
            end
          end
       end
   end    
return ret   
end

function KillWalkArrival()
WalkArrival = nil
end


function Click()
local mx,my = MouseCoords()
local ak,ch
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
      -- CSay(cplayer.." is going to walk to ("..mx..","..my..")")
      Actors.WalkTo(cplayer,mx+Maps.CamX,my+Maps.CamY)
      WalkArrival = nil
      -- Actors.MoveTo(cplayer,mx+Maps.CamX,my+Maps.CamY)
      end
   end
if mousehit(2) then
   if my>500 then  -- must come prior to checks in the field
      for ak=0,5 do
          if RightClickedChar(ak) then
             ch = RPGChar.PartyTag(ak)
             if ch~="" and ch~="UniWendicka" and ch~="UniCrystal" and ch~="Briggs" then activeplayer = ch end 
             end
          end
      end
   end   
end

function SetPlayer(P) cplayer=P end
function SetActive(P) activeplayer=P end

function SetScrolling(set,rsx,rsy,rex,rey)
scrolling = set==true or set=="true" or set=="TRUE" or sval(set)==1
if rsx then scrollrange = {rsx=Sys.Val(rsx),rsy=Sys.Val(rsy),rex=Sys.Val(rex),rey=Sys.Val(rey)} end
end

function DestroyScrollRage() scrollrange={} end

function SetAutoScroll(yesorno)
scrolling = yesorno == "yes"
end

function AutoScroll()
if not scrolling then return end
local px,py = GetCoords(cplayer)
local sx = px - 400
local sy = py - 300
--[[
if scrollrange.rsx and sx<scrollrange.rsx then sx=scrollrange.rsx end
if scrollrange.rsy and sy<scrollrange.rsy then sy=scrollrange.rsy end
if scrollrange.rex and sx>scrollrange.rex then sx=scrollrange.rex end
if scrollrange.rey and sy>scrollrange.rey then sy=scrollrange.rey end
]]
Maps.CamX = sx
Maps.CamY = sy
if ScrollBoundaries.minx and ScrollBoundaries.minx>Maps.CamX then Maps.CamX=ScrollBoundaries.minx end
if ScrollBoundaries.maxx and ScrollBoundaries.maxx<Maps.CamX then Maps.CamX=ScrollBoundaries.maxx end
if ScrollBoundaries.miny and ScrollBoundaries.miny>Maps.CamY then Maps.CamY=ScrollBoundaries.miny end
if ScrollBoundaries.maxy and ScrollBoundaries.maxy<Maps.CamY then Maps.CamY=ScrollBoundaries.maxy end
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
     MS.Run("MAP",WalkArrival,WalkArrivalArg)
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
-- local minenemies = {1,2,3}
-- local maxenemies = {3,6,9}
local hilevel,diflevel
local myleveltotal,partymembers,ptag
local enemiesmain = Maps.GetData("Foes")
FieldFoes = {} 
if (not enemiesmain) or enemiesmain=="" then return CSay("No enemy data found in this map") end
local enemymainlist = mysplit(enemiesmain,";")
local enemies = {}
local es,ea
local layers = { [0]={"* NOT MULTIMAP *"},[1]=mysplit(Maps.Layers(),";") }
local orilay = Maps.LayerCodeName
for es in each(enemymainlist) do
    ea = mysplit(es,",")
    ea[2] = Sys.Val(ea[2] or "1")
    for ak=1,ea[2] do
        table.insert(enemies,ea[1])
        end
    end 
arena = Maps.GetData("Arena")
if not suffixed(upper(arena),".PNG") then arena = arena .. ".png" end
-- Make sure there are no foes in the field
CSay("Searching for existing foes")
for lay in each(layers[Maps.Multi()]) do
	if Maps.Multi()==1 then Maps.GotoLayer(lay) end
	for obj in KthuraEach("Actor") do
		CSay("Checking: "..obj.Kind.." "..obj.Tag.."; Got suffix "..sval(suffixed(obj.Tag,"FoeActor")))
		if suffixed(obj.Tag,"FoeActor") then
			Maps.Obj.Kill(obj.Tag); CSay("Killed foe: "..obj.Tag.." (Obj #"..obj.IDNum..")")
			end 
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
for lay in each(layers[Maps.Multi()]) do
	CSay(' = Foes on Layer: '..lay)
	if Maps.Multi()==1 then Maps.GotoLayer(lay) end
	for obj in KthuraEach() do
		-- CSay("   = Seen: "..obj.IDNum.."; "..obj.Tag.."; "..obj.Kind) -- Debugline
		if prefixed(obj.Kind,"$Enemy") and (not suffixed(obj.Kind,"Boss")) then
			CSay("  = Process: "..obj.IDNum.."; "..obj.Tag.."; "..obj.Kind)
			FieldFoes[obj.Tag] = {  }       
			foe = FieldFoes[obj.Tag]
			foe.me = obj.Tag
			foe.Work = right(trim(obj.Kind),3)
			foe.Go = left(foe.Work,2)
			foe.Skill = Sys.Val(right(foe.Work,1))     
			if skill<foe.Skill then
				CWrite("  = Rejected. Not meant for this skill level",255,0,0)
				FieldFoes[obj.Tag] = nil
			else
				foe.OriPos = { X = obj.X, Y = obj.Y }
				foe.Actor = obj.Tag .. " FoeActor"
				foe.Tag = foe.Actor
				foe.Layer = lay
				CSay("  = Spawning actor")
				Actors.Spawn(obj.Tag,"GFX/FIELD/ENCOUNTER.PNG",foe.Tag,1)
				CSay("  = Configuring actor ( skill = "..skill.." ) ")
				Maps.Obj.Pick(foe.Tag)
				foe.Enemies = {}
				--[[ old
				num = rand(minenemies[skill],maxenemies[skill])
				]]
				-- new
				repeat
					num = rand(1,9)
				until num<1+(skill) or (rand(1,num*((4-skill)*(4-skill)))<=skill and rand(1,num*num*(4-skill))==1)
				hilevel = 0
				for ak=1,num do
					foe.Enemies[ak] = 
					{
						level = rand(lvrange[1],lvrange[2]),
						foe   = enemies[rand(1,#enemies)]
					}
					if hilevel<foe.Enemies[ak].level then hilevel=foe.Enemies[ak].level end
				end
				diflevel = hilevel - mylevel
				CSay("  = MyLevel="..mylevel.."; HiLevel="..hilevel.."; DifLevel="..diflevel)    
				if diflevel<-10 then
					R = 0
					G = 255
					B = 0
					foe.radius = 50
					CSay("  = Too Easy")
				elseif diflevel<=0 then
					R = 180
					G = 255
					B = 0
					foe.radius = 150
					CSay("  = Easy")
				elseif diflevel<10 then
					R = 255
					G = 180
					B = 0
					foe.radius = 300
					CSay("  = Hard")
				else
					R = 255
					G = 0
					B = 0
					foe.radius = 600
					CSay("  = Too Hard")
				end   
				CWrite("  = Adjusting color of object "..Maps.Obj.MyObject.Tag.."  to ("..R..","..G..","..B..")",R,G,B)   
				Maps.Obj.SetColor(R,G,B)
				--foe.obj = nil
			end
		elseif suffixed(obj.Kind,"Boss") and prefixed(obj.Kind,"$Enemy") then
			CSay("Boss found: "..obj.Tag)
			FieldFoes[obj.Tag] = {  }       			
			foe = FieldFoes[obj.Tag]
			foe.Actor = obj.Tag .. " FoeActor"
			foe.Tag = foe.Actor 
			foe.me = obj.Tag
			foe.Go = "Boss"
			foe.OriPos = { X = obj.X, Y = obj.Y }
			foe.event = obj.DataGet("BOSSFUNCTION")
			foe.barrier = obj.DataGet("LINKEDBARRIER")
			CSay("= Function: "..foe.event)
			CSay("= Barrier:  "..foe.barrier)
			--CSay("= Datadump: "..obj.DataDump())
			Maps.Obj.Obj(foe.barrier).Impassible = 1
			Maps.Obj.Obj(foe.barrier).Visible = 1
			Maps.Remap()
			Actors.Spawn(obj.Tag,"GFX/FIELD/Boss.PNG",foe.Tag,1)
			Maps.Obj.Pick(foe.Tag)
			Maps.Obj.SetColor(255,0,0)
			--CSay("WARNING! This level contains a boss, but the system is not yet set up for that.")      
		end
	end
end 
if Maps.Multi()==1 then Maps.GotoLayer(orilay) end
end



function ResetFoePositions()
--[[
local k,foe,obj
if not FieldFoes then return end
for k,foe in spairs(FieldFoes) do
    if not foe.OriPos then
      CSay("WARNING! No OriPos set for foe: "..k)
      else
      obj = Actors.Actor(foe.Tag)
      obj.X = foe.OriPos.X
      obj.Y = foe.OriPos.Y
      end
    end
]]    
end

-- @IF *DEVELOPMENT
function ToggleFoeRadius()
FoeRadius = not FoeRadius
end
-- @FI

function FoeList()
local f = serialize("FieldFoes",FieldFoes)
local r,g,b = 0,0,0
for l in each(mysplit(f,"\n")) do
    r = r + 10
    if r>255 then r=0; g=g+10 CWrite("Hit SPACE...") Console.Show() Console.Flip() repeat INP.Grab() until INP.KeyH(32)~=0 end
    if g>255 then g=0; b=b+10 end
    if b>255 then b=0 end
    CWrite(l,r,g,b)
    end
CWrite("Current skill: "..sval(skill))    
end 

function FoeChase(foe)
local player = Actors.Actor(cplayer)
Actors.WalkTo(foe.Tag,player.X,player.Y)
end

function FoeActive(foe)
local player = Actors.Actor(cplayer)
local enemy  = Actors.Actor(foe.Tag)
return Distance(player.X,player.Y,enemy.X,enemy.Y)<=foe.radius
end

function GetEncTracks()
local f
local ret = {}
if not musicavailable then return {"NOMUSIC.OGG"} end
for f in iJCR6Dir() do
    if prefixed(upper(f),"MUSIC/ENCOUNTER/") then table.insert(ret,f) end 
    end
return ret
end

function StartEncounter(foe)
FX.FallDown("PARTY","ShowParty")
Image.Cls()
MS.Run("PARTY","ShowParty")
if foe.event then
   MS.Run("MAP",foe.event)
else   
   Loading()
   local k,v,i
   -- Destroy all old shit we got
   for k in IVARS() do
    if prefixed(k,"$COMBAT.") or prefixed(k,"%COMBAT.") or prefixed(k,"&COMBAT.") then 
       Var.Clear(k)
       CSay("Destroyed: "..k) 
       end 
    end
   -- Let's now define the new shit we got    
   Var.D("$COMBAT.BACKGROUND",arena)
   Var.D("$COMBAT.BEGIN","Default")
   encmusic = encmusic or GetEncTracks()    
   if Maps.GetData("AltEncounterMusic")~="" then Var.D("$COMBAT.MUSIC",Maps.GetData("AltEncounterMusic")) else Var.D("$COMBAT.MUSIC",encmusic[rand(1,#encmusic)]) end
   for i,v in ipairs(foe.Enemies) do
       Var.D("$COMBAT.FOE"  ..i,v.foe)
       Var.D("%COMBAT.LVFOE"..i,v.level)
       end
   end    
-- Remove the foe from the field
if not foe.me then -- This routine was needed due to an old bug. It may not serve much purpose in the main game.
   for k,v in pairs(FieldFoes) do if v==foe then foe.me=k end end
   end
FieldFoes[foe.me] = nil
Maps.Obj.Kill(foe.Tag)    
--[[ Debugging. Music routine claims to have receive a nil value (which is not possible no matter how you explain things, but still it reports it, so let's see what we got here.       
for k in IVARS() do
    CSay(k.." = "..Var.C(k))  
    end
--]]     
-- All the shit defined so let combat commence.    
if not foe.event then StartCombat() end -- Events need to start the combat by itself. This makes "fake bosses" possible :)
if foe.barrier then
   Maps.Obj.Obj(foe.barrier).Impassible = 0
   Maps.Obj.Obj(foe.barrier).Visible = 0
   Maps.Remap()
   end
end

function ControlFoes()
local foe
local player = Actors.Actor(cplayer)
local maxdistance
if not FieldFoes then return end
for obj in KthuraEach("Actor") do
    maxdistance=16 -- When the player comes within this distance, let's kill him/her :)    
    foe = FieldFoes[replace(obj.Tag," FoeActor","")]
    -- CSay("We got a foe on  : "..obj.Tag.." >> "..sval(foe~=nil))
    -- CSay("We got suffix on : "..obj.Tag.." >> "..sval(suffixed(obj.Tag,"FoeActor")))
    if foe and obj.Visible>0 and suffixed(obj.Tag,"FoeActor")  and (Maps.Multi()==0 or Maps.LayerCodeName==foe.Layer) then
       (({   -- Switch
          HZ = function ()  -- Horizontaal
               if FoeActive(foe) then 
                 FoeChase(foe)
               else
                 if foe.GoEast then Actors.MoveTo(obj.Tag,obj.X+10,obj.Y) else Actors.MoveTo(obj.Tag,obj.X-10,obj.Y) end
                 if obj.X==foe.OldX and obj.Y==foe.OldY then foe.GoEast=not foe.GoEast foe.OldX=nil else foe.OldX=obj.X foe.OldY=obj.Y end 
                 end 
               end,
          VT = function () -- Verticaal
               if FoeActive(foe) then 
                 FoeChase(foe)
               else
                 if foe.GoSouth then Actors.MoveTo(obj.Tag,obj.X,obj.Y+10) else Actors.MoveTo(obj.Tag,obj.X,obj.Y-10) end
                 if obj.X==foe.OldX and obj.Y==foe.OldY then foe.GoSouth=not foe.GoSouth foe.OldY=nil else foe.OldX=obj.X foe.OldY=obj.Y end 
                 end 
               end,     
          SS = function() -- Sta Stil!     
               if FoeActive(foe) then 
                 FoeChase(foe)
                 end 
               end,
          AS = function() -- Altijd Stilstaan
               end  ,
          Boss = function() -- Eindbazen staan altijd stil
                 maxdistance = 32 -- Bosses are bigger, so a bigger range to start the battle!
                 end        
       })[foe.Go] or function() Sys.Error("Unknown go code for foe #"..obj.IdNum,"Tag,"..obj.Tag..";Go,"..foe.Go) end)()        
       if Distance(player.X,player.Y,obj.X,obj.Y)<=maxdistance then  
          CSay("Start encounter: "..obj.Tag)    
          StartEncounter(foe)
          return -- An encounter has begun, so this way, we can make sure a second one won't start
          end
       end
    end
end

function PlaceTreasures()
	local layers = {"*"} -- In non multi-map we need at least one "layer"
	local originallayer
	-- if Maps.Multi()==1 then originallayer = Maps.LayerCodeName end
	if Maps.Multi()==1 then 
		layers = mysplit(Maps.Layers(),";") 
		originallayer=Maps.LayerCodeName 
	end	
	for lay in each(layers) do
		if Maps.Multi()==1 then Maps.GotoLayer(lay) end
		for obj in KthuraEach('Obstacle') do -- Remove all existing items to prevent conflicts			
			if prefixed(obj.Tag,"Item.") then 
				Maps.Obj.Kill(obj.Tag) 
			end			
		end	
	end
	CSay("Placing in treasures")
	local k,treas
	for k,treas in spairs(FieldTreasure or {}) do
		if Maps.Multi()==1 then Maps.GotoLayer(treas.layer) end
		Maps.CreateObstacle(treas.x,treas.y,treas.icon,treas.objtag)
		Maps.Obj.Pick(treas.objtag)  --CSay("Pick")
		Maps.Obj.MyObject.Dominance = treas.dominance  -- CSay("Dominance")
		Maps.Obj.MyObject.Labels = treas.labels       -- CSay("Labels")
		Maps.Obj.MyObject.Impassible = 0
		CSay("  = Placed: "..k)
	end
	if Maps.Multi()==1 then 
		Maps.MultiRemap()
		Maps.GotoLayer(originallayer) 
	else
		Maps.Remap()    
	end
end

function SetUpTreasure(layerswitch) -- if layerswitch is set to 1 only reset this layer. if layerswitch is set to 2 only setup if the layer has not been setup yet. If not a multi-map or if layerswitch is nil, everything will work normally.
	local treasurestring
	local treasurestringarray = {}
	local treasures = {}
	local pt = ngpcount or 1
	local i,t,tra
	local crate,ctag,addit,vtag,iratesk1,irate -- all needed for the Special Items
	-- Get treasures from map itself
	CSay("Find treasure from map itself")
	CSay("Playthrough #"..pt)
	for i = 1 , pt do
		t = Maps.GetData("PT"..right("   "..pt,3).." Items")
		if t~="" then table.insert(treasurestringarray,t) end    
	end
	-- Compile into a workable array
	treasurestring=join(treasurestringarray,";")
	for t in each(mysplit(treasurestring,";")) do
		tra = mysplit(t,",")
		if #tra~=2 then Sys.Error("Invalid treasure definition in this map! > "..t) end
		for i=1,Sys.Val(tra[2]) do        
			table.insert(treasures,trim(tra[1]))
		end
	end
	if #treasures==0 then CSay("No treasure in this map."); return end
	-- Let's place in all the treasure
	FieldTreasure = {}
	local add,itemnr,itemcode,item
	local layers = {"*"} -- In non multi-map we need at least one "layer"
	local orilayer
	if Maps.Multi()==1 then layers = mysplit(Maps.Layers(),";") orilayer=Maps.LayerCodeName end
	for lay in each(layers) do
		if Maps.Multi()==1 then Maps.GotoLayer(lay) end
		for obj in KthuraEach('$Item') do
			if (rand(1,(skill)*3)==1) then
				itemnr = rand(1,#treasures)
				itemcode = treasures[itemnr]
				if prefixed(itemcode,"ONCE:") then
					itemcode = right(itemcode,len(itemcode)-5)
					table.remove(treasures,itemnr)
				end
				if not itemcode then
					CSay("Error! Item code became 'nil'. Let's sort this out!")
					DBGSerialize(treasures)
					CSay("itemnr = "..itemnr)
				end   
				item = ItemGet("ITM_"..itemcode)
				add = {
					x = obj.X,
					y = obj.Y,
					spottag = obj.Tag,
					labels = obj.Labels,
					dominance = obj.Dominance,
					objtag = "Item."..obj.Tag,
					item = itemcode,
					layer = lay,
					icon = item.Icon
				}
				FieldTreasure[obj.Tag] = add          
			end
		end -- for obj
	end -- for layer
	for lay in each(layers) do
		if Maps.Multi()==1 then Maps.GotoLayer(lay) end
		for obj in KthuraEach("$SpecialItem") do
			ctag = obj.Tag
			addit = true
			vtag = "%TREASURE_RATE["..ctag.."]"
			iratesk1=nil
			irate = obj.DataGet("RATE")
			item = ItemGet('ITM_'..obj.DataGet("ITEM"))
			if obj.DataGet("RATE")=="INF" then
				crate=nil
			elseif obj.DataGet("RATE")=="UNIQUE" then
				addit = not( CVVN(vtag) and CVV(vtag)>0 )
				crate=1
			else
				crate = CVVN(vtag) or 1
				addit = rand(1,crate)<=1
				if skill==1 then iratesk1=obj.DataGet('S1RI') end
			end        
			add = {
				x = obj.X,
				y = obj.Y,
				spottag = obj.Tag,
				labels = obj.Labels,
				dominance = obj.Dominance,
				objtag = "Item."..obj.Tag,
				item = obj.DataGet("ITEM"),
				rate = crate,
				irate = irate,
				iratech = iratesk1,
				vtag = vtag,
				layer = lay,
				icon = item.Icon
			}
			if addit then
				CSay("Added special item: "..add.item) 
				FieldTreasure[obj.Tag]=add
			else
				CSay("Addition of special item \""..add.item.."\" has been rejected")    
			end
		end -- for obj
	end -- for layer
	PlaceTreasures()
	if Maps.Multi()==1 then Maps.GotoLayer(orilayer) end
end 

function FindTreasures()
	local k,t
	local px,py,given,idata
	Maps.Obj.Pick(cplayer)
	px = Maps.Obj.MyObject.X
	py = Maps.Obj.MyObject.Y
	for k,t in spairs(FieldTreasure) do
		if Maps.Multi()==0 or Maps.LayerCodeName==t.layer then
			if Distance(px,py,t.x,t.y)<32 then
				given = ItemGive("ITM_"..t.item,{activeplayer})
				if (not given) and (not Done("&TUTORIAL.BAGSFULL")) then
					Actors.StopWalking(cplayer)
					MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
					MS.Run("BOXTEXT","LoadData","TUTORIAL/BAGSFULL;BAGSFULL")
					SerialBoxText("BAGSFULL",upper("FULL."..activeplayer)) --,"Field")
          SerialBoxText("BAGSFULL","TUTORIAL_FULL") --,"Field")
          MS.Run("BOXTEXT","RemoveData","BAGSFULL")
		end  
	  end
	  if given then 
          idata = FieldTreasure[k]
          FieldTreasure[k]=nil 
          Maps.Obj.Kill(t.objtag) 
          if idata.rate then
			  if rand(1,idata.iratech or 1)<=1 then Var.D(idata.vtag,(idata.rate or 1) + (idata.irate or 1)) end
		  end  -- rate
		end -- given  
	  end    -- multi
  end -- for k,t
end -- function

function SetUpAutoClickables()
local prefixes = {"NPC_","ARMCHST"}
local p
for obj in KthuraEach() do
    for p in each(prefixes) do 
        if prefixed(obj.Tag,p) then AddClickable(obj.Tag) CSay("Autoclickable "..obj.Tag.." added") end
        end
    end
end


function SwitchLayer(layer,forcenewsetup) -- forcenewsetup may ONLY be done by LoadMap() and MUST also be done by LoadMap() :)
	if Maps.Multi()==0 then return end -- when we got not layer, we cannot switch layers anyway
	CSay("Switching to map layer: "..layer)
	Maps.GotoLayer(layer)
	MS.Run("MAP","OnLayerSwitch",layer)
	--[[ I thought of a better more efficient solution than the crap I had in mind first.
	local l = 2
	if forcenewsetup then l = nil end
	SetUpFoes(l)
	SetUpTreasure(l)
	]]
end



function LoadMap(map,layer)
FieldFoes = nil -- Let's just FORCE enemies will NOT mess this up.
Loading()
PartyPopArray = nil
ScrollBoundaries = {}
Maps.Load(map)
 if Maps.Multi()==1 then 
	if layer and layer~="" then SwitchLayer(layer,true) end
	end
SetUpFoes()
SetUpTreasure()
SetUpAutoClickables()
Var.Clear("$MAP.MAPSHOW.LASTREQUEST")
Var.Clear("$MAP.MAPSHOW.LASTALWAYSSHOW")
end

function PartyPop(TagPrefix,Wind)
Actors.Actor("PLAYER").Visible = 0
local ak,ch
PartyPopArray = {}
PartyPopArray.Actors = {}
for ak=0,5 do
    ch = RPGChar.PartyTag(ak)
    if ch~="" then 
       table.insert(PartyPopArray.Actors,ch)
       Actors.Spawn("PLAYER","GFX/Actors/Player","POP_"..ch)
       Actors.MoveToSpot("POP_"..ch,TagPrefix.."_"..ch)
       Actors.ChoosePic("POP_"..ch,upper(ch).."."..upper(Wind or "North"))
       end
    end
end

function PartyUnPop()
if not PartyPopArray then return end
local ch
for ch in each(PartyPopArray.Actors) do
    Actors.MoveToSpot("POP_"..ch,"PLAYER")    
    end
WalkWait(PartyPopArray.Actors)    
for ch in each(PartyPopArray.Actors) do
    Maps.Obj.Kill("POP_"..ch)    
    end
Actors.Actor("PLAYER").Visible = 1    
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
-- @IF ALLOW_EMERGENCYSAVE
if LAURA.GetFlow()~="FIELD" then return end
if ES_Time~=Time.Time() then
   EM_Second = (EM_Second or -1) + 1
   if EM_Second>=maxtime then
      Loading()
      LAURA.Save("System/Emergency",1)
      EM_Second = nil
      MINI("Emergency file has been written")
      end
   ES_Time = Time.Time()
   end
-- @FI   
-- @IF EMSAVEDEBUG
DarkText("Save timer: "..sval(EM_Second),10,10)
-- @FI
end

function ScheduledExecution()
local ev
for ev in each(Scheduled) do
    CSay("Scheduled Execution: "..ev.MS.."."..ev.FN)
    MS.Run(ev.MS,ev.FN) 
    end
Scheduled = {}    
end

function Schedule(scr,func)
table.insert(Scheduled,{MS=scr,FN=func})
CSay("Scheduled: "..scr.."."..func)
end

function ListScheduled()
local ev
for ev in each(Scheduled) do
    CSay("   "..ev.MS.."."..ev.FN)
    end
CSay(" "..#Scheduled.." event(s) listed for execution")    
end

function MAIN_FLOW()
DrawScreen()
ScheduledExecution()
Click()
AutoScroll()
ZoneAction()
WalkArrivalCheck()
Termination()
EmergencySave()
ControlFoes()
FindTreasures()
Flip()
end
