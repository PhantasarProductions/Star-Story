--[[
/**********************************************
  
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
  
  
 **********************************************/
 



Version: 15.07.20

]]
function TutSave()
if not Done("&DONE.TUT.YAQIRPA.SAVE") then
   Actors.StopWalking("ActWendicka")
   Actors.StopWalking("ActCrystal")
   Actors.StopWalking("Briggs")
   MapText("EXPLAIN_SAVE")
   Tutorial("Use the diary to save your game")
   end
MapShow("save")   
end

function SaveSpot()
-- Mini("Savespot reached!")
GotoSave()
end 

CLICK_ARRIVAL_SAVE1 = SaveSpot

function EnterSave() MapShow("save") end
function EnterGreatHall() MapShow("GreatHall") end
function EnterEntrance() MapShow("Entrance") end

function GALE_OnLoad()
CSay("Welcome to the Yaqirpa")
Music("Dungeon/Opening Theme C")
if not CVV("&DUNG.YAQIRPA") then
  MS.LoadNew("FIELD","Script/Flow/Field.lua") 
  MS.Run("FIELD","SetPlayer","ActWendicka") 
  end
ZA_Enter("SAVEZONE1",TutSave)
ZA_Enter("SAVEZONE1",EnterSave)
ZA_Enter("EnterSave",EnterSave)
ZA_Enter("ToHallS",EnterGreatHall)
ZA_Enter("Entrance_Zone",EnterEntrance)
-- ZA_Enter("EnterSave",EnterEntrance)
AddClickable("SAVE1")
alwaysshow = {"ActWendicka","ActCrystal","ActBriggs"}
end

function MAP_FLOW()
-- Follow the loader. If Wendicka is the leader Crystal will follow Wendicka. If Crystal is the leader, Wendicka will follow Briggs. Briggs can never be the leader and will always follow Crystal.
clplayer = clplayer or "Wendicka"
local follow = {Wendicka = "Briggs", Crystal = "Wendicka", Briggs = "Crystal"}
local x,y,w 
local tx,ty,fx,fy
local leader,follower
for follower,leader in pairs(follow) do
    x,y,w = GetCoords("Act"..leader)
    tx,ty = x,y
    fx,fy = GetCoords("Act"..follower)
    -- @SELECT w
    -- @CASE "North"
       tx = x
       ty = y+64
    -- @CASE "South"
       tx = x
       ty = y-64
    -- @CASE "East"
       tx = x-64
       ty = y
    -- @CASE "West"
       tx = x+64
       ty = y
    -- @DEFAULT
       tx = x
       ty = y+64
    -- @ENDSELECT
    -- CSay(follower.."> Leader:"..x..","..y..","..w.."; Target"..tx..","..ty)
    -- CSay("Leader = "..leader.."; controlled leader player = "..clplayer)
    if follower ~= clplayer and (tx~=fx or ty~=fy) and Actors.Walking("Act"..follower)==0 then Actors.WalkTo("Act"..follower,tx,ty)  end
    Actors.ChoosePic("Act"..leader,upper(leader).."."..upper(w))
    end
end
