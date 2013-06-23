
class Yoba

  constructor: (params) ->

    # Get skin for Yoba
    yobaImage         = new Image()
    yobaImage.src     = getSkin()


    # Default parameters and constants
    defaultRadius     = 40
    defaultSpeed      = -> ~~(Math.random() * 25 + 5)

    # Public params
    this.src          = yobaImage
    this.position     = params.position
    this.radius       = params.radius         || defaultRadius
    this.speed        = params.speed          || defaultSpeed()
    this.mass         = getMass(params.radius || defaultRadius)
    this.angle        = 0
    this.textDelay    = 0
    this.text         = ''

    # Register new Yoba
    registerYoba(this)



  # Register new Yoba
  registerYoba = (self) ->
    Yoba.allYobas.push(self)


  # Get mass by radius
  getMass = (R) ->
    p = 0.0001
    ~~((4 / 3) * Math.PI * R * R * R * p)


  # Return random skin from list
  getSkin = ->
    path = "skins/"
    skins = [
      "1.png",
      "2.png",
      "3.png",
      "4.png"
    ]

    path + skins[~~(Math.random() * skins.length)]



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



  # Class members and methods

  # All Yobas
  @allYobas = []


  # Remove all Yobas
  @removeYobas = ->
    @allYobas = []



  # Get random swearword from list
  @getSwearword = ->

    swearwords = [
      "Sooqa",
      "Krysa",
      "LOL",
      "Tvoi mama ebal",
      "U tebya bugurt",
      "U vas popka prigorela",
      "Butthurt",
      "Lalka",
      "Sasai",
      "Pidor"
    ]

    swearwords[~~(Math.random() * swearwords.length)]


  # Stop script and render "sasai lolka"
  @stopScript = ->
    handler.stop()
    setTimeout(canvas.showSasai, 1000)
