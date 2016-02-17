Shape = require './Shape'
Helpers = require '../utils/Helpers'


module.exports = class Triangle extends Shape
  constructor: (@ee, @svg, @pos, @width, @column, @row, @type) ->
    super()
    @draw()
    @prepareEvents()


  draw: ->
    # get shorter side length
    height = Helpers.pytagoras( @width, @width / 2 )

    # Calculate points
    if @type is 'inverse'
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


    # Add ID for later reference
    id = 'c' + @column + 'r' + @row
    if @type is 'inverse'
      id += 'i'

    @element.attr 'id', id


  toggle: =>
    @element.toggleClass 'filled'
    filled = @element.hasClass 'filled'

    if filled
      @ee.emit 'triangleAdded', @column, @row, @type

    else
      @ee.emit 'triangleRemoved', @column, @row, @type


  # Paint on mousedown & hover
  prepareEvents: ->
    @element.mousedown @toggle

    @ee.on 'gridMousedown', () =>
      # console.log 'activate hover'
      @element.hover @toggle


    @ee.on 'gridMouseup', () =>
      # console.log 'deactivate hover'
      @element.unhover @toggle

