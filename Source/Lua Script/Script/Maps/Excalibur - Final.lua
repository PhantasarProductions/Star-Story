--[[
**********************************************
  
  Excalibur - Final.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 16.07.15
]]

-- @USE /Script/Use/Maps/Gen/Schuif.lua

-- @USEDIR Script/Use/Maps/AltArena

chats = 1

center=400

Names = {
            ['#000'] = 'Secret Hangar',
            ['#001'] = 'Hidden layer',
            ['#002'] = 'Security department',
            ['#003'] = 'Lady of the Lake - Artificial Park',
            ['#004'] = 'Coder Section - LAURA',
            ['#005'] = 'Residential Area - Galahad',
            ['#006'] = 'Junk collection area - Donald',            
            ['#008'] = 'Coder Section - BLITZ',
            ['#012'] = 'Junk collection area - Geert',
            ['#016'] = 'Coder Section - LUA',
            ['#018'] = 'Junk collection area - Marine',
            ['#019'] = 'Staff department',
            ['#020'] = 'High Security Department'
        }; names=Names
        
keycolors = {RED = {255,0,0}, GREEN={0,255,0},BLUE={0,0,255},GOLD={255,180,0}}        

keyopen = {}
        
Image.Load("GFX/Textures/Excalibur/Keycard.png","EX_KEYCARD")

keyinsysvar = "$DITISVIEZEVUILEKUTCODEDIEJEVOORALNIETMOETLEZENENWAARIKEERDERVANBAALDANTROTSOPBENMAARDAARCODEVOLGENSDEREGELSNIETWILWERKENDANDOENWEHETMAAROPDESHITMETHODE.HETZOUDEKEYCARDSINEXCALIBURINIEDERGEVALMOETENLATENWERKEN.HOOPIK"
        
function initkeycards() 
    keycards = {}
    CSay('KeyCards reset as requested!')     
end     

function HangarEntrance()
   local left  = Maps.Obj.Obj("EntranceLeft")
   local right = Maps.Obj.Obj("EntranceRight")
   left.X = left.X-39
   right.X = right.X+39
   local PLAYER = Actors.Actor("PLAYER")
   local Barrier = Maps.Obj.Obj("BlockStart")
   Barrier.Impassible = 0
   Maps.Remap()
   Actors.MoveToSpot("PLAYER","BeginDungeon")
   repeat
     DrawScreen()
     CSay("Player on Y: "..PLAYER.Y)
     Flip()
   until PLAYER.Y>=365
   for i=39,0,-1 do
       left.X=left.X+1
       right.X=right.X-1
       DrawScreen()
       Flip()
   end  
   if not(Done('&DONE.EXCALIBUR.WENDICKAWELCOMEBACK')) then MapText("WENDICKA_WELCOMEBACK") end
   Barrier.Impassible = 1
   Maps.Remap()
end   

function GetKey(pname)
  local Name = upper(pname)
  local lay = Maps.LayerCodeName
  assert(keycolors[Name],"No keycard with color "..Name)
  MINI(Name.." keycard found",keycolors[Name][1],keycolors[Name][2],keycolors[Name][3])
  keycards[lay][Name] = true
  Maps.Obj.Kill("NPC_"..Name,1)
  Var.D(keyinsysvar,serialize('ret',keycards))
  SFX('Audio/Sfx/Yeah/Yeah.ogg')
end

function NPC_RED  ()  GetKey('RED')   end
function NPC_GREEN()  GetKey('GREEN') end
function NPC_BLUE()   GetKey('BLUE')  end
function NPC_GOLD()   GetKey('GOLD')  end

