/**
*
*/


// TODO: Make it class-methods of Yoba (?)

/* Initialize canvas */
var canvasElement = null;
var ctx = null;

/* Script interval ID */
var scriptIntervalID = null;


/* Array of YOBAS */
var YOBAS = [];


function moveYobas()
{

  /*
    Rotate and move all Yobas
  */
  "use strict";


  var π = Math.PI;  // Math.PI alias

  // Clear screen before render
  ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);

  // Calculate speed, position and direction for each Yoba
  for(var yobaIndex = 0; yobaIndex < YOBAS.length; ++yobaIndex) {
    var y = YOBAS[yobaIndex];

    // Aliases

    var X0 = y.position - y.radius, // TODO: what if params.position < R?
        Y0 = canvasElement.height - 2 * y.radius,
        R  = y.radius,
        ΔS = y.speed,
        M  = y.mass;


    // If Yoba has come to the edge

    if(y.position + R + ΔS >= canvasElement.width && ΔS > 0)
      ΔS = - Math.abs(ΔS);
                              // Right border - move left
    else if(y.position - R + ΔS <= 0 && ΔS < 0)
      ΔS = + Math.abs(ΔS);
                              // Left border - move right


    // Check to other Yobas on the way

    var bumpedYobaIndex = -1;
                        // The index of a nearby Yoba, which will be bumped

    // Check positions of each Yoba
    for(var i = 0; i < YOBAS.length; ++i) {
      if(i != yobaIndex) { // Not check self
        var oR = YOBAS[i].position + YOBAS[i].radius + YOBAS[i].speed,
            oL = YOBAS[i].position - YOBAS[i].radius + YOBAS[i].speed,
            yR = y.position + R + ΔS,
            yL = y.position - R + ΔS;

        // If there will be a collision
        // if(yR >= oL && yR <= oR || yR <= oR && yR >= oL)
        if(yR >= oL && yR <= oR || yL <= oR && yL >= oL)
          bumpedYobaIndex = i;
                            // Remember that Yoba's index
      }
    }


    if(bumpedYobaIndex != -1) { // If there will be a collision

      // Calculate speeds after bump

      var m1 = y.mass,
          m2 = YOBAS[bumpedYobaIndex].mass,
          v1 = y.speed,
          v2 = YOBAS[bumpedYobaIndex].speed;

      // p01 + p02 = p1 + p2
      var v11 = ((m1 - m2) * v1 + 2 * m2 * v2) /
                    (m1 + m2),

          v21 = (2 * m1 * v1 + (m2 - m1) * v2) /
                    (m1 + m2);

      ΔS = v11;
      YOBAS[bumpedYobaIndex].speed = v21;

      // Yoba says:
      y.textDelay = 10;
      y.text = Yoba.getSwearword();
      YOBAS[bumpedYobaIndex].textDelay = 10;
      y.text = Yoba.getSwearword();
    }


    // Yoba says: // TODO: -> function

    if(y.textDelay > 0) {
      --y.textDelay;
      ctx.fillText(y.text, y.position, 10);
    }


    // Calculate the force of rolling friction and speed

    var f = 0.3,
        N = 9.8 * M;    // F = mg

    var a = (N * (f / R)) / R;    // TODO: radius not needed?


    // What the fuck? Rewrite this shit!
    ΔS -= (ΔS > 0) ? a : -a;


    // Calculate angle and angle increment

    var Δφ = 2 * π + (Math.round(ΔS) / R);
    var φ = y.angle + Δφ;


    // Rotate and draw Yoba

    ctx.save();
    ctx.translate(X0 + Math.round(ΔS), Y0);

    ctx.translate(R, R);
    ctx.rotate(φ);
    ctx.drawImage(y.src, -R, -R, 2 * R, 2 * R);

    ctx.restore();

    // Remember calculated variables

    y.angle = φ % (4 * π);
    y.position += Math.round(ΔS);
                              // Attention! position MUST be integer
    y.speed = ΔS;
                              // Speed can be float
  }


  // TODO: Stick this code in a function

  // If all Yobas stopped spining, stop script
  var allYobasStopped = true;
  for(i = 0; i < YOBAS.length; ++i) {
    if(Math.floor(Math.abs(YOBAS[i].speed)) != 0) {
      allYobasStopped = false;
      break;
    }
  }

  // If all Yobas stops
  if(allYobasStopped) {
    // Stop render Yobas
    clearInterval(scriptIntervalID);
    setTimeout(function() {
      ctx.font = 'italic 40pt Calibri';
      ctx.shadowColor = 'orange';
      ctx.shadowOffsetX = 3;
      ctx.shadowOffsetY = 3;
      ctx.fillText('SASAI LOLKA', Math.floor(canvasElement.width * 0.30), 100);
    }, 1000);
  }

}
