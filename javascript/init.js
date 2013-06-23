// Generated by CoffeeScript 1.3.3
var drawYobas;

drawYobas = function() {
  if (Yoba.scriptIntervalID) {
    clearInterval(Yoba.scriptIntervalID);
  }
  Yoba.removeYobas();
  if (!canvas.isInitialized()) {
    canvas.initialize(document.getElementById("yoba_track"));
  } else {
    canvas.clear();
  }
  new Yoba({
    radius: 50,
    position: 950
  });
  new Yoba({
    radius: 40,
    position: 400
  });
  new Yoba({
    radius: 60,
    position: 100
  });
  return Yoba.scriptIntervalID = setInterval(mainHandler, 60);
};
