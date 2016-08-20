--[[
**********************************************
  
  ARK SMASH.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
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
 
version: 16.08.20
]]
-- @IF IGNORE
SpellAni = {}
-- @FI

--[[
function ShowCrystalAndAllTargets(ai)
end
]]

function SpellAni.ArkSmash(ActG,ActT,TarG,TarT)
    -- Init
    local DrawParty = ShowParty
    local planets = {}
    for p in each({'Neptune','Uranus','Saturn','Jupiter','Mars','Earth','Venus','Mercury'}) do
        planets[#planets+1] = {
                                  name=p,
                                  img=Image.Load('GFX/Space/'..p..'.png'),
                                  x = - 200 - (#planets*900),
                                  y = 250
                              }
        Image.HotCenter(planets[#planets].img)                                                    
    end
    local sun = Image.Load('GFX/XSpace/SunSurface.png')
    local stars = {}    
    -- Make it dark    
    for alpha=0,100 do
        DrawScreen()
        stars[#stars+1] = {x=rand(0,790),y=rand(0,500),spd=rand(1,10)/5}
        Image.SetAlphaPC(alpha)
        Black()
        Image.Rect(0,0,800,600)
        White()
        Image.SetAlphaPC(100)
        DrawFighters()
        DrawParty()
        Flip()
    end
    -- Planet slide
    local theend = true
    repeat
        theend = true
        Image.Cls()
        stars[#stars+1] = {x=0,y=rand(0,500),spd=rand(1,10)/5}
        White()
        for star in each(stars) do
            Image.Line(star.x,star.y,star.x,star.y)
            star.x = star.x + star.spd
        end
        for planet in each(planets) do
            Image.Draw(planet.img,planet.x,planet.y)
            planet.x = planet.x + 8
            theend = theend and planet.x>1200
        end
    DrawFighters()
    DrawParty()
    Flip()        
    until theend    
    -- Burn into the sun
    for sunx=-2000,0,5 do
        Image.Cls()
        White()
        for star in each(stars) do
            Image.Line(star.x,star.y,star.x,star.y)
            star.x = star.x + star.spd
        end
        DrawFighters()
        Image.Draw(sun,sunx,0)
        DrawParty()       
        Flip() 
    end
    for alpha=0,100,5 do
        Image.Cls()
        Image.SetAlphaPC(alpha)
        Red()
        Image.Rect(0,0,800,600)
        White()
        Image.SetAlphaPC(100)
        DrawFighters()
        DrawParty()
        Flip()
    end
    -- Go back to the play screen
    for alpha=100,0,-1 do
        DrawScreen()
        Image.SetAlphaPC(alpha)
        Red()
        Image.Rect(0,0,800,600)
        White()
        Image.SetAlphaPC(100)
        DrawFighters()
        DrawParty()
        Flip()
    end    
    -- Free memory
    for planet in each(planets) do Image.Free(planet.img) end
    Image.Free(sun)    
end



-- @IF IGNORE
return SpellAni
-- @FI
