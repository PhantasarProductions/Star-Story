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
 
version: 16.08.04
]]

-- [[ @USE /Script/Use/Maps/Gen/Schuif.lua ]]

-- @USEDIR Script/Use/Maps/AltArena

chats  = 7

center = 400

Names = {
            ['#000'] = 'Secret Hangar',
            ['#001'] = 'Hidden layer',
            ['#002'] = 'Security department',
            ['#003'] = 'Lady of the Lake - Artificial Park',
            ['#004'] = 'Coder Section - LAURA',
            ['#005'] = 'Residential Area - Galahad',
            ['#006'] = 'Junk collection area - Donald',
            ['#007'] = 'Camelot - Town Square',            
            ['#008'] = 'Coder Section - BLITZ',
            ['#009'] = 'Maintenance Deck',
            ['#010'] = 'Residential Area - Guinevere',
            ['#011'] = "Crystal's bar",
            ['#012'] = 'Junk collection area - Geert',
            ['#013'] = 'Casino',
            ['#014'] = 'Weapon Storage',
            ['#015'] = 'Medical department',
            ['#016'] = 'Coder Section - LUA',
            ['#017'] = 'Playground',
            ['#018'] = 'Junk collection area - Marine',
            ['#019'] = 'Staff department',
            ['#020'] = 'High Security Department',
            SECRET1  = 'Secret Science Lab',
            SECRET2  = 'Secret labyrinth of "the Mole"'
        }; names=Names
        
keycolors = {RED = {255,0,0}, GREEN={0,255,0},BLUE={0,0,255},GOLD={255,180,0}}        

keyopen = {}
        
Image.Load("GFX/Textures/Excalibur/Keycard.png","EX_KEYCARD")

keyinsysvar = "$DITISVIEZEVUILEKUTCODEDIEJEVOORALNIETMOETLEZENENWAARIKEERDERVANBAALDANTROTSOPBENMAARDAARCODEVOLGENSDEREGELSNIETWILWERKENDANDOENWEHETMAAROPDESHITMETHODE.HETZOUDEKEYCARDSINEXCALIBURINIEDERGEVALMOETENLATENWERKEN.HOOPIK"
        
floorflow = {
               ['#006'] = function()
                            local b = Maps.Obj.Obj('Conveyor')
                            b.InsertY = b.InsertY - rand(1,3)
                            if b.InsertY<-900 then b.InsertY = b.InsertY + 1800 end
                          end,  
               ['#012'] = function()
                            local j = Maps.Obj.Obj('JerrycanTrack')
                            j.InsertX = j.InsertX - 1
                            if j.InsertX<-400 then j.InsertX = j.insertX + 4000 end 
                          end     ,
               ['#018'] = function()
                            -- Define quick refs
                            local o = Maps.Obj.Obj('CONV_BAG')
                            local mt = 'Coordinate Marker Up'
                            local mrk = Maps.Obj.Obj(mt)
                            local lt = 'Len'
                            local lnm = Maps.Obj.Obj(lt)
                            -- Corrections
                            local hx,hy = -5,5
                            local exy = 100
                            local maxy = lnm.Y + lnm.H + exy
                            local miny = mrk.Y
                            local minx = mrk.X
                            -- Animate
                            if o.Y<miny then o.X = minx + maxy + hx; o.Y = miny + maxy + hy end -- Yes, x is set with maxy too. After all we got a perfect 45 degree angle.
                            o.X = o.X - 1
                            o.Y = o.Y - 1                            
                          end                 
            }     
            
function UnLockEmgSave()
  --Var.Clear('&BLOCK.EMERGENCY.SAVE')
  Var.D('&BLOCK.EMERGENCY.SAVE',"TRUE") -- The key system makes it too dangerous to have emergency saves. They can be done on moments that can lock you up eternally.
