--[[
/* 
  Combat Draw Screen

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



Version: 15.07.20

]]
gaugey   = -200
gaugex   = 380

ShowTagPointer = {

    Hero = function(fv,x,y)
           if Image.Loaded("COMBAT.GAUGE.CHAR."..fv.Tag)==0 then 
              Image.AssignLoad("COMBAT.GAUGE.CHAR."..fv.Tag,"GFX/Combat/GaugeIcons/"..fv.Tag..".png"); 
              CSay("Loaded Gauge Icon for: "..fv.Tag)           
              if JCR6.Exists("GFX/Combat/GaugeIcons/"..fv.Tag..".hot")==0 then
                 Image.Hot("COMBAT.GAUGE.CHAR."..fv.Tag,Image.Width("COMBAT.GAUGE.CHAR."..fv.Tag),Image.Height("COMBAT.GAUGE.CHAR."..fv.Tag))
                 CSay("Auto-HotSpotted: Bottom-Right")
                 end
              end   
           Image.Show("COMBAT.GAUGE.CHAR."..fv.Tag,x,y-30)                    
           end,


    Foe  = function(d,x,y) 
           local letter = left(d.Letter or "?",1)
           DarkText(letter,x,y+40,1,1)
           end
}

function DrawGauge()
local iy = 40
local fk,fs,fi,fv,ak,x,r,g,b
local pointerypos = { Hero = iy+17, Foe = iy+37 }
if gaugey<0 then gaugey=gaugey+1 end
-- Init
Image.ViewPort(gaugex,gaugey,800-gaugex,200)
Image.Origin(gaugex,gaugey)
-- Show
White()
Image.Draw("COMBATGAUGE",0,iy)
for fk,fs in spairs(Fighters) do
    for fi,fv in pairs(fs) do
        if fv.Gauge<=10000 then
           g=180
           b=(fv.Gauge/10000)*255
           r=255-b
           x=(fv.Gauge/10000)*300
           else
           r=255
           g=0
           b=0
           x=300+(((fv.Gauge-10000)/10000)*99)
           end
        Image.Color(r,g,b)
        Image.Draw("COMBATGAUGEPOINT"..upper(fk),x,pointerypos[fk])   
        -- White(); Image.Line(x-10,pointerypos[fk],x+10,pointerypos[fk]);    Image.Line(x,pointerypos[fk]-10,x,pointerypos[fk]+10); -- Debug line. Must be a comment in release  
        White() 
        ShowTagPointer[fk](fv,x,pointerypos[fk])
        end
    end
-- Done
Image.Origin(0,0)
Image.ViewPort(0,0,800,600)
end

function DrawScreen()
Image.Cls()
White()
Image.Draw("ARENA",0,0)
DrawGauge()
DrawFighters()
ShowCharReports()
ShowParty()
end
