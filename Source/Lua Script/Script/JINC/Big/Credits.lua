--[[
**********************************************
  
  Credits.lua
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
 
version: 16.08.12
]]
ret = {
        ['00000000'] = { img = 'GFX/Intro/StarStory.png', y=300 },
        ['00000370'] = { txt = 'Audio', r=255,g=0,b=0, y=880 }, -- Audio
        ['00000384'] = { txt = 'Alexander', r=0,g=180,b=255, y=900 },
        ['00000398'] = { txt = 'Benboncan', r=0,g=180,b=255, y=920 },
        ['000003AC'] = { txt = 'GR-Sites', r=0,g=180,b=255, y=940 },
        ['000003C0'] = { txt = 'Gabe Miller', r=0,g=180,b=255, y=960 },
        ['000003D4'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=980 },
        ['000003E8'] = { txt = 'Kristel Kerstens', r=0,g=180,b=255, y=1000 },
        ['000003FC'] = { txt = 'PacDV', r=0,g=180,b=255, y=1020 },
        ['00000410'] = { txt = 'Shockwave-sound.com', r=0,g=180,b=255, y=1040 },
        ['00000424'] = { txt = 'Varazuvi(TM)', r=0,g=180,b=255, y=1060 },
        ['00000438'] = { txt = 'Widzy', r=0,g=180,b=255, y=1080 },
        ['0000044C'] = { txt = 'http://www.freesfx.co.uk', r=0,g=180,b=255, y=1100 },
        ['00000460'] = { txt = 'soundscrate.com', r=0,g=180,b=255, y=1120 },
        ['00000488'] = { txt = 'Code', r=255,g=0,b=0, y=1160 }, -- Code
        ['0000049C'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=1180 },
        ['000004C4'] = { txt = 'Font', r=255,g=0,b=0, y=1220 }, -- Font
        ['000004D8'] = { txt = 'Courtney Novits', r=0,g=180,b=255, y=1240 },
        ['000004EC'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=1260 },
        ['00000500'] = { txt = 'Pablo Impallari', r=0,g=180,b=255, y=1280 },
        ['00000514'] = { txt = 'Ray Larabie', r=0,g=180,b=255, y=1300 },
        ['00000528'] = { txt = 'Ruark Brumbaugh', r=0,g=180,b=255, y=1320 },
        ['0000053C'] = { txt = 'Thobias Benjamin Koehler', r=0,g=180,b=255, y=1340 },
        ['00000550'] = { txt = 'Utopia', r=0,g=180,b=255, y=1360 },
        ['00000564'] = { txt = 'WoodCutter', r=0,g=180,b=255, y=1380 },
        ['0000058C'] = { txt = 'General Data', r=255,g=0,b=0, y=1420 }, -- General Data
        ['000005A0'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=1440 },
        ['000005B4'] = { txt = 'Man of Steel', r=0,g=180,b=255, y=1460 },
        ['000005C8'] = { txt = 'Unknown Artist', r=0,g=180,b=255, y=1480 },
        ['000005DC'] = { txt = 'foofurple', r=0,g=180,b=255, y=1500 },
        ['00000604'] = { txt = 'Graphics', r=255,g=0,b=0, y=1540 }, -- Graphics
        ['00000618'] = { txt = ' deusinvictus', r=0,g=180,b=255, y=1560 },
        ['0000062C'] = { txt = '-', r=0,g=180,b=255, y=1580 },
        ['00000640'] = { txt = 'Aeris', r=0,g=180,b=255, y=1600 },
        ['00000654'] = { txt = 'Alan Speak', r=0,g=180,b=255, y=1620 },
        ['00000668'] = { txt = 'Angela Nagtzaam', r=0,g=180,b=255, y=1640 },
        ['0000067C'] = { txt = 'Ann', r=0,g=180,b=255, y=1660 },
        ['00000690'] = { txt = 'April', r=0,g=180,b=255, y=1680 },
        ['000006A4'] = { txt = 'BMCGOWAN', r=0,g=180,b=255, y=1700 },
        ['000006B8'] = { txt = 'CoolText', r=0,g=180,b=255, y=1720 },
        ['000006CC'] = { txt = 'Cynix', r=0,g=180,b=255, y=1740 },
        ['000006E0'] = { txt = 'Dedicated Teacher', r=0,g=180,b=255, y=1760 },
        ['000006F4'] = { txt = 'Deluge', r=0,g=180,b=255, y=1780 },
        ['00000708'] = { txt = 'Denelson83', r=0,g=180,b=255, y=1800 },
        ['0000071C'] = { txt = 'Emily Esposito', r=0,g=180,b=255, y=1820 },
        ['00000730'] = { txt = 'FlamingText.com', r=0,g=180,b=255, y=1840 },
        ['00000744'] = { txt = 'Frankes', r=0,g=180,b=255, y=1860 },
        ['00000758'] = { txt = 'GDJ', r=0,g=180,b=255, y=1880 },
        ['0000076C'] = { txt = 'GR-Sites', r=0,g=180,b=255, y=1900 },
        ['00000780'] = { txt = 'GameJolt', r=0,g=180,b=255, y=1920 },
        ['00000794'] = { txt = 'Holly', r=0,g=180,b=255, y=1940 },
        ['000007A8'] = { txt = 'J4p4n', r=0,g=180,b=255, y=1960 },
        ['000007BC'] = { txt = 'Jason Schrepel', r=0,g=180,b=255, y=1980 },
        ['000007D0'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=2000 },
        ['000007E4'] = { txt = 'Kelly', r=0,g=180,b=255, y=2020 },
        ['000007F8'] = { txt = 'Kipp', r=0,g=180,b=255, y=2040 },
        ['0000080C'] = { txt = 'Lazur URH', r=0,g=180,b=255, y=2060 },
        ['00000820'] = { txt = 'Linda James', r=0,g=180,b=255, y=2080 },
        ['00000834'] = { txt = 'Lindsey', r=0,g=180,b=255, y=2100 },
        ['00000848'] = { txt = 'Majkel', r=0,g=180,b=255, y=2120 },
        ['0000085C'] = { txt = 'Man of Steel', r=0,g=180,b=255, y=2140 },
        ['00000870'] = { txt = 'Megan', r=0,g=180,b=255, y=2160 },
        ['00000884'] = { txt = 'Merlin2525', r=0,g=180,b=255, y=2180 },
        ['00000898'] = { txt = 'Michal Franc', r=0,g=180,b=255, y=2200 },
        ['000008AC'] = { txt = 'Mohammed Ibrahim', r=0,g=180,b=255, y=2220 },
        ['000008C0'] = { txt = 'Moini', r=0,g=180,b=255, y=2240 },
        ['000008D4'] = { txt = 'NASA', r=0,g=180,b=255, y=2260 },
        ['000008E8'] = { txt = 'OpenClips', r=0,g=180,b=255, y=2280 },
        ['000008FC'] = { txt = 'Palimsest', r=0,g=180,b=255, y=2300 },
        ['00000910'] = { txt = 'Skurian25', r=0,g=180,b=255, y=2320 },
        ['00000924'] = { txt = 'TheSkull', r=0,g=180,b=255, y=2340 },
        ['00000938'] = { txt = 'Tibetan_Fox', r=0,g=180,b=255, y=2360 },
        ['0000094C'] = { txt = 'Unknown Artist', r=0,g=180,b=255, y=2380 },
        ['00000960'] = { txt = 'Vicious_Speed', r=0,g=180,b=255, y=2400 },
        ['00000974'] = { txt = 'Vickie', r=0,g=180,b=255, y=2420 },
        ['00000988'] = { txt = 'YADOT', r=0,g=180,b=255, y=2440 },
        ['0000099C'] = { txt = 'barnheartowl', r=0,g=180,b=255, y=2460 },
        ['000009B0'] = { txt = 'burnurb', r=0,g=180,b=255, y=2480 },
        ['000009C4'] = { txt = 'cgbug', r=0,g=180,b=255, y=2500 },
        ['000009D8'] = { txt = 'eady', r=0,g=180,b=255, y=2520 },
        ['000009EC'] = { txt = 'finao123', r=0,g=180,b=255, y=2540 },
        ['00000A00'] = { txt = 'foofurple', r=0,g=180,b=255, y=2560 },
        ['00000A14'] = { txt = 'glitch', r=0,g=180,b=255, y=2580 },
        ['00000A28'] = { txt = 'hatalar205', r=0,g=180,b=255, y=2600 },
        ['00000A3C'] = { txt = 'jonata', r=0,g=180,b=255, y=2620 },
        ['00000A50'] = { txt = 'jpd2010', r=0,g=180,b=255, y=2640 },
        ['00000A64'] = { txt = 'jphandrigan', r=0,g=180,b=255, y=2660 },
        ['00000A78'] = { txt = 'kg', r=0,g=180,b=255, y=2680 },
        ['00000A8C'] = { txt = 'pitr', r=0,g=180,b=255, y=2700 },
        ['00000AA0'] = { txt = 'qubodub', r=0,g=180,b=255, y=2720 },
        ['00000AB4'] = { txt = 'tzunghaor', r=0,g=180,b=255, y=2740 },
        ['00000AC8'] = { txt = 'wallpaperpal.com', r=0,g=180,b=255, y=2760 },
        ['00000ADC'] = { txt = 'warszawianka', r=0,g=180,b=255, y=2780 },
        ['00000B04'] = { txt = 'Map Design', r=255,g=0,b=0, y=2820 }, -- Map Design
        ['00000B18'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=2840 },
        ['00000B40'] = { txt = 'Music', r=255,g=0,b=0, y=2880 }, -- Music
        ['00000B54'] = { txt = 'Aaron Krogh', r=0,g=180,b=255, y=2900 },
        ['00000B68'] = { txt = 'Alexander', r=0,g=180,b=255, y=2920 },
        ['00000B7C'] = { txt = 'Brian Boyko', r=0,g=180,b=255, y=2940 },
        ['00000B90'] = { txt = 'Eric Matyas', r=0,g=180,b=255, y=2960 },
        ['00000BA4'] = { txt = 'Fake Music Generator', r=0,g=180,b=255, y=2980 },
        ['00000BB8'] = { txt = 'J.W.H. Broeders', r=0,g=180,b=255, y=3000 },
        ['00000BCC'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=3020 },
        ['00000BE0'] = { txt = 'Kevin McLeod', r=0,g=180,b=255, y=3040 },
        ['00000BF4'] = { txt = 'Knight Of Fire', r=0,g=180,b=255, y=3060 },
        ['00000C08'] = { txt = 'Lee Rosevere', r=0,g=180,b=255, y=3080 },
        ['00000C1C'] = { txt = 'Matt McFarland', r=0,g=180,b=255, y=3100 },
        ['00000C30'] = { txt = 'Rockit Maxx', r=0,g=180,b=255, y=3120 },
        ['00000C44'] = { txt = 'SJ Mellia', r=0,g=180,b=255, y=3140 },
        ['00000C58'] = { txt = 'Sergey Cheremisinov', r=0,g=180,b=255, y=3160 },
        ['00000C6C'] = { txt = 'Spiedkiks', r=0,g=180,b=255, y=3180 },
        ['00000C80'] = { txt = 'Wan Kee Chan & Wouter Wershkull', r=0,g=180,b=255, y=3200 },
        ['00000C94'] = { txt = 'WeirdoMusic', r=0,g=180,b=255, y=3220 },
        ['00000CA8'] = { txt = 'Widzy', r=0,g=180,b=255, y=3240 },
        ['00000CBC'] = { txt = 'Your Marginally Talented Photographer Girlfriend', r=0,g=180,b=255, y=3260 },
        ['00000CE4'] = { txt = 'Scenario', r=255,g=0,b=0, y=3300 }, -- Scenario
        ['00000CF8'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=3320 },
        ['00000D20'] = { txt = 'Script', r=255,g=0,b=0, y=3360 }, -- Script
        ['00000D34'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=3380 },
        ['00000F8C'] = { txt = '(c) Copyright 2016', r=255, g=180,b=0,y=3980},
        ['00000FA5'] = { txt = 'Jeroen Petrus Broks', r=255, g=180,b=0,y=4005}
}

return ret