end
               
            
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
  -- Var.D(keyinsysvar,serialize('ret',keycards))
  MS.LN_Run("SFX","Script/Subroutines/SFX.lua","SFX",'Audio/Sfx/Yeah/Yeah.ogg'..";no")
  -- SFX('Audio/Sfx/Yeah/Yeah.ogg')
  UnLockEmgSave()
  if skill~=3 then 
    MapEXP()
    inc('%AURINARATE',6/skill) 
    end
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
   Loading()
   Var.D(keyinsysvar,serialize('ret',keycards))
   GotoSave()
end

function TerugNaarHawk()
   Loading()
   Var.D(keyinsysvar,serialize('ret',keycards))
   if left(Maps.LayerCodeName,1)~="#" then return MapText('NOHAWK') end
   local node = "EXN"..math.ceil(tonumber(right(Maps.LayerCodeName,3))/5)
   MS.LN_Run("TRANS","Script/SubRoutines/Transporter.lua","ReDefNode","F"..right(Maps.LayerCodeName,3)..";"..Maps.CodeName..";Excalibur;"..Names[Maps.LayerCodeName]..";"..Maps.LayerCodeName..";"..node)
   TelEffect(TEL_OUT)
   DrawScreen() Flip()
   DrawScreen() Flip()
   if CVV('&JOINED.JOHNSON') then MapText('JOHNSON_LEAVE') end
   LoadMap("Hawk","Bridge")
   SpawnPlayer("Scotty","South")
   Party("Wendicka","Crystal","Yirl","Foxy","Xenobi","Rolf")
   if not(Done("&DONE.HAWK.ROLF.WELCOME.BACK")) then MapText("ROLF_IS_BACK") end
end

function InternStralen()
   Loading()
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
  DrawScreen() Flip()
  DrawScreen() Flip()
  Maps.Obj.Kill('PLAYER')
  local narea = tonumber(right(area,3))
  local tomap
  if narea>10 then tomap="Excalibur - Final - 2" else tomap = "Excalibur - Final" end
  if Maps.CodeName~=tomap then LoadMap(tomap,area) end
  Maps.GotoLayer(area)
  SpawnPlayer("Trans.Spot.F"..right(area,3))
  FinalMapShow()
end

function Niets() end -- Believe it or not I need this!

function MAP_FLOW()
  local lay = Maps.LayerCodeName
  ;(floorflow[lay] or Niets)()
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
  for i=1,30 do
      L.X = L.X - 1
      R.X = R.X + 1
      DrawScreen()
      Flip()
  end
  Maps.Remap()
  FinalMapShow()    
end

function OpenSecret1()
   local LAY = '#007'
   local c = 'RED'
   if not keycards[LAY][c] then return end
   OpenKeyDoor(c)
   MapShow('BASE,K_RED,SECRET')
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
if prefixed(BossFile,'SpecialBoss/') then Var.D("$COMBAT.FOE1",BossFile) end
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
  Award('BONUS_HOME')
  Var.D('&IGNORE.TRANSPORTER','TRUE')
end


function ToSecret1()
  TelEffect(TEL_OUT)
  Maps.Obj.Kill('PLAYER')
  Maps.GotoLayer('SECRET1')
  SpawnPlayer('Start')
  Done('&IGNORE.GETOUT')
end

function GetOutSecret1()
  if CVV('&IGNORE.GETOUT') then return end
  TelEffect(TEL_OUT)
  Maps.Obj.Kill('PLAYER')
  Maps.GotoLayer('#007')
  SpawnPlayer('FromSecret')
end

function BossSecret1() 
  CleanCombat()
  Var.D("$COMBAT.BACKGROUND","Facility.png")
  Var.D("$COMBAT.BEGIN","Default")
  Var.D("$COMBAT.FOE1","Boss/HWSNBN")
  Var.D("$COMBAT.ALTCOORDSFOE1","300,400")
  Var.D("%COMBAT.LVFOE1",MapLevel()*({.50,.95,1})[skill])
  Var.D('$COMBAT.MUSIC','specialboss/Back to Darkness.ogg')
  Schedule('MAP','UnLockEmgSave')
  StartCombat()
end

function Nova()
  if Done('&DONE.RISING.NOVA') then return end
  Award('BONUS_NOVA')
  if skill~=3 then for i=1,(6/skill) do MapEXP() end end
end

