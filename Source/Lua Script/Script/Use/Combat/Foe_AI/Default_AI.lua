--[[
/* 
  2015

  Copyright (C)  JPB
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
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

*/



Version: 15.08.26

]]
-- @IF IGNOREME
Foe_AI = {}
-- @FI

DefaultSys = {
        Attack = function(me,myact)
                 myact.TargetGroup,myact.TargetIndividual = FoeTargetSelector['1F'](me)
                 myact.Act = "ATK"
                 myact.ActSpeed=250
                 return myact.TargetGroup and myact.TargetIndividual
                 end,
        Guard  = function(me,act)
                 Sys.Error("Foe guarding not yet supported")
                 end
}

DefaultProcess = {
        Sys = function (me,act,myact)
              return DefaultSys[act](me,myact) 
              end,
        Abl = function (me,act,myact)
              local item = ItemGet(act)
              myact.Act = "FAI"
              myact.ItemCode = act
              myact.Item = item
              myact.ActSpeed = item.ActSpeed
              myact.TargetGroup,myact.TargetIndividual = FoeTargetSelector[item.Target](me)
              return myact.TargetGroup
              end
    }



function Foe_AI.Default(pos)
-- initiations
local timeout=0
Act.Foe = Act.Foe or {}
Act.Foe[pos] = {}
Fighters.Foe[pos].Gauge = 10001
Fighters.Foe[pos].Act = Act.Foe[pos]
local myact = Act.Foe[pos]
local myfoe = Fighters.Foe[pos]
local actlist = Fighters.Foe[pos].Actions
local ok = false
local chosenaction
local acttype,act,actsplit
if (not actlist) or #actlist==0 then DBGSerialize(Fighters.Foe[pos],true) Sys.Error("Foe_AI.Default("..pos.."): No actions defined!") end
repeat
   if timeout>=10000 then Sys.Error("Foe_AI.Default("..pos.."): Timeout") end
   chosenaction = actlist[rand(1,#actlist)]
   actsplit     = mysplit(chosenaction,".")
   acttype      = actsplit[1]
   act          = actsplit[2]
   timeout      = timeout + 1
   ok           = (DefaultProcess[acttype] or function() DBGSerialize(actsplit,true) Sys.Error("Foe_AI.Default("..pos.."): Unknown action type "..sval(acttype).."."..sval(act)) end)(myfoe,act,myact)
until ok
end 
