Shape = require './Shape'
Helpers = require '../utils/Helpers'


module.exports = class Triangle extends Shape
  constructor: (@svg, @pos, @width) ->
    super()
    
    console.log 'triangle ' + @width

    # get shorter side length
    pytagoras = Helpers.pytagoras( @width, @width / 2 )
    console.log 'pytagoras ' + pytagoras

    points = [
      @pos.x, @pos.y
      @pos.x + @width, @pos.y
      @pos.x / 2, @pos.y + pytagoras
    ]

    @svg.polyline points