function U()
  Maps.Obj.OBJ('UBU').Impassible = 1 
  Maps.Obj.OBJ('UBD').Impassible = 1 
  Maps.Obj.OBJ('DBL').Impassible = 0 
  Maps.Obj.OBJ('DBR').Impassible = 0
  Maps.Remap() 
end

function D()
  Maps.Obj.OBJ('UBU').Impassible = 0 
  Maps.Obj.OBJ('UBD').Impassible = 0 
  Maps.Obj.OBJ('DBL').Impassible = 1 
  Maps.Obj.OBJ('DBR').Impassible = 1
  Maps.Remap() 
end

function F10T(p)
  Maps.Obj.Kill("PLAYER")
  SpawnPlayer('Play'..p)
  Actors.Actor('PLAYER').Dominance = ({U=80,D=20})[p]
  -- Maps.Remap()
  ;({U=U,D=D})[p]()
end

function Boss10()
  if Done('&DONE.EXCALIBUR.FINALDUNGEON.BOSS.AREA[010]') then return end
  local tune = 'Dungeon/Spiedkiks_-_05_-_Freak_Boutique.ogg'
  local boss = 'Gold Killer Droid'
  Boss(boss,tune)
  Maps.Obj.Kill('Boss10Obj')
  MapEXP()
  inc("%AURINARATE",120/skill)
end

function NPC_AMMO()
  local crTAG = '%EX.CRYSTAL.RECHARGES[' .. Maps.LayerCodeName ..']'
  if skill~=1 and (not CVVN(crTAG)) then
     Var.D(crTAG,({rand(100,256)*rand(1,3),rand(1,5)})[skill-1])
  end
  if skill~=1 and CVV(crTAG)<=0 then
     MapText('CRYSTAL.EMPTY')
     return
  end    
  local loaded = false
  local arm
  for key in each(mysplit(RPGChar.PointsFields('Crystal'),";")) do
      if prefixed(key,'ARM.AMMO') then
         arm = RPGChar.Points('Crystal',key)
         loaded = loaded or arm.Have~=arm.Maximum
         arm.Have=arm.Maximum 
      end
  end
  if loaded then
     if skill~=1 then 
        dec(crTAG)
        if CVV(crTAG)>1 then
           MINI(Var.S('At this AMMO box you can refill your ARMS '..crTAG..' more times'),180,255,0)
        elseif CVV(crTAG)>1 then
           MINI('There is only one more refill round left in this AMMO box',180,100,0)
        else
           MINI('This AMMO box is empty now',255,0)
        end       
     end
     MapText('CRYSTAL.REFILL') 
  else
     MapText('CRYSTAL.FULL')
  end
end

function ToSecret2()
   Actors.MoveToSpot('PLAYER','Geheimpje')
   TelEffect(TEL_OUT)
   Maps.Obj.Kill('PLAYER')
   Maps.GotoLayer('SECRET2')
   SpawnPlayer('Start')   
end

function TalkLab()
   MapShow('Lab')
   if Done('&DONE.EXCALIBUR.FINAL.SECRET.LAB') then return end
   PartyPop('LAB','South')
   repeat
      Maps.CamY = Maps.CamY + 1
      DrawScreen()
      Flip()
   until Maps.CamY>=3072
   MapText('LAB')
   PartyUnPop()
   Award('BONUS_SECRETLAB')
   for i=1,math.ceil(6/(skill*2)) do MapEXP() end
end

function FightMcLeen()
   PartyPop('Mac','West')
   Var.D('$JOHNSON',"Ashley")
   RPGChar.SetName("Johnson","Ashley")
   MapText('MCLEEN1')
   Schedule('MAP','McLeenPostFight')
   Boss('SpecialBoss/McLeen','SpecialBoss/GeorgeMcLeen.ogg')
   -- OnlyCrystalIsLeft() -- Debug line to test the alternate ending. May NOT be active in the actual game.
   -- Sys.Error('Boss fight not yet scripted') 
end

