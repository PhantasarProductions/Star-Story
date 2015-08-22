-- @IF IGNOREME
Foe_AI = {}
-- @FI

DefaultSys = {
        Attack = function(me,myact)
                 myact.TargetGroup,myact.TargetIndividual = FoeTargetSelector['1F'](me)
                 myact.Act = "ATK"
                 myact.ActSpeed=250
                 return myact.TargetGroup and myact.TargetIndividual
                 end,
        Guard  = function(me,act)
                 Sys.Error("Foe guarding not yet supported")
                 end
}

DefaultProcess = {
        Sys = function (me,act,myact)
              return DefaultSys[act](me,myact) 
              end,
        Abl = function (me,act,myact)
              Sys.Error("Special abilities not yet implemented")
              end
    }



function Foe_AI.Default(pos)
-- initiations
local timeout=0
Act.Foe = Act.Foe or {}
Act.Foe[pos] = {}
Fighters.Foe[pos].Gauge = 10001
Fighters.Foe[pos].Act = Act.Foe[pos]
local myact = Act.Foe[pos]
local myfoe = Fighters.Foe[pos]
local actlist = Act.Foe[pos].Actions
local ok = false
local chosenaction
local acttype,act,actsplit
if (not actlist) or #actlist==0 then Sys.Error("Foe_AI.Default("..pos.."): No actions defined!") end
repeat
   if timeout>=10000 then Sys.Error("Foe_AI.Default("..pos.."): Timeout") end
   chosenaction = rand(1,#actlist)
   actsplit     = mysplit(chosenaction,".")
   acttype      = actsplit[1]
   act          = actsplit[2]
   timeout      = timeout + 1
   ok           = (DefaultProcess[acttype] or function() Sys.Error("Foe_AI.Default("..pos.."): Unknown action type "..actsplit.."."..act) end)(myfoe,act,myact)
until ok
end 