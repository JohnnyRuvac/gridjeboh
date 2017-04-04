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


rects = new Rects 375, 0, 16
