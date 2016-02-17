module.exports = class Storage
  constructor: (@ee) ->

    @ee.on 'triangleAdded', @addTriangle
    @ee.on 'triangleRemoved', @removeTriangle

    if window.localStorage.drawing 
      @data = @load()
      @draw()
    
    else 
      @data = {}
      @save()


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
    window.localStorage.setItem 'drawing', JSON.stringify( @data )
    # console.log 'saving data: '
    # console.log @data
    # console.log window.localStorage.drawing


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
