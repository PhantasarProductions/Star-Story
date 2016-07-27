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
 
version: 16.07.27
]]


stock = stock or {}
PM = PM or 0
char = char or "Wendicka"
price = {} -- This variable may not be saved, due to prices changing during development or future updates.
items = {}
chpointer = 'MenuCharPointer' Image.HotCenter(chpointer)
buyicons = {}


function cpos(c)
    local pcharn
    for i=0,5 do
    	  if RPGChar.PartyTag(i)==(c or char)  then pcharn=i end 
    end
    local x,y
    if pcharn<3 then
       x = (pcharn*200)+100
       y = 550
    else
       local tpos = pcharn - 3
       x = 640 + (tpos * 40) + 15
       y = 550 + 15
    end
    return x,y
end    

function xcpos(c)
	local x,y = cpos(c)
	return x
end

function ycpos(c)
	local x,y = cpos(c)
	return y
end


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
  price[item] = (({
                  ['1A'] = function() return skill end,
                  ['1F'] = function() return skill*2 end,
                  ['AA'] = function() return skill*5 end,
                  ['AF'] = function() return skill*5 end,
                  ['OS'] = function() return 10 end,
                  ['EV'] = function() return skill*10 end
                 })[items[item].Target] or function() return (skill*1000) end)()
  price[item] = price[item] + (items[item].AttackPower or 0) * ({2,5,10})[skill]
  price[item] = price[item] + (items[item].Healing or 0) * ({4,10,20})[skill]
  price[item] = price[item] + (items[item].APRecover or 0) * ({8,40,80})[skill]
  for k,v in pairs(items[item]) do
  	  CSay("item => "..type(v).." "..k.." "..sval(v))
      if prefixed(k,"Cause") and v then price[item] = price[item] + ({ 5,10,25})[skill] end 
      if prefixed(k,"Cure")  and v then price[item] = price[item] + ({10,20,50})[skill] end 
  end     
  CSay(item.." costs "..price[item].." shilders")        
  -- return price[item]
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
          GetPrice(item)
      end
end

function Bye()
	LAURA.Flow("FIELD")
end

function Buy(tag,data)
	if ItemGive("ITM_"..tag,char,false,true) then
	   buyicons[char] = { tag = "ITM_"..tag, x = xcpos(), y = ycpos(), max=64}
	   dec("%SHILDERS",price[tag])
	else
	   MINI(RPGChar.GetName(char).." has no more room in "..hisher[char].." inventory",255,0,0)
	end
end

function MAIN_FLOW()
    local item,y
    local mx,my = MouseCoords()
    local cash = CVV("%SHILDERS")
    local icol,iprc
    Image.Cls()
    SetFont('PhantasarWorld')
    Red()
    Image.DText("Sellameria's General Store",20,20)
   	Image.Color(180,255,0)
   	Image.DText(ItemDescription,20,50)
		ItemDescription = ""
    Image.ViewPort(20,100,800,300)
    SetFont('PhantasarStore')
    for idx,itm in ipairs(stock) do
        item = items[itm]
        y = (100 + (idx*20)) - PM 
        White()
        ItemIcon("ITM_"..itm,60,y,20)
        --CSay(itm.." > "..sval(price[itm].."; "..sval(cash)))
        if price[itm]>cash then
        	 icol = {255,0,0}
        	 iprc = {255,0,0}
        elseif my>y-10 and my<y+10 and my>100 and my<100+300 then
        	icol = {255,180,0}
        	iprc = {0,255,255}
        	ItemDescription=item.Description
        	if INP.MouseH(1)==1 then
        		Buy(itm,item)
        	end
        else
          icol = {180,100,0}
          iprc = {  0,180,255}
        end
        Image.Color(icol[1],icol[2],icol[3])
        Image.DText(item.Name,100,y,0,2)  	
        Image.Color(iprc[1],iprc[2],iprc[3])
        Image.DText(price[itm].." shilders",780,y,1,2)        
    end
    Image.ViewPort(0,0,800,600)
    --local pcharn
    CSay('-- checking phantasar store click ---')
    for i=0,5 do 
        CSay('Check clickchar: '..i..'; currently is: '..sval(pcharn))
        if ClickedChar(i) then
           if i==pcharn then Bye() return end
           char=RPGChar.PartyTag(i)
        end
    	  if RPGChar.PartyTag(i)==char then pcharn=i end
    end
    CSay('-- end check --')
    if pcharn<3 then
       White()
		   Image.Draw(chpointer,(pcharn*200)+100,450)
	  end
  	ShowParty()
	  if pcharn>2 then		
		   local tpos = pcharn - 3
		   Image.Color(0,180,255)
		   Image.Rect(tpos*40+640,550,30,30,1)
		end
		White()
		for ch,dat in pairs(buyicons) do
		    ItemIcon(dat.tag,dat.x,dat.y,dat.max)
		    dat.max = dat.max - 1
		    if dat.max<=0 then buyicons[ch] = nil end
		end
	  ShowMouse()	  
    Flip()
    if INP.KeyH(KEY_ESCAPE)==1 then Bye() end
end


        
