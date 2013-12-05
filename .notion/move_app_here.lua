dopath("app")

moveapp={}

function moveapp.byclass(ws, class)
   local win = app.match_class(class)[1]
   if win then
       local frame = ws:current()
       frame:attach(win, { switchto = true })
       win:goto()
   end
end
