
class Yoba

  constructor: (params) ->

    # Get skin for Yoba
    yobaImage     = new Image()
    yobaImage.src = getSkin()


    # Add yoba to YOBAS handler
    YOBAS.push({
            src:          yobaImage
            position:     params.position
            radius:       params.radius         || defaultParams.radius
            speed:        params.speed          || defaultParams.speed()
            angle:                                 defaultParams.angle
            mass:         getMass(params.radius || defaultParams.radius)
            textDelay:    0
            text:         ''
    })


  # Default parameters and constants
  defaultParams = {
    radius:       40
    speed: ->     Math.floor(Math.random() * 25 + 5)
    angle:        0
  }


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


  # Class members and methods

  @canvasElement      = null
  @ctx                = null
  @scriptIntervalID   = null


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
