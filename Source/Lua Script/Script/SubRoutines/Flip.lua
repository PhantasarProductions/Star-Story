--[[
  Flip.lua
  
  version: 15.09.09
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
]]
--[[
/* 
  Flip Sub Routine

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



Version: 15.05.22

]]
function FlipActions()
-- Tutorial Text
SetFont("Tutorial")
local h = Image.TextWidth('ABC')
local y 
local ak,l
if TutorialTime and TutorialTime>0 and TutorialAlpha>0 then
   -- @IF *DEVELOPMENT
   Image.DText("Tutorial: Time: "..TutorialTime..";  Alpha:"..TutorialAlpha)
   -- @FI
   y = (h*#TutorialText)/2
   for ak,l in ipairs(TutorialText) do
       Image.SetAlphaPC(TutorialAlpha)
       Black()
       Image.DText(l,399,y+(ak*h)-1,2,2)
       Image.DText(l,401,y+(ak*h)+1,2,2)
       White()
       Image.DText(l,400,y+(ak*h),2,2)
       Image.SetAlpha(1)
       if TutorialTime>0 then
          TutorialTime = TutorialTime - 1
          end
       if TutorialTime==0 and TutorialAlpha>0 then
          TutorialAlpha = TutorialAlpha - 1
          TutorialTime = 5
          end
       end
   end      
end


function InitTutorial(txt)
TutorialText = mysplit(txt or "WARNING!\nNil for tutorial received","\n")
TutorialTime = 600
TutorialAlpha = 100
CSay("Tutorial text received:")
for ak,l in ipairs(TutorialText) do
    CSay("  "..ak..">"..l)
    end
end

function ConsoleTutorial()
CSay("Tutorial text received:")
for ak,l in ipairs(TutorialText) do
    CSay("  "..ak..">"..l)
    end
CSay("Time left:"..TutorialTime)
CSay("Alpha: "..TutorialAlpha)
end
