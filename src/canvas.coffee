
# Canvas and rendering methods
canvas = {

  canvasElement:      null
  ctx:                null
  width:              0
  height:             0


  # Is canvas initialized?
  isInitialized: ->
    canvas.ctx?


  # Initialize canvas
  initialize: (element) ->
    canvas.canvasElement  = element
    canvas.ctx            = element.getContext('2d')
    canvas.width          = element.width
    canvas.height         = element.height


  # Clear canvas
  clear: ->
    canvas.ctx.clearRect(0, 0, canvas.width, canvas.height)


  # Show 'sasai lolka' and replay button
  showSasai: ->
    ctx = canvas.ctx

    ctx.save()

    # Show 'SASAI LOLKA'
    ctx.font = 'italic 40pt Calibri'
    ctx.shadowColor = 'orange'
    ctx.shadowOffsetX = 3
    ctx.shadowOffsetY = 3
    ctx.fillText('SASAI LOLKA', ~~(canvas.width * 0.30), 100)

    # Show 'click to replay'
    ctx.font = 'italic 10pt Calibri'
    ctx.shadowColor = 'red'
    ctx.shadowOffsetX = 1
    ctx.shadowOffsetY = 1
    ctx.fillText('Click to replay', ~~(canvas.width * 0.50), 130)

    ctx.restore()


  # Draw Yoba
  drawYoba: (params) ->
    R         = params.radius
    fi        = params.angle
    src       = params.src
    ctx       = canvas.ctx
    position  = params.position

    ctx.save()
    ctx.translate(position - R, canvas.height - 2 * R)

    ctx.translate(R, R)
    ctx.rotate(fi)
    ctx.drawImage(src, -R, -R, 2 * R, 2 * R)

    ctx.restore()


  # Show text at (X;Y)
  showTextAt: (text, X, Y) ->
    canvas.ctx.fillText(text, X, Y)


}
