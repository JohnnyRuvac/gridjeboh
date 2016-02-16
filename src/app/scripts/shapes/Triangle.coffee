Shape = require './Shape'
Helpers = require '../utils/Helpers'


module.exports = class Triangle extends Shape
  constructor: (@svg, @pos, @width, inverse) ->
    super()

    # get shorter side length
    height = Helpers.pytagoras( @width, @width / 2 )

    # Calculate points
    if inverse
      points = [
        @pos.x + @width / 2, @pos.y
        @pos.x + @width / 2 + @width, @pos.y
        @pos.x + @width, @pos.y + height
        @pos.x + @width / 2, @pos.y
      ]

    else
      points = [
        @pos.x, @pos.y + height
        @pos.x + @width / 2, @pos.y
        @pos.x + @width, @pos.y + height
        @pos.x, @pos.y + height
      ]

    # Create element
    @element = @svg.polyline points

    # Click
    @element.click () =>
      @element.toggleClass 'filled'

