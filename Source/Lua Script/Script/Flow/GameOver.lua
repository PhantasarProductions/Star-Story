function GALE_OnLoad()
Music("Special/GameOver.ogg")
Combat = Image.GrabScreen()
GameOver = Image.Load("GFX/Combat/GameOver.png")
Image.HotCenter(GameOver)
CombatAlpha=100
-- GameOverAlpha=0
end

function MAIN_FLOW()
White()
if CombatAlpha>0 then CombatAlpha = CombatAlpha - .01 end
Image.Cls()
Image.SetAlphaPC(100)
Image.Show(GameOver,400,300)
Image.SetAlphaPC(CombatAlpha)
Image.Show(Combat,0,0)
Image.SetAlphaPC(100)
if CombatAlpha>0 then CombatAlpha = CombatAlpha - .01 else 
   SetFont("CombatMessage")
   DarkText("Hit any key or press a mousebutton to exit",400,550,2,2,0,math.sin(Time.MSecs()/100)*180,255) 
   end
Flip()   
local dev,k
local devices = { { B=2, F=INP.MouseH}, {B=255,F=INP.KeyH }}
for dev in each(devices) do 
    for k=0,dev.B do if dev.F(k)>0 then Sys.Bye() end end
    end
end