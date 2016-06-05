local Block = {}
Block.__index = Block

function Block.init(color, x, y)
  local vars = {}
  setmetatable(vars, Block)
  vars.color = color
  vars.x     = x
  vars.y     = y
  return vars
end

function Block:getColor()
  return self.color
end

function Block:getX()
  return self.x
end

function Block:getY()
  return self.y
end

function Block:setColor(color)
  self.color = color
end

function Block:setX(x)
  self.x = x
end

function Block:setY(y)
  self.y = y
end

return Block
