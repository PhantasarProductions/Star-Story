--[[
/* 
  Debug

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



Version: 15.08.06

]]
function Dbg(...)
-- @IF *DEVELOPMENT
local i,v,o
for i,v in ipairs(arg) do
    o = ""
    if #arg>1 then o = string.sub("          "..i,10,-1)..":" end
    o = o .."DEBUGLOG>"..v
    Console.Write(o,0,180,255)
    end
-- @FI
end

function DBGSerialize(v,shownow)
-- -- @IF *DEVELOPMENT
if shownow then
   Console.Write("Debug serialize request received, stand by...",0,180,255)
   Console.Show()
   Console.Flip()
   end
local function dbgmysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
        end
local vl = mysplit(serialize("DEBUGCHECK",v),"\n")
local l,c
for c,l in ipairs(vl) do 
    Console.Write(string.sub("          "..c,10,-1)..": "..l,180,255,0)
    if shownow then
       Console.Show()
       Console.Flip()
       end 
    end        
-- @FI        
end
