--[[
**********************************************
  
  Phantasar - Frendor.lua
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
 
version: 16.07.30
]]

rosettavar = "&DONE.SPOKEN.ROSETTA"
rosetta = Var.C(rosettavar)=='TRUE'

reggie = Maps.Obj.Obj("Feena_Reggie")
reggie.Visible = 0

mpts = { [true] = "CANSPEAK", [false] = "CANNOTSPEAK"}

prismdiamondsgiven = prismdiamondsgiven or 1


-- We gotta check if Crystal has all ARMS (except for the ARC SMASH). If not Rachel should not appear.
function DoesCrystalHaveAllARMS()
 local ARMS = {
                      'DART',
                      'HEALINGSPRAY',
                      'POISONDART',
                      'VIRUSBOMB',
                      'MUNCHHAUSEN',
                      'MULTIBLAST',
                      'FLAMETHROWER',
                      'MINICANNON',
                      'ICEBULLET',
                      'STUN_GUN',
                      'DOPING_SHOT',
                      'BIOHAZARD',
                      'HEALINGSHOWER',
                      'ROCKTHROWER',
                      'NAPALMSHOWER',
                      'RISINGNOVA'}
 local ret = true                      
 local have
 for ARM in each(ARMS) do
     have = RPGChar.ListHas('Crystal','ARMS',ARM)==1
     ret = ret and have
     CSay('Check ARM: '..ARM.."  => "..sval(have).." == ret> "..sval(ret))
 end
 return ret                      
end

function RosettaText(Tag)
	MapText(Tag.."."..mpts[rosetta])
end

function NPC_Rosetta()
	if Done(rosettavar) then
		MapText("ROSETTA")
	else
		rosetta=true
		MapText("ROSETTA_PRE")
		PartyPop("Rosetta")
		MapText("ROSETTA_FIRST")
		PartyUnPop()
	end
end

function NPC_FEENALARIA()
  local diamant,give 
	if rosetta then
		if not Done("&DONE.PHANTASAR.FEENA_1") then
			MapText("FEENA_1A")
			PartyPop("Feena")
			reggie.Visible = 1
			MapText("FEENA_1B")
			KickReggie("East","Feena_Foxy","Feena_Reggie")
			MapText("FEENA_1C")
			PartyUnPop()
			reggie.Visible = 0
		elseif CVV("&DONE.PHANTASAR.GHOSTHOUSE.COMPLETE") and (not CVV("&DONE.PHANTASAR.GHOSTHOUSE.FEENAREWARD") ) then
			 MapText("FEENA_REWARD")
			 give = rand(1,prismdiamondsgiven)==1
			 diamant = ({ [true]='ITM_EQP_PHAN_PRISMDIAMOND', [false]='ITEM_PHAN_PRISMDIAMOND'})[give]
			 if ItemGive(diamant) then
			    MapEXP()
			    if give then 
			       prismdiamondsgiven = prismdiamondsgiven + (skill*skill)
			       if prismdiamondsgiven>100000 then prismdiamondsgiven=100000 end -- Prevent crashes in long term
			   end
			   Done("&DONE.PHANTASAR.GHOSTHOUSE.FEENAREWARD")
			 else
			   MapText("FEENA_FULL")
			 end
		elseif CVV("&DONE.PHANTASAR.GHOSTHOUSE.FEENAREWARD") then
		  MapText("FEENA_NEVER")
		else
			MapText("FEENA_ONLYHOPE")	
		end	
	else
	   MapText("FEENA_HUH")
	end
end

function NPC_Scyndi()    RosettaText("SCYNDI")    end
function NPC_Irravonia() RosettaText("Irravonia") end

function NPC_Merya()
	RosettaText("MERYA")
	if (not rosetta) or Done("&DONE.PHANTASAR.MERYA.KICK.REGGIE") then return end
	SetActive("Foxy")
	Actors.ChoosePic('PLAYER',"FOXY.NORTH")
	MapText("MERYA.REGGIE")
	local ireggie = Image.Load("GFX/Scenario/Reggie_Big.png")
	Image.HotCenter(ireggie)
	local x = Actors.PX("PLAYER") - Maps.CamX
	local y = Actors.PY("PLAYER") - Maps.CamY
	for scale=0,200 do
	    DrawScreen()
	    Image.DText("cycle: "..scale.." C ("..x..","..y..")")
	    Image.Scale(scale/100,scale/100)
	    Image.Rotate(scale*2)
	    Image.Draw(ireggie,x,y)
	    Flip()
	end
	local flits = false
	Music('Sys/Silence.ogg')
	SFX("Audio/SFX/Scenario/Reggie_Crash.ogg")
	for i=0,10 do
	    flits = not flits 
	    CSay(sval(flits));
	    white=white or White
	    black=black or Black;
	    ({[true]=white,[false]=black})[flits==true]()	   
		  Image.Rect(0,0,800,600)
		  Flip()
		  Time.Sleep(1)
	end
	Cls() Flip() Cls() Flip() -- Make sure the screen is dark
	local cbars = Maps.Obj.Obj('ColorBars')
	--cbars.Alpha = 1
	cbars.X = Maps.CamX
	cbars.Y = Maps.CamY
	cbars.W = 800
	cbars.H = 600
	cbars.R = 255
	cbars.G = 255
	cbars.B = 255
	CSay(cbars.X.."/"..cbars.y)
	CSay(cbars.W.."/"..cbars.h)
	CSay(cbars.R..","..cbars.G..","..cbars.B)
	Maps.Remap() 
	DrawScreen()
	--MapShow("NIETS")
	Time.Sleep(100)
	MapText('FOXY.OOPS')
	--MapShow("*ALL*")
	--reggie.Visible = 0	  
	Award("SCENARIO_CRASH")  
	cbars.Visible = 0
	Maps.Remap() 
	Music('Dungeon/Enchanted Valley.ogg')  	    
end

function NPC_Merchant()
   CSay("Let's talk to the merchant")
   RosettaText("MERCHANT")
   if rosetta then
      MS.LN_Run ("PHANTASARSTORE","script/flow/PhantasarStore.lua","GenerateStock")
      LAURA.Flow("PHANTASARSTORE")
      CSay("Phantasar Shop not yet available")
   end   
end

-- Rachel
function NPC_Rachel()
   if not rosetta then
     MapText('RACHEL.CANNOTSPEAK')
     return
   end
   if GetActive()~='Crystal' or (CVV('&RACHEL.DONE.AIROM.STUFF')) then
      MapText('RACHEL.NOTCRYSTAL')
      return
   end
   MapText('RACHEL.CRYSTAL')
   Done('&RACHEL.DONE.UNLOCK.AIROM') 
end

function GALE_OnLoad()
	Music('Dungeon/Enchanted Valley.ogg')
	NPC_SAVESPOT = savespot.blue
	ZA_Enter("Byebye",GoWorld,"Phantasar")
	if not CVV("&DONE.PHANTASAR.GHOSTHOUSE.COMPLETE") then Maps.Obj.Kill("NPC_MT_MARRILONA",0) end	
	if skill==3 and prismdiamondsgiven<10 then prismdiamondsgiven=10 end
	if not DoesCrystalHaveAllARMS() then Maps.Obj.Kill('NPC_Rachel') end -- Rachel only appears if Crystal has all ARMS except the ARC SMASH
end


-- @USE Phantasar.lua
