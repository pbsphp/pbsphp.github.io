// Generated by CoffeeScript 1.4.0
var Yoba;

Yoba = (function() {
  var allYobas, getMass, getRandomFrom, getSkin, registerYoba;

  function Yoba(params) {
    var defaultRadius, defaultSpeed, yobaImage;
    yobaImage = new Image();
    yobaImage.src = getSkin();
    defaultRadius = 40;
    defaultSpeed = function() {
      return ~~(Math.random() * 25 + 5);
    };
    this.src = yobaImage;
    this.position = params.position;
    this.radius = params.radius || defaultRadius;
    this.speed = params.speed || defaultSpeed();
    this.mass = getMass(params.radius || defaultRadius);
    this.angle = 0;
    this.textDelay = 0;
    this.text = '';
    registerYoba(this);
  }

  registerYoba = function(self) {
    return allYobas.push(self);
  };

  getMass = function(R) {
    var p;
    p = 0.0001;
    return ~~((4 / 3) * Math.PI * R * R * R * p);
  };

  getRandomFrom = function(array) {
    return array[~~(Math.random() * array.length)];
  };

  getSkin = function() {
    var path, skins;
    path = "skins/";
    skins = ["1.png", "2.png", "3.png", "4.png", "5.png"];
    return path + getRandomFrom(skins);
  };

  Yoba.prototype.redraw = function() {
    return canvas.drawYoba({
      radius: this.radius,
      angle: this.angle,
      src: this.src,
      position: this.position
    });
  };

  Yoba.prototype.startSpeek = function() {
    this.textDelay = 10;
    return this.text = Yoba.getSwearword();
  };

  Yoba.prototype.continueSpeek = function() {
    if (this.textDelay > 0) {
      --this.textDelay;
      return canvas.showTextAt(this.text, this.position, 10);
    }
  };

  Yoba.prototype.rightPoint = function() {
    return this.position + this.radius + this.speed;
  };

  Yoba.prototype.leftPoint = function() {
    return this.position - this.radius + this.speed;
  };

  Yoba.prototype.atRightBorder = function() {
    return this.rightPoint() >= canvas.width && this.speed > 0;
  };

  Yoba.prototype.atLeftBorder = function() {
    return this.leftPoint() <= 0 && this.speed < 0;
  };

  Yoba.prototype.getBumpedYoba = function() {
    var anotherYoba, currentYoba, oL, oR, yL, yR, _i, _len, _ref;
    currentYoba = this;
    _ref = Yoba.getAllYobas();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      anotherYoba = _ref[_i];
      if (!(anotherYoba !== currentYoba)) {
        continue;
      }
      oR = anotherYoba.rightPoint();
      oL = anotherYoba.leftPoint();
      yR = currentYoba.rightPoint();
      yL = currentYoba.leftPoint();
      if ((oL <= yR && yR <= oR) || (oL <= yL && yL <= oR)) {
        return anotherYoba;
      }
    }
    return null;
  };

  allYobas = [];

  Yoba.getAllYobas = function() {
    return allYobas;
  };

  Yoba.removeYobas = function() {
    return allYobas = [];
  };

  Yoba.getSwearword = function() {
    var swearwords;
    swearwords = ["Sooqa", "Krysa", "LOL", "Tvoi mama ebal", "U tebya bugurt", "U vas popka prigorela", "Butthurt", "Lalka", "Sasai", "Pidor"];
    return getRandomFrom(swearwords);
  };

  Yoba.stopScriptIfAllStopped = function() {
    var allYobasStopped, y, _i, _len, _ref;
    allYobasStopped = true;
    _ref = Yoba.getAllYobas();
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      y = _ref[_i];
      if (~~y.speed !== 0) {
        allYobasStopped = false;
        break;
      }
    }
    if (allYobasStopped) {
      Handler.stop();
      return setTimeout(canvas.showSasai, 1000);
    }
  };

  return Yoba;

})();
