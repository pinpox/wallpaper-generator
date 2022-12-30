-- Minimalistic wallpaper with colored squares
local vector = require 'generators.lib.vector'

local function distance(vector1, vector2)
    return math.max(math.abs(vector1.x - vector2.x),
                    math.abs(vector1.y - vector2.y))
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

function maxDistOthers(square, squaresTable, margin, max_dim)
    local r = max_dim
    i = 1
    while i <= #squaresTable do
        local temp = distance(square.center, squaresTable[i].center)
        r = math.min(r, temp - squaresTable[i].halfSide - margin)
        i = i + 1
    end
    return r
end

local function maxDistEdges(square, margin, w, h)
    return math.min(w - 1 - margin - square.center.x,
                    square.center.x - margin,
                    square.center.y - margin,
                    h - 1 - margin - square.center.y)
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
    --
    math.randomseed(os.time())
    local sTable = {}
    local center
    local square
    while #sTable < nSquares do
        center = vector.new(math.random(width), math.random(height))
        square = {center = center, halfSide = 1}
        --
        if not collisionInSquare(square, sTable) then
            square.halfSide = math.min(maxDistOthers(square, sTable, margin, math.min(width, height)),
                                       maxDistEdges(square, margin, width, height))
            if square.halfSide > 0 then
                table.insert(sTable, square)
                --
                local col = fg_colors[math.random(#fg_colors)]
                cr:set_source_rgb(colors.hex(col))
                cr:rectangle(center.x - square.halfSide, center.y - square.halfSide,
                         2 * square.halfSide, 2 * square.halfSide)
                cr:fill()
            end
        end
    end
end

return squares
