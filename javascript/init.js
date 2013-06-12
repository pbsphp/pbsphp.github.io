/**
*
*/


function drawYobas()
{
  /*
    Initialize canvas, screen, Yobas, render Yobas
  */
  "use strict";

  // Initialize canvas
  canvasElement = document.getElementById("yoba_track");
  ctx = canvasElement.getContext("2d");

  // Create Yobas
  new Yoba({ radius: 50, position: 950 });
  new Yoba({ radius: 40, position: 400 });
  new Yoba({ radius: 60, position: 100 });


  // Rotate and Yobas, render every 60ms
  // Remember script interval ID to destroy script when all Yobas stops
  scriptIntervalID = setInterval(moveYobas, 60);

}
