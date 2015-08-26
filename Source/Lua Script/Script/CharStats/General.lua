--[[
/* 
  

  Copyright (C) 2015 Jeroen P. Broks

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



Version: 15.07.20

]]
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
-- This file links to all general calculations for characters.             --
-- You can see I did put in an AutoUse.lua plus its own separate folder    --
-- This is done because I don't expect to need any alternate scripts,      --
-- so just the same script for all characters, BUT in the unexpected case  --
-- I do need a different script then this way it is possible. But the      --
-- Truth is that all work is done in AUTOUSE.LUA and that any other file   --
-- will just be alterations to all this                                    --
--                                                                         --
-- Seems like I completely forgot about Wendicka's lighting thingy.        --
-- Silly me. So a few scripts did have to be used after all :)             --
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------



--[[ Contrary to normal working this out you should do all alterations like
     this:
     
     
function GALE_OnLoad()

    CALC_Strength = function()
     -- code --
     end
     
   CALC_Defense = function
     -- code --
     end
     
   -- and so on!
   
   end
   
-- If you don't then the AUTOUSE will overwrite everything, however doing this inside the GALE_OnLoad will cause the AutoUse functions to be overwritten. 


]] 
