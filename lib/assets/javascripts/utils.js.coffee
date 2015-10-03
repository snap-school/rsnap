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
window.addLoadEvent = addLoadEvent

getURL = (url, async=false) ->
  try
    request = new XMLHttpRequest()
    request.open "GET", url, async
    request.send()
    return request.responseText  if request.status is 200
    throw new Error("unable to retrieve " + url)
  catch err
    return err
window.getURL = getURL


getAsset = (name) ->
  if typeof window.assetsUrl == 'undefined'
    window.assetsUrl = JSON.parse(getURL("/snap_assets.json"))
  return window.assetsUrl[name]
window.getAsset = getAsset
