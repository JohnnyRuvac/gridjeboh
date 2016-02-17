EventEmitter = require '../../node_modules/eventemitter3'
Storage = require './utils/Storage'
Grid = require './Grid'


# Constants
RATIO = 1 / 50


# Init
ee = new EventEmitter()
grid = new Grid(ee, RATIO)
storage = new Storage(ee)
