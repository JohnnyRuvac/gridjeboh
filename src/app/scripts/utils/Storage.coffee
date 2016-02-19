hotkeys = require '../../../node_modules/jquery.hotkeys'


module.exports = class Storage
  constructor: (@ee) ->

    @prepareHistory()

    @ee.on 'triangleAdded', @addTriangle
    @ee.on 'triangleRemoved', @removeTriangle

    if window.localStorage.drawing 
      @data = @load()
      @draw()
    
    else 
      @data = {}



  addTriangle: (x, y, type) =>
    
    # console.log @data

    if !@data[x]
      @data[x] = {}

    if !@data[x][y]
      @data[x][y] = {}

    if type is 'inverse'
      @data[x][y].inverse = true
    else
      @data[x][y].normal = true

    id = 'c' + x + 'r' + y
    id += 'i' if type is 'inverse'
    # console.log 'id: ' + id

    @save()
    # console.log 'added ' + x + ', ' + y + ', ' + type
    # console.log @data


  removeTriangle: (x, y, type) =>
    # console.log 'removed ' + x + ', ' + y + ', ' + type
    delete @data[x][y][type]
    
    if Object.keys( @data[x][y] ).length is 0
      delete @data[x][y]

    if Object.keys( @data[x] ).length is 0
      delete @data[x]
    
    @save()


  save: =>
    # after save when undo, set history to this point
    if @index < @history.length - 1
      @history = @history.slice( 0, @index + 1 )

    currentState = window.localStorage.getItem 'drawing'

    if !currentState?
      currentState = "{}"
      
    @index++
    
    if Object.keys(@data).length > 0
      window.localStorage.setItem 'drawing', JSON.stringify( @data )


  load: ->
    JSON.parse(window.localStorage.drawing)


  draw: ->
    
    for column, rows of @data
      for row, shape of rows
        
        # check for both types: normal/inverse triangle
        if shape.normal
          id = 'c' + column + 'r' + row
          # console.log 'id: ' + id
          @ee.emit 'markActive', id

        if shape.inverse
          id = 'c' + column + 'r' + row + 'i'
          # console.log 'id: ' + id
          @ee.emit 'markActive', id


  prepareHistory: ->
    
    @history = []
    @index = 0

    $(document).bind 'keydown', 'z', @undo
    $(document).bind 'keydown', 'x', @redo


  changeHistory: =>
    stringData = @history[ @index ]

    if !stringData?
      stringData = "{}"

    window.localStorage.setItem 'drawing', stringData
    @data = JSON.parse( stringData )

    @ee.emit 'clearGridRequested'

    @draw()


  undo: =>
    console.log 'undo'

    # only if there are steps back
    if @index <= 0 then return

    @index--
    
    @changeHistory()


  redo: =>
    console.log 'redo'

    # only if there are steps forward
    if @index >= @history.length - 1 then return
      
    @index++
