var world;
window.addLoadEvent(function () {
  world = new WorldMorph(document.getElementById('world'));
  world.role = 1;//TODO chose the good one and make them more explicit with string instead of int
  //world.isDevMode = true;
  ide = new IDE_Morph();
  ide.openIn(world);
  ide.openProjectString(window.getURL(document.querySelector('#world').dataset.file));

  setInterval(function() {world.doOneCycle();}, 1);
});
