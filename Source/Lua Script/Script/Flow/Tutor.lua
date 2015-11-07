--[[
  Tutor.lua
  Version: 15.11.07
  Copyright (C) 2015 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================
  zLib license terms:
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

back = "MenuBack"

Les = {

    ["Combat Flow"] = {"The flow of combat is easy enough to understand.","All people and battle have a marker going over","the gauge top-right of the combat screen","When somebody reaches 'COM' he/she can","set up his/her move.","","After that he/she goes to ACT and","as soon as ACT has been reached the move","will be executed.","","","",
                       "Undoubtedly you have seen some people moving","faster than others. This is dependent on the","character's Agility.","The higher the Agility value the faster"," you move.","","","",
                       "Between COM and ACT a few different rules","apply. There the type of move and certain powerups","can determine how fast you move","","","","Never underestimate the importance of the speed","as battles can be won or lost","on how well you deal with this!"},
    ["Predicting the moves of your enemies"] = {"Unless you play in the Hard Mode, you can","(if you are lucky) predict","your enemies' moves.","","","Like you the enemy picks its move","when on the COM spot of the time gauge.","This means that when going from COM to ACT","its move is chosen and the enemy cannot change it.","","If you can enter you move during this process","just hover over your targets when you try to attack them,","but don't click straight away.",
                                                 "","Under the foe's HP bar you can","see what he's planning to do","And on single target moves even on whom","","","Making good use of this information","can really determine the outcome of a battle"},
    ["Business Points"] = {"You may have seen that Yirl requires 'Business Points'","in order to learn new skills.","","I know you wonder, what are they?","And more importantly, how to earn them?","","","The points are just calculated","on your current sitation.","The list below explains how:","",
                           "10 points for every aurina you pocess","5 points for every aurina you exchanged for money","1 point per 200 credits you have","1 point per 300 credits you spent in any way","5 points per item you pocess on any character","2.5 points per item stored in the vault","","The end result is rounded up or down accordingly"}                                                 
}

function ShowLessons()
local y = 15
local mx,my = MouseCoords()
for L,_ in spairs(Les) do
    if my>y and my<y+15 then
       Image.Color(0,180,255)
    else
       Image.Color(0,80,155)
       end
    Image.DText(L,100,y)
    y = y + 15   
    end
end

function DrawScreen()
-- First the background
Image.Show(back,0,0)
if Lesson then ShowLesson() else ShowLessons() end
Flip()
-- X Stuff
ShowParty()
ShowMouse()
end

function CheckExit()
if mousehit(2) then
	if Lesson then 
		Lesson=false
	else 
  	LAURA.Flow("FIELD") end
  	end
end

function MAIN_FLOW()
DrawScreen()
CheckExit()
Flip()
end
