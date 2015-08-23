--[[
/* 
  Combat Linker

  Copyright (C) 2015 JPB

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



Version: 15.06.27

]]
function ClearCombatData()
local remove = {}
local k,v
for k,v in IVARS() do
    if left(k,8)=="%COMBAT." then table.insert(remove,k) end
    if left(k,8)=="$COMBAT." then table.insert(remove,k) end
    end
for _,k in ipairs(remove) do
    Var.Clear(k)
    end
end

function StartCombat()
MS.Load("COMBAT","Script/Flow/Combat.lua") -- Make sure everything in the battle is properly reset!
MS.Run("COMBAT","InitCombat")
LAURA.Flow("COMBAT")
end        
