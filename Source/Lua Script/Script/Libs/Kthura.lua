--[[
/* 
  Kthura

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

------------------------------------------------------------------------------

--[[
      
       This file contains some quick functions for quick access to Kthura
       Maps. This file even contains a few feature to actually edit Kthura 
       maps directly. It goes without saying but ths script should therefore
       be handled with care. You've no idea how dangerous a lua script can be
       when not handled properly. (I've heard the statement "It's just a Lua
       script" way to often). :)
       
       Please note, this file is only set up for the way the LAURA II engine
       delivers its Kthura API. I can therefore not guarantee this file will
       work in other engines using Kthura.
       
       Also, be sure to get rid of the data obtained prior to loading a new map.
       If you try to read or write to an object belonging to a map no longer
       in the system's memory LAURA II will crash, and throw no error message 
       (if running LAURA II from a console, only the message "ERROR" may appear
       on the console, and that's all you get).
       
       If you are not sure about what you are doing, then leave this file
       be and use the official documented commands only. 
       
]]



function KthuraGet(kind,idx) -- Grab an object. The returned value can even be edited affecting the map, so use with care.
Maps.ObjectList.Start(kind)
Maps.ObjectList.Pick(idx)
return Maps.ObjectList.MyObject
end


function KthuraEach(kind) -- Iterator. The values returned are editable and the edits will affect the Kthura map, so use with care :)
local c = Maps.ObjectList.Start(kind)
local k
local tab = {}
print("objects to go through: "..c)
for k=0,c-1 do
    print (k.."   "..c)
    Maps.ObjectList.Pick(k)
    table.insert(tab,Maps.ObjectList.MyObject)
    end
local i=0    
return function()
       i = i + 1
       if tab[i] then return tab[i] end
       end    
end       

function SafeKthuraGet(kind,idx) -- This is just based on the script grabber. It only returns a table with data. Changing them won't affect the map at all, and this data is even safe after loading a new map.
Maps.ObjectList.Start(kind) 
local f=loadstring(Maps.ObjectList.ToScript(i or -1))
return f()
end