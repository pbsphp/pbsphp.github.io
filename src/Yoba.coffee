
class Yoba

  constructor: (params) ->

    # Get skin for Yoba
    yobaImage         = new Image()
    yobaImage.src     = getSkin()


    # Default parameters and constants
    defaultRadius     = 40
    defaultSpeed      = -> Math.floor(Math.random() * 25 + 5)
    defaultAngle      = 0

    # Public params
    this.src          = yobaImage
    this.position     = params.position
    this.radius       = params.radius         || defaultRadius
    this.speed        = params.speed          || defaultSpeed()
    this.angle        =                          defaultAngle
    this.mass         = getMass(params.radius || defaultRadius)
    this.textDelay    = 0
    this.text         = ''


    # Register new
    registerYoba(this)



  # Register new Yoba
  registerYoba = (self) ->
    Yoba.allYobas.push(self)


  # Get mass by radius
  getMass = (R) ->
    p = 0.0001
    Math.floor ((4 / 3) * Math.PI * R * R * R * p)


  # Return random skin from list
  getSkin = ->
    path = "skins/"
    skins = [
      "1.png",
      "2.png",
      "3.png",
      "4.png"
    ]

    randomIndex = Math.floor(Math.random() * skins.length)
    path + skins[randomIndex]


  # Rotate, move and redraw Yoba
  redraw: ->
    ctx = Yoba.ctx
    R = this.radius
    fi = this.angle

    ctx.save()
    ctx.translate(this.position - R, Yoba.canvasElement.height - 2 * R)

    ctx.translate(R, R)
    ctx.rotate(fi)
    ctx.drawImage(this.src, -R, -R, 2 * R, 2 * R)

    ctx.restore()



  # Class members and methods

  @canvasElement      = null
  @ctx                = null
  @scriptIntervalID   = null



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

    randomIndex = Math.floor(Math.random() * swearwords.length)
    swearwords[randomIndex]
