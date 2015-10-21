--[[
  WalkWait.lua
  
  version: 15.09.03
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

-- @UNDEF WALKWAITDEBUG

function WalkWait(dact)
local ok
local act = ({ ["table"]  = function() return dact       end,
               ["string"] = function() return {dact}     end,
               ["nil"]    = function() return {"PLAYER"} end })[type(dact)]()
repeat
MS.Run("Field","DrawScreen")
ok = true
local y
for a in each(act) do
    -- @IF WALKWAITDEBUG
    y = (y or 0) + 15
    DarkText("Actor: "..a.."; Walking: "..Actors.Walking(a).."; ok: "..bool2int(ok),5,y,0,0,255,180,0)
    -- @FI
    ok = ok and Actors.Walking(a)==0   
    end
Flip()    
until ok    
end
