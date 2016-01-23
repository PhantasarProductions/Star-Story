--[[
  SchuifNextReal.lua
  Version: 16.01.23
  Copyright (C) 2016 Jeroen Petrus Broks
  
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
if not(Next and Prev) then Sys.Error("No next?") end


InitSchuif("NextLinks",-30,0,"Dicht")
InitSchuif("PrevLinks",-30,0,"Dicht")
InitSchuif("NextRechts",30,0,"Dicht")
InitSchuif("PrevRechts",30,0,"Dicht")

function OpenPrev()
SetSchuif({"PrevLinks","PrevRechts"},"Open")
end

function OpenNext()
SetSchuif({"NextLinks","NextRechts"},"Open")
end

function SluitPrev()
SetSchuif({"PrevLinks","PrevRechts"},"Dicht")
end

function SluitNext()
SetSchuif({"NextLinks","NextRechts"},"Dicht")
end


ZA_Enter("SchuifPrev",OpenPrev); ZA_Leave("SchuifPrev",SluitPrev)
ZA_Enter("SchuifNext",OpenNext); ZA_Leave("SchuifNext",SluitNext)

