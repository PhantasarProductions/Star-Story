--[[
/* 
  

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

*/



Version: 15.05.22

]]
if not boxtextroutine then
 BoxTextBack = BoxTextBack or "BOXTEXT.KTHURA" -- Only place the standard value in if there are no other values yet. This is done to prevent bugs for scripts using this module having their own routines (like the battle engine for example).


 function LoadBoxText(f)
 MS.Run("BOXTEXT","LoadData",f)
 end

 function LoadBoxText2(f,a)
 MS.Run("BOXTEXT","LoadData",f..";"..a)
 end

 function SerialBoxText(f,tag,bck)
 MS.Run("BOXTEXT","SerialBoxText",f..";"..tag..";"..(bck or BoxTextBack))
 end

 function FreeBoxText(f)
 MS.Run("BOXTEXT","RemoveData",f)
 end

 function MapText(tag,bck)
 SerialBoxText("MAP",tag)
 end
 
end 
