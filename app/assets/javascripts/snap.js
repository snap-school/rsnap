var world;
window.addLoadEvent(function () {
  world = new WorldMorph(document.getElementById('world'));

  world.role = document.querySelector('#world').dataset.role;
  //role: 0=>student 1=>teacher
  //world.isDevMode = true;
  ide = new IDE_Morph();

  if (document.querySelector('#world').dataset.file) {
    ide.openProjectString(window.getURL(document.querySelector('#world').dataset.file));
  };
  ide.openIn(world);

  setInterval(function() {world.doOneCycle();}, 1);
});
