function valstr(a)
return ({
   ['nil'] = function(a) return 'nil' end,
   ['number'] = function(a) return ''..a end,
   ['string'] = function(a) return a end,
   ['boolean'] = function(a) return ({[true]='true', [false]='false'})[a] end,
   ['function'] = function(a) Sys.Error("valstr does not support functions") end,
   ['table'] = function(a) Sys.Error('Valstr does not support tables') end})[type(a)](a)
end

strval = valstr