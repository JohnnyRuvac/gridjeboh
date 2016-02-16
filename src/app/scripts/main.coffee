Helpers = require './utils/Helpers'
Triangle = require './Shapes/Triangle'


RATIO = 1 / 75


ww = window.innerWidth
wh = window.innerHeight
unit = ww * RATIO
console.log 'unit: ' + unit

svg = Snap(ww, wh)

pos =
  x: 0
  y: 0


countX = 1 / RATIO + 1
triangleHeight = Helpers.pytagoras( unit, unit / 2 )
countY =  wh / triangleHeight + 1

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
    triangle = new Triangle svg, pos, unit

endTime = new Date()
took = endTime - startTime
console.log 'drew ' + i * j + ' shapes, took: ' + took + 'ms'
