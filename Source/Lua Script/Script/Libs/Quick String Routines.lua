--[[
/* 
  Quick String Routines for GALE

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



Version: 15.02.16

]]
-- These routines only work when the GALE.Strings module has been included


function mid(txt,o,l)
return Str.Mid(txt,o,l or 1)
end

function left(txt,l)
return Str.Left(txt,l or 1)
end

function right(txt,l)
return Str.Right(txt,l or 1)
end

function upper(txt)
return Str.Upper(txt)
end

function lower(txt)
return Str.Lower(txt)
end
