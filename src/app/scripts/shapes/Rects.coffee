module.exports = class Rects
  constructor: (@width, @offset, @count) ->

    @svg = Snap(0,0)
    @svgElem = $( @svg.node )
    @svgElem.width( @width ).height( @width )

    newWidth = @width

    for i in [1..@count]
      newWidth = @drawRecursively newWidth, 16, i




  drawRecursively: (oldWidth, count, index) ->
    newWidth = @getEmbededSquareWidth oldWidth
    offset = ( @width - newWidth ) / 2
    cw = index % 2 is 0
    @draw newWidth, offset, count, cw
    return newWidth


  draw: (width, offset, count, clockwise) ->
    rects = []

    tl = new TimelineLite 
      paused: true

    for i in [1..count]
      rect = @svg.rect offset, offset, width, width
      rects.push rect.node

      if i is 1 then TweenLite.to rect.node, 1, {opacity: 1}

      props =
        opacity: 1
        rotation: 90 / count * i
        transformOrigin: 'center center'
        delay: - 0.075

      props.rotation *= if clockwise then 1 else -1

      tl.to rect.node, 0.1, props


    setTimeout () =>
      tl.play()
    , 1200


  getEmbededSquareWidth: (width) ->
    newWidth = Math.sqrt( width / 2 * width / 2 + width / 2 * width / 2 )