function FinalMapShow()
  local floors = {'BASE'}
  local LAY = Maps.LayerCodeName
  keyopen[LAY] = keyopen[LAY] or {}
  for c in each({'RED','GREEN','BLUE','GOLD'}) do
      if keyopen[LAY][c] then floors[#floors+1]="K_"..c end
  end
  MapShow(join(floors,","))
end


function ToDungeon()
   Var.Clear('&IGNORE.TRANSPORTER')
   Maps.Obj.Kill("PLAYER")
   Maps.GotoLayer("#001")
   SpawnPlayer('BeginMetNummer1')
end

function ToHangar()
   Maps.Obj.Kill("PLAYER")
   Maps.GotoLayer("#000")
   SpawnPlayer('From001')
end

function Opslaan()
   GotoSave()
end

function TerugNaarHawk()
   local node = "EXN"..math.ceil(tonumber(right(Maps.LayerCodeName,3))/5)
   MS.LN_Run("TRANS","Script/SubRoutines/Transporter.lua","ReDefNode","F"..right(Maps.LayerCodeName,3)..";".."Excalibur - Final;Excalibur;"..Names[Maps.LayerCodeName]..";"..Maps.LayerCodeName..";"..node)
   TelEffect(TEL_OUT)
   if CVV('&JOINED.JOHNSON') then MapText('JOHNSON_LEAVE') end
   LoadMap("Hawk","Bridge")
   SpawnPlayer("Scotty","South")
   Party("Wendicka","Crystal","Yirl","Foxy","Xenobi","Rolf")
   if not(Done("&DONE.HAWK.ROLF.WELCOME.BACK")) then MapText("ROLF_IS_BACK") end
end

function InternStralen()
   Var.D("$EXCALIBURTRANSPORT","return  { "..serialize('keys',keycards)..", "..serialize('locs',Names).." }")
   MS.LoadNew("EXCATRANS","Script/Flow/Excalibur_Transport.lua")
   MS.Run('EXCATRANS','TransferVarsFromMap')
   LAURA.Flow('EXCATRANS')
   -- Sys.Error('This feature is not yet implemented') 
end

function CancelTrans() end -- This function just had to exist, that's all

function Transporter()
     -- ReDefNode(tag,mapcode,world,location,layer,node)
     FinalMapShow()
     if Done("&IGNORE.TRANSPORTER") then return end
     Actors.Actor('PLAYER').Walking=0
     Actors.Actor('PLAYER').Moving=0
     Actors.MoveToSpot('PLAYER',"Trans.Spot.F"..right(Maps.LayerCodeName,3))
     local i = RunQuestion('MAP','TRANSPORTER')
     TurnPlayer('South')
     ;(({ InternStralen, TerugNaarHawk, Opslaan, CancelTrans })[i] or function() Sys.Error("Unknown transporter answer code (#"..i..")") end)()
end


function Trans_GOTO(parea)
  local area = parea or Var.C('$EXCAL_IWANTTOGOTO')
  if area==Maps.LayerCodeName then return end
  TelEffect(TEL_OUT)
  Maps.Obj.Kill('PLAYER')
  Maps.GotoLayer(area)
  SpawnPlayer("Trans.Spot.F"..right(area,3))
  FinalMapShow()
end

function MAP_FLOW()
  local lay = Maps.LayerCodeName
  keycards = keycards or {} -- crash prevention. This line may actually never be needed!
  keycards[lay] = keycards[lay] or {}
  local kcc = keycards[lay]
  SetFont('ExFinal')
  DarkText(names[lay],center,2,2,0,180,0,255)
  local kx=center
  kx = kx - (17*2)
  for kn in each({'RED','GREEN','BLUE','GOLD'}) do
      if keycards[lay][kn] then  
         Image.Color(keycolors[kn][1],keycolors[kn][2],keycolors[kn][3])
      else
         Image.Color(80,80,80)
      end      
      Image.Draw("EX_KEYCARD",kx,15)
      kx = kx + 17
  end
end


function OpenKeyDoor(color)
  local c = upper(color)
  local L = Maps.Obj.Obj(c.."_LINKS")
  local R = Maps.Obj.Obj(c.."_RECHTS")
  local LAY = Maps.LayerCodeName
  if not keycards[LAY][c] then return end
  keyopen[LAY] = keyopen[LAY] or {}
  if keyopen[LAY][c] then return end
  keyopen[LAY][c] = true  
  MINI(c.." access granted",keycolors[c][1],keycolors[c][2],keycolors[c][3])
  Maps.Obj.Kill("OPEN_"..c)
  L.Impassible = 0
  R.Impassible = 0
  Maps.Remap()
  for i=1,30 do
      L.X = L.X - 1
      R.X = R.X + 1
      DrawScreen()
      Flip()
  end
  FinalMapShow()    
end

function Admiraal()
  if Done('&JOINED.JOHNSON') then return end
  -- Yeah, admiral Johnson will join the group
  PartyPop('adm','South')
  Maps.Obj.Obj('Reggie').Visible=1
  MapText('ADMIRAAL1')
  Actors.Spawn('go_admiraal','GFX/Actors/Player','Johnson')
  Actors.ChoosePic('Johnson','JOHNSON.NORTH')
  -- Actors.MoveToSpot('Johnson','go_admiraal',1) -- No matter what I do, things refuse to work :(
  --AddPartyPop('Johnson')
  repeat
     Maps.CamY = Maps.CamY + 1
     DrawScreen()
     Flip()
  until Maps.CamY>=800
  MapText('ADMIRAAL2')
  KickReggie('East','POP_Foxy','Reggie')
  MapText('ADMIRAAL3')
  Party('Wendicka','Crystal','Johnson','Yirl','Foxy','Xenobi')
  SyncLevel('Johnson') -- In the new game + we must make sure her stats are properly updated.
  RPGChar.SetName("Johnson","Admiral Johnson")
  Var.D("$JOHNSON","Johnson")
  Maps.Obj.Kill('Johnson')
  Maps.Obj.Obj('Reggie').Visible=0
  PartyUnPop()
  -- Sys.Error("I'm sorry! This leads to a part that is not yet properly scripted. Please come back soon!")
end

function ExecChat(i)
   if not Done('&DONE.EXCALIBUR.FINAL.CHAT['..i..']') then MapText('CHAT'..i) end
end   

function Boss(BossFile,track)
local cyb = {'Gunner','Medic','Captain'}
local lvmul = {.50,.75,1}
CleanCombat()
local lv = MapLevel()*lvmul[skill]
local subjects = ({2,4,8})[skill]
local x,y,si
-- Background data
Var.D("$COMBAT.BACKGROUND",AltArena['EXCALIBUR - FINAL'][Maps.LayerCodeName] or "Excalibur.png")
-- Var.D("$COMBAT.VICTORYCHECK","Flirmouse_King")
Var.D("$COMBAT.BEGIN","Default")
-- The boss him/herself
Var.D("$COMBAT.FOE1","Boss/"..BossFile)
Var.D("%COMBAT.LVFOE1",lv)
Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
local base = {300,400}
local subjectxy = {
                     {0,-100},
                     {0, 100},
                     { 100,0},
                     {-100,0},
                     
                     { 50, 50},
                     {-50, 50},
                     { 50,-50},
                     {-50,-50} 
                  }

for i=1,subjects do 
    si = i + 1
    Var.D("$COMBAT.FOE"..si,"Reg/Cyborg "..cyb[rand(1,#cyb)])
    Var.D('%COMBAT.LVFOE'..si,lv/(4-skill))
    -- x = 300+(math.sin(((i-1)/(subjects))*360)*200)
    -- y = 400+(math.cos(((i-1)/(subjects))*360)*100)
    x = base[1]+subjectxy[i][1]
    y = base[2]+subjectxy[i][2]
    CSay("Subject #"..i.." is set to coordinates ("..x..","..y..")")
    Var.D("$COMBAT.ALTCOORDSFOE"..si,x..","..y)
    end
Var.D("$COMBAT.MUSIC",track )    
StartCombat()
end    




function Boss005()
  if Done('&DONE.BOSS005') then return end
  MapText('BOSS005.'..upper(GetActive()))
  -- Sys.Error('The rest is not yet scripted')
  Maps.Obj.Kill("SuperCyborg",1)
  Schedule("MAP","PostBoss005")
  Boss("SuperCyborg","SpecialBoss/Exit the premises.ogg")
end

function PostBoss005()
  Award('BOSS_SUPERCYBORG')
end  

function GoHome() 
  LoadMap('Excalibur_Home')
  SpawnPlayer('Voordeur')
end

function GALE_OnLoad()
   --if not (Done("&DONE.INIT.EXCALIBUR.KEYS")) then initkeycards() end
   --CSay(serialize('keycards',keycards))
   local getkeycard = loadstring(CVV(keyinsysvar).."\n\nreturn ret")
   keycards = (getkeycard or function() Sys.Error("Error generated in getting keycard data") end)()
   MS.LoadNew("PARTY","Script/Subroutines/Party.lua")
   if (CVV("&JOINED.JOHNSON")) then
      Party("Wendicka","Crystal","Yirl","Foxy","Xenobi","Johnson")
      SyncLevel('Johnson')
      if not CVV('&IGNORE.TRANSPORTER') then MapText("JOHNSON_BACK") end -- temp crash prevention. A more neat solution is on the way.
   else
      Party("Wendicka","Crystal","Yirl","Foxy","Xenobi")
   end
   Music("Excalibur/Final.ogg")
   ZA_Enter("EntranceWalkSouth",HangarEntrance)
   ZA_Enter("ToDungeon",ToDungeon)
   ZA_Enter("TerugNaarHangar",ToHangar)
   ZA_Enter("Transporter",Transporter)
   ZA_Enter('OPEN_RED',OpenKeyDoor,'RED')
   ZA_Enter('OPEN_GREEN',OpenKeyDoor,'GREEN')
   ZA_Enter('OPEN_BLUE',OpenKeyDoor,'BLUE')
   ZA_Enter('OPEN_GOLD',OpenKeyDoor,"GOLD")
   ZA_Enter("Admiraal",Admiraal)
   ZA_Enter('Boss005',Boss005)
   ZA_Enter('Go Home',GoHome)
   ZA_Leave("Transporter",Var.Clear,'&IGNORE.TRANSPORTER')
   for i=1,chats do ZA_Enter('CHAT'..i,ExecChat,i) end
   Award('SCENARIO_FINALDUNGEON')
   FinalMapShow()
end
