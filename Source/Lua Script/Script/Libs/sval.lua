--[[
/* 
  sval

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



Version: 15.07.18

]]
svaltypes = {

   ['string']   = function(a) return a end,
   ['number']   = function(a) return a end,
   ['table']    = function(a) return serialize('<table>',a) end,
   ['function'] = function(a) return "<function>" end,
   ['nil']      = function(a) return "<nil>" end,
   ['unknown']  = function(a) return "<unknown type: "..type(a)..">" end,
   ['boolean']  = function(a) if a then return "true" else return "false" end end
   }

function sval(a)
local f = svaltypes[type(a)] or svaltypes.unknown
return f(a)
end
