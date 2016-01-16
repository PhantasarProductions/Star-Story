--[[
**********************************************
  
  Ysperon - Eugorvnia.lua
  (c) Jeroen Broks, 2016, All Rights Reserved.
  
  This file contains material that is related 
  to a storyline that is which is strictly
  copyrighted to Jeroen Broks.
  
  This file may only be used in an unmodified
  form with an unmodified version of the 
  software this file belongs to.
  
  You may use this file for your study to see
  how I solved certain things in the creation
  of this project to see if you find valuable
  leads for the creation of your own.
  
  Mostly this file comes along with a project
  that is for most part released under an
  open source license and that means that if
  you use that code with this file removed
  from it, you can use it under that license.
  Please check out the other files to find out
  which license applies.
  This file comes 'as-is' and in no possible
  way the author can be held responsible of
  any form of damages that may occur due to 
  the usage of this file
  
  
 **********************************************
 
version: 16.01.16
]]

-- @USE /Script/Use/Maps/Gen/Next.lua
-- @USE /Script/Use/Maps/Gen/Sudoku.lua

-- @IF IGNORE
Sudoku = {}
-- @FI

function START()
MapShow("START")
if not Done("&DONE.EUGORVNIA.ARRIVAL") then 
   PartyPop("Start","South")
   MapText("WELCOME")
   PartyUnPop()
   end
end


function MultiShow(Tag,Labels,Num)
for i=1,Num or 1 do
    ZA_Enter(Tag..i,MapShow,Labels)
    end
end    

function GALE_OnLoad()
Music("Dungeon/Dark_City.ogg")
ZA_Enter("STARTROOM",START)
ZA_Leave("STARTROOM",MapShow,"*ALL*")
MultiShow("ShowBase","Base",3)
MultiShow("ShowToSecret","ToSecret",2)
-- Init Sudoku Puzzle
Sudoku.Eugorvnia1 = {
                             SolveRemove = {"Sudo1Solve1","Sudo1Solve2"},
                             GroupSize = 4,
                             Layer = "#003",
                             Solved = { 
                                          G11R1 = {1,2}, G12R1 = {3,4},
                                          G11R2 = {3,4}, G12R2 = {1,2},
                                          G21R1 = {2,1}, G22R1 = {4,3},
                                          G21R2 = {4,3}, G22R2 = {2,1}
                                          },
                             ZegVoor = { {'G21R2C2'}, -- Easy Only
                                         {'G11R2C2'},                               -- Medium + Easy
                                         {'G11R1C1','G12R2C2','G22R1C1','G21R1C1','G22R1C2'}  -- Hard + Medium + Easy
                                       },
                             Tiles = "Eugorvnia"          
                    }
InitSudoku('Eugorvnia1')                    
end
