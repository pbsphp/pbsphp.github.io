// Generated by CoffeeScript 1.3.3
var handler;

handler = {
  scriptIntervalID: null,
  delay: 60,
  initialize: function(id) {
    return handler.scriptIntervalID = id;
  },
  stop: function() {
    if (handler.scriptIntervalID) {
      return clearInterval(handler.scriptIntervalID);
    }
  },
  start: function() {
    return handler.scriptIntervalID = setInterval(handler.main, handler.delay);
  },
  main: function() {
    var HEIGHT, R, WIDTH, X0, Y0, allYobasStopped, bumpedYoba, dFi, dS, fi, i, m1, m2, oL, oR, scriptIntervalID, speeds, v1, v2, y, yL, yR, yb, yobaIndex, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2;
    scriptIntervalID = Yoba.scriptIntervalID;
    WIDTH = canvas.width;
    HEIGHT = canvas.height;
    canvas.clear();
    _ref = Yoba.getAllYobas();
    for (yobaIndex = _i = 0, _len = _ref.length; _i < _len; yobaIndex = ++_i) {
      y = _ref[yobaIndex];
      X0 = y.position - y.radius;
      Y0 = HEIGHT - 2 * y.radius;
      R = y.radius;
      dS = y.speed;
      if (y.position + R + dS >= WIDTH && dS > 0) {
        dS = -Math.abs(dS);
      } else if (y.position - R + dS <= 0 && dS < 0) {
        dS = +Math.abs(dS);
      }
      bumpedYoba = null;
      _ref1 = Yoba.getAllYobas();
      for (i = _j = 0, _len1 = _ref1.length; _j < _len1; i = ++_j) {
        yb = _ref1[i];
        if (yobaIndex !== i) {
          oR = yb.position + yb.radius + yb.speed;
          oL = yb.position - yb.radius + yb.speed;
          yR = y.position + R + dS;
          yL = y.position - R + dS;
          if ((oL <= yR && yR <= oR) || (oL <= yL && yL <= oR)) {
            bumpedYoba = yb;
          }
        }
      }
      if (bumpedYoba) {
        m1 = y.mass;
        m2 = bumpedYoba.mass;
        v1 = y.speed;
        v2 = bumpedYoba.speed;
        speeds = handler.getSpeedsAfterBump(m1, v1, m2, v2);
        dS = speeds[0];
        bumpedYoba.speed = speeds[1];
        y.startSpeek();
        bumpedYoba.startSpeek();
      }
      y.continueSpeek();
      dS -= handler.getFrictionalAcceleration(y.radius, y.mass, dS);
      dFi = Math.round(dS) / R;
      fi = y.angle + dFi;
      y.angle = handler.getNewAngle(y.angle, R, dS);
      y.position += Math.round(dS);
      y.speed = dS;
      y.redraw();
    }
    allYobasStopped = true;
    _ref2 = Yoba.getAllYobas();
    for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
      yb = _ref2[_k];
      if (~~(Math.abs(yb.speed)) !== 0) {
        allYobasStopped = false;
        break;
      }
    }
    if (allYobasStopped) {
      return Yoba.stopScript();
    }
  },
  getSpeedsAfterBump: function(m1, v1, m2, v2) {
    return [((m1 - m2) * v1 + 2 * m2 * v2) / (m1 + m2), (2 * m1 * v1 + (m2 - m1) * v2) / (m1 + m2)];
  },
  getFrictionalAcceleration: function(R, M, speed) {
    var N, a, f;
    f = 0.3;
    N = 9.8 * M;
    a = (N * (f / R)) / R;
    if (speed > 0) {
      return a;
    } else {
      return -a;
    }
  },
  getNewAngle: function(a0, R, speed) {
    var dFi, fi;
    dFi = Math.round(speed) / R;
    fi = a0 + dFi;
    return 2 * Math.PI + fi % (4 * Math.PI);
  }
};
