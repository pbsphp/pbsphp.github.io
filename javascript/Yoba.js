/**
*
*/


function Yoba(params)
{

  /*
    Yoba constructor

    Initialize Yoba and render to canvas,
    call (new Yoba()) for create new Yoba
  */
  "use strict";


  // Default params, will be used if some params undefined
  var defaultParams = {
    radius:     40,
    speed:      Math.floor(Math.random() * 25 + 5),  // random: 5...30
    angle:      0
  };


  var getMass = function(R)
  {
    /*
      Calculate mass via radius
    */

    var ρ = 0.0001;
    return Math.floor((4.0 / 3.0) * Math.PI * R * R * R * ρ);
  };


  var getSkin = function()
  {
    /*
      Returns random skin from list
    */

    var path = "skins/",
        skins = [
          "1.png",
          "2.png",
          "3.png",
          "4.png"
        ];

    var randomIndex = Math.floor(Math.random() * skins.length);
    return path + skins[randomIndex];
  }


  var yobaImage = new Image();
  yobaImage.src = getSkin(); // "skins/1.png";


  // Rotate yoba
  YOBAS.push({
          src:        yobaImage,
          position:   params.position,
          radius:     params.radius || defaultParams.radius,
          speed:      params.speed  || defaultParams.speed,
          angle:                       defaultParams.angle,
          mass:       getMass(params.radius || defaultParams.radius),
          textDelay:  0,
          text:       ''
  });



  // Class methods

  Yoba.getSwearword = function()
  {
    /*
      Get random swearword from list
    */

    var swearwords = [
      "Sooqa",
      "Krysa",
      "LOL",
      "Tvoi mama ebal",
      "U tebya bugurt",
      "U vas popka prigorela",
      "Butthurt",
      "Lalka",
      "Sasai",
      "Pidor"
    ];

    var randomIndex = Math.floor(Math.random() * swearwords.length);
    return swearwords[randomIndex];
  }

}
