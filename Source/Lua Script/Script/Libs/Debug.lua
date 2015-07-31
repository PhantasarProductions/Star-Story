function Dbg(...)
-- @IF *DEVELOPMENT
local i,v,o
for i,v in ipairs(arg) do
    o = ""
    if #arg>1 then o = string.sub("          "..i,10,-1)..":" end
    o = o .."DEBUGLOG>"..v
    Console.Write(o,0,180,255)
    end
-- @FI
end
