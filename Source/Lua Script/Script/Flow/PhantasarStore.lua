--[[
**********************************************
  
  PhantasarStore.lua
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
 
version: 16.05.17
]]
stock = stock or {}
PM = PM or 0
char = char or "Wendicka"
price = {} -- This variable may not be saved, due to prices changing during development or future updates.
items = {}

function AddToStock(item)
 if tablecontains(stock,item) then
   CSay("= Item is already there")
 else
   stock[#stock+1]=item
   CSay("= Item added") 
 end    
end

function GetPrice(item)
  items[item]=items[item] or ItemGet("ITM_"..item)
  if price[item] then return end
  price[item] = ({
                  ['1A'] = function() return skill end,
                  ['1F'] = function() return skill*2 end,
                  ['AA'] = function() return skill*5 end,
                  ['AF'] = function() return skill*5 end,
                  ['OS'] = function() return 10 end,
                  ['EV'] = function() return skill*10 end
                 })[items.Target] or (skill*1000)
  price[item] = price[item] + (items[item].AttackPower or 0) * ({2,5,10})[skill]
  price[item] = price[item] + (items[item].Healing or 0) * ({4,10,20})[skill]
  price[item] = price[item] + (items[item].APRecover or 0) * ({8,40,80})[skill]
  for k,v in pairs(items) do
      if prefixed(k,"Cause") and v then price[item] = price[item] + ({ 5,10,25})[skill] end 
      if prefixed(k,"Cure")  and v then price[item] = price[item] + ({10,20,50})[skill] end 
  end     
  CSay(item.." costs "..price[item].." shilders")        
end

function GenerateStock()
      -- Stock from inventory
      for ch in each({"Wendicka","Crystal","Yirl","Foxy","Xenobi","Rolf"}) do
          CSay("Scanning: "..ch)
          for i=1, InventorySockets do
              local item = upper(RPGChar.GetData(ch,"INVITEM"..i))
              if prefixed(item,"PHANTASAR_") then
                 CSay("= Found item: "..item)
                 AddToStock(item)
              end              
          end
      end
      -- Stock from vault
      CSay("Scanning the vault")
      for k,v in IVARS() do
          if prefixed(k,"%VAULT.ITM_PHANTASAR_") then
             CSay('Found: '..replace(k,"%VAULT.ITM_",""))
             AddToStock(replace(k,"%VAULT.ITM_",""))
          end   
      end
      -- Sort table and add prices
      CSay("Sorting stock")
      table.sort(stock)
      for item in each(stock) do
          price[item] = GetPrice(item)
      end
end
