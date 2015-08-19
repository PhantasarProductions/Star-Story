--[[
/* 
  True Music

  Copyright (C) 2015 Jeroen Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  the restrictions of this file are removed and will automatically become
  zLib licensed (see below).
  
  Please note that doing so counts as a modification and must be marked as such
  in accordance to the zLib license.
  ===========================


  zLib license terms:

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



Version: 15.08.01

]]
-- The 'real' music stuff will happen here.


-- _@_USEDIR Scripts/Use/AltMusic
function TrueMusic(songfile,noloop)
if not musicavailable then
   Console.Write("Request done to load music "..songfile..", but the music is not available!",255,0,0)
   return 
   end -- If this is the version without music, then let's skip it all!
if currentsong==songfile then return end
currentsong=songfile
if true then -- config.music or MainMenuScript then
	LoadMusic(noloop)
	StartMusic()
	else
	CSay("Config did not allow any music to be played, so the request to load "..songfile.." has been denied!")
	end
end

function LoadMusic(noloop)
if AltMusic and AltMusic[upper(currentsong)] then
   Console.Write("Redirection script has been found for music: "..currentsong,255,180,0)
   currentsong = AltMusic[upper(currentsong)]()
   end
if song then Audio.Free(song) end
Console.Write("Loading music: "..sval(currentsong),255,255,0)
local rqsong = currentsong
if Str.Upper(Str.Right(rqsong,4))~=".OGG" then rqsong = rqsong .. ".ogg"; end 
if noloop then
   song = Audio.Load("Music/"..rqsong)
   else
   song = Audio.LoadLoop("Music/"..rqsong)
   end
end

function StartMusic()
Console.Write("Starting music",255,255,0)
if Audio.Playing("MUSIC")~=0 then Audio.Stop("MUSIC") end
Audio.Play(song,"MUSIC")
end

function StopMusic()
local cnt=0
Audio.Stop("MUSIC")
if Audio.Playing("MUSIC")~=0 then 
   Console.Write("WARNING!!! Music still playing after stop request",255,41,9)
   repeat
   Console.write("Attempt #"..cnt.." to shut the music down",56,120,24)
   Audio.Stop("MUSIC")
   cnt=cnt+1
   until cnt>20 or (Audio.Playing("MUSIC")==0)
   if Audio.Playing("MUSIC")~=0 then Console.Write("WARNING!!! Music stop request keeps failing!",255,41,9) end
   end 
end

-- PushMusic and PullMusic were most of all used by the battle engine.
-- Its names are based on the assembly language :)
function PushMusic()
PushedMusic = PushedMusic or {}
PushedMusicNr = PushedMusicNr or 0
PushedMusicNr = PushedMusicNr + 1
PushedMusic[PushedMusicNr] = currentsong
end

function PullMusic()
if not PushedMusic then Console.Write("! WARNING: Pull music requested when a push was never done before!");  return; end
if #PushedMusic<1 then Console.Write("! WARNING: Pull music requested while the queue is currently empty!"); return; end
if PushedMusicNr<1 then Console.Write("! WARNING: Pull music requested while the queue index is currently 0!"); return; end
local PM = PushedMusic[PushedMusicNr]
PushedMusic[PushedMusicNr] = nil
PushedMusicNr = PushedMusicNr - 1
TrueMusic(PM)
end

Console.Write("Music routines loaded!",255,255,255)
