--[[
**********************************************
  
  Nizozemska - Belioss.lua
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
 
version: 16.05.20
]]

-- @USE /Script/Use/Maps/Gen/Next.lua


function Enter()
    if not Done("&DONE.NIZOZEMSKA.BELIOSS.ENTER") then MapText("ENTER") end
end

function Renew()
    RecoverParty()
    MS.Run("FIELD","SetUpFoes")
    MS.Run("FIELD","SetUpTreasure")    
end

function NPC_SaveSpot()
  MS.LoadNew("NIZOSAVE","Script/Flow/NizozemskaSave.lua")
  LAURA.Flow("NIZOSAVE")
end

function To6()
   Maps.GotoLayer("#006")
   SpawnPlayer("Start")
end

function To4()
   Maps.GotoPlayer('#004')
   SpawnPlayer('From6')
end

function GALE_OnLoad()
  Music('Dungeon/Electro Cabello.ogg')
  ZA_Enter("ByeBye",GoWorld,"Nizozemska")
  ZA_Enter("Enter",Enter)
  ZA_Enter("Renew",Renew)
  ZA_Enter("To6",To6)
  ZA_Enter("To4",To4)
  for i=1,4 do ZA_Enter("Base"  ..i,MapShow,"Base"  ) end
  for i=1,2 do ZA_Enter("Secret"..i,MapShow,"Secret") end  
end

