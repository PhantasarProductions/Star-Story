--[[
  AAAAAAAAAAA.lua
  AAAAAAAAA - This file simply must always be loaded first and thus this measure. ;)
  version: 15.09.02
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
]]
--[[
/* 
  AAAAAAAAA - This file simply must always be loaded first and thus this measure. ;)

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



Version: 15.08.26

]]
-- @USEDIR Script/Use/Linkers
-- @USEDIR Script/Use/Goto
-- I placed the linkers and gotos in a separate folder just to keep things organized, but they are nearly always required, so therefore I placed the link here, so that I don't have to refer to it all the time (I told ya I'm lazy).

-- This is a file with some base variable definitions and should ALWAYS be on top.

skill = Sys.Val(Var.C("%SKILL"))
ngpcount = Sys.Val(Var.C("%NEWGAMEPLUS"))
if ngpcount==0 then ngpcount=1 end
if skill==0 then skill=2 end


-- @SELECT skill
-- @CASE 1
   InventorySockets = 100         -- Max sockets
   InventorySocketRow = 10        -- Max number of sockets per row
   InventoryMaxStack = 25         -- Max number of items that may be stacked on a socket
   InventoryMaxVaultStack = 500   -- Max number of items that may be stacked on a vault socket (where each (unique) item just has one socket)
-- @CASE 2
   InventorySockets = 50
   InventorySocketRow = 10   
   InventoryMaxStack = 10
   InventoryMaxVaultStack = 250
-- @CASE 3
   InventorySockets = 25
   InventorySocketRow = 5
   InventoryMaxStack = 1
   InventoryMaxVaultStack = 100
-- @ENDSELECT    



function ALWAYSTRUE() return true end
