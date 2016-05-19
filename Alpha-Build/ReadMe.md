### NOTE

Due to the Alpha Build getting to big for this github repository to contain, I have no choice but to remove it.
This shall happen in June 2016
After that the Alpha version shall only be available through request. This because of the current stage of the game in which an open alpha is no longer desirable anyway.

# Alpha Build

In this part of the repository the alpha versions for both Mac and Windows will be kept up-to-date on a regular basis. Please note that the game was created on a Mac and thefore the Mac Executable may predate the Windows executables. The assests and scripts are always the same in both versions. A few bugs in the Windows version may therefore come to life due to a few version conflicts, though I'll try to keep the Windows executables up-to-date.


In order to download, update and play the alpha versions you first need the command line version of git and you need version 1.7.0 or higher at least as a feature was used that does not work on any earlier versions. 
If you don't have git, make sure you obtain it :)


### How to do it?
Windows users should download the AlphaStar.bat file in this directory and running this batch file will automatically install Star Story and run it, or in case you already have it automatically update it to the latest version and then run it.
Mac users should download the AlphaStar.sh file in this directory and basically it does everything the AlphaStar.bat file does, but then on Mac. 

Don't worry about compiling and stuff. This has already been done for before you could even get downloading. ;)


### A short tutorial for people unfamiliar with DOS/Unix prompts
If you know how that stuff works, skip this part, but if you don't know then follow this.

###### Windows
Download and save the AlphaStar.bat file to C:\Users\\_username_\AlphaStar
Open the prompt and type the next commands
- cd C:\Users\\_username_\AlphaStar
- AlphaStar

That should do it for you. Of course, substitute _username_ with your system username :)

###### Mac
Download and save the AlphaStar.sh file to /Users/_username_/AlphaStar
Open the terminal, you can find it in your applications folder in the subfolder "utilities"
In the console type the next commands
- cd ~/AlphaStar
- ./AlphaStar.sh


Well, that should do it. Any questions?


### Alternate method
Unfortunately I had to remove the alpha builds on my DropBox account. My Dropbox max size was close to its limits and I couldn't afford to pay for more space.
If you really think I should make an alternate download for the alpha version available, write a ticket on the issue tracker and I shall see what I can do, however I cannot promise anything!!!



### Character viewer
I have a handy utility available that can scan a savegame for all relevant character data. It only dumps data directely related to characters, it cannot analyse anything any game data other than that (because the the character framework is set up to work with multiple engines and this util's focus was to support them all).
My main focus was to make this utility help me balance the enemies I set up well, however it can also help to locate certain bugs on certain data. You can screenshot its results if you found anything suspicious, you can also use its dump save feature and send the produced dump file to me.

Oh yeah, you need to know where the savegames themselves are dumped if you use this utility:

- For Mac that's in: /Users/_username_/Library/Application Support/Phantasar Productions/LAURA2/Star Story/Saved Games
- For Windows that's in: C:\\users\\_username_\\AppData\\Roaming\\Phantasar Productions\\LAURA2\\Star Story\\Saved Games

Download:

- [Download the utility for Mac](https://www.dropbox.com/s/y9l6eabwu122dwr/RPGCharViewer_Mac.dmg?dl=0)
- [Download the utility for Windows](https://www.dropbox.com/s/rl19d6gpqixexw4/RPGCharViewer_Windows.7z?dl=0)
- [Download the source code](https://www.dropbox.com/s/v96gv1rzfcl69wf/RPGCharViewer_Source.7z?dl=0) 

(If you download the source code, you will need [My BlitzMax Modules](https://github.com/Tricky1975/TrickyMod) and Brucey's Volumes module in order to get the code compiled. 
The code of the modules is mostly either licenced under the zlib license or the MPL, the utility itself is licensed under the GNU/GPL).



### Reporting bugs and issues

Reporting bugs and issues can be doing through the issue tracker in this repository however a few things to keep in mind

- It goes without saying, but you are about to play a game that is not finished. Parts will be missing, some dungeons cannot yet be completed. Some spells may not yet be animated, and so on. If you report something please make sure that it's something I didn't think of, or something I don't know, as it's not productive to report stuff that solely isn't there because I did not yet develop that part.
- ALWAYS make sure you have the latest version before you report something. You should be sure the issue isn't already taken care of :)
- Be as detailed as you can in your bug reports. Screenshots can help. I need to replecate the bug before I can fix it, after all :)
- The GameJolt API has been disabled in this ALPHA version for security reasons. It will of course be there in the official releases.
- Make sure you mention if you are on Windows or Mac. Most issues should be the same on both platforms (the game is for most part written in Lua after all), but sometimes things appear to be OS specific even when it doesn't appear to be that way at first.
- Please check if you report an issue if it wasn't reported before
- Any comments, suggestions, bug reports or anything else related to the alpha builds should be in this issue tracker and not in SourceForge reviews or GameJolt comments or anywhere else where a page on this game pops up.
- Also please don't spoil the story line to people awaiting the official release
- Last but not least. I hope you have fun helping me out. If you want I can credit you as an Alpha tester in the credits. Just let me know how you wish to be credited. :)


