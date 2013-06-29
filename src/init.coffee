
# Initialize canvas, creates and starts Yobas rendering
init = ->

  # Stop render Yobas if needed
  handler.stop()

  # Remove old Yobas
  Yoba.removeYobas()

  # Initialize canvas
  unless canvas.isInitialized()
    # If isn't initialized
    canvas.initialize(document.getElementById("yoba_track"))

  else
    # Else, clear canvas
    canvas.clear()

  # Create Yobas

  new Yoba({ radius: 50, position: 950 })
  new Yoba({ radius: 40, position: 400 })
  new Yoba({ radius: 60, position: 100 })

  # Start rendering Yobas
  handler.start()
