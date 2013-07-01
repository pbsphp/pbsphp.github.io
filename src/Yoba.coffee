
class Yoba

  constructor: (params) ->

    # Get skin for Yoba
    yobaImage       = new Image()
    yobaImage.src   = getSkin()


    # Default parameters and constants
    defaultRadius   = 40
    defaultSpeed    = -> ~~(Math.random() * 25 + 5)

    # Public params
    @src            = yobaImage
    @position       = params.position
    @radius         = params.radius         || defaultRadius
    @speed          = params.speed          || defaultSpeed()
    @mass           = getMass(params.radius || defaultRadius)
    @angle          = 0
    @textDelay      = 0
    @text           = ''

    # Register new Yoba
    registerYoba(this)



  # Register new Yoba
  registerYoba = (self) ->
    allYobas.push(self)


  # Get mass by radius
  getMass = (R) ->
    p = 0.0001
    ~~((4 / 3) * Math.PI * R * R * R * p)


  # Return random element from array
  getRandomFrom = (array) ->
    array[~~(Math.random() * array.length)]


  # Return random skin from list
  getSkin = ->
    path = "skins/"
    skins = [
      "1.png"
      "2.png"
      "3.png"
      "4.png"
      "5.png"
    ]

    path + getRandomFrom(skins)



  # Rotate, move and redraw Yoba
  redraw: ->
    canvas.drawYoba({
      radius:   this.radius
      angle:    this.angle
      src:      this.src
      position: this.position
    })


  # Speek
  startSpeek: ->
    this.textDelay    = 10
    this.text         = Yoba.getSwearword()


  # Continue speek (if needed)
  continueSpeek: ->
    if this.textDelay > 0
      --this.textDelay
      canvas.showTextAt(this.text, this.position, 10)



    ##!!!
  rightPoint: ->
    this.position + this.radius + this.speed

  leftPoint: ->
    this.position - this.radius + this.speed


  # Is Yoba at right border?
  # At, on or in?
  atRightBorder: ->
    # TODO: speed > 0 as method
    this.rightPoint() >= canvas.width && this.speed > 0


  # Is Yoba at right border?
  atLeftBorder: ->
    this.leftPoint() <= 0 && this.speed < 0



  # Get yoba object that was bumped by this
  getBumpedYoba: ->
    currentYoba = this
    # Check positions of each Yoba
    for anotherYoba in Yoba.getAllYobas() when anotherYoba isnt currentYoba
      oR = anotherYoba.rightPoint()
      oL = anotherYoba.leftPoint()
      yR = currentYoba.rightPoint()
      yL = currentYoba.leftPoint()

      # If there will be collision
      if oL <= yR <= oR || oL <= yL <= oR
        return anotherYoba

    # If not founded
    return null



  # Class members and methods

  # All Yobas
  allYobas = []


  # Get all Yobas
  @getAllYobas = ->
    allYobas


  # Remove all Yobas
  @removeYobas = ->
    allYobas = []



  # Get random swearword from list
  @getSwearword = ->

    swearwords = [
      "Sooqa"
      "Krysa"
      "LOL"
      "Tvoi mama ebal"
      "U tebya bugurt"
      "U vas popka prigorela"
      "Butthurt"
      "Lalka"
      "Sasai"
      "Pidor"
    ]

    getRandomFrom(swearwords)



  # If all yobas stopped, stop script
  @stopScriptIfAllStopped = ->

    # If all Yobas stopped, change flag
    allYobasStopped = yes
    for y in Yoba.getAllYobas()
      if ~~y.speed != 0
        allYobasStopped = no
        break

    # If all Yobas stopped, stop script and show message
    if allYobasStopped
      Handler.stop()
      setTimeout(canvas.showSasai, 1000)
