--[[
  AutoUse.lua
  
  version: 16.06.03
  Copyright (C) 2015, 2016 Jeroen P. Broks
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
-- @USEDIR Script/Use/Anyway

ROOM_ME = Maps.CodeName

ThisIsAMapScript = true

-- Load the map scenario if available
function InitMapText()
MS.LoadNew("BOXTEXT","Script/SubRoutines/BoxText.lua")
MS.Run("BOXTEXT","RemoveData","MAP")
-- Well, we MUST avoid "if"s, eh? Well, let me show you what kind of dirty code that can create.
local maptextfile = "Languages/"..Var.C("$LANG").."/Scenario/MAPS/"..Maps.CodeName
local letsgo = { 
  [0] = function() Console.Write("WARNING! No maptext found for map "..Maps.CodeName,255,180,0); Console.Write(">> "..maptextfile,0,180,255) end,
  [1] = function() MS.Run("BOXTEXT","LoadData","MAPS/"..Maps.CodeName..";MAP"); Console.Write("MapText for "..Maps.CodeName.." loaded",0,255,180) end }
local f = letsgo[JCR6.Exists(maptextfile)]
f()
-- Well, you gotta agree this could been done in a more efficient way :P
-- Oh yeah, Lua does accept 0 for an array index, it's rather that ipairs doesn't pick that up, but we didn't need ipairs anyway here :P   
-- I could not yet use the functions from BoxTextLinker, as they are not loaded on the moment this function is called, for the other functions, it doesn't matter.
end; InitMapText()

function MapText(tag,mapaltMS)
SerialBoxText("MAP",tag,mapaltMS or "BOXTEXT.KTHURA")
end


-- The Zone Action routines
ZA = { Enter = {}, Leave = {}, Flow = {} }
ZAChkEnter = {}
ZAChkLeave = {}

function ZA_SetAction(Z,A,F,P)
table.insert(ZA[A],{Z = Z, F = F, P = P})
end

function ZA_Enter(Z,PF,P)
local F = PF
if F=="ALB_EXE" then F = ALB_EXE end
ZA_SetAction(Z,"Enter",F,P)
end

function ZA_Leave(Z,F,P)
ZA_SetAction(Z,"Leave",F,P)
end

function ZA_Flow(Z,F,P)
ZA_SetAction(Z,"Flow",F)
end

function ZA_Run(Z,A)
local F
for f in ipairs(ZA[Z][A]) do f() end
end

function ZA_CheckEnter(actor)
local b
local ZK,ZZ 
for ZK,ZZ in pairs(ZA.Enter) do
    if ROOM_ME==Maps.CodeName then
       b = Maps.Obj.Exists(ZZ.Z)==1 and Maps.ActorInZone(actor,ZZ.Z)==1
       if (not ZAChkEnter[ZZ.Z]) and b then 
          KillWalkArrival() 
          ZZ.F(ZZ.P) 
          end
       ZAChkEnter[ZZ.Z] = b
       end 
    end
end

function ZA_CheckLeave(actor)
local b
local ZK,ZZ 
for ZK,ZZ in pairs(ZA.Leave) do
    b = Maps.Obj.Exists(ZZ.Z)==1 and Maps.ActorInZone(actor,ZZ.Z)==1
    if Maps.Obj.Exists(ZZ.Z)==1 and ZAChkLeave[ZZ.Z] and (not b) then 
       KillWalkArrival() 
       ZZ.F(ZZ.P) 
       end
    ZAChkLeave[ZZ.Z] = b 
    end
end

function ZA_CheckFlow(actor)
local b
local ZK,ZZ 
for ZK,ZZ in pairs(ZA.Flow) do
    b = Maps.Obj.Exists(ZZ.Z)==1 and Maps.ActorInZone(actor,ZZ.Z)==1
    if b then
       KillWalkArrival() 
       ZZ.F(ZZ.P) 
       end
    end
end

function ResetClickables()
MS.LN_Run("FIELD","Script/Flow/Field.lua","ResetClickables")
end; ResetClickables() -- Yeah, it must always be executed when a new map is loaded, and this way, that will always happen :)

function RemoveClickable(c)
MS.Run("FIELD","RemoveClickable",c)
end

function AddClickable(c)
MS.Run("FIELD","AddClickable",c)
end

AddClickableScript = function(scr) MS.LN_Run("FIELD","Flow/Field.Lua","AddClickableScript",scr) end

function DrawScreen()
MS.Run("FIELD","DrawScreen")
end

function NPC_MapText()
TurnPlayer("North")
MapText(upper(Var.C("$NPC_MAPTEXT")))
end

function CharMapText(Tag)
local a = GetActive()
local t = upper (Tag.."."..a)
MapText(t)
end

function RecoverParty(dontresetap)
local ak,ch,hp,ap,arm
for ak=0,5 do
    ch = RPGChar.PartyTag(ak)
    if ch~="" then
       hp = RPGChar.Points(ch,"HP")
       ap = RPGChar.Points(ch,"AP")
       if skill>=2 and (not dontresetap) then ap.Have=0 end
       for stn in each({"Strength","Defense","Will","AP","HP","Resistance","Agility","Accuracy","Evasion"}) do
       	  if (skill~=3 and RPGStat.Stat(ch,"BUFF_"..stn)<0) then RPGStat.DefStat(ch,"BUFF_"..stn,0) end
       	  if (skill~=1 and RPGStat.Stat(ch,"BUFF_"..stn)>0) then RPGStat.DefStat(ch,"BUFF_"..stn,0) end
       	  end  
       hp.Have = hp.Maximum
       end
    if ch=="Crystal" and (not dontresetap) then -- Reload all ARMS
	   --CSay("Reloading Crystal's ARMS")
       for arm in each(mysplit(RPGChar.PointsFields('Crystal'),";")) do
		   --CSay("arm = "..arm.." >> "..sval(prefixed(arm,"ARM.AMMO")))
           if prefixed(arm,"ARM.AMMO") then 
			   RPGChar.Points(ch,arm).Have = RPGChar.Points(ch,arm).Maximum; 
			   --CSay("= "..arm) 
			   end
           end
       end   
    end
end


function KthuraEach(kind) -- This is just a copy, because the normal usage routine did not yet load the Kthura.lua file causing errors. No other way to "fix" that.
-- CSay("Startup Kthura-Each: "..sval(kind))
local c = Maps.ObjectList.Start(kind or "")
local k
local tab = {}
-- CSay("objects to go through: "..c)
for k=0,c-1 do
    -- CSay(k.."   "..c)
    Maps.ObjectList.Pick(k)
    -- CSay(Maps.ObjectList.MyObject.Kind)
    table.insert(tab,Maps.ObjectList.MyObject)
    end
local i=0    
return function()
       i = i + 1
       if tab[i] then return tab[i] end
       end    
end       


function ActivatePad(tag,transporter)
--if ActivatedPads[tag] then return end
if ActivatedPads[upper(Maps.CodeName.."."..tag)] then return end
if transporter=="General" then MS.LN_Run("TRANS","Script/Flow/Transporter.lua","ActivatePad",tag) else Done("&PAD.ACTIVE["..tag.."]") end 
Maps.Obj.Obj("Trans.Pad."..tag).TextureFile = "GFX/Textures/Teleporter Pad/"..transporter..".png" 
ActivatedPads[tag] = true
end

TEL_OUT = 1
TEL_IN  = 2
function TelEffect(inorout)
local start = {0,99}
local eind  = {99,0}
local stap  = {1,-1}
Actors.ChoosePic("PLAYER","TELEPORT")
Actors.Actor("PLAYER").NotInMotionThen0 = 0
for f=start[inorout],eind[inorout],stap[inorout] do
    Image.Cls()
    Actors.Actor("PLAYER").Frame = f 
    Maps.Draw()
    --DrawScreen()
    Flip()    
    end
local cp = GetActive()    
if inorout==2 then
   Actors.ChoosePic("PLAYER",upper(cp)..".SOUTH")
   TurnPlayer("South")
   Actors.Actor("PLAYER").NotInMotionThen0 = 1
   Maps.Draw()
   --DrawScreen()
   Flip()
   end
end

function TransporterPad(tag,dontask)
ActivatePad(tag,"General")
if Done("&TELPADINUSE") then Var.Clear("&TELPADINUSE") return end
Actors.StopWalking("PLAYER")
Actors.StopMoving("PLAYER")
Actors.MoveToSpot("PLAYER","Trans.Spot."..tag)
;({
     function() -- Recover & Save
     TelEffect(TEL_OUT)
     RecoverParty()
     Loading()
     Time.Sleep(250)
     MS.Run("FIELD","SetUpFoes")
     MS.Run("FIELD","SetUpTreasure")
	   RedoMapShow() 
     TelEffect(TEL_IN)
     GotoSave()
     end,
     
     function() -- Beam me up, Scotty!
     if not CVV("&GOT.HAWK") then SerialBoxText("SCOTTY","NOSHIP") return end
     if CVV("&TRANSPORTERBLOCK") then MapText("TRANSPORTERBLOCK") return end
     Award("SCENARIO_BEAMMEUP")
     TelEffect(TEL_OUT)
     LoadMap("Hawk","Bridge")
     SpawnPlayer("Scotty","South")
     -- MINI("Beaming up not yet properly set up")
     end,
     
     function() -- Cancel 
     end,
     })[dontask or RunQuestion("SCOTTY","GENERAL")]()
--MINI("Transporter routine not yet present")
Var.Clear("&TELPADINUSE")
end

function ReturnOnlyPad(tag)
ActivatePad(tag,"ReturnOnly")
Actors.StopWalking("PLAYER")
Actors.StopMoving("PLAYER")
Actors.MoveToSpot("PLAYER","Trans.Spot."..tag)
;({
     
     function() -- Beam me up, Scotty!
     if not CVV("&GOT.HAWK") then SerialBoxText("SCOTTY","NOSHIP") return end
     Award("SCENARIO_BEAMMEUP")
     TelEffect(TEL_OUT)
     LoadMap("Hawk","Bridge")
     SpawnPlayer("Scotty","South")
     -- MINI("Beaming up not yet properly set up")
     end,
     
     function() -- Cancel 
     end,
     })[RunQuestion("SCOTTY","RETURNONLY")]()

end

function RecoveryPad(tag)
ActivatePad(tag,"Recover")
Actors.StopWalking("PLAYER")
Actors.StopMoving("PLAYER")
Actors.MoveToSpot("PLAYER","Trans.Spot."..tag)
RecoverParty(true)
end

-- for obj in KthuraEach() do Console.Write("*"..obj.Tag.."*",255,255,0) end      



function InitPads()
local
  function mysplit(inputstr, sep) -- needed because this is called outside the regular load sequence. :(
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
  end
local pad
Maps.Remap()
-- ActivatedPads = ActivatedPads or {}
MS.LN_Run("TRANS","Script/Flow/Transporter.lua","TransferActivatedPads")
local ActivatedPadsGet = loadstring(Var.S("return $RET"))
local ActivatedPadsList = ActivatedPadsGet()
ActivatedPads = {}
for _,Pad in ipairs(ActivatedPadsList) do ActivatedPads[Pad] = true end
local function puretag(tag) return replace(tag,"Trans.Spot.","") end
local function dimnonactive(tag)
      if not(ActivatedPads[upper(Maps.CodeName.."."..tag)] or Var.C("&PAD.ACTIVE["..tag.."]")=="TRUE") then
         -- CSay("Got tag: "..tag)
         Maps.Obj.Obj("Trans.Pad."..tag).TextureFile = "GFX/Textures/Teleporter Pad/Deactivated.png" 
         end
      end
local layers,orilayer = ({ [0]=function() return {'SL:MAP'},nil end, [1]=function () return mysplit(Maps.Layers(),";"),Maps.LayerCodeName end})[Maps.Multi()]()
for layer in each(layers) do      
  if Maps.Multi()==1 then Maps.GotoLayer(layer) end
  for obj in KthuraEach() do    
    (({
      ["$TransporterGeneral"] = function() 
                                Console.Write("Get pad : "..puretag(obj.Tag),255,255,255)
                                pad = Maps.Obj.Obj("Trans.Pad."..puretag(obj.Tag))
                                Console.Write("Done!",255,255,255)
                                dimnonactive(puretag(obj.Tag))
								                AddClickableScript("return { spot='"..obj.Tag.."', obj = 'Trans.Pad."..puretag(obj.tag).."', arrival='TransporterPad', arrivalarg='"..puretag(obj.Tag).."' }")
                                --ZA_Enter(pad.Tag,loadstring('MS.Run("MAP","TransporterPad","'..puretag(obj.Tag)..'")'))
                                end,
      ["$TransporterRecover"] = function() 
                                pad = Maps.Obj.Obj("Trans.Pad."..puretag(obj.Tag))
                                dimnonactive(puretag(obj.Tag))
								                AddClickableScript("return { spot='"..obj.Tag.."', obj = 'Trans.Pad."..puretag(obj.tag).."', arrival='RecoveryPad', arrivalarg='"..puretag(obj.Tag).."' }")
                                --ZA_Enter(pad.Tag,loadstring('MS.Run("MAP","RecoveryPad","'..puretag(obj.Tag)..'")'))
                                end,                          
      ["$TransporterReturnOnly"] 
                              = function()
                                Console.Write("Return only pad: "..obj.Tag,0,180,255)
                                pad = Maps.Obj.Obj("Trans.Pad."..puretag(obj.Tag)) 
                                dimnonactive(puretag(obj.Tag))
								                AddClickableScript("return { spot='"..obj.Tag.."', obj = 'Trans.Pad."..puretag(obj.tag).."', arrival='ReturnOnlyPad', arrivalarg='"..puretag(obj.Tag).."' }")
                                --ZA_Enter(pad.Tag,loadstring('MS.Run("MAP","ReturnOnlyPad","'..puretag(obj.Tag)..'")'))
                                end                          
    })[obj.Kind] or function() end)()
    end
   end
-- if Maps.Multi()==1 and orilayer~="" then Console.Write("Going back to original: "..orilayer,180,255,0)  Maps.GotoLayer(orilayer)   end
end; InitPads()



function GRANT_ARM()
local SPOTTAG = CVV("$ARMSPOT")
local SPOT = Maps.Obj.Obj(SPOTTAG)
local CHESTTAG = replace(SPOTTAG,"ARMSPOT","ARMCHST")
local CHEST = Maps.Obj.Obj(CHESTTAG)
local ARMTAG = SPOT.DataGet("ARM")
local ARM = ItemGet("ARM_"..ARMTAG)
local ok
CSay("We're there. Now let's check this out!")
for ak=0,5 do
    ok = ok or RPGChar.PartyTag(ak)=="Crystal"
    end
if not ok then
   SerialBoxText("ARMS","NOCRYSTAL","BOXTEXT.KTHURA")
   CSay("Oh bummer! Crystal's not in the group!")
   return
   end    
Var.D("$ARMOBTAINED",ARM.Name)
SetActive("Crystal")
TurnPlayer("North")
Maps.Obj.Obj(CHESTTAG).Frame=1
SerialBoxText("ARMS","CRYSTAL","BOXTEXT.KTHURA")
RPGChar.AddList("Crystal","ARMS",ARMTAG)
RPGChar.Points("Crystal","EXP").Inc(1000)
Maps.PermaWrite("-- NOKILL:")
Maps.Obj.Kill(CHESTTAG,1)
Maps.Remap()   
end

function SecretDungeon()
if Done("&ANNOUNCEDSECRET."..upper(Maps.CodeName)) then return end
SerialBoxText("SECRETDUNGEON","SECRETDUNGEON","BOXTEXT.KTHURA")
end

function KickReggie(direction,foxy,reggie)
  local dw = Actors.DontWarn
  Actors.DontWarn = 1
  local foxyobj = Maps.Obj.Obj(foxy)
  local reggieobj = Maps.Obj.Obj(reggie)
  local foxyoriginalimg
  local reggiexy,reggiego
	-- Move Foxy
	if Maps.Obj.Kind(foxy) == 'Actor' then	
		foxyoriginalimg = Actors.Actor(foxy).ChosenPic		
		Actors.ChoosePic(foxy,"FOXY."..upper(direction))
		Actors.Actor(foxy).Frame=1
	else
	  foxyoriginalimg = foxyobj.TextureFile 
	  foxyobj.TextureFile = "GFX/ACTORS/PLAYER/Foxy."..direction..".png"
	  foxyobj.Frame=1
	end
	-- Make Reggie fly
	reggiexy = {reggieobj.X,reggieobj.Y}
	reggiego = ( { NORTH = {X=0,Y=-2}, SOUTH={X=0,Y=2}, WEST={X=-2,Y=0}, EAST={X=2,Y=0}} )[upper(direction)]
	repeat
	reggieobj.X = reggieobj.X + reggiego.X
	reggieobj.Y = reggieobj.Y + reggiego.Y
	DrawScreen()
	Flip()
	until Maps.Block(reggieobj.X+reggiego.X,reggieobj.Y+reggiego.Y)~=0
	-- Cuckoo
	SFX("Audio/SFX/Cuckoo-Clock-Sound.ogg")
	Time.Sleep(2000)
	-- Restore Foxy
	if Maps.Obj.Kind(foxy) == 'Actor' then					
		Actors.ChoosePic(foxy,foxyoriginalimg)
		Actors.Actor(foxy).Frame=0
	else	    
	  foxyobj.TextureFile = foxyoriginalimg
	  foxyobj.Frame=0
	end
	-- Make Reggie go back
	repeat
	reggieobj.X = reggieobj.X - reggiego.X
	reggieobj.Y = reggieobj.Y - reggiego.Y
	DrawScreen()
	Flip()
	until reggieobj.X == reggiexy[1] and reggieobj.Y==reggiexy[2]	
	-- Restore DontWarn
	Actors.DontWarn = dw
end

function ALB_EXE(tag) -- AutoLabel Execute
local myobj = Maps.Obj.Obj(tag)
MapShow(myobj.Labels)
end

	
	
