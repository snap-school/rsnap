var world;
window.addLoadEvent(function () {
  world = new WorldMorph(document.getElementById('world'));
  world.role = 1;//TODO chose the good one and make them more explicit with string instead of int
  //role: 0=>student 1=>teacher
  //world.isDevMode = true;
  ide = new IDE_Morph();

  ide.openProjectString(window.getURL(document.querySelector('#world').dataset.file));
  ide.openIn(world);

  setInterval(function() {world.doOneCycle();}, 1);
});
