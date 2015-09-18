--[[
  Inventory and Abilities Linker.lua
  Version: 15.09.18
  Copyright (C) 2015 Jeroen Petrus Broks
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles or another
  series or saga which is property of Jeroen P. Broks.
  This means that it may contain references to a story-line plus characters
  which are property of Jeroen Broks. These references may only be distributed
  along with an unmodified version of the game. 
  
  As soon as you remove or replace ALL references to the storyline or character
  references, or any termology specifically set up for the Phantasar universe,
  or any other univers a story of Jeroen P. Broks is set up for,
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
]]

ABL_PowerUps = {"INSTANT","CANCEL","APCUT","DBLSPEED","DBLPOWER"}

if not realinventory then -- This if statement must prevent that the real Items and Abilities routine (which incldues this file as well and I cannot prevent that) gets destroyed by these definitions!

   MS.LoadNew("ITEMS","Script/SubRoutines/Items and Abilities.lua")

   ItemName = function(I)
   MS.Run("ITEMS","ItemName",I)
   return Var.C("$RET")
   end

   ItemDesc = function(I)
   MS.Run("ITEMS","ItemDesc",I)
   return Var.C("$RET")
   end
   
   ItemIcon = function(I,x,y,max)
   local para = I..";"..x..";"..y
   if max then para = para ..";"..max end
   MS.Run("ITEMS","ItemIcon",para)
   end
   
   ItemIconCode = function(I)
   MS.Run("ITEMS","ItemIconCode",I)
   return Var.C("$RET")
   end
   
   ItemField = function (I,F)
   MS.Run("ITEMS","ItemField",I..";"..F)
   return Var.C("$RET")
   end
   
   ItemGet = function (I)
   ItemGetArray = ItemGetArray or {}
   if ItemGetArray[I] then return ItemGetArray[I] end
   -- Loading()
   --MS.Run("ITEMS","ItemGet",I)
   -- local f = loadstring(Var.C('$RET'))   
   -- print(Var.C("$RET"))
   local gotstring = JCR6.LoadString("Script/JINC/IAA/"..I..".lua")
   local f = loadstring(gotstring)
   ItemGetArray[I] = f()
   return ItemGetArray[I]
   end
   
   
   end -- grand end
   
-- if RPGChar.CharExists("VAULT")==0 then RPGChar.CreateChar("VAULT") end   

-- The statements below are general statements, but I placed them here as I saw no need to make a separate file for that.   
function ItemGive(pitemcode,chl,alwaysallowvault,nochat)
local itemcode = upper(pitemcode)
if left ( itemcode,4 )~="ITM_" then return CSay("WARNING! "..itemcode.." may not be an item, or at least not one I can process!") end
local ch
local item = ItemGet(itemcode)
local spot,tochar
local ak
local allowchars =
(({ ["string"] = function() return {chl} end,
    [ "table"] = function() return chl end,
    [   "nil"] = function()
                 local i
                 local ret = {}
                 local c
                 for i=0,5 do 
                     c = RPGChar.PartyTag(i)
                     if c~="" then table.insert(ret,c) end
                     end
                 return ret    
                 end })[type(chl)] or function() Sys.Error("Unknown char defintion in ItemGive","ItemCode,"..sval(itemcode)..";ch,"..type(chl)..";,"..sval(chl)) end)()
                 
for ch in each(allowchars) do 
    for ak=1,InventorySockets do
        -- CSay("Spot: "..ak.."; have: "..RPGChar.Stat(ch,"INVAMNT"..ak).." max: "..InventoryMaxStack) -- debug
        if (not spot) and itemcode=="ITM_"..RPGChar.Data(ch,"INVITEM"..ak) and RPGChar.Stat(ch,"INVAMNT"..ak)<InventoryMaxStack then spot = spot or ak  tochar = tochar or ch end
        --CSay("Spot: "..ak.."; have: "..RPGChar.Stat(ch,"INVAMNT"..ak).." max: "..InventoryMaxStack.." spot: "..sval(spot)) -- debug
        end
    -- Now we'll do the same for an empty socket if no filled socket matched our requiments before    
    for ak=1,InventorySockets do
        if (not spot) and RPGChar.Stat(ch,"INVAMNT"..ak)==0 then spot = spot or ak  tochar = tochar or ch end
        end    
    end -- chars allowed
if spot and tochar then   
   RPGChar.SetData(tochar,"INVITEM"..spot,right(itemcode,len(itemcode)-4))
   RPGChar.IncStat(tochar,"INVAMNT"..spot)
   if not nochat then MINI(RPGChar.GetName(tochar).." received a "..item.Name) end
   return true       
   end       
if (not alwaysallowvault) and item.ItemType~="KeyItem" then return false end
inc("%VAULT."..itemcode)    
if not nochat then MINI(item.Name.." has been put into the vault.") end
return true                     
end

-- This statement is most of used for Key Items. It doesn't matter who has it, as long as that person is a party member or as the item is in the vault.
-- In the case of Linked Party members, it'll be easy, as the item automatically transfers to the linked character as soon as he/she joins the group.
function ItemHave(itemcode)
if CVV("%VAULT."..itemcode)>0 then return true end
local i,ch,chi
for chi = 0,5 do
    ch = RPGChar.PartyTag(chi)
    if ch and ch~="" then
       for i=1,InventorySockets do
           if (itemcode=="ITM_"..RPGChar.Data(ch,"INVITEM"..i) or itemcode==RPGChar.Data(ch,"INVITEM"..i) ) and RPGChar.Stat(ch,"INVAMNT"..i)>0 then return true end
           end
       end 
    end
end   


