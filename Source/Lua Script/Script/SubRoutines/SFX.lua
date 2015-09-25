--[[
  SFX.lua
  
  version: 15.09.25
  Copyright (C) 2015 Jeroen P. Broks
  This software is provided 'as-is', without any express or implied
  warranty.  In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:
  1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.
  2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.
  3. This notice may not be removed or altered from any source distribution.
]]

-- Load sound effect
function SFXLoad(file)
Console.Write("Loading Sound Effect:"..file,183,213,170)
-- @IF DEVELOPMENT
Console.Write("Check existence:     "..JCR5.Exist(file),183,213,170)
-- @FI   
local ret = Audio.Load(file)
return ret
end

-- Play sound effect
function SFX(pfile,once) --,force)
local file = Str.Upper(pfile)
SFXBuffers = SFXBuffers or {}
--[[
-- force should ALWAYS be used from the title menu, otherwise... CRASH!!!!
if GameScript and not config.sfx then Console.Write('Sound Effects are OFF, so request to play '..file..' has been ignored',255,0,0); return end -- if in a gamescript and the config is set to no sfx, then no sfx :)
if (not GameScript) and (not force) then 
   Console.Write("Outside the GameScript, so let's try to call the game script!",rand(1,255),rand(1,255),rand(1,255))
   LAURA.ExecuteGame('SFX',file); 
   return 
   end
]]   
SFXBuffers[file] = SFXBuffers[file] or SFXLoad(file)
Audio.Play(SFXBuffers[file])
if once=="yes" then
   Audio.Free(SFXBuffers[file]) 
   SFXBuffers[file] = nil
   end
end


