--[[
**********************************************
  
  Excalibur_Home.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
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
 
version: 15.09.10
]]

function CLICK_ARRIVAL_Vlag_Brabant()
CharMapText("Brabant") 
end

function CLICK_ARRIVAL_Computer()
CSay("Savespot activated")
GotoSave()
end

function CLICK_ARRIVAL_Scyndi()
GoToVault()
end

function CLICK_ARRIVAL_Crystal_Asleep()
MapText("FOUNDCRYSTAL_FOUNDHER")
local alpha
for alpha=0,100 do
    Image.SetAlphaPC(100)
    DrawScreen()
    Black()
    Image.SetAlphaPC(alpha)
    Image.Rect(0,0,800,600)
    Flip()
    end
MapShow("Crystal","CrystalFound")    
for alpha=100,0,-1 do
    Image.SetAlphaPC(100)
    DrawScreen()
    Black()
    Image.SetAlphaPC(alpha)
    Image.Rect(0,0,800,600)
    Flip()
    end
MapText("FOUNDCRYSTAL_SECURITY")
Maps.Obj.Kill("Crystal_Asleep",1)
MapText("FOUNDCRYSTAL_AWAKE")    
GrantExperienceOnLevel({"UniWendicka","UniCrystal"},10)
Music("Sys/Silence.ogg")
DrawScreen()
Flip()
Party("Wendicka")
Maps.Obj.Kill("Crystal Awake",1)
Image.Cls(); Flip(); Time.Sleep(500)
Image.Font("Fonts/Robotica.ttf",40)
White()
Image.Cls(); Image.DText(({Dutch = "Een jaar later"})[CVV("$LANG")] or "One Year Later",400,300,2,2); Flip(); Time.Sleep(2000)
Image.Cls(); Flip(); Time.Sleep(500)
LoadMap("Excalibur_Kitchen")
MapShow("Niks")
MapText("COOK1")
MapShow("Keuken")
MapText("COOK2")
Actors.Spawn("Wendicka","PLAYER","PLAYER")
local ak
for ak=1,40 do
    Maps.Obj.Obj("Deur_Links" ).X = Maps.Obj.Obj("Deur_Links" ).X - 1
    Maps.Obj.Obj("Deur_Rechts").X = Maps.Obj.Obj("Deur_Rechts").X + 1
    DrawScreen()
    Flip()
    end
Actors.WalkToSpot("PLAYER","WendickaCook")
TurnPlayer("West")
WaitWalking()
MapText("COOK3")    
Actors.WalkToSpot("PLAYER","Wendicka")
WaitWalking()
for ak=1,40 do
    Maps.Obj.Obj("Deur_Links" ).X = Maps.Obj.Obj("Deur_Links" ).X + 1
    Maps.Obj.Obj("Deur_Rechts").X = Maps.Obj.Obj("Deur_Rechts").X - 1
    DrawScreen()
    Flip()
    end
LoadMap("Excalibur_AllQuiet")
Actors.Spawn("Keuken_Start","PLAYER","PLAYER")    
-- Sys.Error("Let's crash out until the next section has been put in")
end


function GALE_OnLoad()
if not CVV("%DONE.PROLOGUE")      then Music("Scenario/Panic Stations.ogg") 
elseif CVV("%DONE.EXHURU")        then Music("Scenario/Panic Stations.ogg")
elseif CVV("%ATTACKED.EXCALIBUR") then Music("Excalibur/Attacked.ogg")
else                                   Music("Scenario/Calm Indoors.ogg") end
ZA_Enter("Kamer_Wendicka" ,function() MapShow("Wendicka")  end)
ZA_Enter("Kamer_Crystal"  ,function() MapShow("Crystal")   end)
ZA_Enter("Kamer_Woonkamer",function() MapShow("Woonkamer") end)
ZA_Enter("Kamer_Keuken",   function() MapShow("Keuken")    end)
ZA_Enter("Kamer_Badkamer" ,function() MapShow("Badkamer")  end)
AddClickable("Vlag_Brabant")
AddClickable("Computer")
AddClickable("Scyndi") -- The name "Scyndi refers to a cabinet in my home of which I did have a picture of Scyndi (from Secrets of Dyrt) and named the cabinet after it. The picture is removed by now, but the name remained.
if Maps.Obj.Exists("Crystal_Asleep")>0 then AddClickable("Crystal_Asleep") end
SetScrollBoundaries(432,-96,576,-96)
end
