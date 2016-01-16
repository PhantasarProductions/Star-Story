--[[
        Sudoku.lua
	(c) 2016 Jeroen Petrus Broks.
	
	This Source Code Form is subject to the terms of the 
	Mozilla Public License, v. 2.0. If a copy of the MPL was not 
	distributed with this file, You can obtain one at 
	http://mozilla.org/MPL/2.0/.
        Version: 16.01.16
]]
Sudoku = {}
SudoRoot = {}  for i=2,9 do SudoRoot[i*i] = i end

function SudoQuery(rs)
local gx,gy,r,c=0,1,1,1
return function()
       gx = gx + 1
       if gx>rs then gx=1 gy=gy+1 end
       if gy>rs then gy=1 r =r +1 end
       if r >rs then r =1 c =c +1 end
       if c >rs then return nil,nil, nil,nil end
       return gx,gy,r,c
       end
end

function SudoReTexture(symb,work,gx,gy,r,c)
local tag = "G"..gx..gy.."R"..r
-- CSay(tag.."/"..c)
symb.TextureFile = "GFX/Textures/Sudoku/"..work.Tiles.."/"..work.PlaySolve[tag][c]..".png"
end

function SudoReTexture2(symb,work,tag,c)
if not work.PlaySolve[tag] then CSay("ERROR: No data in tag "..tag)
elseif not work.PlaySolve[tag][Sys.Val(c)] then CSay("ERROR: No data for "..tag.."/"..c) end
-- CSay(serialize('PlaySolve',work.PlaySolve))
symb.TextureFile = "GFX/Textures/Sudoku/"..work.Tiles.."/"..work.PlaySolve[tag][Sys.Val(c)]..".png"
CSay(tag.."/"..c.." has now tex: "..symb.TextureFile)
end

function InitSudoku(id)
local oldlayer = Maps.LayerCodeName
if CVV("&SUDOKU."..id) then return end -- No need to waste any memory or performance for stuff that is done already.
local work = Sudoku[id]
if not work then Sys.Error("Data for sudoku "..id.." does not exist!") end
if not SudoRoot[work.GroupSize] then Sys.Error("Cannot initize a Sudoku on groupsize "..work.GroupSize) end
work.RootSize = SudoRoot[work.GroupSize]
work.PlaySolve = {}
local ps = work.PlaySolve
local tag,tagc,butt,symb,tile,clkscript,clkarray
if work.Layer then Maps.GotoLayer(work.Layer) else CSay("No layer set for Sudoku. If this is multi-map, you'll get in trouble") end
for gx,gy,r,c in SudoQuery(work.RootSize) do    
    tag = "G"..gx..gy.."R"..r
    tagc = tag .. "C"..c
    CSay("Initizing Sudoku field: "..tagc)
    CSay("= Default value")
    ps[tag] = ps[tag] or {}
    ps[tag][c] = 0
    CSay("= Quick grandsol link")
    work.grandsol = work.grandsol or {}    
    CSay("= Create symbol object")
    work.Objects = work.Objects or {}
    work.Objects[tagc] = work.Objects[tagc] or {}
    butt = Maps.Obj.Obj                   ("SUDO_BUTT_"..id.."_"..tagc)
    tile = Maps.Obj.Obj                   ("SUDO_TILE_"..id.."_"..tagc)
    symb = Maps.Obj.CreateObject(tile.Kind,"SUDO_SYMB_"..id.."_"..tagc)
    symb.X = tile.X
    symb.Y = tile.Y
    symb.W = tile.W
    symb.H = tile.H
    symb.Dominance = tile.Dominance + 1
    symb.Visible = 1
    SudoReTexture(symb,work,gx,gy,r,c)
    work.Objects[tagc].Buttons = butt
    work.Objects[tagc].Tiles   = tile
    work.Objects[tagc].Symbols = symb    
    CSay("= Create Clickable")
    clkarray = { spot="SUDO_BUTT_"..id.."_"..tagc, arrival = "SudoButton", arrivalarg=id..';'..tag..";"..c, obj="SUDO_BUTT_"..id.."_"..tagc }
    clkscript = serialize("ret",clkarray).."\n\nreturn ret"
    CSay("   > "..clkscript)
    MS.Debug=0 -- Something is wrong, I need to know what!
    -- AddClickableScript(clkscript,"*DIT*MAG*GEWOONWEG*NIET*GESPLIT*WORDEN")
    MS.LN_Run("FIELD","Flow/Field.Lua","AddClickableScript",clkscript,"*DIT*MAG*GEWOONWEG*NIET*GESPLIT*WORDEN") -- When everything else fails (for no reason), let's FORCE our way through! (GRRR!)
    end
-- CSay(serialize('PlaySolve',work.PlaySolve))    
local ctag,c -- cut tag    
for i=3,skill,-1 do  -- The "Zeg voor" routine. The lower the difficulty the more it will reveal.
    for gtag in each(work.ZegVoor[i]) do
        ctag = mysplit(gtag,"C")
        tag = ctag[1] c = Sys.Val(ctag[2])
        work.PlaySolve[tag][c] = work.Solved[tag][c]
        SudoReTexture2(work.Objects[gtag].Symbols,work,tag,c)
        work.Objects[gtag].Buttons.Visible=0
        CSay("Revealed: "..gtag.."   value: "..(work.Solved[tag][c] or 'nil').." play value: "..(work.PlaySolve[tag][c] or 'nil'))
        end
    end    
Maps.Remap()
if work.Layer then Maps.GotoLayer(oldlayer) end    
end

function SudoButton(id,tag,c)
CSay("Player activates sudoku button: "..id.."/"..tag.."/"..c)
end 
