Helpers = require './utils/Helpers'
Triangle = require './Shapes/Triangle'


module.exports = class Grid
  constructor: (@ee, @RATIO) ->

    # Init svg element
    @svg = Snap(0, 0)
    @svgElem = $( @svg.node )

    # Draw whole grid
    @draw(@RATIO)
    @prepareEvents()

    # @prepareAnimation()
    # @drawAnimation()

    # @fadeAnimation()
    @marchAnim()

    # window resize
    $(window).on 'debouncedresize', @handleResize


  marchAnim: () ->
    tl = new TimelineMax 
      paused: true

    for row, index in @shapes
      subTl = new TimelineMax()

      props =
        opacity: 0
        ease: Power2.easeIn
        # delay: 0.3 * index

      for shape, index2 in row
        props.delay = Math.random() * index / 24
        subTl.from shape, Math.random() / 2, props, Math.random() / 12
      
      tl.staggerFrom subTl, 0.6, props, Math.random() / 6

    setTimeout () =>
      tl.play()
    , 1000




  draw: () ->
    @shapes = []

    ww = window.innerWidth
    wh = window.innerHeight
    unit = ww * @RATIO
    # console.log 'unit: ' + unit

    @svgElem.width( ww ).height( wh )

    pos =
      x: 0
      y: 0

    countX = 1 / @RATIO + 1
    triangleHeight = Helpers.pytagoras( unit, unit / 2 )
    countY =  wh / triangleHeight + 1

    # countX = 1
    # countY = 1

    startTime = new Date()

    for i in [0...countY] by 1
      row = []
      for j in [0...countX] by 1

        pos = 
          x: unit * j
          y: triangleHeight * i

        # offset even rows
        if i % 2 is 0
          pos.x -= unit / 2

        # draw triangle
        triangle = new Triangle @ee, @svg, pos, unit, j, i, 'normal'

        # add to all shapes
        row.push triangle.element.node

        # position of inverse triangle
        pos2 = 
          x: unit / 2 * (j + 1)
          y: triangleHeight * i

        # draw inverse triangle
        triangle = new Triangle @ee, @svg, pos, unit, j, i, 'inverse'

        # add to all shapes
        row.push triangle.element.node

      @shapes.push row



    endTime = new Date()
    took = endTime - startTime
    console.log 'drew ' + i * j + ' shapes, took: ' + took + 'ms'


  clear: =>
    $('svg .filled').removeClass('filled')


  markActive: (id) ->
    $('#' + id).addClass('filled')


  prepareEvents: () ->
    # Listen to mark active request
    @ee.on 'markActive', @markActive

    # Clear all
    @ee.on 'clearGridRequested', @clear

    # paint shapes with mouse down & hover
    @svg.mousedown () =>
      @ee.emit 'gridMousedown'

    @svg.mouseup () =>
      @ee.emit 'gridMouseup'


  handleResize: () =>
    @svg.clear()
    @draw()


  prepareAnimation: () ->
    shapes = @shapes.reverse()
    
    for shape in shapes
      
      time = Math.random() / 1
      
      props =
        # y: window.innerHeight + 100
        opacity: 0
        delay: Math.random() / 3
        ease: Power2.easeIn

      TweenLite.to shape, time, props


  drawAnimation: () ->
    shapes = @shapes.reverse()
    
    for shape in shapes
      
      time = Math.random() * 10
      
      props =
        # y: window.innerHeight + 100
        # opacity: 0
        drawSVG: 0
        delay: Math.random() / 3
        ease: Power2.easeIn

      TweenLite.from shape, time, props


  fadeAnimation: () ->
    for shape in @shapes
      time = Math.random() / 2
      props =
        opacity: 0
        delay: Math.random() / 3
        ease: Power2.easeIn

      TweenLite.from shape, time, props

