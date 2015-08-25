--[[
/* 
  

  Copyright (C) 2015 Jeroen P. Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles.
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



Version: 15.05.22

]]
if not realinventory then -- This if statement must prevent that the real Items and Abilities routine (which incldues this file as well and I cannot prevent that) gets destroyed by these definitions!

   MS.LoadNew("ITEMS","Script/SubRoutines/Items and Abilities.lua")

   ItemName = function(I)
   MS.Run("ITEMS","ItemName",I)
   return Var.C("$RET")
   end

   ItemDesc = function(I)
   MS.Run("ITEMS","ItemDesc",I)
   return Var.C("$RET")
   end
   
   ItemIcon = function(I,x,y)
   MS.Run("ITEMS","ItemIcon",I..";"..x..";"..y)
   end
   
   ItemIconCode = function(I)
   MS.Run("ITEMS","ItemIconCode",I)
   return Var.C("$RET")
   end
   
   ItemField = function (I,F)
   MS.Run("ITEMS","ItemField",I..";"..F)
   return Var.C("$RET")
   end
   
   ItemGet = function (I)
   ItemGetArray = ItemGetArray or {}
   if ItemGetArray[I] then return ItemGetArray[I] end
   MS.Run("ITEMS","ItemGet",I)
   local f = loadstring(Var.C('$RET'))
   -- print(Var.C("$RET"))
   ItemGetArray[I] = f()
   return ItemGetArray[I]
   end
   
   
   end -- grand end
