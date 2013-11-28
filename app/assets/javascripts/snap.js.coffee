world = null

window.onload = ->
  world = new WorldMorph(document.getElementById('world'))
  world.isDevMode = false
  world.role = 1
  new IDE_Morph().openIn(world)
  setInterval(loopAction, 1)
  return

loopAction = ->
  world.doOneCycle()
  return
