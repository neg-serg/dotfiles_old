-- package.path = "/usr/share/lua/5.1//?.lua;/usr/share/lua/5.1//?/init.lua;"..package.path
-- require 'luarocks.loader'

function map(func, array)
   local res = {}
   for i, v in ipairs(array) do
      res[i] = func(v)
   end
   return(res)
end

function filter(func, array)
   local res = {}
   local j = 1
   for i, v in ipairs(array) do
      if func(v) then
         res[j] = v
         j = j+1
      end
   end
   return res
end

local function is_array(t)
   local numKeys = 0
   for _, _ in pairs(t) do
      numKeys = numKeys + 1
   end
   local numIndices = 0
   for _, _ in ipairs(t) do
      numIndices = numIndices + 1
   end

   return numKeys == numIndices
end

function format(obj)
   if type(obj) == "table" then
      return format_table(obj)
   elseif type(obj) == "string" then
      return string.format("%q", obj:gsub("\n", "\\n"))
   else
      return ("" .. obj)
   end
end




function format_table_helper(table, format_element_fn)
   local res = "{"
   local n = 0

   for i, v in pairs(table) do
      n = n + 1
      local del = ', '
      res = res .. format_element_fn(i, v) .. del
   end
   if n > 0 then
      res = string.sub(res, 1, string.len(res) - 2)
   end
   res = res .. '}'
   return res
end

function format_table(table)
   local function format_array_el(k, v)
      return format(v)
   end
   local function format_dict_el(k, v)
      return format(k) .. "=" .. format(v)
   end
   if is_array(table) then
      return format_table_helper(table, format_array_el)
   else
      return format_table_helper(table, format_dict_el)
   end
end


function pprint(array)
   print(format(array))
end

function prefix_matches(str, completions)
   local function match(comp)
      return (string.find(comp:lower(), string.lower(str..".*"))) == 1
   end
   return filter(match, completions)
end

function whole_matches(str, completions)
   local function match(comp)
      return string.find(comp:lower(), str:lower()) ~= nil
   end
   return filter(match, completions)
end

function only_fuzzy_matches(str, completions)
   local function make_pattern(str)
      local pat = ".*"
      for i = 1, #str do
         local c = str:sub(i,i)
         pat = pat .. c .. ".*"
      end
      return pat
   end
   local function match(comp)
      local pat = make_pattern(str)
      return string.find(comp:lower(), pat:lower()) ~= nil
   end
   return filter(match, completions)
end

function fuzzy_matches(str, completions)
   local matches = prefix_matches(str, completions)
   if next(matches) == nil  then
      matches = whole_matches(str, completions)
   end
   if next(matches) == nil then
      matches = only_fuzzy_matches(str, completions)
   end
   return matches
end


-- function mod_query.fuzzy_complete_name(str, iter)
--    local entries = {}
--    local function add_entry(entry)
--       table.insert(entries, entry)
--    end
-- end

function mod_query.fuzzy_complete_name(str, iter)
   comps = {}
   iter(function(reg)
           table.insert(comps, reg:name())
           return true
        end)
   return fuzzy_matches(str, comps)
end

function mod_query.fuzzy_complete_clientwin(str)
   return mod_query.fuzzy_complete_name(str, ioncore.clientwin_i)
end

function mod_query.query_fuzzy_gotoclient(mplex)
    mod_query.query(mplex, TR("Go to window:"), nil,
                    mod_query.gotoclient_handler,
                    mod_query.make_completor(mod_query.fuzzy_complete_clientwin),
                    "windowname")
end
