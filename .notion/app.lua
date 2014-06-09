app={}
function app.match_class(class, instance)
   -- Return matching client windows as a table.
   -- If the current window is among them, it's placed last on the list
   -- and its successor at the beginning of the list. This facilitates
   -- cycling multiple windows of an application.
   local result = {}
   local offset = 0
   local currwin = ioncore.current()
   ioncore.clientwin_i(function (win)
      if class == win:get_ident().class then
        if instance then
            if instance == win:get_ident().instance then
                table.insert(result, table.getn(result)-offset+1, win)
            end
        else
            table.insert(result, table.getn(result)-offset+1, win)
        end
      end
      if win == currwin then
	 -- Current client window found, continue filling the table from
	 -- the beginning.
	 offset = table.getn(result)
      end
      return true
   end)

   return result
end

function app.byname(prog, name, where)
   local win = ioncore.lookup_clientwin(name)
   if win then
      ioncore.defer(function () win:goto() end)
   else
      if where then
	  ioncore.exec_on(where, prog)
      else
	  ioncore.exec(prog)
      end
   end
end

function app.byclass(prog, class, where)
   local win = app.match_class(class)[1]
   if win then
      ioncore.defer(function () win:goto() end)
   else
      if where then
	  ioncore.exec_on(where, prog)
      else
	  ioncore.exec(prog)
      end
   end
end

function app.byinstance(prog, class, instance, where)
   local win = app.match_class(class, instance)[1]
   if win then
      ioncore.defer(function () win:goto() end)
   else
      if where then
	  ioncore.exec_on(where, prog)
      else
	  ioncore.exec(prog)
      end
   end
end

function app.emacs_eval(expr)
   local emacswin = app.match_class("Emacs")[1]
   if emacswin then
      ioncore.exec("gnuclient -batch -eval '"..expr.."'")
      ioncore.defer(function () emacswin:goto() end)
   else
      ioncore.exec("emacs -eval '"..expr.."'")
   end
end

function app.query_editfile(mplex, dir) 
   local function handler(file)
      app.emacs_eval("(find-file \""..file.."\")")
   end

    mod_query.do_query(mplex,
        'Edit file:',
        dir or mod_query.get_initdir(),
        handler,
        mod_query.file_completor)
end

moveapp={}

function moveapp.byclass(ws, class)
   local win = app.match_class(class)[1]
   if win then
       local frame = ws:current()
       frame:attach(win, { switchto = true })
       win:goto()
   end
end
