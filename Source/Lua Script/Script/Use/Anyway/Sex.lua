--[[
 **********************************************
  
  This file is part of a closed-source 
  project by Jeroen Petrus Broks and should
  therefore not be in your pocession without
  his permission which should be obtained 
  PRIOR to obtaining this file.
  
  You may not distribute this file under 
  any circumstances or distribute the 
  binary file it procudes by the use of 
  compiler software without PRIOR written
  permission from Jeroen P. Broks.
  
  If you did obtain this file in any way
  please remove it from your system and 
  notify Jeroen Broks you got it somehow. If
  you have downloaded it from a website 
  please notify the webmaster to remove it
  IMMEDIATELY!
  
  Thank you for your cooperation!
  
  
 **********************************************
Sex.lua
(c) 2015, 2016 Jeroen Petrus Broks
Version: 16.05.17
]]
Sex = {

    Wendicka = "Female",
    Crystal  = "Female",
    Briggs   = "Male",
    ExHuRU   = "Male",
    Yirl     = "Male",
    Foxy     = "Female",
    Rolf     = "Male",
    Xenobi   = "Male",
    Johnson  = "Female"

  }
  
Sex.UniWendicka = Sex.Wendicka
Sex.UniCrystal  = Sex.Crystal

sexhisher = {Male="his",Female="her"}
sexheshe  = {Male="he", Female="she"}
hisher = {}
heshe  = {}
for sexchar,sexsex in pairs(Sex) do
    hisher[sexchar] = sexhisher[sexsex]
    heshe [sexchar] = sexheshe [sexsex]
    end
    
    
-- Not gender related, but hey, let's define it anyway
Race = {

   UniWendicka = "Human",
   UniCrystal  = "Human",
   Briggs      = "Human",
   Wendicka    = "Human",
   Crystal     = "Human Cyborg",
   ExHuRU      = "Android",
   Yirl        = "Klargin",
   Foxy        = "Vulpin",
   Xenobi      = "Human",
   Rolf        = "Human",
   Johnson     = "Human"
   
}    
    
    
-- One final note. What exactly where you expecting to find in here, when you opened this file? :-P
