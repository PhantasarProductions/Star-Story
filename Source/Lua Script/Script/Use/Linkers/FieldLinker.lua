--[[
  FieldLinker.lua
  Version: 16.01.16
  Copyright (C) 2015, 2016 Jeroen Petrus Broks
  
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
LoadMap = LoadMap or function(map,layer) -- This way of defining makes sure we won't (by accident) overwrite the 'real' routine if it's present.
	parameter = map
	if layer then parameter = parameter .. ";" .. layer end	
	MS.LN_Run("FIELD","Flow/Field.lua","LoadMap",parameter)
end



Schedule = Schedule or function (scr,func)
MS.LN_Run("FIELD","Flow/Field.lua","Schedule",scr..";"..func) 
end

SetActive = SetActive or function(P) MS.LN_Run("FIELD","Flow/Field.lua","SetActive",P) end

TurnPlayer = TurnPlayer or function(w) MS.LN_Run("FIELD","Flow/Field.lua","TurnPlayer",w) end

GetActive = GetActive or function() MS.LN_Run("FIELD","Flow/Field.Lua","GetActive","yes") return Var.C("$RET") end

SetAutoScroll = SetAutoScroll or function(yes) MS.LN_Run("FIELD","Flow/Field.lua","SetAutoScroll",({[true]='yes',[false]='no'})[yes=='yes' or yes==true]) end

SetScrollBoundaries = SetScrollBoundaries or function(xmin,ymin,xmax,ymax)
MS.LN_Run("FIELD","Flow/Field.Lua","SetScrollBoundaries",strval(xmin)..";"..strval(ymin)..";"..strval(xmax)..";"..strval(ymax))
end

PartyPop = PartyPop or function(prefix,wind)
MS.LN_Run("FIELD","Flow/Field.Lua","PartyPop",prefix..";"..(wind or "North")) 
end

PartyUnPop = PartyUnPop or function() 
MS.LN_Run("FIELD","Flow/Field.Lua","PartyUnPop") 
end

KillWalkArrival = KillWalkArrival or function()
CSay("KillWalkArrival")
MS.LN_Run("FIELD","Flow/Field.Lua","KillWalkArrival") 
end
 
AddClickableScript = AddClickableScript or function(scr) MS.LN_Run("FIELD","Flow/Field.Lua","AddClickableScript",scr,"*DIT*MAG*GEWOONWEG*NIET*GESPLIT*WORDEN") end
