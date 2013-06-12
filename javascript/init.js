/**
*
*/


function drawYobas()
{
  /*
    Initialize canvas, screen, Yobas, render Yobas
  */
  "use strict";


  // Clear variables after last using

  // Stop drawing Yobas
  if(scriptIntervalID)
    clearInterval(scriptIntervalID);

  YOBAS = [];


  // Initialize canvas
  canvasElement = canvasElement || document.getElementById("yoba_track");
  ctx           = ctx           || canvasElement.getContext("2d");

  // Clear after last using
  ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);


  // Create Yobas
  new Yoba({ radius: 50, position: 950 });
  new Yoba({ radius: 40, position: 400 });
  new Yoba({ radius: 60, position: 100 });


  // Rotate and Yobas, render every 60ms
  // Remember script interval ID to destroy script when all Yobas stops
  scriptIntervalID = setInterval(moveYobas, 60);

}
