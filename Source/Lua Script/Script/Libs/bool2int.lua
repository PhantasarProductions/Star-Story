--[[
***********************************************************
bool2int.lua
This particular file has been released in the public domain
and is therefore free of any restriction. You are allowed
to credit me as the original author, but this is not 
required.
This file was setup/modified in: 
2015
If the law of your country does not support the concept
of a product being released in the public domain, while
the original author is still alive, or if his death was
not longer than 70 years ago, you can deem this file
"(c) Jeroen Broks - licensed under the CC0 License",
with basically comes down to the same lack of
restriction the public domain offers. (YAY!)
*********************************************************** 
Version 15.10.04
]]
--[[
/*


   The file you are currently accessing is a file released in the public
   domain, meaning you can freely alter it distribute it without any means of
   restriction whatsoever, and the only thing you cannot do is claim ownsership
   on it.
   
   Please note, Public Domain means no restriction at all, you may mention me
   (Jeroen Broks) as the original programmer, but you don't have to (if you
   find anything on the internet claiming to be public domain forcing you to
   name the source you obtained it from, then it simply ain't public domain,
   meaning the one who told you so is lying about its license type).
   
   Please note, that should any file in the public domain be a clear referrence
   to a real person (either dead or alive) the restrictionless status of the
   public domain gets a restriction as you may not give out references to 
   real people out without that person's permission (which is not a copyright
   issue), and that is one of the many examples that could void the freedom
   of public domain. The file must fulfill the rules of other laws. I guess
   that was pretty obvious.
   
   This file is released "AS IS", meaning that the creator of this file 
   dislaims any form of warranty, without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
   
   In other words, you're using this file at your own risk.
   
*/
   


Version: 15.02.16

]]
function bool2int(boolexpression)
if boolexpression then return 1 else return 0 end
end
