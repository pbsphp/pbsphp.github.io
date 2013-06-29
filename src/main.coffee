
Handler = {

  # Main handler script interval ID
  scriptIntervalID: null

  # Update every %delay% ms
  delay: 60


  # Stop script
  stop: ->
    if Handler.scriptIntervalID
      clearInterval(Handler.scriptIntervalID)


  # Start script
  start: ->
    Handler.scriptIntervalID = setInterval(Handler.main, Handler.delay)



  # Main handler
  # Called every 60ms
  main: ->

    # Aliases
    WIDTH     = canvas.width
    HEIGHT    = canvas.height


    # Clear screen before rendering
    canvas.clear()


    # For each Yoba calculate speed

    for currentYoba, yobaIndex in Yoba.getAllYobas()

      # Aliases
      X0 = currentYoba.position - currentYoba.radius
      Y0 = HEIGHT - 2 * currentYoba.radius
      R  = currentYoba.radius
      speed = currentYoba.speed


      # Detect border

      # TODO: currentYoba.atRightBorder()
      if currentYoba.atRightBorder()
        # Right border, move left
        speed = - Math.abs(speed)
      else if currentYoba.atLeftBorder()
        # Left border, move right
        speed = + Math.abs(speed)


      # Detect other Yobas on the way

      bumpedYoba = null   # The nearby Yoba, which will be bumped
      # Check positions of each Yoba
      for anotherYoba, i in Yoba.getAllYobas()
        if i != yobaIndex
          oR = anotherYoba.rightPoint()
          oL = anotherYoba.leftPoint()
          yR = currentYoba.rightPoint()
          yL = currentYoba.leftPoint()

          # If there will be collision
          if oL <= yR <= oR || oL <= yL <= oR
            bumpedYoba = anotherYoba


      # If there is nearby Yoba
      if bumpedYoba
        # Calculate speeds after bump

        m1 = currentYoba.mass
        m2 = bumpedYoba.mass
        v1 = currentYoba.speed
        v2 = bumpedYoba.speed

        # Get speeds after bump
        [ speed, bumpedYoba.speed ] = Handler.getSpeedsAfterBump(m1, v1, m2, v2)


        # Yoba says
        currentYoba.startSpeek()
        bumpedYoba.startSpeek()



      # Continue speek if can
      currentYoba.continueSpeek()


      # Determine the acceleration due to the frictional force
      speed -= Handler.getFrictionalAcceleration(currentYoba.radius, currentYoba.mass, speed)


      # Remember calculated vars

      currentYoba.angle       = Handler.getNewAngle(currentYoba.angle, R, speed)
                                                    # 0 <= angle <= 2 pi
      currentYoba.position   += Math.round(speed)      # position: Integer
      currentYoba.speed       = speed               # speed: Float


      # Rotate, move and redraw Yoba
      currentYoba.redraw()


    # If all Yobas stopped, stop script
    Yoba.stopScriptIfAllStopped()



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
