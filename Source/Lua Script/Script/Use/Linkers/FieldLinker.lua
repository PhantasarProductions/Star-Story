LoadMap = LoadMap or function(map) -- This way of defining makes sure we won't (by accident) overwrite the 'real' routine if it's present.
MS.LN_Run("FIELD","Flow/Field.lua","LoadMap",map)
end


Schedule = Schedule or function (scr,func)
MS.LN_Run("FIELD","Flow/Field.lua","Schedule",scr..";"..func) 
end