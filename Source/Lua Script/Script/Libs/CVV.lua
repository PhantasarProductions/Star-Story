--[[
/* 
  CVV

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
-- This is a function to turn a variable into an easy to get value.
-- This function requires to be used in a app that uses the gamevars module from GALE

CVF = {
   ["%"] = function(k) return Sys.Val(Var.C(k)) end,
   ["&"] = function(k) return string.upper(Var.C(k))=="TRUE" or string.upper(Var.C(k))=="FALSE" end,
   ["$"] = function(k) return Var.C(k) end
}

function CVV(k)
local prefix = string.sub(k,1,1)
local f = CVF[prefix] or CVF["$"]
return f(k)
end

function CVVN(k) -- This one will return nil if we have no variable
if Var.Got(k)==0 then return nil end
return CVV(k)
end

function inc(k,value)
local v = value or 1
local prefix = string.sub(k,1,1)
if prefix~="%" then
  Console.Write("ERROR! Can only 'inc' variables marked as '%'",255,0,0)
  return
  end
local s = CVV(k) + v
Var.D(k,s)
end 


function dec(k,value)
local v = value or 1
local prefix = string.sub(k,1,1)
if prefix~="%" then
  Console.Write("ERROR! Can only 'dec' variables marked as '%'",255,0,0)
  return
  end
local s = CVV(k) - v
Var.D(k,s)
end 

function Done(k)
local r = CVV(k)
if not r then Var.D(k,"TRUE") end
return r
end 

function IVARS()
if not CVV then GALE_Error("The CVV.lua library was not loaded! IVARS() cannot work without it!") end
local keys = {}
local values = {}
local k,v,i
if Var.Count==0 then GALE_Error("Can't list IVARS! At least one variable must be defined!") end
for i=0,Var.Count()-1 do
    k = Var.Key(i)
    v = CVV(k)
    keys[i+1] = k
    values[i+1] = v
    end
local idx = 0    
return function()
   idx = idx + 1
   if keys[idx] then return keys[idx],values[idx] end
   end    
end

-- This function will convert a series of GameVars into a Lua table.
-- The first character could be $, _, %, or & any other character will just return the entire varname into a string. (though some other characters may be used in the future for stuff).
-- $ and _ will be converted into a string. % will convert into a integer and & into a boolean. 
function Var2Table(prefix,trimprefix)
local p = prefix or ""
local pl = len(p)
local k,v,t,tk
local ret={}
for k,v in IVARS() do
    t = left(k,1)
    if t=="$" or t=="%" or t=="_" or t=="_" then tk = right(k,len(k)-1) else tk=k end     
    if left(tk,len(p))==p then
       if trimprefix then tk=right(tk,len(tk)-len(p)) end 
       ret[tk] = v 
       end
    end
return ret    
end 

function Toggle(boolvar) 
local prefix = string.sub(k,1,1)
if prefix~="&" then
  Console.Write("ERROR! Can only 'Toggle' variables marked as '&'",255,0,0)
  return
  end
if not sval then
  Console.Write("ERROR! Toggle requires the sval function which does not appear to be loaded",255,0,0)
  return
  end
if not upper then
  Console.Write("ERROR! Toggle requires the upper function which does not appear to be loaded",255,0,0)
  return
  end
Var.D(boolvar,upper(sval(not CVV(boolvar))))
end  