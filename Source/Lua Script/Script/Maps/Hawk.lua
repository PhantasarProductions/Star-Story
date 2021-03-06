--[[
**********************************************
  
  Hawk.lua
  (c) Jeroen Broks, 2015, 2016, All Rights Reserved.
  
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
 
version: 16.09.25
]]

-- @USEDIR Script/Use/Maps/Hawk/
-- @USE /Script/Use/Maps/Gen/Schuif.lua
-- I chose this method in order not to have to change this script (and thus changing stuff in the demo when I don't need to) for any new location you may visit.

ReggieKick = {
                ["ANHYSBYS.REJOIN"] = true, 
                ["WENDICKAGONE"] = true,
                ["CRYSTALFATHER"] = true
             } -- Should contain all events that leads to Foxy kicking Reggie.

HeroLeadList = {"Wendicka","Crystal","Yirl","Foxy","Xenobi","ExHuRU","Rolf"}

Schuif = { Links = { Dicht = { Maps.Obj.Obj("Schuifdeur_Links" ).X ,  Maps.Obj.Obj("Schuifdeur_Links" ).Y }} , 
          Rechts = { Dicht = { Maps.Obj.Obj("Schuifdeur_Rechts").X ,  Maps.Obj.Obj("Schuifdeur_Rechts").Y }} ,
           Vault = { Dicht = { Maps.Obj.Obj("Vault_Door")       .X ,  Maps.Obj.Obj("Vault_Door")       .Y }}}
          
Schuif.Links .Open = { Schuif.Links .Dicht[1]-40,Schuif.Links .Dicht[2] }          
Schuif.Rechts.Open = { Schuif.Rechts.Dicht[1]+40,Schuif.Rechts.Dicht[2] }
Schuif.Vault .Open = { Schuif.Vault .Dicht[1]   ,Schuif.Vault .Dicht[2]+64 }          

Schuif.Ga = { Links = 'Dicht', Rechts = 'Dicht', Vault = 'Dicht' }
Schuif.Obj = { Links = "Schuifdeur_Links", Rechts = "Schuifdeur_Rechts", Vault = "Vault_Door" }

function SchuifOpen()
Schuif.Ga.Links  = 'Open'
Schuif.Ga.Rechts = 'Open'
end

function SchuifDicht()
Schuif.Ga.Links  = 'Dicht'
Schuif.Ga.Rechts = 'Dicht'
end

function TalkParty(ch)
MapText(upper(ch).."."..CVV("$HAWK"))
;(TeachWendicka or function() CSay("Teach Wendicka does not appear to be available") end)(ch)
end

function CLICK_ARRIVAL_Hawk_Crystal()	TalkParty("Crystal") end
function CLICK_ARRIVAL_Hawk_ExHuRU()	TalkParty("ExHuRU") end
function CLICK_ARRIVAL_Hawk_Yirl()		TalkParty("Yirl") end
function CLICK_ARRIVAL_Hawk_Foxy()		TalkParty("Foxy") end
function CLICK_ARRIVAL_Hawk_Reggie()	TalkParty("Reggie") end
function CLICK_ARRIVAL_Hawk_Xenobi()	TalkParty("Xenobi") end
function CLICK_ARRIVAL_Hawk_Rolf()		TalkParty("Rolf") end
function CLICK_ARRIVAL_Hawk_Reggie()
TalkParty("Reggie")
if ReggieKick[CVV('$HAWK')] then KickReggie("South","Hawk_Foxy","Hawk_Reggie") end 
end


function CLICK_ARRIVAL_Terminal()
if not Done("&TUT.TERMINAL") then MapText("TERMINALTUTORIAL") end
MS.LoadNew("TERMINAL","Script/Flow/Terminal.lua") -- Load the terminal program, but only if it wasn't already loaded.
LAURA.Flow("TERMINAL")
end

function CLICK_ARRIVAL_Nav()
if CheckOutBlackHoleDweller then CheckOutBlackHoleDweller() end
if not Done("&TUT.NAV.HAWK") then 
   MapText("NAVTUTORIAL") 
   end
if not Done("&NAV.YAQIRPA") then ActivateRemotePad('YaqirpaStart','Return_Yaqirpa','Poloqor','Yaqirpa - Entrance') end   
if not FullVersion then
   MapText("ENDDEMO")
elseif not Done("&NAV.PHYSILIUM.OLDRUINS") then
   ActivateRemotePad('TRANSWENDICKA','Physillium - The Ruins of the Y Anhysbys','Physillium','The Ruins of the Y Anhysbys - Wendicka\'s spot',"#002")
   -- Sys.Error("Protection blockout! We cannot continue yet.")
   FirstWorld("Physillium","ArrivalPhysillium")
   -- We do need to script the arrival at Physilium part first!
   end
if AutoNewNav then AutoNewNav() end      
MS.LoadNew("TRANS","Script/Flow/Transporter.lua")
LAURA.Flow("TRANS")
end


function Vault()
if (not Done("&DONE.HAWK.FIRSTTIMEVAULT")) and GetActive()=="Wendicka" then MapText("VAULT") end 
GoToVault()
end


function NPC_Upgrade()
if not Done('&INTRODUCED.SEPPAE') then MapText('UPGRADEA') end
MapText('UPGRADE')
MS.LoadNew("UPGRADE","Script/Flow/Upgrade.lua")
LAURA.Flow("UPGRADE")
end

function MAP_FLOW()
DoSchuif()
end

function HawkMusic()
local lmusic = {}
if CVVN('$HAWKMUSIC') and JCR6.Exists("MUSIC/"..CVV("$HAWKMUSIC"))==0 and JCR6.Exists(CVV("$HAWKMUSIC"))==0 then Var.Clear("$HAWKMUSIC") end -- and this should fix issue #304
if CVVN('$HAWKMUSIC') then 
   Music(CVV('$HAWKMUSIC'))
else
   for mpiece in iJCR6Dir(true) do
       if prefixed(mpiece,"MUSIC/HAWK/") and suffixed(".OGG") then lmusic[#lmusic+1]=right(mpiece,len(mpiece)-6) end
       end
   Music(lmusic[rand(1,#lmusic)])    
   end
end


function Bridge()
MapShow('Bridge')
if not HawkBridge then CSay("No extra bridge functions in the demo") return end -- Prevent trouble in the demo as this only works in the full version of the game.
if not CVVN("$HAWK.BRIDGE") then CSay("No bridge feature was asked") return end -- Nothing here, then let's get outta here.
CSay("Executing: "..CVV("$HAWK.BRIDGE")); -- Separator MUST be present!!!
(HawkBridge[CVV("$HAWK.BRIDGE")] or function() MINI("Hawk Bridge event '"..CVV("$HAWK.BRIDGE").."' not found",255,0,0) end)()
Var.Clear("$HAWK.BRIDGE")
end

function GALE_OnLoad()
Done("&GOT.HAWK")
-- Set the leader. In the Hawk, only this person can be used as leader. The HeroHeadList determines the priority order (in case Wendicka is not in the party Crystal will be the leader, and both Wendicka and Crystal aren't there then Yirl and so on).
for ch in each(HeroLeadList) do
    if InParty(ch) then HeroLead = HeroLead or ch end
    if InParty(ch) and ch~=HeroLead then
       AddClickable("Hawk_"..ch)
    else
       Maps.Obj.Kill("Hawk_"..ch)
       end   
    end
if not InParty('Foxy') then Maps.Obj.Kill("Hawk_Reggie_"..ch) else AddClickable('Hawk_Reggie') end    
SetActive(HeroLead)    
CSay("The controllable character in the Hawk will be: "..HeroLead)
-- Let's select the music. Since you get here a lot, I see fit in the possibility to randomize the music, though in the demo I'll keep it to one track only (as the demo ends here).
if not CVV('&NOHAWKMUSIC') then HawkMusic() end
-- Boundaries
SetScrollBoundaries(0,15,0,658)
-- Schuifdeuren
ZA_Enter("Schuifdeur_Open",SchuifOpen)
ZA_Leave("Schuifdeur_Open",SchuifDicht)
ZA_Enter("OpenVaultDoor",function() Schuif.Ga.Vault = 'Open'  end)
ZA_Leave("OpenVaultDoor",function() Schuif.Ga.Vault = 'Dicht' end)
-- Show
ZA_Enter("ShowBridge1",MapShow,'Bridge')
ZA_Enter("ShowBridge2",Bridge)
ZA_Enter("ShowBack"   ,MapShow,'Back')
-- Show NPCs in the back only when you let them on board
if not CVV("&BANIKA") then Maps.Obj.Kill("NPC_Banika") Maps.Obj.Kill("NPC_Bakina") end
-- Vault
ZA_Enter("Vault",Vault)
-- Terminals
AddClickable("Nav")
AddClickable("Terminal")
-- Recover upon arrival
RecoverParty()
-- Merge with fullgame text
if FullVersion then MS.Run("BOXTEXT","LoadData","MAPS/HAWK_FULL;MAP;true") end
end
