-- World variables
CELLSIZE = 16
TICK = 0
TICKRATE = 0.75

-- Player variables
HISCORE = 0
SCORE   = 0

-- Board grid
GRID   = {}
WIDTH  = 10
HEIGHT = 22

-- Tetrimino shapes
SHP_I = {
    {
        {0, 0, 0, 0},
        {1, 1, 1, 1},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 0, 1, 0},
        {0, 0, 1, 0},
        {0, 0, 1, 0},
        {0, 0, 1, 0}
    },
    {
        {0, 0, 0, 0},
        {0, 0, 0, 0},
        {1, 1, 1, 1},
        {0, 0, 0, 0}
    },
    {
        {0, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 1, 0, 0}
    }
}

SHP_O = {
    {
        {0, 1, 1, 0},
        {0, 1, 1, 0},
        {0, 0, 0, 0}
    }
}

SHP_T = {
    {
        {0, 1, 0},
        {1, 1, 1},
        {0, 0, 0}
    },
    {
        {0, 1, 0},
        {0, 1, 1},
        {0, 1, 0}
    },
    {
        {0, 0, 0},
        {1, 1, 1},
        {0, 1, 0}
    },
    {
        {0, 1, 0},
        {1, 1, 0},
        {0, 1, 0}
    }
}

SHP_S = {
    {
        {0, 1, 1},
        {1, 1, 0},
        {0, 0, 0}
    },
    {
        {0, 1, 0},
        {0, 1, 1},
        {0, 0, 1}
    },
    {
        {0, 0, 0},
        {0, 1, 1},
        {1, 1, 0}
    },
    {
        {1, 0, 0},
        {1, 1, 0},
        {0, 1, 0}
    }
}

SHP_Z = {
    {
        {1, 1, 0},
        {0, 1, 1},
        {0, 0, 0}
    },
    {
        {0, 0, 1},
        {0, 1, 1},
        {0, 1, 0}
    },
    {
        {0, 0, 0},
        {1, 1, 0},
        {0, 1, 1}
    },
    {
        {0, 1, 0},
        {1, 1, 0},
        {1, 0, 0}
    }
}

SHP_J = {
    {
        {0, 0, 1},
        {1, 1, 1},
        {0, 0, 0}
    },
    {
        {0, 1, 0},
        {0, 1, 0},
        {0, 1, 1}
    },
    {
        {0, 0, 0},
        {1, 1, 1},
        {1, 0, 0}
    },
    {
        {1, 1, 0},
        {0, 1, 0},
        {0, 1, 0}
    }
}

SHP_L = {
    {
        {1, 0, 0},
        {1, 1, 1},
        {0, 0, 0}
    },
    {
        {0, 1, 1},
        {0, 1, 0},
        {0, 1, 0}
    },
    {
        {0, 0, 0},
        {1, 1, 1},
        {0, 0, 1}
    },
    {
        {0, 1, 0},
        {0, 1, 0},
        {1, 1, 0}
    }
}

-- Used in moving tetriminos
ACCEL     = false
ACCELRATE = 0
ROT       = 1
ACTIVE    = true

function love.load()
    BLK_BLU = love.graphics.newImage("assets/element_blue_square.png")
    BLK_GRN = love.graphics.newImage("assets/element_green_square.png")
    BLK_GRY = love.graphics.newImage("assets/element_grey_square.png")
    BLK_PPL = love.graphics.newImage("assets/element_purple_square.png")
    BLK_RED = love.graphics.newImage("assets/element_red_square.png")
    BLK_YEL = love.graphics.newImage("assets/element_yellow_square.png")

    -- Initialize grid to 10x22 zeroes
    for y = 1, HEIGHT do
        GRID[y] = {}
        for x = 1, WIDTH do
            GRID[y][x] = 0
        end
    end

    -- Test blocks
    GRID[1][5]   = {block = BLK_BLU, falling = true, active = true}
    GRID[10][5]  = {block = BLK_RED, falling = true, active = false}
    GRID[7][6]   = {block = BLK_PPL, falling = true, active = false}
    GRID[15][7]  = {block = BLK_YEL, falling = true, active = false}
end

function love.update(dt)
    ACCEL = love.keyboard.isDown("down")
    if ACCEL then 
        ACCELRATE = 0.50
    else
        ACCELRATE = 0
    end

    TICK = TICK + dt
    if TICK >= TICKRATE - ACCELRATE then
        for y = HEIGHT, 1, -1 do
            for x = WIDTH, 1, -1 do
                if GRID[y][x] ~= 0 and y < HEIGHT then
                    -- Current block is falling and space below is empty
                    if GRID[y][x].falling and GRID[y + 1][x] == 0 then
                        GRID[y + 1][x] = GRID[y][x]
                        GRID[y][x] = 0
                    -- Current block is falling and space is filled
                    elseif GRID[y][x].falling then
                        GRID[y][x].falling = false
                        if GRID[y][x].active then GRID[y][x].active = false end
                    end
                -- Make falling field false for blocks on bottom row
                elseif GRID[y][x] ~= 0 and GRID[y][x].falling then
                    GRID[y][x].falling = false
                    if GRID[y][x].active then GRID[y][x].active = false end
                end
            end
        end
        TICK = 0
    end

    -- Check for complete rows
    
end

function love.draw()
    -- Draw grid
    -- Draw blocks with the topmost two rows hidden
    for y = 3, HEIGHT do
        for x = 1, WIDTH do
            if GRID[y][x] ~= 0 then
                love.graphics.draw(GRID[y][x].block, x * CELLSIZE, 
                                   y * CELLSIZE)
            else
                love.graphics.setColor(120, 120, 120)
                love.graphics.rectangle('line', x * CELLSIZE, y * CELLSIZE,
                                        CELLSIZE, CELLSIZE)
                love.graphics.setColor(255, 255, 255)
            end
        end
    end
end

function love.keypressed(key)
    love.keyboard.setKeyRepeat(true)
    if key == "left" then moveTetrimino("left")
    elseif key == "right" then moveTetrimino("right")
    elseif key == "up" then rotateTetrimino() end
end

function createTetrimino(shape)
end

function moveTetrimino(dir)
    -- Are the blocks able to move
    can_move = true
    -- Table of active blocks consisting of [1]: block info, [2]: y, [3]: x
    active_blks = {}
    -- The coeff and bound vars help with code reuse.
    coeff = 1
    bound = WIDTH
    if dir == "left" then
        coeff = -1
        bound = 1
    end

    for y = 1, HEIGHT do
        for x = 1, WIDTH do
            if GRID[y][x] ~= 0 and GRID[y][x].active then
                table.insert(active_blks, {GRID[y][x], y, x})
                if x == bound or GRID[y][x + coeff] ~= 0 
                   and not GRID[y][x + coeff].active then
                    can_move = false
                end
            end
        end
    end

    -- Return if a move is not possible
    if not can_move then return end

    -- Removes all active blocks to move them
    deleteActive()

    -- (In/De)crement the x coordinates of active blocks
    -- Add the blocks back to the grid
    for i = 1, #active_blks do
        active_blks[i][3] = active_blks[i][3] + coeff
        GRID[active_blks[i][2]][active_blks[i][3]] = active_blks[i][1]
    end
end

function rotateTetrimino()
end

function deleteActive()
    for y = 1, HEIGHT do
        for x = 1, WIDTH do
            if GRID[y][x] ~= 0 and GRID[y][x].active then 
                GRID[y][x] = 0
            end
        end
    end
end
