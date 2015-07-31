--[[
/*
	
	
	
	
	
	(c) , , All rights reserved
	
		This program is free software: you can redistribute it and/or modify
		it under the terms of the GNU General Public License as published by
		the Free Software Foundation, either version 3 of the License, or
		(at your option) any later version.
		
		This program is distributed in the hope that it will be useful,
		but WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
		GNU General Public License for more details.
		You should have received a copy of the GNU General Public License
		along with this program.  If not, see <http://www.gnu.org/licenses/>.
		
	Exceptions to the standard GNU license are available with Jeroen's written permission given prior 
	to the project the exceptions are needed for.
*/


Version: 15.04.29

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
Console.Write("Loading music: "..currentsong,255,255,0)
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
