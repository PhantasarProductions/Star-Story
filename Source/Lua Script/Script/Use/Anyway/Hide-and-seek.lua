--[[
/* 
  Hide_and_seek

  Copyright (C) 2015 Jeroen P. Broks
  
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
alwaysshow = alwaysshow or {"PLAYER"}

function MapShow(...)
if ThisIsAMapScript then
   for i,v in ipairs(arg) do CSay("Show #"..i.." "..v) end CSay("")
   Maps.ShowOnlyLabel(join(arg,","),1)
   Var.D("$MAP.MAPSHOW.LASTREQUEST",join(arg,","))
   Var.D("$MAP.MAPSHOW.LASTALWAYSSHOW",serialize("ret",alwaysshow))
   local i,a
   for i,a in ipairs(alwaysshow) do Maps.ShowObject(a) end
   if ResetFoePositions then ResetFoePositions() else MS.Run("FIELD","ResetFoePositions") end
else
   CSay("MapShow: Not called from Map Script so calling it from mapscript artifically")
   MS.Run("MAP","MapShow",join(arg,",")) 
   end
end

function OnlyMapShow(...) -- Same as mapshow but will skip the 'always show' variable
if ThisIsAMapScript then
   for i,v in ipairs(arg) do CSay("Show #"..i.." "..v) end CSay("")
   Maps.ShowOnlyLabel(join(arg,","),1)
   Var.D("$MAP.MAPSHOW.LASTREQUEST",join(arg,","))
   Var.D("$MAP.MAPSHOW.LASTALWAYSSHOW",serialize("ret",alwaysshow))
   local i,a
   for i,a in ipairs(alwaysshow) do Maps.ShowObject(a) end
   if ResetFoePositions then ResetFoePositions() else MS.Run("FIELD","ResetFoePositions") end
else
   --CSay("MapShow: Not called from Map Script so calling it from mapscript artifically")
   --MS.Run("MAP","MapShow",join(arg,",")) 
   end
end -- Yeah this was the dirty method I know   

function RedoMapShow() -- This function has only been put in place for the LoadGame sequence to make sure the request of the last MapShow is properly followed if it was in fact used at all since the last loadmap.
if ThisIsAMapScript then
  local req = CVVN("$MAP.MAPSHOW.LASTREQUEST")
  local fas = loadstring(CVV("$MAP.MAPSHOW.LASTALWAYSSHOW").."\nreturn ret")
  local tas = alwaysshow
  local as
  CSay("Redo Map Show")
  CSay("- Last request = "..sval(req))
  alwaysshow = fas() or tas
  for as in each(alwaysshow) do CSay("- Always show: "..as) end
  if req then MapShow(req) end
  alwaysshow = tas
else
   CSay("RedoMapShow: Not called from Map Script so calling it from mapscript artifically")
   MS.Run("MAP","RedoMapShow")
   end 
end
