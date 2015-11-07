--[[
**********************************************
  
  Tutor.lua
  (c) Jeroen Broks, 2015, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 15.11.07
]]

back = "MenuBack"

Les = {

    ["Combat Flow"] = {"The flow of combat is easy enough to understand.","All people and battle have a marker going over","the gauge top-right of the combat screen","When somebody reaches 'COM' he/she can","set up his/her move.","","After that he/she goes to ACT and","as soon as ACT has been reached the move","will be executed.","","","",
                       "Undoubtedly you have seen some people moving","faster than others. This is dependent on the","character's Agility.","The higher the Agility value the faster"," you move.","","","",
                       "Between COM and ACT a few different rules","apply. There the type of move and certain powerups","can determine how fast you move","","","","Never underestimate the importance of the speed","as battles can be won or lost","on how well you deal with this!"},
    ["Predicting the moves of your enemies"] = {"Unless you play in the Hard Mode, you can","(if you are lucky) predict","your enemies' moves.","","","Like you the enemy picks its move","when on the COM spot of the time gauge.","This means that when going from COM to ACT","its move is chosen and the enemy cannot change it.","","If you can enter you move during this process","just hover over your targets when you try to attack them,","but don't click straight away.",
                                                 "","Under the foe's HP bar you can","see what he's planning to do","And on single target moves even on whom","","","Making good use of this information","can really determine the outcome of a battle"},
    ["Business Points"] = {"You may have seen that Yirl requires 'Business Points'","in order to learn new skills.","","I know you wonder, what are they?","And more importantly, how to earn them?","","","The points are just calculated","on your current sitation.","The list below explains how:","",
                           "10 points for every aurina you pocess","5 points for every aurina you exchanged for money","1 point per 200 credits you have","1 point per 300 credits you spent in any way","5 points per item you pocess on any character","2.5 points per item stored in the vault","","The end result is rounded up or down accordingly"},
    ["Elemental Resistance"] = {"It can help a log if you try to sort out which element enemies don't like. Some enemies can be weak to fire or be immune to it.","There are 7 grades of resistances.","",{c='color',r=255,g=0,b=0},"1. Fatal",{c='color',r=0,g=180,b=255},"When you hit the enemy with an element that is marked as 'fatal' it will kill it instantly!",
                               {c='color',r=255,g=0,b=0},"2. Ultra-Weak",{c='color',r=0,g=180,b=255},"Will multiply the damage by 4",
                               {c='color',r=255,g=80,b=0},"3. Weak",{c='color',r=0,g=180,b=255},"Will multiply the damage by 1.75 (and will be rounded accordlingly)",
                               {c='color',r=255,g=255,b=255},"4. --",{c='color',r=0,g=180,b=255},"Nothing special will happen, just the regular damage",
                               {c='color',r=255,g=180,b=0},"5. Half",{c='color',r=0,g=180,b=255},"Damage will be halved (and rounded accordingly)",
                               {c='color',r=255,g=180,b=0},"6. Immune",{c='color',r=0,g=180,b=255},"Won't do damage at all",
                               {c='color',r=0,g=255,b=0},"7. Absorb",{c='color',r=0,g=180,b=255},"Will heal in stead of damage","","",
                               "Trying to figure this out well, can really work in your advantage!"}
                                        
                                                                            
}

LPM=0

function ShowLesson()
local y = 15
local dy = y - LPM
Image.ViewPort(50,15,800,600)
SetFont('ItemHeader')
Image.Color(255,0,0)
Image.DText(Lesson,50,y); y = y + Image.TextHeight(Lesson)
Image.Color(0,180,255)
SetFont("ItemDescription")
for line in each(Les[Lesson]) do
    ({['string'] = function()
                   dy = y - LPM
                   Image.DText(line,50,dy)
                   y = y + Image.TextHeight(line)
                   end, 
      ['table'] = ({ color = function() Image.Color(line.r,line.g,line.b) end})[line.c]             
      })[type(line)]() 
    end
Image.ViewPort(0,0,800,600)
end

function ShowLessons()
local y = 15
local mx,my = MouseCoords()
for L,_ in spairs(Les) do
    if my>y and my<y+15 then
       Image.Color(0,180,255)
       if mousehit(1) then Lesson=L; LPM=0 end
    else
       Image.Color(0,80,155)
       end
    Image.DText(L,100,y)
    y = y + 15   
    end
end

function DrawScreen()
-- First the background
Image.Cls()
Image.Show(back,0,0)
if Lesson then ShowLesson() else ShowLessons() end
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
Image.Cls()
DrawScreen()
CheckExit()
Flip()
end
