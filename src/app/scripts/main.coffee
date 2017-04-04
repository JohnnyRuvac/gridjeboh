EventEmitter = require '../../node_modules/eventemitter3'
Storage = require './utils/Storage'
Grid = require './Grid'
SquareGrid = require './SquareGrid'
Rects = require './shapes/Rects'


# Constants
RATIO = 1 / 30


# Init
# ee = new EventEmitter()
# grid = new Grid(ee, RATIO)
# storage = new Storage(ee)

# squareGrid = SquareGrid(RATIO)

ww = window.innerWidth
wh = window.innerHeight

w = if ww > wh then wh / 4 else ww / 4
count = if ww < 1024 then 4 else 8

rects = new Rects w, 0, count
