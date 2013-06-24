

handler = {

  # Main handler script interval ID
  scriptIntervalID: null

  # Update every %delay% ms
  delay: 60


  initialize: (id) ->
    handler.scriptIntervalID = id


  # Stop script
  stop: ->
    if handler.scriptIntervalID
      clearInterval(handler.scriptIntervalID)


  # Start script handler
  start: ->
    handler.scriptIntervalID = setInterval(handler.main, handler.delay)



  # Main handler
  # Called every 60ms
  main: ->

    # Aliases
    scriptIntervalID  = Yoba.scriptIntervalID
    WIDTH             = canvas.width
    HEIGHT            = canvas.height


    # Clear screen before rendering
    canvas.clear()


    # For each Yoba calculate speed

    for y, yobaIndex in Yoba.getAllYobas()

      # Aliases
      X0 = y.position - y.radius
      Y0 = HEIGHT - 2 * y.radius
      R  = y.radius
      dS = y.speed


      # Detect border

      if y.position + R + dS >= WIDTH && dS > 0
        # Right border, move left
        dS = - Math.abs(dS)
      else if y.position - R + dS <= 0 && dS < 0
        # Left border, move right
        dS = + Math.abs(dS)


      # Detect other Yobas on the way
      bumpedYoba = null   # The nearby Yoba, which will be bumped

      # Check positions of each Yoba
      for yb, i in Yoba.getAllYobas()
        if yobaIndex != i
          oR = yb.position + yb.radius + yb.speed
          oL = yb.position - yb.radius + yb.speed
          yR = y.position + R + dS
          yL = y.position - R + dS

          # If there will be collision
          if oL <= yR <= oR || oL <= yL <= oR
            bumpedYoba = yb


      # If there is nearby Yoba
      if bumpedYoba
        # Calculate speeds after bump

        m1 = y.mass
        m2 = bumpedYoba.mass
        v1 = y.speed
        v2 = bumpedYoba.speed

        # Get speeds after bump
        speeds = handler.getSpeedsAfterBump(m1, v1, m2, v2)

        dS = speeds[0]
        bumpedYoba.speed = speeds[1]

        # Yoba says
        y.startSpeek()
        bumpedYoba.startSpeek()



      # Continue speek if can
      y.continueSpeek()


      # Determine the acceleration due to the frictional force
      dS -= handler.getFrictionalAcceleration(y.radius, y.mass, dS)

      # Calculate angle and angle increment

      dFi = Math.round(dS) / R
      fi = y.angle + dFi


      # Remember calculated vars

      y.angle       = handler.getNewAngle(y.angle, R, dS)
                                          # 0 <= y.angle <= 2 pi
      y.position   += Math.round(dS)      # position: Integer
      y.speed       = dS                  # speed: Float


      # Rotate, move and redraw Yoba
      y.redraw()



    # If all Yobas stopped, change flag
    allYobasStopped = true
    for yb in Yoba.getAllYobas()
      if ~~(Math.abs(yb.speed)) != 0
        allYobasStopped = false
        break


    # If all Yobas stopped
    if allYobasStopped
      # Stop rendering Yobas
      Yoba.stopScript()



  # Private

  # Get speeds after bump
  getSpeedsAfterBump: (m1, v1, m2, v2) ->
    # The law of conservation of momentum: p01 + p02 = p1 + p2
    [
      ((m1 - m2) * v1 + 2 * m2 * v2) / (m1 + m2)
      (2 * m1 * v1 + (m2 - m1) * v2) / (m1 + m2)
    ]


  # Determine the acceleration due to the frictional force
  getFrictionalAcceleration: (R, M, speed) ->
    # It works lol
    f = 0.3
    N = 9.8 * M    # N = mg

    a = (N * (f / R)) / R

    if speed > 0 then a else -a


  # Get angle increment
  getNewAngle: (a0, R, speed) ->
    dFi = Math.round(speed) / R
    fi = a0 + dFi
    2 * Math.PI + fi % (4 * Math.PI)

}
