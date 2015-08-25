--[[
  
  This function was written by Wookai
  http://stackoverflow.com/questions/2282444/how-to-check-if-a-table-contains-an-element-in-lua
  
]]
function tablecontains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end





--[[ This function was written by Jeroen Broks.
     Use it any way you see fit.]]     
function isorcontains(v,e)
if type(v)=="table" then return tablecontains(v,e) end
return v==e
end     