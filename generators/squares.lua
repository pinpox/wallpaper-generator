-- Minimalistic wallpaper with colored squares
local vector = require 'generators.lib.vector'

local function distance(vector1, vector2)
    return math.max(math.abs(vector1.x - vector2.x),
                    math.abs(vector1.y - vector2.y))
end

local function collisionScreenEdges(square, width, height, margin)
    return  square.center.x + square.halfSide >= width - margin
        or square.center.x - square.halfSide <= margin
        or square.center.y + square.halfSide >= height - margin
        or square.center.y - square.halfSide <= margin
end

local function collisionInSquare(square, squaresTable)
    local ans = false
    local i = 1
    while not ans and i <= #squaresTable do
        local temp = distance(square.center, squaresTable[i].center)
        ans = temp < squaresTable[i].halfSide
        i = i + 1
    end
    return ans
end


local function collisionOutSquare(square, squaresTable, margin)
    local ans = false
    local i = 1
    while not ans and i <= #squaresTable do
        local temp = distance(square.center, squaresTable[i].center)
        ans = temp <= square.halfSide + squaresTable[i].halfSide + margin
        i = i + 1
    end
    return ans
end

local function squares(cr, palette, width, height)
    local margin = 5
    local nSquares = 100
    -- Draw background
    local colors = require 'colors'
    cr:set_source_rgb(colors.hex(palette.base02))
    cr:paint()
    --
    local fg_colors =  { palette.base08, palette.base09, palette.base0A,
                         palette.base0B, palette.base0C, palette.base0D, palette.base0E,
                         palette.base0F }
    math.randomseed(os.time())
    local cTable = {}
    local center
    local carre
    while #cTable < nSquares do
        center = vector.new(math.random(width), math.random(height))
        carre = {center = center, halfSide = 1}
        --
        if not collisionInSquare(carre, cTable) then
            while not collisionOutSquare(carre, cTable, margin) and
                not collisionScreenEdges(carre, width, height, margin) do
                carre.halfSide = carre.halfSide + 1
            end
            table.insert(cTable, carre)
            --
            local col = fg_colors[math.random(#fg_colors)]
            cr:set_source_rgb(colors.hex(col))
            cr:rectangle(center.x - carre.halfSide, center.y - carre.halfSide,
                         2 * carre.halfSide, 2 * carre.halfSide)
            cr:fill()
        end
    end
end

return squares
