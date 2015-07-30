--[[
/* 
  Quick JCR6

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



Version: 15.07.18

]]


function jcr6listfile(m,f)
--[[
local bt = JCR6.ReadFile(m,f)
local ret = {}
while JCR6.Eof(bt)==0 do
      table.insert(ret,JCR6.ReadLn(bt))
      end
JCR6.Close(bt)
return ret
]]
if not mysplit then Sys.Error("JCR6ListFile requires mysplit.lua") end
local s = JCR6.LoadString(m,f)
return mysplit(s,"\n")
end

JCR6ListFile = jcr6listfile      

function jcr6dirtable()
 local f=loadstring(JCR6.DirTable())
 return f()
end
JCR6DirTable = jcr6dirtable

function iJCR6Dir(cap)
local t = jcr6dirtable()
local i = 0
return function() 
    i = i + 1
    if t[i] and cap then return string.upper(t[i]) elseif t[i] then return t[i] end
    end
end
