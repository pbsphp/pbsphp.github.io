
drawYobas = ->
  # Initialize canvas, creates and starts Yobas rendering

  # Clear variables after last using

  # Stop render Yobas if needed
  if Yoba.scriptIntervalID
    clearInterval(Yoba.scriptIntervalID)

  # Remove old Yobas
  Yoba.removeYobas()

  # Initialize canvas
  unless Yoba.canvasElement
    Yoba.canvasElement  = document.getElementById("yoba_track")
    Yoba.ctx            = Yoba.canvasElement.getContext("2d")

  else
    # Clear screen (canvas element)
    Yoba.ctx.clearRect(0, 0, Yoba.canvasElement.width, Yoba.canvasElement.height)


  # Create Yobas

  new Yoba({ radius: 50, position: 950 })
  new Yoba({ radius: 40, position: 400 })
  new Yoba({ radius: 60, position: 100 })


  # Start render Yobas
  Yoba.scriptIntervalID = setInterval(mainHandler, 60)
