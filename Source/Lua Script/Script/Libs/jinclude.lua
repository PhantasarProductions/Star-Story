--[[
/* 
  J - Include

  Copyright (C) 2013, 2015 Jeroen P. Broks

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



Version: 15.07.18

]]
-- This function is supposed to read an entire lua function from a JCR file
-- and return the value it returns.
function jinc(a)
local s = ''
--local bt = JCR6.ReadFile(a)
CSay("J-Including: "..a) --.." ("..bt..")")
--[[
if bt==0 then CSay("WARNING! Null returned when opening the file!") end
while JCR6.Eof(bt)==0 do
      --s = s .. Str.Char(JCR6.ReadB(bt))
      s = s .. JCR6.ReadLn(bt).."\n"
      CSay(bt..">"..s)
      end
JCR6.Close(bt); CSay("End of file") ]]
s = JCR6.LoadString(a)
-- print("\n\nJ_INCLUDED SCRIPT:\n"..s.."END J_INCLUDE!\n\n")
local fn = loadstring(s)
if not fn then Sys.Error("Included script contains errors","f,jinc;script,"..a) end
if type(fn)~="function" then CSay("WARNING! J-Include did not produce a function. It produced a "..type(fn).." in stead!") end
return fn()
end

JINC = jinc

if __consolecommand then
   function __consolecommand.JINCTEST()
    local a = jinc("Test.lua")
    Console.Write("Returned: "..a,rand(1,255),rand(1,255),rand(1,255))
    end
   end
