var world;
window.addLoadEvent(function () {
  world = new WorldMorph(document.getElementById('world'));

  world.role = document.querySelector('#world').dataset.role;
  world.isDevMode = false;

  ide = new IDE_Morph();
  ide.openIn(world);

  if (document.querySelector('#world').dataset.file) {
    ide.openProjectString(window.getURL(document.querySelector('#world').dataset.file));
  };

  setInterval(function() {world.doOneCycle();}, 30);
});
