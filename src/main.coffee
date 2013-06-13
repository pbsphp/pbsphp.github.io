
# Yobas list
YOBAS             = []        # TODO: push Yobas, not hashed


# Main handler
# Called every 60ms
moveYobas = ->
  # TODO: rename

  # Aliases
  pi                = Math.PI
  canvasElement     = Yoba.canvasElement
  ctx               = Yoba.ctx
  scriptIntervalID  = Yoba.scriptIntervalID


  # Clear screen before rendering
  ctx.clearRect(0, 0, canvasElement.width, canvasElement.height)


  # For each Yoba calculate speed

  for y, yobaIndex in YOBAS

    # Aliases
    X0 = y.position - y.radius
    Y0 = canvasElement.height - 2 * y.radius
    R  = y.radius
    dS = y.speed
    M  = y.mass


    # Detect border

    if y.position + R + dS >= canvasElement.width && dS > 0
      # Right border, move left
      dS = - Math.abs(dS)
    else if y.position - R + dS <= 0 && dS < 0
      # Left border, move right
      dS = + Math.abs(dS)


    # Detect other Yobas on the way
    bumpedYoba = null   # The index of nearby Yoba, which will be bumped

    # Check positions of each Yoba
    for yb, i in YOBAS
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


      # p01 + p02 = p1 + p2

      v11 = ((m1 - m2) * v1 + 2 * m2 * v2) / (m1 + m2)
      v21 = (2 * m1 * v1 + (m2 - m1) * v2) / (m1 + m2)

      dS = v11
      bumpedYoba.speed = v21

      # Yoba says
      y.textDelay           = 10
      y.text                = Yoba.getSwearword()
      bumpedYoba.textDelay  = 10
      y.text                = Yoba.getSwearword()



    # Yoba silent
    if y.textDelay > 0
      --y.textDelay
      ctx.fillText(y.text, y.position, 10)


    # Calculate the force of rolling friction and speed

    f = 0.3
    N = 9.8 * M    # N = mg

    a = (N * (f / R)) / R

    # What the fuck? Rewrite this shit!
    # dS -= (dS > 0) ? a : -a
    dS -= if dS > 0
            a
          else
            -a


    # Calculate angle and angle increment

    dFi = 2 * pi + (Math.round(dS) / R)
    fi = y.angle + dFi


    # Rotate and draw Yoba

    ctx.save()
    ctx.translate(X0 + Math.round(dS), Y0)

    ctx.translate(R, R)
    ctx.rotate(fi)
    ctx.drawImage(y.src, -R, -R, 2 * R, 2 * R)

    ctx.restore()


    # Remember calculated vars

    y.angle       = fi % (4 * pi)
    y.position   += Math.round(dS)    # position:integer
    y.speed       = dS                # speed:float



  # If all Yobas stopped, stop script
  allYobasStopped = true
  for yb in YOBAS
    if Math.floor(Math.abs(yb.speed)) != 0
      allYobasStopped = false
      break


  # If all Yobas stopped
  if allYobasStopped
    # Stop rendering Yobas
    clearInterval(scriptIntervalID)

    setTimeout(->
      ctx.save()

      # Show 'SASAI LOLKA'
      ctx.font = 'italic 40pt Calibri'
      ctx.shadowColor = 'orange'
      ctx.shadowOffsetX = 3
      ctx.shadowOffsetY = 3
      ctx.fillText('SASAI LOLKA', Math.floor(canvasElement.width * 0.30), 100)

      # Show 'click to replay'
      ctx.font = 'italic 10pt Calibri'
      ctx.shadowColor = 'red'
      ctx.shadowOffsetX = 1
      ctx.shadowOffsetY = 1
      ctx.fillText('Click to replay', Math.floor(canvasElement.width * 0.50), 130)

      ctx.restore()

    , 1000)
