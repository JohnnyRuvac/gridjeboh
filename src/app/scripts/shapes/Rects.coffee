module.exports = class Rects
  constructor: (@width, @offset, @count) ->

    @svg = Snap(0,0)
    @svgElem = $( @svg.node )
    @svgElem.width( @width ).height( @width )

    # click
    @svgElem.click =>
      @svg.clear()
      @init()

    # window resize
    $(window).on 'debouncedresize', =>
      @svg.clear()
      @init()

    # init
    @init()


  init: () =>
    count = 8 + Math.round( Math.random() * 8 )

    newWidth = @width

    for i in [1..@count]
      newWidth = @drawRecursively newWidth, count, i


  drawRecursively: (oldWidth, count, index) ->
    newWidth = @getEmbededSquareWidth oldWidth
    offset = ( @width - newWidth ) / 2
    cw = index % 2 is 0
    @draw newWidth, offset, count, cw
    return newWidth


  draw: (width, offset, count, clockwise) ->
    rects = []

    tl = new TimelineMax
      yoyo: true
      repeat: -1
      repeatDelay: Math.random()
      paused: true
      # ease: Power1.easeInOut

    for i in [1..count]
      rect = @svg.rect offset, offset, width, width
      rects.push rect.node

      time = Math.random() / 6 + 0.3

      if i is 1 then TweenLite.to rect.node, time, {opacity: 1}

      props =
        opacity: 1
        rotation: 90 / count * i
        transformOrigin: 'center center'
        delay: - time * 0.5

      props.rotation *= if clockwise then 1 else -1

      tl.to rect.node, time, props


    setTimeout () =>
      tl.play()
    , Math.random() * 50


  getEmbededSquareWidth: (width) ->
    newWidth = Math.sqrt( width / 2 * width / 2 + width / 2 * width / 2 )
