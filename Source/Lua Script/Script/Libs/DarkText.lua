--[[
  DarkText.lua
  
  version: 16.12.17
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
--[[
  DarkText.lua
  
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

DTSW = DTSW or 795 -- Should be changed by the script if any other screenwidth than 800 is used. 

function DarkText(txt,px,py,ah,av,r,g,b,br,bg,bb)
Image.Color(br or 0,bg or 0,bb or 0)
local x,y = px or 0 , py or 0
local ax,ay
for ay=y-1,y+1 do for ax=x-1,x+1 do Image.DText(txt,ax,ay,ah,av) end end
Image.Color(r or 255, g or 255, b or 255)
Image.DText(txt,x,y,ah,av)
end


function FitText(txt,x,y,r,g,b)
local w = Image.TextWidth(txt)
local ha = 0
local tx = x
if x+w>DTSW then tx=DTSW ha=1 end
DarkText(txt,tx,y,ha,0,r,g,b)
end
