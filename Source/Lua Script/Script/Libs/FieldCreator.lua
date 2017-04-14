--[[
  FieldCreator.lua
  
  version: 16.12.17
  Copyright (C) 2016 Jeroen P. Broks
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
  FieldCreator.lua
  
  version: 16.02.25
  Copyright (C) 2016 Jeroen P. Broks
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


-- Can be used with 'For' statements
function FieldEnum(x1,y1,x2,y2)
if not y2 then y2=y1 y1=1 end
if not x1 then x2=x1 x1=1 end
local x=x1-1
local y=y1
if (not x1 and x2 and y1 and y2) then Sys.Error("Illegal Function Call","F,FieldEnum;x,"..(x1 or 'nil').."."..(x2 or 'nil')..";y,"..(y1 or 'nil').."."..(y2 or 'nil')) end
if x2<x1 or y2<y1 then Sys.Error("Illegal Function Call","F,FieldEnum;x,"..x1.."."..x2..";y,"..y1.."."..y2) end
return function()
       x = x + 1 
       if x>x2 then x=x1; y=y+1 end
       if y>y2 then return nil,nil end
       return x,y
       end
end
       
function CreateField(w,h,v,ktr,ss1,ss2)
local f
if (not ktr) and type(v)=='table' then 
    f = loadstring(serialize("ret",v).."\nreturn ret")       
    end
local s1 = ss1 or 1
local s2 = ss2 or 1
local ret = {}
for x,y in FieldEnum(s1,s2,s1+w,s2+h) do
    ret[x] = ret[x] or {}
    ret[x][y] = (f or function() return v end)()
    end
return ret    
end
