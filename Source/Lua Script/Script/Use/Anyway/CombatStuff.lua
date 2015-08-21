function CleanCombat()
for k in IVARS() do
    if prefixed(k,"$COMBAT.") or prefixed(k,"%COMBAT.") or prefixed(k,"&COMBAT.") then 
       Var.Clear(k)
       CSay("Destroyed: "..k) 
       end 
    end
end    
