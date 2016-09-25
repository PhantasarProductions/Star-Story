--[[
  A few mathematical functions.lua
  
  version: 16.09.19
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
function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function rand(a,b)
if a and b then return Math.Rand(a,b) end
if a and (not b) then return Math.Rand(1,a) end
if not a then Console.Write("WARNING! Rand() First value is nil") end
CSay('rand.a ='..sval(a))
CSay('rand.b ='..sval(b))
Sys.Error('Random Definition invalid')
end

--[[ Decimal to hex
I've seen several things for decimal to hexadecimal conversion in the search, and also many on JavaScript in Google. Many local search results deal with functions available to Lua in various code libraries, but few if any actually did it with Lua.. (Lua has a nice inbuilt function for HEX to DEC though, so I won't try to reinvent that wheel).
All working examples I found were larger and/or messier than what I worked up, so I'm sharing this so next time someone searches they might get what they need. :)
Note that by extending the key string with more letters, changing the B value, decimal can be converted to any number in any base from 2 to 26, so long as the host system can hold the decimal integer you're feeding it. Don't ask for base 1; it will loop forever. >:)

Lostgallifreyan
]]
function DEC_HEX(IN)
    local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
    while IN>0 do
        I=I+1
        IN,D=math.floor(IN/B),math.mod(IN,B)+1
        OUT=string.sub(K,D,D)..OUT
    end
    return OUT
end

function DEC_OCT(IN)
    local B,K,OUT,I,D=8,"01234567","",0
    while IN>0 do
        I=I+1
        IN,D=math.floor(IN/B),math.mod(IN,B)+1
        OUT=string.sub(K,D,D)..OUT
    end
    return OUT
end

function DEC_BIN(IN)
    local B,K,OUT,I,D=2,"01","",0
    while IN>0 do
        I=I+1
        IN,D=math.floor(IN/B),math.mod(IN,B)+1
        OUT=string.sub(K,D,D)..OUT
    end
    return OUT
end

sin = math.sin
cos = math.cos
tan = math.tan
abs = math.abs
sqr = math.sqrt

function Distance(x1,y1,x2,y2) -- BLD: Calculates distance between two points, by using Pythagoras
  local rechthoekszijde1 = abs(x1-x2)
  local rechthoekszijde2 = abs(y1-y2)
  local hypothenusakwardraat = (rechthoekszijde1*rechthoekszijde1) + (rechthoekszijde2*rechthoekszijde2)
  local hypothenusa = sqr(hypothenusakwardraat)
  return hypothenusa
end

function NumLead(number,size,leadchar)
    if not right then Sys.Error("NumLead needs the 'right' function to be imported!") end
    local r = ""
    for i=1,size or 4 do r = r .. (leadchar or "0") end
    return right(r,size or 4)
end    
     
