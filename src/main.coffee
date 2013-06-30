
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

    # Clear screen before rendering
    canvas.clear()


    # For each Yoba calculate speed

    for currentYoba in Yoba.getAllYobas()

      # Detect border

      if currentYoba.atRightBorder()
        # Right border, move left
        currentYoba.speed = -Math.abs(currentYoba.speed)
      else if currentYoba.atLeftBorder()
        # Left border, move right
        currentYoba.speed = +Math.abs(currentYoba.speed)



      # If there is Yoba that will be bumped
      # Calculate params after bump for this two yobas
      bumpedYoba = currentYoba.getBumpedYoba()
      if bumpedYoba

        m1 = currentYoba.mass
        v1 = currentYoba.speed
        m2 = bumpedYoba.mass
        v2 = bumpedYoba.speed

        # Get speeds after bump
        [ currentYoba.speed, bumpedYoba.speed ] = Handler.getSpeedsAfterBump(m1, v1, m2, v2)


        # Yoba says
        currentYoba.startSpeek()
        bumpedYoba.startSpeek()



      # Continue speek if can
      currentYoba.continueSpeek()


      # Determine the acceleration due to the frictional force
      currentYoba.speed -= Handler.getFrictionalAcceleration(
                                                      currentYoba.radius,
                                                      currentYoba.mass,
                                                      currentYoba.speed )


      # Remember calculated vars

      currentYoba.angle       = Handler.getNewAngle(  currentYoba.angle,
                                                      currentYoba.radius,
                                                      currentYoba.speed )
                                                    # 0 <= angle <= 2 pi
      currentYoba.position   += Math.round(currentYoba.speed)
                                                    # position :: int


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
