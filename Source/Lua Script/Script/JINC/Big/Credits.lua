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
 
version: 16.11.12
]]
local
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
        ['0000058C'] = { txt = 'Game identification data', r=255,g=0,b=0, y=1420 }, -- Game identification data
        ['000005A0'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=1440 },
        ['000005C8'] = { txt = 'General Data', r=255,g=0,b=0, y=1480 }, -- General Data
        ['000005DC'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=1500 },
        ['000005F0'] = { txt = 'Man of Steel', r=0,g=180,b=255, y=1520 },
        ['00000604'] = { txt = 'Unknown Artist', r=0,g=180,b=255, y=1540 },
        ['00000618'] = { txt = 'Widzy', r=0,g=180,b=255, y=1560 },
        ['0000062C'] = { txt = 'foofurple', r=0,g=180,b=255, y=1580 },
        ['00000654'] = { txt = 'Graphics', r=255,g=0,b=0, y=1620 }, -- Graphics
        ['00000668'] = { txt = ' deusinvictus', r=0,g=180,b=255, y=1640 },
        ['0000067C'] = { txt = '-', r=0,g=180,b=255, y=1660 },
        ['00000690'] = { txt = 'Aeris', r=0,g=180,b=255, y=1680 },
        ['000006A4'] = { txt = 'Alan Speak', r=0,g=180,b=255, y=1700 },
        ['000006B8'] = { txt = 'Angela Nagtzaam', r=0,g=180,b=255, y=1720 },
        ['000006CC'] = { txt = 'Ann', r=0,g=180,b=255, y=1740 },
        ['000006E0'] = { txt = 'April', r=0,g=180,b=255, y=1760 },
        ['000006F4'] = { txt = 'BMCGOWAN', r=0,g=180,b=255, y=1780 },
        ['00000708'] = { txt = 'CoolText', r=0,g=180,b=255, y=1800 },
        ['0000071C'] = { txt = 'Cynix', r=0,g=180,b=255, y=1820 },
        ['00000730'] = { txt = 'Dedicated Teacher', r=0,g=180,b=255, y=1840 },
        ['00000744'] = { txt = 'Deluge', r=0,g=180,b=255, y=1860 },
        ['00000758'] = { txt = 'Denelson83', r=0,g=180,b=255, y=1880 },
        ['0000076C'] = { txt = 'Emily Esposito', r=0,g=180,b=255, y=1900 },
        ['00000780'] = { txt = 'FlamingText.com', r=0,g=180,b=255, y=1920 },
        ['00000794'] = { txt = 'Frankes', r=0,g=180,b=255, y=1940 },
        ['000007A8'] = { txt = 'GDJ', r=0,g=180,b=255, y=1960 },
        ['000007BC'] = { txt = 'GR-Sites', r=0,g=180,b=255, y=1980 },
        ['000007D0'] = { txt = 'GameJolt', r=0,g=180,b=255, y=2000 },
        ['000007E4'] = { txt = 'Holly', r=0,g=180,b=255, y=2020 },
        ['000007F8'] = { txt = 'J4p4n', r=0,g=180,b=255, y=2040 },
        ['0000080C'] = { txt = 'Jason Schrepel', r=0,g=180,b=255, y=2060 },
        ['00000820'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=2080 },
        ['00000834'] = { txt = 'Kelly', r=0,g=180,b=255, y=2100 },
        ['00000848'] = { txt = 'Kipp', r=0,g=180,b=255, y=2120 },
        ['0000085C'] = { txt = 'Lazur URH', r=0,g=180,b=255, y=2140 },
        ['00000870'] = { txt = 'Linda James', r=0,g=180,b=255, y=2160 },
        ['00000884'] = { txt = 'Lindsey', r=0,g=180,b=255, y=2180 },
        ['00000898'] = { txt = 'Majkel', r=0,g=180,b=255, y=2200 },
        ['000008AC'] = { txt = 'Man of Steel', r=0,g=180,b=255, y=2220 },
        ['000008C0'] = { txt = 'Megan', r=0,g=180,b=255, y=2240 },
        ['000008D4'] = { txt = 'Merlin2525', r=0,g=180,b=255, y=2260 },
        ['000008E8'] = { txt = 'Michal Franc', r=0,g=180,b=255, y=2280 },
        ['000008FC'] = { txt = 'Mohammed Ibrahim', r=0,g=180,b=255, y=2300 },
        ['00000910'] = { txt = 'Moini', r=0,g=180,b=255, y=2320 },
        ['00000924'] = { txt = 'NASA', r=0,g=180,b=255, y=2340 },
        ['00000938'] = { txt = 'OpenClips', r=0,g=180,b=255, y=2360 },
        ['0000094C'] = { txt = 'Palimsest', r=0,g=180,b=255, y=2380 },
        ['00000960'] = { txt = 'Skurian25', r=0,g=180,b=255, y=2400 },
        ['00000974'] = { txt = 'Snifty', r=0,g=180,b=255, y=2420 },
        ['00000988'] = { txt = 'TheSkull', r=0,g=180,b=255, y=2440 },
        ['0000099C'] = { txt = 'Tibetan_Fox', r=0,g=180,b=255, y=2460 },
        ['000009B0'] = { txt = 'Unknown Artist', r=0,g=180,b=255, y=2480 },
        ['000009C4'] = { txt = 'Vicious_Speed', r=0,g=180,b=255, y=2500 },
        ['000009D8'] = { txt = 'Vickie', r=0,g=180,b=255, y=2520 },
        ['000009EC'] = { txt = 'YADOT', r=0,g=180,b=255, y=2540 },
        ['00000A00'] = { txt = 'barnheartowl', r=0,g=180,b=255, y=2560 },
        ['00000A14'] = { txt = 'bedpenner', r=0,g=180,b=255, y=2580 },
        ['00000A28'] = { txt = 'burnurb', r=0,g=180,b=255, y=2600 },
        ['00000A3C'] = { txt = 'cgbug', r=0,g=180,b=255, y=2620 },
        ['00000A50'] = { txt = 'eady', r=0,g=180,b=255, y=2640 },
        ['00000A64'] = { txt = 'finao123', r=0,g=180,b=255, y=2660 },
        ['00000A78'] = { txt = 'foofurple', r=0,g=180,b=255, y=2680 },
        ['00000A8C'] = { txt = 'glitch', r=0,g=180,b=255, y=2700 },
        ['00000AA0'] = { txt = 'hatalar205', r=0,g=180,b=255, y=2720 },
        ['00000AB4'] = { txt = 'jonata', r=0,g=180,b=255, y=2740 },
        ['00000AC8'] = { txt = 'jpd2010', r=0,g=180,b=255, y=2760 },
        ['00000ADC'] = { txt = 'jphandrigan', r=0,g=180,b=255, y=2780 },
        ['00000AF0'] = { txt = 'kg', r=0,g=180,b=255, y=2800 },
        ['00000B04'] = { txt = 'pitr', r=0,g=180,b=255, y=2820 },
        ['00000B18'] = { txt = 'qubodub', r=0,g=180,b=255, y=2840 },
        ['00000B2C'] = { txt = 'tzunghaor', r=0,g=180,b=255, y=2860 },
        ['00000B40'] = { txt = 'wallpaperpal.com', r=0,g=180,b=255, y=2880 },
        ['00000B54'] = { txt = 'warszawianka', r=0,g=180,b=255, y=2900 },
        ['00000B7C'] = { txt = 'Map Design', r=255,g=0,b=0, y=2940 }, -- Map Design
        ['00000B90'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=2960 },
        ['00000BB8'] = { txt = 'Music', r=255,g=0,b=0, y=3000 }, -- Music
        ['00000BCC'] = { txt = 'Aaron Krogh', r=0,g=180,b=255, y=3020 },
        ['00000BE0'] = { txt = 'Alexander', r=0,g=180,b=255, y=3040 },
        ['00000BF4'] = { txt = 'Brian Boyko', r=0,g=180,b=255, y=3060 },
        ['00000C08'] = { txt = 'Eric Matyas', r=0,g=180,b=255, y=3080 },
        ['00000C1C'] = { txt = 'Fake Music Generator', r=0,g=180,b=255, y=3100 },
        ['00000C30'] = { txt = 'J.W.H. Broeders', r=0,g=180,b=255, y=3120 },
        ['00000C44'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=3140 },
        ['00000C58'] = { txt = 'Kevin McLeod', r=0,g=180,b=255, y=3160 },
        ['00000C6C'] = { txt = 'Knight Of Fire', r=0,g=180,b=255, y=3180 },
        ['00000C80'] = { txt = 'Lee Rosevere', r=0,g=180,b=255, y=3200 },
        ['00000C94'] = { txt = 'Matt McFarland', r=0,g=180,b=255, y=3220 },
        ['00000CA8'] = { txt = 'Rockit Maxx', r=0,g=180,b=255, y=3240 },
        ['00000CBC'] = { txt = 'SJ Mellia', r=0,g=180,b=255, y=3260 },
        ['00000CD0'] = { txt = 'Sergey Cheremisinov', r=0,g=180,b=255, y=3280 },
        ['00000CE4'] = { txt = 'Spiedkiks', r=0,g=180,b=255, y=3300 },
        ['00000CF8'] = { txt = 'Wan Kee Chan & Wouter Wershkull', r=0,g=180,b=255, y=3320 },
        ['00000D0C'] = { txt = 'WeirdoMusic', r=0,g=180,b=255, y=3340 },
        ['00000D20'] = { txt = 'Widzy', r=0,g=180,b=255, y=3360 },
        ['00000D34'] = { txt = 'Your Marginally Talented Photographer Girlfriend', r=0,g=180,b=255, y=3380 },
        ['00000D5C'] = { txt = 'Scenario', r=255,g=0,b=0, y=3420 }, -- Scenario
        ['00000D70'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=3440 },
        ['00000D98'] = { txt = 'Script', r=255,g=0,b=0, y=3480 }, -- Script
        ['00000DAC'] = { txt = 'Jeroen Broks', r=0,g=180,b=255, y=3500 },
        ['00000DD4'] = { txt = 'Testers', r=255,g=0,b=0, y=3540 }, -- Testers
        ['00000DE8'] = { txt = '1 Up-Nuke', r=0,g=180,b=255, y=3560 },
        ['00000DFC'] = { txt = 'DarkbloodBane', r=0,g=180,b=255, y=3580 },
        ['00000E10'] = { txt = 'FB Projecten', r=0,g=180,b=255, y=3600 },
        ['00000E24'] = { txt = 'Honno', r=0,g=180,b=255, y=3620 },
        ['0000107C'] = { txt = '(c) Copyright 2016', r=255, g=180,b=0,y=4220},
        ['00001095'] = { txt = 'Jeroen Petrus Broks', r=255, g=180,b=0,y=4245}
}

return ret
