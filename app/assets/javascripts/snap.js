var world;
window.addLoadEvent(function () {
  world = new WorldMorph(document.getElementById('world'));

  var ds = document.querySelector('#world').dataset;

  world.role = ds.role;
  world.isDevMode = false;

  ide = new IDE_Morph();
  ide.openIn(world);

  setTimeout(function(){if (ds.file) {
    ide.openProjectString(window.getURL(ds.file));
  };

  setInterval(function() {world.doOneCycle();}, 30);}, 400)

});
