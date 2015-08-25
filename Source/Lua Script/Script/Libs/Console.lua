--[[
/* 
  Console Library for GALE

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



Version: 15.02.06

]]
-- LUALIB: License: zLib

CSayColors = {255,180,0}

function CWrite(Txt,R,G,B)
Console.Write(Txt,R or 255, G or 255, B or 255)
end

function CSay(Txt)
CWrite(Txt,CSayColors[1],CSayColors[2],CSayColors[3])
end