function OnlyCrystalIsLeft()
   PartyUnPop()
   for i=1,100 do DrawScreen() end -- No Flipping. The Player should not see this. 
   MapShow('BASE,DEAD')
   Party('Crystal')
   SetActive('Crystal')
   TurnPlayer('West')
   Actors.Actor('PLAYER').X = Maps.Obj.Obj('Mac_Crystal').X
   Actors.Actor('PLAYER').Y = Maps.Obj.Obj('Mac_Crystal').Y
   MapText('MCLEEN.CRYSTALALONE1')
   TelEffect(TEL_OUT)
   Actors.Actor('PLAYER').Visible=0
   MapText('MCLEEN.CRYSTALALONE2')
   DrawScreen()
   MS.Load("GAMEOVER","Script/Flow/GameOver.Lua")
   LAURA.Flow("GAMEOVER")
end

function McLeenVictory()
   Maps.Obj.Kill('McLeen',1)
   MapText('McLeen2')
   PartyUnPop()
   Award('BOSS_MCLEEN')
   inc('%AURINAS',30/skill)
end

function McLeenPostFight()
  local v = Var.C('&GAMEOVER')=='TRUE';
  ({ [false]=McLeenVictory, [true]=OnlyCrystalIsLeft})[v]()
  -- Cool, eh? Avoiding "if" commands. :-P
end

function ToGoddess()
   LoadMap("Excalibur - Final Boss","#020")
   Maps.GotoLayer("#020")
   SpawnPlayer("Start")
end
  
function GALE_OnLoad()
   --if not (Done("&DONE.INIT.EXCALIBUR.KEYS")) then initkeycards() end
   --CSay(serialize('keycards',keycards))
   local getkeycard = loadstring(CVV(keyinsysvar).."\n\nreturn ret")
   keycards = (getkeycard or function() Sys.Error("Error generated in getting keycard data") end)()
   MS.LoadNew("PARTY","Script/Subroutines/Party.lua")
   if (CVV("&JOINED.JOHNSON")) then
      Party("Wendicka","Crystal","Johnson","Yirl","Foxy","Xenobi")
      SyncLevel('Johnson')
      if (not CVV('&IGNORE.TRANSPORTER')) and MS.ContainsScript("BOXTEXT.KTHURA")==1 then MapText("JOHNSON_BACK") end -- temp crash prevention. A more neat solution is on the way.
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
   ZA_Enter('ShowSecret',MapShow,'BASE,SECRET')
   ZA_Enter('OPEN_SECRET_1',OpenSecret1)
   ZA_Leave("Transporter",Var.Clear,'&IGNORE.TRANSPORTER')
   ZA_Enter("ToSecret1",ToSecret1)
   ZA_Leave('GetOutSecret1',Var.Clear,'&IGNORE.GETOUT')
   ZA_Enter('GetOutSecret1',GetOutSecret1)
   ZA_Enter('NOVA',Nova)
   -- 10 specific
   --ZA_Enter('UB',U)
   --ZA_Enter('DB',D)
   ZA_Enter('10setD',D)
   ZA_Enter('ToU',F10T,'U')
   ZA_Enter('ToD',F10T,'D')
   ZA_Enter('Boss10',Boss10)
   -- end 10
   -- secret 2
   ZA_Enter('ToSecret2',ToSecret2)
   ZA_Enter('EnterLab',MapShow,'Lab')
   ZA_Enter('LeaveLab',MapShow,'BASE')
   ZA_Enter('TalkLab',TalkLab)
   -- George McLeen
   ZA_Enter('FightMcLeen',FightMcLeen)   
   -- Chat
   for i=1,chats do ZA_Enter('CHAT'..i,ExecChat,i) end
   for i=1,chats do ZA_Enter('Chat'..i,ExecChat,i) end
   -- And some final shit
   Award('SCENARIO_FINALDUNGEON')
   FinalMapShow()
   Var.D('&BLOCK.EMERGENCY.SAVE',"TRUE")
   ZA_Enter('FLOOR20REACHED',Done,'&DONE.EXCALIBUR.FLOOR20.REACHED') -- Needed for Black Hole Dweller
   ZA_Enter('Goddess',ToGoddess)
end
