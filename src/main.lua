-- Tetrimino definitions
BLOCK_I = {
    {{0, 0, 0, 0},
     {0, 0, 0, 0},
     {0, 0, 0, 0},
     {1, 1, 1, 1}},
    {{0, 1, 0, 0},
     {0, 1, 0, 0},
     {0, 1, 0, 0},
     {0, 1, 0, 0}},
}

BLOCK_O = {
    {{0, 0, 0, 0},
     {0, 1, 1, 0},
     {0, 1, 1, 0},
     {0, 0, 0, 0}}
}

BLOCK_T = {
}

-- Player variables
HISCORE = 0
SCORE   = 0

-- Board grid
GRID = {}

-- Used in moving tetriminos
ACCEL = false
ROT   = 1

function love.load()
    -- Initialize grid to 10x20 zeroes
    for y = 1, 20 do
        for x = 1, 10 do
            GRID[y][x] = 0
        end
    end
end

function love.update(dt)
end

function love.draw()
end
