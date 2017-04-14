--[[
  jinclude.lua
  
  version: 16.12.26
  Copyright (C) 2015, 2016 Jeroen P. Broks
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
-- This function is supposed to read an entire lua function from a JCR file
-- and return the value it returns.

jincdebug = false

function jinc(a,prefix,err)
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
if prefix then s = prefix.."\n"..s end
-- print("\n\nJ_INCLUDED SCRIPT:\n"..s.."END J_INCLUDE!\n\n")
--[[ old
local fn = loadstring(s)
if not fn then Sys.Error("Included script contains errors","f,jinc;script,"..a..";error,"..err) end
if type(fn)~="function" then CSay("WARNING! J-Include did not produce a function. It produced a "..type(fn).." in stead!") end
return fn()
]]
if jincdebug then
   local jdb = mysplit(s,"\n")
   for i,l in ipairs(jdb) do
       Console.Write(right("         "..i,10).." | "..l,255,255,0)
   end
end       
local ok,fn = pcall(loadstring,s)
if not ok then Sys.Error("JINC script had a compilation error","f,jinc;script,"..a..";error,"..(fn or "unprintable error")) return nil end
local ret 
ok,ret = pcall(fn)
if not ok then Sys.Error("JINC script had a runtime error","f,jinc;script,"..a..";error,"..(ret or "unprintable error")) return nil end
return ret
end

JINC = jinc

if __consolecommand then
   function __consolecommand.JINCTEST()
    local a = jinc("Test.lua")
    Console.Write("Returned: "..a,rand(1,255),rand(1,255),rand(1,255))
    end
   end
