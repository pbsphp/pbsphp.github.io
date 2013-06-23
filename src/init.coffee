
drawYobas = ->
  # Initialize canvas, creates and starts Yobas rendering

  # Clear variables after last using

  # Stop render Yobas if needed
  handler.stop()

  # Remove old Yobas
  Yoba.removeYobas()

  # Initialize canvas
  unless canvas.isInitialized()
    canvas.initialize(document.getElementById("yoba_track"))

  else
    # Clear screen (canvas element)
    canvas.clear()

  # Create Yobas

  new Yoba({ radius: 50, position: 950 })
  new Yoba({ radius: 40, position: 400 })
  new Yoba({ radius: 60, position: 100 })


  # Start render Yobas
  handler.start()
