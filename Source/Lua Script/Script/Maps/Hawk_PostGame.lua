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
 
version: 16.11.30
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

function StartNewGamePlus()
  -- NG Plus Message
  Image.Cls()
  DarkText("Starting New Game+",400,250,2,2,255,0,0)
  DarkText("Please wait",400,350,2,2,255,180,0)
  Flip()
  -- Clear all non-transferrable variables
  local pv = JINC('Script/JINC/NewGame+/PreserveVar.lua')
  local transfer = {}
  local varlist = mysplit(Var.Vars(';'),";")
  CSay("- Saving fixed vars")
  for v in each(pv.fixed) do
      if CVVN(v) then transfer[v] = Var.C(v) CSay('  = Preserved: '..v) end
  end 
  CSay("- Saving prefixed vars")
  --CSay(serialize('varlist',varlist))
  CSay("Vars = "..Var.Vars(';'))
  for v in each(varlist) do
      CSay("Let's try: "..v)
      for pre in each(pv.prefix) do 
          -- CSay("v = "..v.."; pre = "..pre.."; prefixed = "..sval(prefixed(v,pre)))
          if prefixed(v,pre) then transfer[v] = Var.C(v) CSay('  = Preserved: '..v) end
      end    
  end
  --CSay("- Showing result")
  --CSay(serialize("result",transfer))
  CSay("- Clear all variables")
  Var.ClearAll()     
  CSay("- Defining all NEEDED variables anew")
  for k,v in spairs(transfer) do
      Var.D(k,v)
      CSay("  = "..k.."  << "..v)
  end
  -- Upgrade ExHuRU
  CSay("Upgrading ExHuRU ABL Used")
  for a in each({'YKSY','KAKSI','KOLME','NELJA','KUUSI','BATTLECRY'}) do
      inc('%ABL.USED.EXHURU.'..a,CVV("%ABL.USED.ROLF."   ..a))
      inc('%ABL.USED.EXHURU.'..a,CVV("%ABL.USED.JOHNSON."..a))
      Var.Clear("%ABL.USED.JOHNSON."..a)
      Var.Clear("%ABL.USED.ROLF."   ..a)
  end
  -- Clearing Navigation Panel Hawk
  CSay("- Clearing the navigation panel on the Hawk")
  TransporterClearAll()    
  -- Boost Xenobi
  local xlv = RPGChar.Stat("Xenobi",'Level')
  if xlv>300 and xlv<9000 then RPGStat.IncStat("Xenobi","Level",28); SyncLevel('Xenobi') end
  -- Make sure Uniforemd versions of Wendicka and Crystal come up properly.
  CSay("- Uniform level resync")
  SyncLevel('UniWendicka')
  SyncLevel('UniCrystal')
  CSay("- EXP uncap")
  local needexp = {1500,4500,15000}
  -- Reopening EXP in case the level cap was reached in the previous cycle
  for ch in each({"Wendicka","Crystal","ExHuRU","Yirl","Foxy","Xenobi"}) do -- No need to get the uniformed versions and Rolf and Johnson as they are all LINKED!!
      if RPGChar.Stat(ch,"Level")~=10000 then
         CSay(ch.."'s EXP has been re-opened (in case it was closed)")
         RPGChar.Points(ch,"EXP",1).Maximum = needexp[skill] or 5000
         if RPGChar.Points(ch,"EXP",1).Maximum==0 then RPGChar.Points(ch,"EXP",1).Maximum=5000 end -- Dirty code straight from hell, but it will have to do for now.
         if ngpcount>=5 then
            local b = ngpcount
            local d = skill * 50
            RPGChar.Points(ch,"EXP",1).Maximum = b*d
         end
      else
         CSay(ch.."'s EXP remains closed, since the level cap has been reached")
      end   
   end   
  -- Kill all map swap files, but make sure the chests removed by a collected ARM remain.
  Maps.PermaGenocide(1) 
  -- Remove all key items
  if CVV('%VAULT.KEY_YAQIRPA') then Var.Clear("%VAULT.KEY_YAQIRPA") end
  for ch in each({"Wendicka","Crystal","ExHuRU","Yirl","Foxy","Xenobi"}) do
      for i=1,InventorySockets do
          if upper(RPGStat.GetData(ch,'INVITEM'..i))=="KEY_YAQUIRPA" then 
             RPGChar.DefStat(ch,'INVAMNT'..i,0) 
             RPGStat.setData(ch,'INVITEM'..i,'')
             end
      end
  end
  -- Fix and issue with Wendicka's modifiers
  for s in each({'Dark','Light','Fire','Frost','Lightning','Water','Wind','Earth'}) do
      RPGStat.LinkStat("Wendicka","UniWendicka","ER_MODIFIER_"..s)
      CSay("Wendicka Casual/Uniform - Linking: "..s)
  end
  -- Count new cycle 
  if ngpcount<10 then ngpcount = ngpcount + 1 end
  Var.D('%NEWGAMEPLUS',ngpcount)
  -- Go back to the Yaqirpa
  MapShow("ShowNothing!!!")
  Party('UniWendicka','UniCrystal','Briggs')
  DrawScreen()
  Flip()
  DrawScreen()
  Flip()
  LoadMap('Prologue_Yaqirpa') 
  MapShow("Entrance")
  Actors.Spawn("StartWendicka","GFX/Actors/Uniform","ActWendicka"); CSay("Wendicka Loaded")
  Actors.Spawn("StartCrystal","GFX/Actors/Uniform","ActCrystal"); CSay("Crystal Loaded")
  Actors.Spawn("StartBriggs","GFX/Actors/Uniform","ActBriggs"); CSay("Briggs Loaded"); CSay("All actors loaded")
  Actors.ChoosePic("ActWendicka","WENDICKA.NORTH")
  Actors.ChoosePic("ActCrystal","CRYSTAL.NORTH")
  Actors.ChoosePic("ActBriggs","BRIGGS.NORTH")
  Maps.CamX=608
  Maps.CamY=1360
  Maps.Draw()
  Flip()
  for ch in each({'Wendicka','Crystal','Briggs'}) do
      local p = RPGChar.Points(ch,"HP")
      p.Have = p.Maximum
  end
  MapText('NEWGAMEPLUS')
  -- Sys.Error('Not everything for the New Game+ has yet been set up')  
end

function NPC_NEWGAMEPLUS()
   SetActive('Wendicka')
   TurnPlayer('North')
   MapText('NGP')
   local Keuze = RunQuestion("MAP","NGPQ1")
   if Keuze==2 then return MapText('NGPQ1_NEE') end
   MapText('NPG2') -- This is a typo in the scenario files. It's quite a disaster to fix it there, so let's just make the same typo here.
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
