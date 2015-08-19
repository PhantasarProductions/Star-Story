# WHAT THE F**** IS WRONG WITH ZIGGO!

Another temp worklog, as long as Ziggo is down.


- FIXED: Infinite loop in "FallDown" effect is fixed
- FIXED: Speed issue in "Falldown" effect is fixed
- FIXED: Foe reset ignore bug fixed (won't affect older savegames untill new dungeon is loaded, once that's done, the reset will work)
- FIXED: Several Foe/Player detection errors (leading to crashes) fixed.
- ISSUE: Put on an 'ignore internet' feature for loadgame.
- FIXED: Field encounters always had an empty battle. That is now fixed
- BUG: Returning to field music always comes to a claim about a nil value. The routines the nil value is extracted from is not able to produce such a value so this is a bit odd.
- BUG: Stuff loaded by the map during a loadgame is suddenly classed "not loaded". Some variables are also not working the way they should from loadgame. 
- ENHANCEMENT: LAURA II now supports skipping GameJolt login regardless of settings. I only need to adapt the launcher for this setup.
- FIXED: The two bugs above came forth due to a misformulated boolean expression causing all system vars to get deleted. Well this is fixed.
- TO DO: Balance Briggs more properly with the girls. The game is not fun this way, and even though Briggs is a guest, the opening dungeon is the most important one.





