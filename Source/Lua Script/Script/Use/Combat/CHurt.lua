function Hurt(tg,ti,hp,element)
local r,g,b = 255,255,255
local report = hp
local dodmg = hp
local chtarget = FighterTag(act.TargetGroup,act.TargetIndividual)
local elementalresistance = ({
                                 [1] = function() return RPGStat.Stat(chtarget,"ER_"..element) end,
                                 [0] = function() return 0 end
                              })[RPGStat.StatExists(chtarget,"ER_"..element)]()
local switch = 
               ({   -- Lua way of doing a 'switch case' statment. Ugly I know, but it works. :-P
                    -- Why the variable defition is needed is beyond me, as the variable is totally unneeded, but Lua fails to parse this code without it.
     
                 [0] = function() -- fatal
                       report = "DEATH"; r,g,b = 255,0,0
                       dodmg = RPGStat.Points(chtarget,"HP").Have
                       end,
                 [1] = function() -- super weakness
                       dodmg = dodmg *4
                       report = dodmg; r,g,b = 255,0,0
                       end,
                 [2] = function() -- regular weakness
                       dodmg = round(dodmg * 1.75)       
                       report = dodmg; r,g,b = 255,80,0
                       end,
                 [4] = function() -- half
                       dodmg = round(dodmg/2)
                       if dodmg<1 then dodmg=1 end
                       report = dodmg
                       r,g,b = 255,180,0
                       end,      
                 [5] = function() -- resistent
                       dodmg = 0
                       report = "NO EFFECT!"      
                       r,g,b = 255,180,0
                       end,
                 [6] = function()
                       dodmg = math.abs(dodmg)*(-1)
                       report = math.abs(dodmg)
                       r,g,b = 0,255,0
                       end,      
                 default = function() end      -- In all other situations (which includes situation 3) do nothing :)
               })[elementalresistance or 'default']()
RPGStat.Points(chtarget,"HP").Have = RPGStat.Points(chtarget,"HP").Have - dodmg
CharReport(tg,ti,report,{r,g,b})               
end


function Attack(ag,ai,act,pdata)
local chactor = FighterTag(ag,ai)
local chtarget = FighterTag(act.TargetGroup,act.TargetIndividual)
local data = pdata or {}
local tg,ti = TargetFromAct(act)
local atkstat = data.atk or "Strength"
local defstat = data.def or "Defense"
local modifier = data.mod or 1
local critical = ({[true]=1,[false]=0})[data.critical==true] -- I have to do it this way, as 'nil' can be a value and would result into a crash.
local element = data.element or "Non-Elemental"
local atk = RPGStat.Stat(chactor,atkstat)
local def = RPGStat.Stat(chtarget,defstat)                              
local damage = atk + rand(0,round(atk*.75))
local defense = def + rand(0,round(def*.25))
if data.ignoredefense then defense=0 end
local totaldamage = damage - defense
if totaldamage<1 then totaldamage=1 end
Hurt(tg,ti,totaldamage)                               
end