--[[
  Menu.lua
  Version: 15.10.16
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

-- @USEDIR Script/Use/Menu

pchar = 0
returnto = "ERROR"
FeatureArray = {FIELD = { "Status" , "Items" , "Abilities", "Order" }, VAULT = { "Items", "Vault" }, STORE = {"Store","Items"} }
Feature = {}

ABL_PowerUpColors = {
                          INSTANT  = {255,255,  0},
                          CANCEL   = {255,180,  0},
                          DBLSPEED = {  0,180,255},
                          DBLPOWER = {255,  0,  0},
                          APCUT    = {180,255,  0} 
                    }

tuts = {

    ["FIELD.Status"] = "Welcome to the status menu\n\nClick one of the icons above to access all features\nClick the characters below to switch to another character\nOr click the character you're watching to get outta here",
    ["FIELD.Items"]  = "Right click an item and the onwer will use it.\n\nLeft click an item to place it to a different spot or even a different characters",
    ["FIELD.Abilities"] = "Left click an ability to use it, if it's available in the field.\n\nSome characters show the requirement to learn a new move",
    ["FIELD.Order"] = "Click the characters in the menu (not the bar below) to switch the combat order",
    
    ["VAULT.Items"] = "Drag items from or to other characters\nor into or out of the vault.",
    ["VAULT.Vault"] = "\n\n",
    
    ["STORE.Store"] = "\n\n",
    ["STORE.Items"] = "\n\n",
    
    ["COMBAT.Status"] = "",
    ["COMBAT.Items"] = "Click any item with either left or right to use it,\nor click the status bar to cancel",
    ["COMBAT.Abilities"] = "Click any ability to use it\nor click the status bar to cancel",
    ["COMBAT.Order"] = "Click any character on the back row\nto replace the current character\n\nor click the status bar to cancel"

   }
   
ChosenItem = {}   

function PointChar(chp)
pcharn = Sys.Val(chp)
pchar = RPGChar.PartyTag(pcharn)
end

function PointCharByName(ch)
pchar = ch
pcharn=-1
for ak=0,5 do 
    if RPGChar.PartyTag(ak)==ch then pcharn=ak end
    end
if pcharn<0 then Sys.Error("No chacter "..ch.." in the party") end
end

function PointPage(v)
Feature[returnto] = v
end

function SetReturnTo(r)
returnto = r
end

function GALE_OnLoad()
back = Image.Load("GFX/StatusBar/StatusFull.png")
chpointer = Image.Load("GFX/StatusBar/CharPointer.png"); Image.HotCenter(chpointer)
invsocket = Image.Load("GFX/StatusBar/ItemSocket.png");  Image.HotCenter(invsocket)
FeaturePics = {}
local i,v,k,a
for k,a in spairs(FeatureArray) do
    for i,v in ipairs(a) do FeaturePics[v] = FeaturePics[v] or Image.Load("GFX/StatusBar/Icons/"..v..".png"); Image.HotCenter(FeaturePics[v]); CSay(k.." asked for an icon "..v) end
    end
end

function ReturnItem()
if not ChosenItem.Taken then return end
local ak = ChosenItem.Spot
local ch = ChosenItem.Char
if ch == "VAULT" then
   inc("%VAULT.ITM_"..ChosenItem.Item)
else
   if not ak then return MINI("WARNING! No spot for this item. It might get lost!") end
   RPGChar.DefStat(ch,"INVAMNT"..ak,RPGChar.Stat(ch,"INVAMNT"..ak)-1)
   RPGChar.SetData(ch,"INVITEM"..ak,ChosenItem.Item)
   end
ChosenItem = {}   
end



function ItemEffect(ch,item,socket)
	
end

function UseItem(pch,item,socket)
local ch = pch or pchar
;(({
     Consumable = function()
                  if ItemEffect(ch,item) then RPGChar.DecStat("INVAMNT"..socket,1) else MINI("It's senseless to do that now!",255,0,0) end
                  end,
     EndlesslyUsable =
                  function()
                  if not ItemEffect(ch,item) then MINI("It's senseless to do that now!",255,0,0) end 
                  end,
     KeyItem =    function()
                  MINI("This item is automatically used when it's needed",255,0,0)
                  end,
     EquipItem =  function()
                  MINI("This item is automatically used when you have it in your inventory",255,0,0) 
                  end                                       
})[item.ItemType] or function() Sys.Error("Unknown Item Type: "..sval(item.ItemType)) end)(ch,item)
end

function SellItem(ch,item,socket)
	SFX("Audio/SFX/Shopping/ChaChing.ogg")
	RPGChar.DecStat(ch,"INVAMNT"..socket,1)
	inc("%CASH",item.ITM_SellPrice)
end

function SellTaken()
	local item
	if ChosenItem.Taken then
		item = ItemGet("ITM_"..ChosenItem.Item)
		SFX("Audio/SFX/Shopping/ChaChing.ogg")
		ChosenItem = {}
		inc("%CASH",item.ITM_SellPrice)		
	end	
end

function BuyHover(item,icode,char)
	local ok
	if not char then
		ChosenItem = {Taken=true,Item=icode,Icon=ItemIconCode("ITM_"..icode)}
		ok = true
	else
		ok = ItemGive("ITM_"..icode,char)
	end	
ok = ok and CVV("%CASH")>item.ITM_BuyPrice
if ok then
	dec("%CASH",item.ITM_BuyPrice)
	SFX("Audio/SFX/Shopping/ChaChing.ogg")
	end
end



DrawArray = {
   ERROR  = function() Sys.Error("Draw called in an unknown environment","RT,"..returnto) end,
   FIELD  = function()
            local i,v,x,y
            local mx,my = MouseCoords()
            for i,v in ipairs(FeatureArray.FIELD) do
                if v==Feature[returnto] then Image.Color(0,180,255) else Image.Color(0,90,128) end
                Image.Draw(FeaturePics[v],(i*64)+100,25)
                y = 25
                x = (i*64)+100
                if mousehit(1) and mx>x-16 and mx<x+16 and my>y-16 and my<y+16 then Feature[returnto] = v end 
                end
            end,
   VAULT  = function()
            local i,v,x,y
            local mx,my = MouseCoords()
            for i,v in ipairs(FeatureArray.VAULT) do
                if v==Feature[returnto] then Image.Color(0,180,255) else Image.Color(0,90,128) end
                Image.Draw(FeaturePics[v],(i*64)+100,25)
                y = 25
                x = (i*64)+100
                if mousehit(1) and mx>x-16 and mx<x+16 and my>y-16 and my<y+16 then Feature[returnto] = v end 
                end
            end,
   STORE  = function()
            local i,v,x,y
            local mx,my = MouseCoords()
            for i,v in ipairs(FeatureArray.STORE) do
                if v==Feature[returnto] then Image.Color(0,180,255) else Image.Color(0,90,128) end
                Image.Draw(FeaturePics[v],(i*64)+100,25)
                y = 25
                x = (i*64)+100
                if mousehit(1) and mx>x-16 and mx<x+16 and my>y-16 and my<y+16 then Feature[returnto] = v end 
                end
            end,         
   COMBAT = function()
            end,
}

ABLKIND = {

    ABL = function()
          SetFont('AbilityList')
          local size = Image.TextHeight("ABCDEFG")
          local y = size/2
          local abilities = RPGStat.CountList(pchar,"ABL")
          local ak
          local abl,ablshort,abldata
          local x
          local mx,my = MouseCoords()   my=my-100
          local mh = mousehit(1)
          local cancel = mousehit(2)
          local col
          local choice = nil
          local i,pu,puu
          local APCost
          for ak=1,abilities do
              ablshort = RPGStat.ListItem(pchar,"ABL",ak)
              abl = "ABL_"..ablshort
              abldata = ItemGet(abl)
              White()
              ItemIcon(abl,30,y,size)
              x=100
              Image.Color(0,180,255)
              --Image.DText("Mouse: "..mx..","..my,mx,my)              
              if my>y-(size/2) and my<y+(size/2) then
                 if mousehit(1) then choice=abl; CSay("Chosen: "..abl) end
                 Image.Color(180,180,255)
                 end
              Image.DText(Var.S(abldata.Name),x,y,0,2)
              Image.ScalePC(50,50)
              for i,pu in ipairs(ABL_PowerUps) do
                  puu = upper(pu)
                  if abldata["ABL_"..pu] then
                     col = ABL_PowerUpColors[puu] or {255,0,255} -- If a socket is purple, we got an error! :)
                     Image.Color(col[1],col[2],col[3])
                     Image.Show("ABL_Socket",(i*18)+300,y)
                     if RPGChar.ListHas(pchar,"ABL_POWERUP",ablshort.."."..puu)~=0 then
                        Image.Show("ABL_"..pu,(i*18)+300,y) 
                        end
                     end
                  end
              Image.ScalePC(100,100)    
              Image.Color(255,180,0)
              APCost = abldata.ABL_AP
              if RPGChar.ListHas(pchar,"ABL_POWERUP",ablshort..".APCUT")~=0 then APCost = math.ceil(APCost/2) end
              if APCost > RPGChar.Points(pchar,"AP").Have then Red() end
              Image.DText(APCost,680,y,1,2)
              if mousehit(2) then choice="cancel" end
              y = y + size,choice
              end
          return y + size,choice
          end,
    ARM = function()
          SetFont('AbilityList')
          local size = Image.TextHeight("ABCDEFG")
          local y = size/2
          local abilities = RPGStat.CountList(pchar,"ARMS")
          local abl,abldata,ablshort
          local x
          local ammo,choice
          local mx,my = MouseCoords()   my=my-100
          for ak=1,abilities do
              ablshort = RPGStat.ListItem(pchar,"ARMS",ak)
              abl = "ARM_"..ablshort
              abldata = ItemGet(abl)
              White()              
              ItemIcon(abl,30,y,size)
              x=100
              -- name
              Image.Color(0,180,255)              
              if my>y-(size/2) and my<y+(size/2) then
                 if mousehit(1) then choice=abl end
                 Image.Color(180,180,255)
                 end
              Image.DText(abldata.Name,x,y,0,2)
              Image.Color(255,180,0)
              -- The ammo
              ammo = RPGChar.Points(pchar,"ARM.AMMO."..ablshort,1)
              if ammo.Maximum==0 then ammo.Maximum=abldata.ARM_MaxAmmo; ammo.have=abldata.ARM_MaxAmmo end
              if ammo.Have==0 then Red() end
              Image.DText(ammo.Have.."/"..ammo.Maximum,680,y,1,2)
              -- Hit %
              if RPGChar.StatExists(pchar,"ARM.HIT."..ablshort)==0 then RPGChar.DefStat(pchar,"ARM.HIT."..ablshort,abldata["ARM_Hit%"]) end
              Image.DText(RPGChar.Stat(pchar,"ARM.HIT."..ablshort).."%",580,y,1,2)
              -- Weight
              if RPGChar.StatExists(pchar,"ARM.WEIGHT."..ablshort)==0 then RPGChar.DefStat(pchar,"ARM.WEIGHT."..ablshort,abldata["ARM_Weight"]) end
              Image.DText("-"..RPGChar.Stat(pchar,"ARM.WEIGHT."..ablshort),500,y,1,2)
              -- Extra Power
              if RPGChar.StatExists(pchar,"ARM.XPOWER."..ablshort)==0 then RPGChar.DefStat(pchar,"ARM.XPOWER."..ablshort,abldata["ARM_XPower"]) end
              Image.DText("+"..RPGChar.Stat(pchar,"ARM.XPOWER."..ablshort),450,y,1,2)
              -- cancel
              if mousehit(2) then choice="cancel" end                            
              -- And this must be last, going to the next line
              y = y + size
              end
          return y+size,choice
          end
    }

FeatureHandleArray = {
      ERROR     = function() Sys.Error("Feature draw called in an unknown feature tag","RT,"..Feature[returnto]) end,
      Status    = function()
                  Red(); SetFont('StatusName'); Image.DText(RPGChar.GetName(pchar),50,50)
                  local i,v,y
                  local r,g,b
                  local s
                  local hpb = (RPGStats.Points(pchar, "HP").Have/RPGStats.Points(pchar, "HP").Maximum) * 200
                  local hpc = (RPGStats.Points(pchar, "HP").Have/RPGStats.Points(pchar, "HP").Maximum) * 255                                    
                  local apb = (RPGStats.Points(pchar, "AP").Have/RPGStats.Points(pchar, "AP").Maximum) * 200
                  local epb
                  if RPGStats.Points(pchar,"EXP").Maximum>0 then 
                        epb = (RPGStats.Points(pchar,"EXP").Have/RPGStats.Points(pchar,"EXP").Maximum) * 200
                        end
                  SetFont("StatusStat")
                  Image.Color(255-hpc,hpc,100)
                  Image.DText("HP",50,100)
                  Image.DText(RPGStats.Points(pchar,"HP").Have.." / "..RPGStats.Points(pchar,"HP").Maximum,250,100,1)
                  Image.Color(100,100,100);   Image.Rect(50,120,200,3)
                  Image.Color(255-hpc,hpc,0); Image.Rect(50,120,hpb,3)
                  if RPGStats.Points(pchar,"AP").Maximum>0 then
                     Image.Color(100,100,255)
                     Image.DText("AP",50,125)
                     Image.DText(RPGStats.Points(pchar,"AP").Have.." / "..RPGStats.Points(pchar,"AP").Maximum,250,125,1)
                     Image.Color(100,100,100); Image.Rect(50,145,200,3)
                     Image.Color(0,0,255);     Image.Rect(50,145,apb,3)
                     end
                  White()
                  Image.DText("Level",50,150)
                  Image.DText(RPGStat.Stat(pchar,"Level"),250,150,1)
                  if epb then
                     Image.Color(100,100,100); Image.Rect(50,170,200,3)
                     Image.Color(255,255,255); Image.Rect(50,170,epb,3)
                     end  
                  -- Stats                   
                  for i,v in ipairs ( {"Strength", "Defense", "Will", "Resistance","Agility","Accuracy","Evasion"} ) do
                      Image.Color(0,180,255)
                      y = (i*fonts["StatusStat"][2])+200
                      Image.DText(v,50,y)
                      if RPGChar.Stat(pchar,"BUFF_"..v)<0 then
                         Image.Color(255,0,0)
                      elseif RPGChar.Stat(pchar,"BUFF_"..v)>0 then
                         Image.Color(0,255,0)
                      else
                         Image.Color(255,180,0)
                         end
                      Image.DText(RPGChar.Stat(pchar,"END_"..v),250,y,1)      
                      end
                  -- Elemental Resistance
                  for i,element in ipairs({"Fire","Wind","Water","Earth","Light","Dark","Lightning","Frost"}) do
                      White()
                      Image.Show("ELEMICON_"..element,300,(i*20)+60)
                      ResTxt(RPGChar.Stat(pchar,"ER_"..element),330,(i*20)+60)
                      end    
                  -- Status Change Resistances
                  for i,status in iStatus(false,true) do
                      White()
                      Image.Show("STATUS_"..status,300,(i*20)+270) 
                      s = RPGStats.Stat(pchar,"SR_TRUE_"..status)
                      g = (s/100) * 255
                      r = 255 - g
                      b = 0
                      Image.Color(r,g,b)
                      Image.DText(s.."%",420,(i*20)+270,1)
                      end    
                  end,
      Items     = function() 
                  local ak,x,y
                  local row,col
                  local mx,my = MouseCoords()
                  local temp
                  local hover,hoverdata
                  local item,cmbitem
                  local mousetxt = { FIELD = {"Left = Pick up","Right = Use on "..RPGChar.GetName(pchar)},COMBAT={"Click to use"},VAULT={"Left = pickup"},STORE={"Left = Pickup","Right = Sell"}}
                  White()
                  for ak=1,InventorySockets do
                      -- Get some needed values
                      row = math.floor((ak-1)/InventorySocketRow)
                      col = ak - (row*InventorySocketRow)
                      x   = (col * 40)+50
                      y   = (row * 40)+100     
                      -- Draw the socket                 
                      Image.Draw(invsocket,x,y)
                      -- Draw the icon
                      if RPGChar.Stat(pchar,"INVAMNT"..ak)>0 then
                         ItemIcon("ITM_"..RPGChar.Data(pchar,"INVITEM"..ak),x,y)
                         if RPGChar.Stat(pchar,"INVAMNT"..ak)>1 then
                            if skill==3 then RPGChar.DefStat(pchar,'INVAMNT'..ak,1) else DarkText(RPGChar.Stat(pchar,"INVAMNT"..ak),x+16,y+16,1,1) end
                            end 
                         end
                      -- Detect Hover
                      hover = mx>x-14 and mx<x+14 and my>y-14 and my<y+14
                      if hover then hoverdata = { i = ak, x = x, y = y} end
                      -- Field clicks
                      if (returnto=="FIELD" or returnto=="VAULT" or returnto=="STORE") and hover and pchar~="Briggs" then -- Briggs will be without items as a guest character!
                         -- Move items
                         if mousehit(1) then
                            -- Grab an item
                            if RPGChar.Stat(pchar,"INVAMNT"..ak)==1 then -- Grab when only a single item
                                  temp = RPGChar.Data(pchar,"INVITEM"..ak)
                                  if ChosenItem.Taken and RPGChar.Data(pchar,"INVITEM"..ak)==ChosenItem.Item then -- Stack if same
                                     RPGChar.DefStat(pchar,"INVAMNT"..ak,1+RPGChar.Stat(pchar,"INVAMNT"..ak))
                                     ChosenItem={}
                                     EquipEffect(pchar)
                                  else   
                                    if ChosenItem.Taken then -- Swap
                                     RPGChar.SetData(pchar,"INVITEM"..ak,ChosenItem.Item)
                                    else
                                     RPGChar.DefStat(pchar,"INVAMNT"..ak,0)
                                     end
                                    ChosenItem = { Taken=true, Item=upper(temp), Char=pchar, Slot=ak, Spot=ak }
                                    EquipEffect(pchar)
                                    end
                            -- Grab an item from stack
                            elseif RPGChar.Stat(pchar,"INVAMNT"..ak)>1 then
                               if ChosenItem.Taken then
                                  -- Add to stack if possible
                                  if ChosenItem.Item==RPGChar.Data(pchar,"INVITEM"..ak) and RPGChar.Stat(pchar,"INVAMNT"..ak)<InventoryMaxStack then RPGChar.DefStat(pchar,"INVAMNT"..ak,RPGChar.Stat(pchar,"INVAMNT"..ak)+1) ChosenItem={} end
                                  EquipEffect(pchar)
                                  else
                                  temp = RPGChar.Data(pchar,"INVITEM"..ak)
                                  ChosenItem = { Taken=true, Item=upper(temp), Char=pchar, Slot=ak, Spot=ak }
                                  RPGChar.DefStat(pchar,"INVAMNT"..ak,RPGChar.Stat(pchar,"INVAMNT"..ak)-1)
                                  EquipEffect(pchar)
                                  end
                             -- Get rid of it if you click an empty socket
                             elseif ChosenItem.Taken and RPGChar.Stat(pchar,"INVAMNT"..ak)<=1 and RPGChar.Stat(pchar,"INVAMNT"..ak)<InventoryMaxStack then
                               RPGChar.SetData(pchar,"INVITEM"..ak,ChosenItem.Item)  
                               RPGChar.DefStat(pchar,"INVAMNT"..ak,1+RPGChar.Stat(pchar,"INVAMNT"..ak))
                               ChosenItem = {}
                               EquipEffect(pchar)
                               -- All done
                               end   
                            if ChosenItem.Taken then ChosenItem.Icon=ItemIconCode("ITM_"..ChosenItem.Item) end   
                            end -- end field click
                         end -- end of returnto FIELD                           
                        if returnto=="COMBAT" and hover and pchar~="Briggs" then
                           if mousehit(1) or mousehit(2) then
                               if RPGChar.Stat(pchar,"INVAMNT"..ak)>0 then
                                  cmbitem = ItemGet("ITM_"..RPGChar.GetData(pchar,"INVITEM"..ak))
                                  if cmbitem.ItemType=="Consumable" or cmb.ItemType=="EndlesslyUsable" then
                                     Var.D("%CHOSENITEM.SOCKET",ak)
                                     Var.D("$CHOSENITEM.ITEM",RPGChar.GetData(pchar,"INVITEM"..ak))
                                     LAURA.Flow("COMBAT")
                                     end
                                  end
                              end
                           end   
                      end
                  if CVV("%CHOSENITEM.SOCKET")==0 and mousehit(2) and returnto=="COMBAT" then -- Should be executed when user didn't click an item with right
                     Var.D("%CHOSENITEM.SOCKET",-1)
                     LAURA.Flow("COMBAT")                     
                     end    
                  local dy = my + 16   
                  local dl
                  if hoverdata and RPGChar.Stat(pchar,"INVAMNT"..hoverdata.i)>0 then
                         item = ItemGet("ITM_"..RPGChar.Data(pchar,"INVITEM"..hoverdata.i))
                         SetFont("ItemHeader")
                         FitText(item.Name,mx+16,my+16,255,0,0)
                         dy = dy + Image.TextHeight(item.Name)
                         SetFont("ItemDescription")
                         for dl in each(mysplit(item.Description,"\n")) do
                             FitText(dl,mx+16,dy,0,180,255)
                             dy = dy + Image.TextHeight(dl)
                             end
                          if returnto=="FIELD" and mousehit(2) then
                             UseItem(pchar,item,hoverdata.i) 
                             end      
                          if returnto=="STORE" then 
                             if not item.ITM_Sellable then
                                mousetxt[returnto][2] = "You cannot sell this item"
                             else
                                if item.ITM_SellPrice==1 then
                                   mousetxt[returnto][2] = "Sell for 1 credit"
                                else   
                                   mousetxt[returnto][2] = "Sell for "..(item.ITM_SellPrice or "no").." credits"
                                   end
                                end
                             if mousehit(2) then SellItem(pchar,item,hoverdata.i) end
                             end   
                          SetFont("Tutorial")
                          for dl in each(mousetxt[returnto] or {}) do
                              FitText(dl,mx+16,dy,255,180,0)
                              dy = dy + Image.TextHeight(dl) 
                              end 
                         end    
                  -- @IF *DEVELOPMENT
                  y = 20
                  for k,v in spairs(ChosenItem) do
                      White() 
                      Image.DText(k.." = "..sval(v),780,y,1); y = y + Image.TextWidth("A") 
                      end                
                  -- @FI    
                  end,
      Store     = function()
                  local y=116
                  local mx,my = MouseCoords()
                  local item,itemcode
                  local cg,cb,cr
                  local hover,hoveritemcode
                  local dy = my + 16
                  local dx = mx + 16
                  DarkText(Store.Name,400,100,2,2,255,0,0)
                  for itemcode in each(Store.Stock) do
                      White()
                      ItemIcon(itemcode,60,y)
                      item = ItemGet(itemcode)
                      SetFont("ItemHeader")
                      cr = 0
                      cg = 100
                      cb = 180
                      if my>y-16 and my<y+16 then 
                         hover = item
						  hoveritemcode = replace(itemcode,"ITM_","")
                         cg = 180
                         cb = 255
                         end
                      DarkText(item.Name,100,y,0,2,0,cg,cb)
                      cr = 255
                      cg = 180
                      cb = 0
                      if item.ITM_BuyPrice>CVV("%CASH") then cg=0 end
                      DarkText(item.ITM_BuyPrice.." cr",780,y,1,2,cr,cg,cb)
                      y = y + 32
                      end
                  if hover then
                     SetFont("ItemDescription")
                     for dl in each(mysplit(hover.Description,"\n")) do
                             FitText(dl,mx+16,dy,255,180,0)
                             dy = dy + Image.TextHeight(dl)
                             end
                     SetFont("Tutorial")
                     for dl in each({"Left = Buy & pickup","Right = Buy and put in "..RPGChar.GetName(pchar).."'s inventory"}) do
                              FitText(dl,mx+16,dy,255,180,100)
                              dy = dy + Image.TextHeight(dl) 
                              end                       
                     end   
				   if mousehit(1) then
					if ChosenItem.Taken and my>116 and my<500 then
						SellTaken()
					elseif hover then
						BuyHover(hover,hoveritemcode)
						end
					end   
				   if mousehit(2) and hover then
					BuyHover(hover,hoveritemcode,pchar)
					end
                  end,            
      Vault     = function()
                  local y = 15
                  local hover = nil
                  local itcode,item,itshort,itreallyshort
                  Image.ViewPort(50,100,700,400)
                  Image.Origin(50,100)
                  for itcode in IVARS() do
                      if prefixed(itcode,"%VAULT.") then
                         itshort = right(itcode,len(itcode)-7)
                         White()
                         ItemIcon(itshort,50,y) 
                         item = ItemGet(itshort)
                         itreallyshort = right(itshort,len(itshort)-4)
                         if CVV(itcode)<1 then 
                            Red()
                         else
                            Image.Color(0,80,155)
                            if INP.MouseY()>84+y and INP.MouseY()<116+y then
                               hover = {code=itcode, short=itshort, reallyshort=itreallyshort}
                               LightBlue()
                               end
                            end
                         Image.DText(item.Name,100,y,0,2) 
                         Image.DText("x"..CVV(itcode),680,y,1,2)  
                         y = y + 32
                         end 
                      end
                  if INP.MouseH(1)==1 and INP.MouseY()>100 then
                     if ChosenItem.Taken then 
                        if CVV("%VAULT.ITM_"..ChosenItem.Item) < InventoryMaxVaultStack then
                           inc("%VAULT.ITM_"..ChosenItem.Item)
                           ChosenItem = {}
                           end
                     elseif hover then
                        ChosenItem = { Taken=true, Item=hover.reallyshort, Char="VAULT", Icon=ItemIconCode(hover.short) }   
                        dec(hover.code) 
                        end 
                     end   
                  Image.ViewPort(0,0,800,600)
                  Image.Origin(0,0)
                  end,            
      Abilities = function()
                  Image.ViewPort(50,100,700,400)
                  Image.Origin(50,100)
                  local a = RPGChar.Data(pchar,"ABLTYPE")
                  local f = ABLKIND[a] or ABLKIND.ABL
                  local y,choice = f()
                  if choice and returnto=='COMBAT' then
                     Var.D("$CHOSENABILITY",choice) 
                     LAURA.Flow("COMBAT")
                     end
                  SetFont("Tutorial")
                  White()
                  Image.DText(learnspellmessages[pchar](),350,y,2)
                  --Image.DText('returnto = '..returnto,350,y+30,2) -- debug line
                  Image.ViewPort(0,0,800,600)
                  Image.Origin(0,0)
                  end,
      Order     = function()
					local x
					local y
					local ch,chd 
					local picfile,picref		
					local tempch
					local mx,my = MouseCoords()
					local havechosen
					for i=0,5 do
						x = ({ 50,300,550, 60,310,560})[i+1]
						y = ({ 50, 75,100,225,250,275})[i+1]
						ch = RPGChar.PartyTag(i)
						chd = ch
						if ch and ch~="" then						
							if left(ch,3)=="Uni" then chd = replace(ch,"Uni","") end
							picfile = "GFX/Portret/"..sval(chd).."/"..RPGChar.GetData(ch,"Pic")..".png"						
							picref = upper(chd).."."..upper(RPGChar.GetData(ch,"Pic"))
							Image.LoadNew(picref,picfile)
							if orderchosen==i then
								Image.Color(0,0,math.abs(sin(Time.MSecs()/100)*255))
								Image.Rect(x,y,250,Image.Height(picref))
							end							
							White()
							Image.Show(picref,x,y)
							SetFont('StatusStat')
							Image.Color(255,180,0) Image.DText("#"..Sys.Val(i+1),x+115,y)
							Red(); Image.DText(RPGChar.GetName(ch),x+120,y+50)	
							if mousehit(1) and mx>x and mx<x+250 and my>y and my<y+Image.Height(picref) and (not havechosen) then
								havechosen=true
								if orderchosen then
									tempch = RPGChar.PartyTag(orderchosen)
									RPGChar.SetParty(orderchosen,ch)
									RPGChar.SetParty(i,tempch)
									orderchosen = nil
								else
									orderchosen = i
								end
							end							
						end					
					end
                  end                             
   
}


function LoadStore(storefile)
CSay("Loading store: "..storefile)
local tempstore = jinc("Script/JINC/Shops/"..storefile..".lua")
Store = { Name = tempstore.StoreName, Stock = {} }
for i=1,10 do
    CSay(i..">"..tempstore["Stock"..i])
    if tempstore["Stock"..i]~="*Nothing*" then Store.Stock[#Store.Stock+1] = replace(tempstore["Stock"..i],".lua","") end
    end
end

function DrawScreen()
	Feature.VAULT = Feature.VAULT or "Items"
	Feature[returnto] = Feature[returnto] or "Status"
	if not Done("&"..returnto.."."..Feature[returnto]) then 
		Tutorial(tuts[returnto.."."..Feature[returnto]])
		CSay("Showing menu tutorial: "..returnto.."."..Feature[returnto]) 
	end
	Image.Cls()
	Image.Draw(back,0,0)
	if pcharn<3 then
		Image.Draw(chpointer,(pcharn*200)+100,450)
	else
		-- This comes later.
	end
	local f = DrawArray[returnto or "ERROR"] or DrawArray.ERROR
	f()
	f = FeatureHandleArray[Feature[returnto] or "ERROR"] or FeatureHandleArray.ERROR
	f()
	ShowParty()
	ShowMouse(ChosenItem.Icon)
end

ClickArray = {
   ERROR  = function() Sys.Error("Click called in an unknown environment","RT,"..returnto) end,
   FIELD  = function()
            local ak
            for ak=0,5 do
                if ClickedChar(ak) then
                   if ak==pcharn then ReturnItem() LAURA.FLOW("FIELD") else pcharn=ak; pchar=RPGChar.PartyTag(pcharn) end
                   end
                end
            end,
   VAULT  = function()
            local ak
            for ak=0,5 do
                if ClickedChar(ak) then
                   if ak==pcharn then ReturnItem() LAURA.FLOW("FIELD") else pcharn=ak; pchar=RPGChar.PartyTag(pcharn) end
                   end
                end
            end,
   STORE  = function()
            local ak
            for ak=0,5 do
                if ClickedChar(ak) then
                   if ak==pcharn then ReturnItem() LAURA.FLOW("FIELD") else pcharn=ak; pchar=RPGChar.PartyTag(pcharn) end
                   end
                end
            end,
   COMBAT = function()
            for ak=0,5 do
                if ClickedChar(ak) then
                   Var.D("%CHOSENITEM.SOCKET",-1)
                   Var.D("$CHOSENABILITY","")
                   LAURA.Flow("COMBAT")                     
                   end
                end   
            end           
   }

function Click()
local f = ClickArray[returnto or "ERROR"] or ClickArray.ERROR
f()
end

function MAIN_FLOW()
DrawScreen()
Click()
Flip()
LAURA.TerminateBye()
end
