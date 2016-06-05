-- TODO: Add tetrimino translations
-- TODO: Add level/score functionality

require("tetrimino")

CONTROLS = {}
  CONTROLS.MOVELEFT  = "left"
  CONTROLS.MOVERIGHT = "right"
  CONTROLS.ROTATE    = "up"
  CONTROLS.ACCEL     = "down"

BLOCKS = {
  love.graphics.newImage("assets/element_blue_square.png"),
  love.graphics.newImage("assets/element_grey_square.png"),
  love.graphics.newImage("assets/element_red_square.png"),
  love.graphics.newImage("assets/element_green_square.png"),
  love.graphics.newImage("assets/element_purple_square.png"),
  love.graphics.newImage("assets/element_yellow_square.png")
}

GRID   = {}
WIDTH  = 10
HEIGHT = 22

LEVEL    = 1
SCORE    = 0
SCORE_RATE = 2
TICK     = 0

TYPES  = {SHP_I, SHP_O, SHP_T, SHP_S, SHP_Z, SHP_J, SHP_L}
ROT    = 1

FALL_RATE  = 0.75
IS_ACCEL   = false
ACCEL_RATE = 0.5

function love.load()
  -- Initialize GRID to all empty blocks
  for y = 1, HEIGHT do
    GRID[y] = {}
    for x = 1, WIDTH do
      GRID[y][x] = {block = nil, active = false}
    end
  end

  -- Spawn a new Tetrimino
  math.randomseed(os.time())
  spawnTetrimino(TYPES[math.random(1, #TYPES)])
end

function love.update(dt)
  -- Increment tick
  TICK = TICK + dt
  -- Add acceleration rate to tick if player is accelerating
  if IS_ACCEL then TICK = TICK + ACCEL_RATE end

  if TICK >= FALL_RATE then
    cascadeActive()
    checkActive()
    deleteFullLines()
    cascadeLines()
  end
end

function love.draw()
  -- Draw grid with top two rows undrawn
  for y = 3, HEIGHT do
    for x = 1, WIDTH do
      if GRID[y][x].block then
        love.graphics.draw(GRID[y][x].block, x * 16, y * 16)
      end
    end
  end
end

function love.keypressed(key)
  if key == CONTROLS.MOVELEFT      then moveTetrimino("left")
  elseif key == CONTROLS.MOVERIGHT then moveTetrimino("right") end
  if key == CONTROLS.ROTATE        then rotateTetrimino() end
  if key == CONTROLS.ACCEL         then IS_ACCEL = true end
end

-- Cascades active blocks if possible
function cascadeActive()
  -- Get a table of {y, x} entries of active blocks
  -- that can be moved down by one
  to_move = {}
  for y = HEIGHT - 1, 1, -1 do
    for x = WIDTH, 1, -1 do
      if GRID[y][x].active and GRID[y + 1][x].block then
        return
      end
      table.insert(to_move, {y, x})
    end
  end

  -- Move each active block down by one
  for i = 1, #to_move do
    y = to_move[i][1]
    x = to_move[i][2]
    GRID[y + 1][x] = GRID[y][x]
    GRID[y][x] = {block = nil, active = true}
  end
end

-- Checks if active blocks can't fall anymore 
function checkActive()
  for y = 1, HEIGHT do
    for x = 1, WIDTH do
      if GRID[y][x].active and not GRID[y + 1][x].active 
         and GRID[y + 1][x].block then
        deactivateActive()
      end
    end
  end
end

-- Cascades all affected blocks if empty lines exist
function cascadeLines()
  -- Count the number of empty lines
  empty_count = 0
  for y = HEIGHT, 1, -1 do
    count = 0
    if checkForEmpty(y) then
      empty_count = empty_count + 1
    end
  end

  -- If no empty lines, exit
  if empty_count == 0 then
    return
  end 

  -- Loop for x empty lines
  for i = 1, empty_count do
    -- Find lowest empty line
    for y = HEIGHT, 1, -1 do
      -- Empty line found, now traverse up from that line
      if checkForEmpty(y) and y ~= 1 then
        for y2 = y - 1, 1, -1 do
          for x = 1, WIDTH do
            -- Move each block in each row down by one
            GRID[y2 + 1][x] = GRID[y2][x]
            GRID[y2][x] = {block = nil, active = false}
          end
        end
      end
    end
  end
end

-- Checks if a given line is empty
function checkForEmpty(y)
  count = 0
  for x = 1, WIDTH do
    if not GRID[y][x].block then
      count = count + 1
    end
  end

  return count == WIDTH
end
-- Deletes a given line
function deleteLine(y)
  for x = 1, WIDTH do
    GRID[y][x] = {block = nil, active = false}
  end
end

-- Deletes all empty lines
function deleteFullLines()
  for y = 1, HEIGHT do
    count = 0
    for x = 1, WIDTH do
      if GRID[y][x].block then count = count + 1 end 
    end

    if count == WIDTH then deleteLine(y) end
  end
end

-- Removes active attribute from currently active blocks
function deactivateActive()
  for y = 1, HEIGHT do
    for x = 1, WIDTH do
      if GRID[y][x].active then
        GRID[y][x].active = false
      end
    end
  end
end

-- Deletes currently active blocks
function deleteActive()
  for y = 1, HEIGHT do
    for x = 1, WIDTH do
      if GRID[y][x].active then
        GRID[y][x] = {block = nil, active = false}
      end
    end
  end
end

-- Spawns a tetrimino of a given type
function spawnTetrimino(type)
end

-- Moves the currently active tetrimino left or right
function moveTetrimino(dir)
end

-- Rotates the currently active tetrimino
function rotateTetrimino()
end
