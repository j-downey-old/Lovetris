-- TODO: Add tetrimino translations
-- TODO: Add level/score functionality

require("tetrimino")

CONTROLS = {}
    CONTROLS.MOVELEFT  = "left"
    CONTROLS.MOVERIGHT = "right"
    CONTROLS.ROTATE    = "up"
    CONTROLS.ACCEL     = "down"

GRID   = {}
WIDTH  = 10
HEIGHT = 22

LEVEL      = 1
SCORE      = 0
SCORE_RATE = 2
TICK       = 0

TYPES  = {SHP_I, SHP_O, SHP_T, SHP_S, SHP_Z, SHP_J, SHP_L}
ACTIVE = false
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
    ACTIVE = true
end

function love.update(dt)
    TICK = TICK + dt
    if IS_ACCEL then TICK = TICK + ACCEL_RATE end

    if TICK >= FALL_RATE then
        cascadeActive()
        ACTIVE = false
        checkActive()
        full_lines = checkFullLines()
        if full_lines ~= 0 then cascadeLines(full_lines) end
        ACTIVE = true
    end
end

function love.draw()
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
    elseif key == CONTROLS.MOVERIGHT then moveTetrimino("right")
    if key == CONTROLS.ROTATE then rotateTetrimino() end
    if key == CONTROLS.ACCEL  then IS_ACCEL = true end
end

-- Cascades active blocks if possible
function cascadeActive()
    to_move = {}
    for y = HEIGHT - 1, 1, -1 do
        for x = WIDTH, 1, -1 do
            if GRID[y][x].active and GRID[y + 1][x].block then
                return
            end
            table.insert(to_move, {y, x})
        end
    end

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

-- Checks for any complete lines
function checkFullLines()
    full_count = 0
    for y = 1, HEIGHT do
        count = 0
        for x = 1, WIDTH do
            if GRID[y][x].block then
                count = count + 1
            end
        end

        if count == WIDTH then
            full_count = full_count + 1
        end 
    end

    return full_count
end

-- TODO: Complete this function
-- Cascades all blocks if empty lines exist
function cascadeLines()
    empty_lines = {}
    for y = 1, HEIGHT do
        count = 0
        for x = 1, WIDTH do
            if GRID[y][x].block then count = count + 1 end 
        end

        if count == WIDTH then
            empty_lines = empty_lines + 1
            deleteLine(y)
        end
    end

    for y = HEIGHT - 1, 1, -1 do
        for x = WIDTH, 1, -1 do
            GRID[y + empty_lines
        end
    end
end

-- Deletes a given line
function deleteLine(y)
    for x = 1, WIDTH do
        GRID[y][x] = {block = nil, active = false}
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
