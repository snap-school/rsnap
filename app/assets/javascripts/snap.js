var world;
window.addLoadEvent(function () {
  world = new WorldMorph(document.getElementById('world'));
  ide = new IDE_Morph();
  ide.openIn(world);
  ide.openProjectString(window.getURL(document.querySelector('#world').dataset.file));

  setInterval(function() {world.doOneCycle();}, 1);
});
