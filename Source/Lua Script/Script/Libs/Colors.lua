--[[
  Colors.lua
  Colors
  version: 16.12.17
  Copyright (C) 2015, 2016 Jeroen P. Broks
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
-- A lib for lazy people like me

function White() Image.Color(255,255,255) end white = White
function Yellow() Image.Color(255,255,0) end yellow = Yellow
function Amber() Image.Color(255,180,0) end amber = Amber
function Green() Image.Color(0,255,0) end green = Green
function LightBlue() Image.Color(0,180,255) end lightblue = LightBlue
function Blue() Image.Color(0,0,255) end blue = Blue
function Black() Image.Color(0,0,0) end black = Black
function Red() Image.Color(255,0,0) end red = Red
