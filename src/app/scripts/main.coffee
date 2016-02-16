Triangle = require './Shapes/Triangle'


RATIO = 1 / 100


ww = window.innerWidth
wh = window.innerHeight
unit = ww * 1 / 100
console.log 'unit: ' + unit

svg = Snap(ww, wh)

pos =
  x: 0
  y: 0


count = 1 / RATIO
start = pos.x
finish = @width * i

for i in [0...count] by 1
  pos = 
    x: unit * i
    y: 0

  console.log 'pos.x: ' + pos.x

  triangle = new Triangle svg, pos, unit
