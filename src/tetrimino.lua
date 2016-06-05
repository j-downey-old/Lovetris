local Tetrimino = {}
Tetrimino.__index = Tetrimino

-- Constructor

function Tetrimino.init(grid, color, blocks)
  local vars = {}
  setmetatable(vars, Tetrimino)
  vars.grid   = grid
  vars.color  = color
  vars.blocks = blocks
end

-- LOVE functions

function Tetrimino:update(dt)
end

function Tetrimino:draw()
end

-- Get functions

function Tetrimino:getColor()
  return self.color
end

function Tetrimino:getBlocks()
  return self.blocks
end

-- Set functions

function Tetrimino:setColor(color)
  self.color = color
end

function Tetrimino:setBlocks(blocks)
  self.blocks = blocks
end

-- Diagnostic functions

local function isBlockBelow(grid, x, y)
end

return Tetrimino
