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
HEIGHT = 20

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
ACCEL = false
ROT   = 1

function love.load()
    BLK_BLU = love.graphics.newImage("assets/element_blue_square.png")
    BLK_GRN = love.graphics.newImage("assets/element_green_square.png")
    BLK_GRY = love.graphics.newImage("assets/element_grey_square.png")
    BLK_PPL = love.graphics.newImage("assets/element_purple_square.png")
    BLK_RED = love.graphics.newImage("assets/element_red_square.png")
    BLK_YEL = love.graphics.newImage("assets/element_yellow_square.png")
    -- Initialize grid to 10x20 zeroes
    for y = 1, HEIGHT do
        GRID[y] = {}
        for x = 1, WIDTH do
            GRID[y][x] = 0
        end
    end

    -- Test blocks
    GRID[6][5]   = {block = BLK_BLU, falling = true, active = false}
    GRID[10][5]  = {block = BLK_RED, falling = true, active = false}
    GRID[7][6]   = {block = BLK_PPL, falling = true, active = false}
    GRID[15][7]  = {block = BLK_YEL, falling = true, active = false}
end

function love.update(dt)
    TICK = TICK + dt
    if TICK >= TICKRATE then
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
                    end
                elseif GRID[y][x] ~= 0 and GRID[y][x].falling then
                    GRID[y][x].falling = false
                end
            end
        end
        TICK = 0
    end
end

function love.draw()
    for y = 1, HEIGHT do
        for x = 1, WIDTH do
            if GRID[y][x] ~= 0 then
                love.graphics.draw(GRID[y][x].block, x * CELLSIZE, 
                                   y * CELLSIZE)
            end
        end
    end
end

function love.keypressed(key)
end

function createTetrimino(shape)
end
