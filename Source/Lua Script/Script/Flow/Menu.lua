--[[
/* 
  Menu

  Copyright (C) 2015 JPB
  
  ===========================
  This file is part of a project related to the Phantasar Chronicles.
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



Version: 15.07.20

]]

-- @USEDIR Script/Use/Menu

pchar = 0
returnto = "ERROR"
FeatureArray = { "Status" , "Items" , "Abilities", "Order" }
Feature = {}

tuts = {

    ["FIELD.Status"] = "Welcome to the status menu\n\nClick one of the icons above to access all features\nClick the characters below to switch to another character\nOr click the character you're watching to get outta here",
    ["FIELD.Items"]  = "Right click an item and the onwer will use it.\n\nLeft click an item to place it to a different spot or even a different characters",
    ["FIELD.Abilities"] = "Left click an ability to use it, if it's available in the field.\n\nSome characters show the requirement to learn a new move",
    ["FIELD.Order"] = "Click the characters in the menu (not the bar below) to switch the combat order",
    
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
local i,v
for i,v in ipairs(FeatureArray) do FeaturePics[i] = Image.Load("GFX/StatusBar/Icons/"..v..".png"); Image.HotCenter(FeaturePics[i]); end
end

function ReturnItem()
if not ChosenItem.Taken then return end
local ak = ChosenItem.Spot
local ch = ChosenItem.Char
RPGChar.DefStat(ch,"INVAMNT"..ak,RPGChar.Stat(ch,"INVAMNT"..ak)-1)
RPGChar.SetData(ch,"INVITEM"..ak,ChosenItem.Item)
end

DrawArray = {
   ERROR  = function() Sys.Error("Draw called in an unknown environment","RT,"..returnto) end,
   FIELD  = function()
            local i,v,x,y
            local mx,my = MouseCoords()
            for i,v in ipairs(FeatureArray) do
                if v==Feature[returnto] then Image.Color(0,180,255) else Image.Color(0,90,128) end
                Image.Draw(FeaturePics[i],(i*64)+100,25)
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
          local abl,abldata
          local x
          for ak=1,abilities do
              abl = "ABL_"..RPGStat.ListItem(pchar,"ABL",ak)
              abldata = ItemGet(abl)
              White()
              ItemIcon(abl,30,y)
              x=100
              Image.Color(0,180,255)              
              Image.DText(abldata.Name,x,y,2,2)
              Image.Color(255,180,0)
              if abldata.ABL_AP > RPGChar.Points(pchar,"AP").Have then Red() end
              Image.DText(abldata.ABL_AP,680,y,1,2)
              y = y + size
              end
          return y + size
          end,
    ARM = function()
          local y = 0
          return y
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
                  Image.Color(255-hpc,255,0); Image.Rect(50,120,hpb,3)
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
                      -- Field clicks
                      if returnto=="FIELD" and mx>x-14 and mx<x+14 and my>y-14 and my<y+14 and pchar~="Briggs" then -- Briggs will be without items as a guest character!
                         -- Move items
                         if mousehit(1) then
                            -- Grab an item
                            if RPGChar.Stat(pchar,"INVAMNT"..ak)==1 then -- Grab when only a single item
                                  temp = RPGChar.Data(pchar,"INVITEM"..ak)
                                  if ChosenItem.Taken and RPGChar.Data(pchar,"INVITEM"..ak)==ChosenItem.Item then -- Stack if same
                                     RPGChar.DefStat(pchar,"INVAMNT"..ak,1+RPGChar.Stat(pchar,"INVAMNT"..ak))
                                     ChosenItem={}
                                  else   
                                    if ChosenItem.Taken then -- Swap
                                     RPGChar.SetData(pchar,"INVITEM"..ak,ChosenItem.Item)
                                    else
                                     RPGChar.DefStat(pchar,"INVAMNT"..ak,0)
                                     end
                                    ChosenItem = { Taken=true, Item=temp, Char=pchar, Slot=ak }
                                    end
                            -- Grab an item from stack
                            elseif RPGChar.Stat(pchar,"INVAMNT"..ak)>1 then
                               if ChosenItem.Taken then
                                  -- Add to stack if possible
                                  if ChosenItem.Item==RPGChar.Data(pchar,"INVITEM"..ak) and RPGChar.Stat(pchar,"INVAMNT"..ak)<InventoryMaxStack then RPGChar.DefStat(pchar,"INVAMNT"..ak,RPGChar.Stat(pchar,"INVAMNT"..ak)+1) ChosenItem={} end
                                  else
                                  temp = RPGChar.Data(pchar,"INVITEM"..ak)
                                  ChosenItem = { Taken=true, Item=temp, Char=pchar, Slot=ak }
                                  RPGChar.DefStat(pchar,"INVAMNT"..ak,RPGChar.Stat(pchar,"INVAMNT"..ak)-1)
                                  end
                             -- Get rid of it if you click an empty socket
                             elseif ChosenItem.Taken and RPGChar.Stat(pchar,"INVAMNT"..ak)<=1 and RPGChar.Stat(pchar,"INVAMNT"..ak)<InventoryMaxStack then
                               RPGChar.SetData(pchar,"INVITEM"..ak,ChosenItem.Item)  
                               RPGChar.DefStat(pchar,"INVAMNT"..ak,1+RPGChar.Stat(pchar,"INVAMNT"..ak))
                               ChosenItem = {}
                               -- All done
                               end   
                            if ChosenItem.Taken then ChosenItem.Icon=ItemIconCode("ITM_"..ChosenItem.Item) end   
                            end -- end field click
                         end -- end of returnto FIELD   
                        if returnto=="COMBAT" and mx>x-14 and mx<x+14 and my>y-14 and my<y+14 and pchar~="Briggs" then
                           if mousehit(1) or mousehit(2) then
                               if RPGChar.Stat(pchar,"INVAMNT"..ak)>0 then
                                  Var.D("%CHOSENITEM.SOCKET",ak)
                                  Var.D("$CHOSENITEM.ITEM",RPGChar.GetData(pchar,"INVITEM"..ak))
                                  LAURA.Flow("COMBAT")
                                  end
                              end
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
      Abilities = function()
                  Image.ViewPort(50,100,700,400)
                  Image.Origin(50,100)
                  local a = RPGChar.Data(pchar,"ABLTYPE")
                  local f = ABLKIND[a] or ABLKIND.ABL
                  local y = f()
                  SetFont("Tutorial")
                  White()
                  Image.DText(learnspellmessages[pchar](),350,y,2)
                  Image.ViewPort(0,0,800,600)
                  Image.Origin(0,0)
                  end,
      Order     = function()
                  end,                             
   
}

function DrawScreen()
Feature[returnto] = Feature[returnto] or "Status"
if not Done("&"..returnto.."."..Feature[returnto]) then Tutorial(tuts[returnto.."."..Feature[returnto]]) end
Image.Cls()
Image.Draw(back,0,0)
Image.Draw(chpointer,(pcharn*200)+100,450)
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
   COMBAT = function()
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
