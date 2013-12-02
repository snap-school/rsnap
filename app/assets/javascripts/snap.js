var world;
window.onload = function () {
  world = new WorldMorph(document.getElementById('world'));
  var ide = new IDE_Morph();
  ide.openIn(world);
  ide.serializer.openProject(
    ide.serializer.loadProjectModel(
      ide.serializer.parse(
        getURL('https://dl.dropboxusercontent.com/1/view/v05hil4cm86x0vw/Applications/rsnap-dev/chatv1.xml')))
    , ide
  );
  setInterval(loop, 1);
};

function loop() {
  world.doOneCycle();
};

function getURL(url) {
  try {
      var request = new XMLHttpRequest();
      request.open('GET', url, false);
      request.send();
      if (request.status === 200) {
          return request.responseText;
      }
      throw new Error('unable to retrieve ' + url);
  } catch (err) {
      return;
  }
}
