Shape = require './Shape'
Helpers = require '../utils/Helpers'


module.exports = class Triangle extends Shape
  constructor: (@svg, @pos, @width) ->
    super()

    # get shorter side length
    pytagoras = Helpers.pytagoras( @width, @width / 2 )

    # Calculate points
    points = [
      @pos.x, @pos.y + pytagoras
      @pos.x + @width / 2, @pos.y
      @pos.x + @width, @pos.y + pytagoras
      @pos.x, @pos.y + pytagoras
    ]

    # Create element
    @element = @svg.polyline points

    # Click
    @element.click () =>
      console.log @element
      @element.toggleClass 'filled'

