

------


--[[
      This function will help you to easily create switch statement.
      Parameter #1 is to variable to check, the second variable should be a table where all indexes or keys should be the values to check and the values the functions containing the stuff to do
      Parameter #3 and later can just be used to add some paramters to the functions (which will be received as an array).      
      key "default" can be used if no value is given, though this system has been desigend to make that optional
]]
function switch(v,functab,...)
(functab[v or 'default'] or function(...) end)(arg)
end