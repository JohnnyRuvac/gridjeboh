Helpers = require './utils/Helpers'
Triangle = require './Shapes/Triangle'


module.exports = class Grid
  constructor: (@ee, RATIO) ->

    ww = window.innerWidth
    wh = window.innerHeight
    unit = ww * RATIO
    # console.log 'unit: ' + unit

    @svg = Snap(ww, wh)

    pos =
      x: 0
      y: 0


    countX = 1 / RATIO + 1
    triangleHeight = Helpers.pytagoras( unit, unit / 2 )
    countY =  wh / triangleHeight + 1

    # countX = 1
    # countY = 1

    startTime = new Date()

    for i in [0...countY] by 1
      for j in [0...countX] by 1

        pos = 
          x: unit * j
          y: triangleHeight * i

        # offset even rows
        if i % 2 is 0
          pos.x -= unit / 2

        # draw triangle
        triangle = new Triangle @ee, @svg, pos, unit, j, i, 'normal'

        # position of inverse triangle
        pos2 = 
          x: unit / 2 * (j + 1)
          y: triangleHeight * i

        # draw inverse triangle
        triangle = new Triangle @ee, @svg, pos, unit, j, i, 'inverse'



    endTime = new Date()
    took = endTime - startTime
    console.log 'drew ' + i * j + ' shapes, took: ' + took + 'ms'


    # Listen to mark active request
    @ee.on 'markActive', @markActive


  markActive: (id) ->
    $('#' + id).addClass('filled')
