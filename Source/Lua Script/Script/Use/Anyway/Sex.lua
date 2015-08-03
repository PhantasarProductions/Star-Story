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
for sexchar,sexsex in spairs(Sex) do
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