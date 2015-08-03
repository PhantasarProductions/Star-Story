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

function DBGSerialize(v)
-- @IF *DEVELOPMENT
local function dbgmysplit(inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={} ; i=1
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                t[i] = str
                i = i + 1
        end
        return t
        end
local vl = mysplit(serialize(v,"MyVar"),"\n")
local l,c
for c,l in ipairs(vl) do Console.Write(string.sub("          "..c,10,-1)..": "..l,180,255,0) end        
-- @FI        
end