--[[
  CPlayerInput.lua
  Version: 15.09.16
  Copyright (C) 2015 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================
  zLib license terms:
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

-- @UNDEF TARGETDEBUGGING


SelectTarget = {

         -- A few initations are always required before this becomes PIA. This function sets it all up and initiates PIA as well
         StartSelect = function(groups,returnto) 
                       SelectTarget.ReturnTo = returnto
                       SelectTarget.AllowGroups = groups
                       if type(groups)=="string" then SelectTarget.AllowGroups = {groups} end 
                       PIA = SelectTarget
                       end,
                       
         AblSelectTarget = function(trgt,ch,pos,returnto)
                           (({
                              ["1A"] = function() SelectTarget.StartSelect("Hero",returnto) end,
                              ["1F"] = function() SelectTarget.StartSelect("Foe" ,returnto) end,
                              ["AA"] = function() Act.Hero[pos].TargetGroup = "Hero"; InputDone=true end,
                              ["AF"] = function() Act.Hero[pos].TargetGroup = "Foe" ; InputDone=true end,
                              ["EV"] = function() Act.Hero[pos].TargetGroup = true  ; InputDone=true end,
                              ["OS"] = function() Act.Hero[pos].TargetGroup = "Hero"; Act.Hero[pos].TargetIndividual=pos end
                           })[trgt] or function() Sys.Error("Unknown Target type "..sval(trgt)) end)()   
                           end,           

         Input = function(ch,pos)
                 local group,i,f
                 local fx,fy
                 local mx,my = MouseCoords()
                 -- @IF TARGETDEBUGGING
                 local debugy = 15
                 -- @FI
                 if not (Done("&TUT.TARGETSELECT")) then Tutorial("Use the mouse to select your target\nLeft mouse button is select\nRight mouse button is cancel") end
                 assert(SelectTarget.AllowGroups,"Cannot select a target without a group")
                 TargetedGroup = nil
                 TargetedFighter = nil
                 -- @IF TARGETDEBUGGING
                 Image.NoFont()
                 DarkText("Mouse = ("..mx..","..my..")",5,0)                 
                 -- @FI
                 DarkText("Please select your target:",400,10,2,0,0,180,255)
                 for group in each(SelectTarget.AllowGroups) do
                     for i,f in pairs(Fighters[group]) do
                         fx,fy = CoordsFighter[group](i)
                         -- @IF TARGETDEBUGGING
                         DarkText("Target>  "..group.."["..i.."] on coordinates ("..fx..","..fy..")",5,debugy) debugy=debugy+15
                         Marker(fx,fy)
                         -- @FI
                         if mx>fx-16 and mx<fx+16 and my>fy-32 and my<fy then
                            TargetedGroup = group
                            TargetedFighter = i
                            -- @IF TARGETDEBUGGING
                            DarkText("^^^^ MY TARGET ^^^^",5,debugy) debugy=debugy+15
                            -- @FI
                            TargetInfo(group,i,f,fx,fy)
                            if INP.MouseH(1)==1 then
                               Act.Hero[pos].TargetGroup = group
                               Act.Hero[pos].TargetIndividual = i
                               PIA = SelectTarget.ReturnTo
                               InputDone=true
                               TargetedGroup = nil
                               end
                            end 
                         end
                     end
                 ShowMouse()
                 if INP.MouseH(2)==1 then 
                    PIA = SelectTarget.ReturnTo
                    TargetedGroup=nil 
                    Var.D("%CHOSENITEM.SOCKET",0)                    
                    end                 
                 end,
         Done = function() return false end -- If this is in PIA, the move is never input, so it should always return false, however, nonexistence of this function will lead to a crash.        
      
      }

InputItems = {

    { Name = "Attack",
      Item = "ATK",
      Allow = function(ch)
              local ret = true
              ret = ret and RPGChar.Stat(ch,"AMMO")==0 
              return ret
              end,
      Input = function(ch,pos)
              Act.Hero[pos].ActSpeed=250              
              if not Act.Hero[pos].Target then
                 SelectTarget.StartSelect({"Foe"})
                 end
              end,        
      Done = function(ch,pos)
             Act.Hero[pos].ActSpeed=250
             return Act.Hero[pos].Target
             end        
      },
      
    { Name = "Shoot",
      Item = "SHT",
      Allow = function(ch)
              local ret = true
              ret = ret and RPGChar.Stat(ch,"AMMO")>0
              ret = ret and RPGChar.Points(ch,"AMMO").Have>0
              return ret
              end,
      Input = function(ch,pos)
              Act.Hero[pos].ActSpeed=250
              Act.Hero[pos].Act = "SHT"
              if not Act.Hero[pos].Target then 
                 SelectTarget.StartSelect({"Foe"},nil)
                 end
              end,        
      Done = function(ch,pos)
             Act.Hero[pos].Act = "SHT"
             Act.Hero[pos].ActSpeed=250
             return Act.Hero[pos].Target
             end        
      },
      
    { Name = "Reload",
      Item = "RLD",
      Allow = function(ch)
              local ret=true 
              ret = ret and RPGChar.Stat(ch,"AMMO")>0
              ret = ret and RPGChar.Points(ch,"AMMO").Have~=RPGChar.Points(ch,"AMMO").Maximum
              return ret
              end,
      Input = function(ch,pos)
              Act.Hero[pos].ActSpeed=250
              Act.Hero[pos].Act = "RLD"
              InputDone=true
              end,        
      Done = function()
             return true
             end          
    }   ,
    
    { Name = "Ability",
      Item = "ABL",
      Allow = function(ch)
              local ret = true
              ret = ret and RPGStat.ListExist(ch,"ABL")~=0
              ret = ret and RPGStat.CountList(ch,"ABL")>0
              return ret
              end,
      Input = function(ch,pos)
              local item
              local iact
              if CVV("$CHOSENABILITY")=='' then GoToMenu(ch,"Abilities") 
              elseif CVV("$CHOSENABILITY")=='cancel' then 
                     PIA=nil
                     Var.D("$CHOSENABILITY",'') 
              else
                 item=ItemGet(CVV("$CHOSENABILITY"))
                 iact = Act.Hero[pos]
                 iact.Act = "ABL"
                 iact.ActSpeed = item.ActSpeed
                 iact.ItemCode = CVV("$CHOSENABILITY")
                 iact.Item = item                 
                 SelectTarget.AblSelectTarget(item.Target,ch,pos)
                 end
              end,        
      Done = function()
             end  
    },
    
    { Name = "ARMS",
      Item = "ARM",
      Allow = function(ch)
              local ret = true
              ret = ret and RPGStat.ListExist(ch,"ARMS")~=0
              ret = ret and RPGStat.CountList(ch,"ARMS")>0
              return ret
              end,
      Input = function(ch)
              end,        
      Done = function()
             end  
    },


    { Name = "Item",
      Item = "ITEM",
      Allow = function(ch) return ch~="Briggs" end,
      Input = function(ch,pos)
              local item
              local iact
              if CVV("%CHOSENITEM.SOCKET")==0 then GoToMenu(ch,"Items") ; CSay("Go to items for ch >> "..sval(ch))
              elseif CVV("%CHOSENITEM.SOCKET")<0 then 
                     PIA=nil
                     Var.D("%CHOSENITEM.SOCKET",0) 
              else
                 item=ItemGet("ITM_"..CVV("$CHOSENITEM.ITEM"))
                 iact = Act.Hero[pos]
                 iact.Act = "ITM"
                 iact.ActSpeed = item.ActSpeed
                 iact.ItemCode = "ITM_"..CVV("$CHOSENITEM.ITEM")
                 iact.Item = item
                 iact.ItemSocket = CVV("%CHOSENITEM.SOCKET")
                 SelectTarget.AblSelectTarget(item.Target,ch,pos)
                 end
              end,        
      Done = function()
             end  
    },
    
    { Name = "Guard",
      Item = "GRD",
      Allow = function() return true end,
      Input = function(ch)
              end,        
      Done = function()
             end       
    },
    
    { Name = "Switch",
      Item = "SWT",
      Allow = function(ch) return RPGChar.PartyTag(3)~="" end,
      Input = function(ch)
              end
    }  

}

IBT = {} --[[ Item by tag ]] for _,vIBT in ipairs(InputItems) do IBT[vIBT.Item] = vIBT end -- (each cannot be used here, as on this call the function was not yet loaded (at least not in the current version of LAURA II on the day this was scripted)).

function AllowInputItems(ch)
-- A few initiations
Var.D("%CHOSENITEM.SOCKET",0)
Var.D("$CHOSENITEM.ITEM","")
Var.D("$CHOSENABILITY","")
Var.D("$CHOSENARM","")
-- Sound Effect here, as this is always at the start of the input. :)
SFX("Audio/SFX/Signal.ogg")
-- And now the input allowance itself
local ret = {}
local v
local case = { 
      [true] = function(value) 
               table.insert(ret,value)
               -- CSay("Allow: "..value.Name) -- Debug line 
               end, 
      [false] = function() end 
      }
--CSay("Scanning for allowed commands: "..ch)
for v in each(InputItems) do 
    assert(v.Allow,"Allow function not found in item "..sval(v.Name)) 
    assert(v.Allow(ch)~=nil,"Allow function returned nil in item "..sval(v.Name))
    assert(case[v.Allow(ch)],"Allow function returned invalid value in item "..sval(v.Name).."("..sval(v.Allow(ch))..")","Value,"..sval(v.Allow(ch)))
    case[v.Allow(ch)](v) 
    end
return ret
end

InputMenu = { Input = function(ch,pos)
                      assert(ch,"Cannot input a move for character 'nil'")
                      local by = 500
                      local x = ((pos or 0)-1)*200
                      local y = (by - Image.Height("CMBTM_Bottom")) - 1 
                      local is = Image.Height("CMBTM_Item") + 1
                      UseInputItems = UseInputItems or AllowInputItems(ch)
                      local tis = is * #UseInputItems
                      local i,v
                      local iy,item
                      local mx,my = MouseCoords()
                      if not (Done("&TUT.STANDARDMENU")) then Tutorial("Use the mouse to select the action you desire") end
                      White()
                      Image.Show("CMBTM_Bottom",x,y); 
                      Black()
                      if RPGChar.Points(ch,"AMMO").Maximum>0 then
                         Image.DText(RPGChar.Points(ch,"AMMO").Have .." / " .. RPGChar.Points(ch,"AMMO").Maximum,x+100,y+40,2,2)
                         end
                      y = y - tis   
                      White()
                      Image.ViewPort(x,y,200,tis)
                      Image.Tile("CMBTM_Sides",x,y)
                      Image.ViewPort(0,0,800,600)
                      Image.Show("CMBTM_Top",x,y-Image.Height('CMBTM_Top'))
                      iy = y
                      SetFont('CombatPlayerInput')
                      for item in each(UseInputItems) do
                          White()
                          Image.Show('CMBTM_Item',x+100,iy)
                          Image.Color(0,180,255)
                          if mx>x and mx<x+200 and my>iy and my<iy+is then
                             Image.Color(0,255,255)
                             if INP.MouseH(1)==1 then PIA=item; Act.Hero[pos] = { Act=item.Item } end
                             end
                          Image.DText(item.Name,x+100,iy+(is/2),2,2)
                          iy = iy + is
                          end  
                      ShowMouse()                        
                      end,
              Done = function() return false end -- If this is in PIA, the move is never input, so it should always return false, however, nonexistence of this function will lead to a crash.        
            }



-- The Done fields can be ignored now. Somehow this does not work the way it should so let's use another method

-- The input routine
function PlayerInput(pos,tag)
local cPIA,citem
PIA = PIA or InputMenu  -- PIA = Player Input Active. It should contain the menu item of the currently active menu item or otherwise the menu itself.
citem = PIA.Item or citem
if citem then cPIA = IBT[citem] end
PIA.Input(tag,pos)
-- if cPIA and cPIA.Done and cPIA.Done(tag,pos) then
if InputDone then
   InputDone = false
   -- Act.Hero[pos].Act = citem
   Fighters.Hero[pos].Gauge = 10001
   Fighters.Hero[pos].Act = Act.Hero[pos]
   UseInputItems = nil
   PIA = nil
   InputDone = false
   if (Act.Hero[pos].Act=="ATK" or Act.Hero[pos].Act=="SHT") and (RPGChar.CountList(tag,"LEARN")>0) then
      Act.Hero[pos].Act = "LRN"
      Act.Hero[pos].ActSpeed = 2500
      end
   end
end


function DebugPIA()
-- local s = mysplit(serialize("PIA",PIA),"\n")
local k,v
if not PIA then CSay("PIA is not yet active") return end
for k,v in spairs(PIA) do
    CSay(k.." = "..sval(v))
    end    
end
