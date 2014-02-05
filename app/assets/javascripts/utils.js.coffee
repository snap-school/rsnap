addLoadEvent = (func) ->
  oldonload = window.onload
  unless typeof window.onload is "function"
    window.onload = func
  else
    window.onload = ->
      oldonload()  if oldonload
      func()
      return
  return
window.addLoadEvent = addLoadEvent;
