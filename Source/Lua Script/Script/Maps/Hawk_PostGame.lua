--[[
**********************************************
  
  Hawk_PostGame.lua
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
 
version: 16.08.03
]]

function CLICK_ARRIVAL_Terminal()
 if not Done("&TUT.TERMINAL") then MapText("TERMINALTUTORIAL") end
 MS.LoadNew("TERMINAL","Script/Flow/Terminal.lua") -- Load the terminal program, but only if it wasn't already loaded.
 LAURA.Flow("TERMINAL")
 Schedule('MAP','StartMusic')
end

function StartMusic()
   Music('Launcher/Launcher.ogg')
end   

function NPC_Bakina()
   SetActive('Wendicka')
   TurnPlayer('North')
   MapText('BANIKA')
end   

function NPC_Upgrade()
   TurnPlayer('North')
   MapText('SAPPAE')
end   

function StarNewGamePlus()
  -- NG Plus Message
  Image.Cls()
  DarkText("Starting New Game+",400,250,2,2,255,0,0)
  DarkText("Please wait",400,350,2,2,255,180,0)
  Flip()
  -- Clear all non-transferrable variables
  local pv = JINC('Script/JINC/NewGame+/PreserveVar.lua')
  local transfer = {}
  local varlist = mysplit(Var.Vars(),";")
  CSay("- Saving fixed vars")
  for v in each(pv.fixed) do
      if CVVN(b) then transfer[v] = Var.C(v) CSay('  = Preserved: '..v) end
  end 
  CSay("- Saving prefixed vars")
  for v in each(varlist) do
      for pre in each(pv.prefix) do 
          if prefixed(v,pre) then transfer[v] = Var.C(v) CSay('  = Preserved: '..v) end
      end    
  end
  CSay("- Clear all variables")
  Vars.ClearAll()     
  CSay("- Defining all NEEDED variables anew")
  for k,v in spairs(transfer) do
      Var.D(k,v)
      CSay("  = "..k.."  << "..v)
  end
  Sys.Error('Not everything for the New Game+ has yet been set up')    
end

function NPC_NEWGAMEPLUS()
   SetActive('Wendicka')
   TurnPlayer('North')
   MapText('NGP')
   local Keuze = RunQuestion("MAP","NGPQ1")
   if Keuze==2 then return MapText('NGPQ1_NEE') end
   MapText('NGP2')
   Keuze = RunQuestion("MAP","NGPQ2")
   if Keuze==1 then StartNewGamePlus() end
end


function GALE_OnLoad()
     StartMusic ()
     MapShow('Back')     
     AddClickable("Terminal")
     -- Show NPCs in the back only when you let them on board
     if not CVV("&BANIKA") then Maps.Obj.Kill("NPC_Banika") Maps.Obj.Kill("NPC_Bakina") end     
end     
